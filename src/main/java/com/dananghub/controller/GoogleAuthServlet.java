package com.dananghub.controller;

import com.dananghub.dao.RoleDAO;
import com.dananghub.dao.UserDAO;
import com.dananghub.entity.Role;
import com.dananghub.entity.User;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

/**
 * Google OAuth 2.0 Login — Xử lý redirect + callback
 *
 * Flow:
 *   1. GET /google-auth          → Redirect tới Google consent screen
 *   2. GET /google-auth?code=... → Google callback, đổi code → token → userinfo → login/register
 *
 * Cần config:
 *   - GOOGLE_CLIENT_ID     (từ Google Cloud Console)
 *   - GOOGLE_CLIENT_SECRET (từ Google Cloud Console)
 *   - Redirect URI: http://localhost:9090/DaNangTravelHub/google-auth
 */
@WebServlet("/google-auth")
public class GoogleAuthServlet extends HttpServlet {

    // ═══ CẤU HÌNH GOOGLE OAUTH ═══
    // Set environment variables: GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET
    private static final String CLIENT_ID;
    private static final String CLIENT_SECRET;
    static {
        java.util.Properties p = new java.util.Properties();
        try { p.load(GoogleAuthServlet.class.getResourceAsStream("/google-oauth.properties")); } catch (Exception ignored) {}
        CLIENT_ID     = p.getProperty("client_id",     System.getenv("GOOGLE_CLIENT_ID") != null ? System.getenv("GOOGLE_CLIENT_ID") : "");
        CLIENT_SECRET = p.getProperty("client_secret",  System.getenv("GOOGLE_CLIENT_SECRET") != null ? System.getenv("GOOGLE_CLIENT_SECRET") : "");
    }

    // Google OAuth endpoints
    private static final String AUTH_URL     = "https://accounts.google.com/o/oauth2/v2/auth";
    private static final String TOKEN_URL    = "https://oauth2.googleapis.com/token";
    private static final String USERINFO_URL = "https://www.googleapis.com/oauth2/v3/userinfo";

