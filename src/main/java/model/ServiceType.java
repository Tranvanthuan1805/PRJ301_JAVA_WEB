package model;

import java.io.Serializable;

/**
 * Model class cho Loại Dịch Vụ (Service Type)
 */
public class ServiceType implements Serializable {
    private static final long serialVersionUID = 1L;

    private int serviceTypeID;
    private String serviceTypeName;
    private String description;

    // Constructors
    public ServiceType() {
    }

    public ServiceType(int serviceTypeID, String serviceTypeName, String description) {
        this.serviceTypeID = serviceTypeID;
        this.serviceTypeName = serviceTypeName;
        this.description = description;
    }

    // Getters and Setters
    public int getServiceTypeID() {
        return serviceTypeID;
    }

    public void setServiceTypeID(int serviceTypeID) {
        this.serviceTypeID = serviceTypeID;
    }

    public String getServiceTypeName() {
        return serviceTypeName;
    }

    public void setServiceTypeName(String serviceTypeName) {
        this.serviceTypeName = serviceTypeName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return serviceTypeName;
    }
}
