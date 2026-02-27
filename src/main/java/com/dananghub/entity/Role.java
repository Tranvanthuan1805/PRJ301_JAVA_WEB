package com.dananghub.entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "Roles")
public class Role implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "RoleId")
    private int roleId;

    @Column(name = "RoleName", nullable = false, unique = true, length = 50)
    private String roleName;

    public Role() {}

    public Role(int roleId, String roleName) {
        this.roleId = roleId;
        this.roleName = roleName;
    }

    public int getRoleId() { return roleId; }
    public void setRoleId(int roleId) { this.roleId = roleId; }

    public String getRoleName() { return roleName; }
    public void setRoleName(String roleName) { this.roleName = roleName; }
}
