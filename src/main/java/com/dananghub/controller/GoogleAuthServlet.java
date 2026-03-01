package com.dananghub.controller;

import com.dananghub.dao.RoleDAO;
import com.dananghub.dao.UserDAO;
import com.dananghub.entity.Role;
import com.dananghub.entity.User;
import com.dananghub.util.JPAUtil;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet("/google-auth")
public class GoogleAuthServlet extends HttpServlet {

    private static final String SUPABASE_URL = "https://cbbdijhwewpptvmgujcz.supabase.co";
    private static final String SUPABASE_ANON_KEY = getAnonKey();

    private static String getAnonKey() {
        // Will be set in init or from config
        return "";
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        JsonObject result = new JsonObject();

        String accessToken = request.getParameter("access_token");
        if (accessToken == null || accessToken.isEmpty()) {
            result.addProperty("success", false);
            result.addProperty("error", "Token không hợp lệ");
            out.print(result);
            return;
        }

        try {
            // Call Supabase to get user info using the access token
            URL url = new URL(SUPABASE_URL + "/auth/v1/user");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);
            conn.setRequestProperty("apikey", getSupabaseAnonKey());

            int status = conn.getResponseCode();
            if (status != 200) {
                result.addProperty("success", false);
                result.addProperty("error", "Xác thực thất bại (HTTP " + status + ")");
                out.print(result);
                return;
            }

            // Read response
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) sb.append(line);
            br.close();

            JsonObject userInfo = JsonParser.parseString(sb.toString()).getAsJsonObject();
            String email = userInfo.has("email") ? userInfo.get("email").getAsString() : null;

            String fullName = "";
            if (userInfo.has("user_metadata")) {
                JsonObject meta = userInfo.getAsJsonObject("user_metadata");
                if (meta.has("full_name")) fullName = meta.get("full_name").getAsString();
                else if (meta.has("name")) fullName = meta.get("name").getAsString();
            }

            if (email == null || email.isEmpty()) {
                result.addProperty("success", false);
                result.addProperty("error", "Không lấy được email từ Google");
                out.print(result);
                return;
            }

            // Find or create user in our database
            UserDAO userDAO = new UserDAO();
            User user = userDAO.findByEmail(email);

            if (user == null) {
                // Create new user with CUSTOMER role
                RoleDAO roleDAO = new RoleDAO();
                Role customerRole = roleDAO.findByName("CUSTOMER");

                user = new User();
                user.setEmail(email);
                user.setUsername(email.split("@")[0]);
                user.setPasswordHash("GOOGLE_OAUTH"); // no password needed
                user.setFullName(fullName.isEmpty() ? email.split("@")[0] : fullName);
                user.setRole(customerRole);
                user.setActive(true);

                boolean created = userDAO.create(user);
                if (!created) {
                    result.addProperty("success", false);
                    result.addProperty("error", "Không thể tạo tài khoản");
                    out.print(result);
                    return;
                }
                // Refresh to get ID
                user = userDAO.findByEmail(email);
            }

            // Create session
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRoleName());

            // Determine redirect based on role
            String ctx = request.getContextPath();
            String redirect;
            String roleName = user.getRoleName();
            if ("ADMIN".equals(roleName)) {
                redirect = ctx + "/admin/dashboard";
            } else if ("PROVIDER".equals(roleName)) {
                redirect = ctx + "/provider/dashboard";
            } else {
                redirect = ctx + "/home";
            }

            result.addProperty("success", true);
            result.addProperty("redirect", redirect);

        } catch (Exception e) {
            e.printStackTrace();
            result.addProperty("success", false);
            result.addProperty("error", "Lỗi hệ thống: " + e.getMessage());
        }

        out.print(result);
    }

    private String getSupabaseAnonKey() {
        return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNiYmRpamh3ZXdwcHR2bWd1amN6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzIzMDQwNjMsImV4cCI6MjA4Nzg4MDA2M30.SuAZmCu_jtQGGWQAA3AVUV4k1HE4EmTHEkpEOwJAS_8";
    }
}
