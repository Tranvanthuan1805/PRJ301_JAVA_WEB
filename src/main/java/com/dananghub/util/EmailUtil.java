package com.dananghub.util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Logger;

/**
 * Tiện ích gửi email thông báo kết quả xét duyệt đơn NCC.
 * Cấu hình SMTP đọc từ WEB-INF/config.properties.
 */
public class EmailUtil {

    private static final Logger log = Logger.getLogger(EmailUtil.class.getName());
    private static Properties config;

    // Đọc config một lần khi class load
    static {
        config = new Properties();
        try (InputStream is = EmailUtil.class.getClassLoader()
                .getResourceAsStream("config.properties")) {
            if (is != null)
                config.load(is);
        } catch (Exception e) {
            log.warning("Không đọc được config.properties: " + e.getMessage());
        }
    }

    /**
     * Gửi email thông báo kết quả xét duyệt đơn NCC.
     *
     * @param toEmail      email người nhận
     * @param toName       tên người nhận
     * @param businessName tên doanh nghiệp
     * @param approved     true = duyệt, false = từ chối
     * @param adminNote    ghi chú của admin
     */
    public static void sendReviewResult(String toEmail, String toName,
            String businessName, boolean approved, String adminNote) {

        String smtpHost = config.getProperty("smtp.host", "smtp.gmail.com");
        String smtpPort = config.getProperty("smtp.port", "587");
        String smtpUser = config.getProperty("smtp.user", "");
        String smtpPass = config.getProperty("smtp.pass", "");

        if (smtpUser.isEmpty()) {
            log.warning("smtp.user chưa cấu hình — bỏ qua gửi email");
            return;
        }

        Properties props = new Properties();
        props.put("mail.smtp.host", smtpHost);
        props.put("mail.smtp.port", smtpPort);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(smtpUser, smtpPass);
            }
        });

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(smtpUser, "EZTravel Admin"));
            msg.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));

            if (approved) {
                msg.setSubject("✅ Đơn đăng ký Nhà Cung Cấp đã được duyệt!");
            } else {
                msg.setSubject("❌ Đơn đăng ký Nhà Cung Cấp chưa được chấp thuận");
            }

            msg.setContent(buildHtml(toName, businessName, approved, adminNote), "text/html; charset=UTF-8");
            Transport.send(msg);
            log.info("Email gửi thành công đến: " + toEmail);

        } catch (Exception e) {
            // Không để lỗi email ảnh hưởng luồng chính
            log.warning("Gửi email thất bại: " + e.getMessage());
        }
    }

    // Tạo nội dung email HTML
    private static String buildHtml(String name, String businessName,
            boolean approved, String adminNote) {

        String color = approved ? "#16a34a" : "#dc2626";
        String icon = approved ? "✅" : "❌";
        String title = approved ? "Chúc mừng! Đơn đăng ký đã được duyệt"
                : "Đơn đăng ký chưa được chấp thuận";
        String detail = approved
                ? "Tài khoản của bạn đã được nâng cấp lên Nhà Cung Cấp. Bạn có thể đăng nhập và bắt đầu tạo tour ngay."
                : "Đơn đăng ký của bạn chưa đáp ứng yêu cầu. Vui lòng xem lý do bên dưới và gửi lại đơn.";

        String noteSection = (adminNote != null && !adminNote.isBlank())
                ? "<div style='background:#f9fafb;border-left:4px solid " + color
                        + ";padding:12px 16px;margin-top:16px;border-radius:4px'>"
                        + "<strong>Ghi chú từ Admin:</strong><br>" + esc(adminNote) + "</div>"
                : "";

        return "<!DOCTYPE html><html><body style='font-family:sans-serif;background:#f3f4f6;padding:32px'>"
                + "<div style='max-width:560px;margin:0 auto;background:#fff;border-radius:12px;overflow:hidden;box-shadow:0 4px 20px rgba(0,0,0,.08)'>"
                + "<div style='background:" + color + ";padding:28px 32px;text-align:center'>"
                + "<div style='font-size:2.5rem'>" + icon + "</div>"
                + "<h2 style='color:#fff;margin:8px 0 0;font-size:1.2rem'>" + title + "</h2>"
                + "</div>"
                + "<div style='padding:28px 32px'>"
                + "<p>Xin chào <strong>" + esc(name) + "</strong>,</p>"
                + "<p>Đơn đăng ký Nhà Cung Cấp với tên doanh nghiệp <strong>\"" + esc(businessName)
                + "\"</strong> đã được xem xét.</p>"
                + "<p>" + detail + "</p>"
                + noteSection
                + "<div style='margin-top:24px;text-align:center'>"
                + "<a href='http://localhost:8080/provider' style='background:" + color
                + ";color:#fff;padding:12px 28px;border-radius:8px;text-decoration:none;font-weight:700'>Truy cập EZTravel</a>"
                + "</div>"
                + "</div>"
                + "<div style='padding:16px 32px;background:#f9fafb;text-align:center;font-size:.78rem;color:#9ca3af'>EZTravel — Nền tảng du lịch Đà Nẵng</div>"
                + "</div></body></html>";
    }

    private static String esc(String s) {
        if (s == null)
            return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;");
    }
}
