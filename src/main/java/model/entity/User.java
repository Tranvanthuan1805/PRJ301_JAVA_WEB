package model.entity;

import java.sql.Timestamp;

public class User {
    private int userId;
    private String email;
    private String username;
    private String passwordHash;
    private int roleId;
    private String roleName;
    private String fullName;
    private String phoneNumber;
    private String avatarUrl;
    private boolean isActive;
    private Timestamp createdAt;

    public User() {}

    public User(int userId, String email, String username, int roleId, String roleName) {
        this.userId = userId;
        this.email = email;
        this.username = username;
        this.roleId = roleId;
        this.roleName = roleName;
    }

    // Full constructor
    public User(int userId, String email, String username, String passwordHash, int roleId, String fullName, String phoneNumber, String avatarUrl, boolean isActive, Timestamp createdAt) {
        this.userId = userId;
        this.email = email;
        this.username = username;
        this.passwordHash = passwordHash;
        this.roleId = roleId;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.avatarUrl = avatarUrl;
        this.isActive = isActive;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }
    public int getRoleId() { return roleId; }
    public void setRoleId(int roleId) { this.roleId = roleId; }
    public String getRoleName() { return roleName; }
    public void setRoleName(String roleName) { this.roleName = roleName; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
    public String getAvatarUrl() { return avatarUrl; }
    public void setAvatarUrl(String avatarUrl) { this.avatarUrl = avatarUrl; }
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
