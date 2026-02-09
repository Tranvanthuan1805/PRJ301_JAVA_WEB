package model;

import java.io.Serializable;

/**
 * Model class cho Trạng Thái Hợp Tác (Cooperation Status)
 */
public class CooperationStatus implements Serializable {
    private static final long serialVersionUID = 1L;

    private int statusID;
    private String statusName;
    private String description;

    // Constructors
    public CooperationStatus() {
    }

    public CooperationStatus(int statusID, String statusName, String description) {
        this.statusID = statusID;
        this.statusName = statusName;
        this.description = description;
    }

    // Getters and Setters
    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return statusName;
    }
}
