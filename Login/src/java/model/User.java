package model;

public class User {
    public int userId;
    public String username;
    public String roleName;

    public User(int userId, String username, String roleName) {
        this.userId = userId;
        this.username = username;
        this.roleName = roleName;
    }

    public int getUserId() { return userId; }
    public String getUsername() { return username; }
    public String getRoleName() { return roleName; }
}
