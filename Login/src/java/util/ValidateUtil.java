package util;

public class ValidateUtil {
    public static String username(String u) {
        if (u == null || u.trim().isEmpty()) return "Username không được để trống";
        u = u.trim();
        if (u.length() < 3 || u.length() > 20) return "Username phải 3-20 ký tự";
        if (!u.matches("^[a-zA-Z0-9._-]+$")) return "Username chỉ gồm chữ/số/._-";
        // ❌ cấm username toàn số
        if (u.matches("^\\d+$")) return "Username phải có chữ cái";
        return null;
    }

    public static String password(String p) {
        if (p == null || p.isEmpty()) return "Password không được để trống";
        if (p.length() < 6) return "Password tối thiểu 6 ký tự";
        return null;
    }
    public static String confirmPassword(String p, String c) {
    if (c == null || c.isEmpty()) return "Confirm password không được để trống";
    if (!p.equals(c)) return "Password và Confirm password không khớp";
    return null;
}

}
