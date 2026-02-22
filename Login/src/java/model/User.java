package model;

public class User {
    private int userId;
    private String username;
    private String roleName;

    public User(int userId, String username, String roleName) {
        this.userId = userId;
        this.username = username;
        this.roleName = roleName;
    }
    
    // Getters
    public int getUserId() {
        return userId;
    }
    
    public String getUsername() {
        return username;
    }
    
    public String getRole() {
        return roleName;
    }
    
    public String getRoleName() {
        return roleName;
    }
    
    // Setters
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}
