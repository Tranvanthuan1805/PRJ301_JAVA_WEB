package com.dananghub.controller;

import com.dananghub.dao.UserDAO;
import com.dananghub.dao.RoleDAO;
import com.dananghub.entity.User;
import com.dananghub.entity.Role;
import com.dananghub.util.PasswordUtil;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

@WebServlet("/auth/google-callback")
public class GoogleCallbackServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final RoleDAO roleDAO = new RoleDAO();
    private final String SUPABASE_URL = "https://cbbdijhwewpptvmgujcz.supabase.co";
    private final String SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNiYmRpamh3ZXdwcHR2bWd1amN6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzIzMDQwNjMsImV4cCI6MjA4Nzg4MDA2M30.SuAZmCu_jtQGGWQAA3AVUV4k1HE4EmTHEkpEOwJAS_8";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accessToken = request.getParameter("access_token");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        if (accessToken == null || accessToken.trim().isEmpty()) {
            response.getWriter().write("{\"success\":false, \"error\":\"Missing token\"}");
            return;
        }

        try {
            // 1. Fetch user info from Supabase Auth API
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest supabaseReq = HttpRequest.newBuilder()
                .uri(URI.create(SUPABASE_URL + "/auth/v1/user"))
                .header("Authorization", "Bearer " + accessToken)
                .header("apikey", SUPABASE_ANON_KEY)
                .GET()
                .build();

            HttpResponse<String> supabaseResp = client.send(supabaseReq, HttpResponse.BodyHandlers.ofString());

            if (supabaseResp.statusCode() != 200) {
                response.getWriter().write("{\"success\":false, \"error\":\"Supabase auth failed: " + supabaseResp.statusCode() + "\"}");
                return;
            }

            // 2. Parse user data
            JsonObject userData = JsonParser.parseString(supabaseResp.body()).getAsJsonObject();
            String email = userData.get("email").getAsString();
            String googleId = userData.get("id").getAsString();
            
            JsonObject userMetadata = userData.get("user_metadata").getAsJsonObject();
            String fullName = userMetadata.has("full_name") ? userMetadata.get("full_name").getAsString() : email.split("@")[0];
            String avatarUrl = userMetadata.has("avatar_url") ? userMetadata.get("avatar_url").getAsString() : null;

            // 3. Sync with local public.Users table
            User user = userDAO.findByEmail(email);

            if (user == null) {
                Role customerRole = roleDAO.findByName("CUSTOMER");
                user = new User();
                user.setEmail(email);
                user.setUsername(email.split("@")[0]);
                user.setPasswordHash(PasswordUtil.hashSHA256("GOOGLE_" + googleId));
                user.setRole(customerRole);
                user.setFullName(fullName);
                user.setAvatarUrl(avatarUrl);
                user.setActive(true);

                try {
                    userDAO.create(user);
                } catch (Exception e) {
                    // username conflict
                    user.setUsername(email.split("@")[0] + "_" + (System.currentTimeMillis() % 10000));
                    userDAO.create(user);
                }
            }

            // 4. Create local session
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRoleName());
            session.setAttribute("userId", user.getUserId());

            String redirect = request.getContextPath() + "/home";
            if ("ADMIN".equals(user.getRoleName())) redirect = request.getContextPath() + "/admin/dashboard";
            else if ("PROVIDER".equals(user.getRoleName())) redirect = request.getContextPath() + "/provider/dashboard";

            response.getWriter().write("{\"success\":true, \"redirect\":\"" + redirect + "\"}");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\":false, \"error\":\"Internal error: " + e.getMessage() + "\"}");
        }
    }
}