    private String getRedirectUri(HttpServletRequest request) {
        // Tự tạo redirect URI từ request để linh hoạt (localhost / production)
        String scheme = request.getScheme();
        String serverName = request.getServerName();
        int port = request.getServerPort();
        String ctx = request.getContextPath();

        StringBuilder uri = new StringBuilder();
        uri.append(scheme).append("://").append(serverName);
        if (("http".equals(scheme) && port != 80) || ("https".equals(scheme) && port != 443)) {
            uri.append(":").append(port);
        }
        uri.append(ctx).append("/google-auth");
        return uri.toString();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");
        String error = request.getParameter("error");

        // ═══ STEP 1: Nếu chưa có code → Redirect tới Google ═══
        if (code == null && error == null) {
            String redirectUri = getRedirectUri(request);
            String state = generateState(request);

            String googleAuthUrl = AUTH_URL
                    + "?client_id=" + URLEncoder.encode(CLIENT_ID, "UTF-8")
                    + "&redirect_uri=" + URLEncoder.encode(redirectUri, "UTF-8")
                    + "&response_type=code"
                    + "&scope=" + URLEncoder.encode("openid email profile", "UTF-8")
                    + "&state=" + URLEncoder.encode(state, "UTF-8")
                    + "&access_type=offline"
                    + "&prompt=select_account";

            response.sendRedirect(googleAuthUrl);
            return;
        }

        // ═══ Nếu user cancel / error ═══
        if (error != null) {
            request.setAttribute("error", "Đăng nhập Google bị hủy: " + error);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // ═══ STEP 2: Google callback với code → Exchange token ═══
        try {
            String redirectUri = getRedirectUri(request);

            // 2a. Exchange authorization code for tokens
            JsonObject tokens = exchangeCodeForTokens(code, redirectUri);
            if (tokens == null || !tokens.has("access_token")) {
                request.setAttribute("error", "Không thể lấy token từ Google");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            String accessToken = tokens.get("access_token").getAsString();

            // 2b. Get user info from Google
            JsonObject userInfo = getUserInfo(accessToken);
            if (userInfo == null || !userInfo.has("email")) {
                request.setAttribute("error", "Không lấy được thông tin từ Google");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            String email = userInfo.get("email").getAsString();
            String name = userInfo.has("name") ? userInfo.get("name").getAsString() : "";
            String picture = userInfo.has("picture") ? userInfo.get("picture").getAsString() : "";

            System.out.println(">>> GOOGLE LOGIN: email=" + email + ", name=" + name);

            // 2c. Find or create user in database
            UserDAO userDAO = new UserDAO();
            User user = userDAO.findByEmail(email);

            if (user == null) {
                // Tạo user mới với role CUSTOMER
                RoleDAO roleDAO = new RoleDAO();
                Role customerRole = roleDAO.findByName("CUSTOMER");

                user = new User();
                user.setEmail(email);
                user.setUsername(email.split("@")[0]);
                user.setPasswordHash("GOOGLE_OAUTH"); // Không cần password
                user.setFullName(name.isEmpty() ? email.split("@")[0] : name);
                user.setRole(customerRole);
                user.setActive(true);

                boolean created = userDAO.create(user);
                if (!created) {
                    request.setAttribute("error", "Không thể tạo tài khoản. Vui lòng thử lại.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }
                // Refresh to get ID
                user = userDAO.findByEmail(email);
                System.out.println(">>> GOOGLE: Created new user: " + user.getUsername());
            } else {
                System.out.println(">>> GOOGLE: Existing user login: " + user.getUsername());
            }

            // 2d. Create session
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRoleName());
            session.setAttribute("googlePicture", picture);

            // 2e. Redirect based on role
            String ctx = request.getContextPath();
            String roleName = user.getRoleName();
            if ("ADMIN".equals(roleName)) {
                response.sendRedirect(ctx + "/home");
            } else if ("PROVIDER".equals(roleName)) {
                response.sendRedirect(ctx + "/provider/dashboard");
            } else {
                response.sendRedirect(ctx + "/home");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi đăng nhập Google: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    /**
     * Exchange authorization code for access token
     */
    private JsonObject exchangeCodeForTokens(String code, String redirectUri) throws IOException {
        String params = "code=" + URLEncoder.encode(code, "UTF-8")
                + "&client_id=" + URLEncoder.encode(CLIENT_ID, "UTF-8")
                + "&client_secret=" + URLEncoder.encode(CLIENT_SECRET, "UTF-8")
                + "&redirect_uri=" + URLEncoder.encode(redirectUri, "UTF-8")
                + "&grant_type=authorization_code";

        URL url = new URL(TOKEN_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        conn.setDoOutput(true);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(params.getBytes("UTF-8"));
        }

        int status = conn.getResponseCode();
        InputStream is = (status == 200) ? conn.getInputStream() : conn.getErrorStream();

        BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) sb.append(line);
        br.close();

        System.out.println(">>> GOOGLE TOKEN RESPONSE (" + status + "): " + sb.toString());

        if (status != 200) return null;
        return JsonParser.parseString(sb.toString()).getAsJsonObject();
    }

    /**
     * Get user profile from Google using access token
     */
    private JsonObject getUserInfo(String accessToken) throws IOException {
        URL url = new URL(USERINFO_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);

        int status = conn.getResponseCode();
        if (status != 200) return null;

        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) sb.append(line);
        br.close();

        System.out.println(">>> GOOGLE USERINFO: " + sb.toString());
        return JsonParser.parseString(sb.toString()).getAsJsonObject();
    }

    /**
     * Generate CSRF state token  
     */
    private String generateState(HttpServletRequest request) {
        String state = Long.toHexString(System.currentTimeMillis());
        request.getSession(true).setAttribute("oauth_state", state);
        return state;
    }
}
