package model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * POJO luu tru 1 tin nhan chat (khong can DB, luu trong Session)
 */
public class ChatMessage implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;
    private String role;       // "user" hoac "assistant" hoac "system"
    private String content;
    private LocalDateTime timestamp;

    public ChatMessage() {
        this.timestamp = LocalDateTime.now();
    }

    public ChatMessage(int id, String role, String content) {
        this.id = id;
        this.role = role;
        this.content = content;
        this.timestamp = LocalDateTime.now();
    }

    // Getter/Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public LocalDateTime getTimestamp() { return timestamp; }
    public void setTimestamp(LocalDateTime timestamp) { this.timestamp = timestamp; }

    // Format thoi gian de hien thi
    public String getFormattedTime() {
        return timestamp.format(DateTimeFormatter.ofPattern("HH:mm"));
    }
}
