package model;

import java.math.BigDecimal;

/**
 * Supplier Model Class
 * Represents a supplier entity in the system
 */
public class Supplier {
    
    // Primary fields from Suppliers table
    private int supplierID;
    private String supplierName;
    private String serviceType;
    private String email;
    private String phoneNumber;
    private String status;
    private BigDecimal basePrice;
    
    // Additional fields for enhanced functionality
    private String supplierCode;
    private String contactPerson;
    private String address;
    private String description;
    private String city;
    private String province;
    private String country;
    private String notes;
    
    // Foreign key fields
    private int serviceTypeID;
    private int cooperationStatusID;
    
    // Display fields (from JOINs)
    private String serviceTypeName;
    private String statusName;
    
    // Constructors
    public Supplier() {
    }
    
    public Supplier(String supplierName, String serviceType, String email, 
                   String phoneNumber, String status, BigDecimal basePrice) {
        this.supplierName = supplierName;
        this.serviceType = serviceType;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.status = status;
        this.basePrice = basePrice;
    }
    
    public Supplier(int supplierID, String supplierName, String serviceType, 
                   String email, String phoneNumber, String status, BigDecimal basePrice) {
        this.supplierID = supplierID;
        this.supplierName = supplierName;
        this.serviceType = serviceType;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.status = status;
        this.basePrice = basePrice;
    }
    
    // Getters and Setters
    public int getSupplierID() {
        return supplierID;
    }
    
    public void setSupplierID(int supplierID) {
        this.supplierID = supplierID;
    }
    
    public String getSupplierName() {
        return supplierName;
    }
    
    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }
    
    public String getServiceType() {
        return serviceType;
    }
    
    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPhoneNumber() {
        return phoneNumber;
    }
    
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public BigDecimal getBasePrice() {
        return basePrice;
    }
    
    public void setBasePrice(BigDecimal basePrice) {
        this.basePrice = basePrice;
    }
    
    public String getSupplierCode() {
        return supplierCode;
    }
    
    public void setSupplierCode(String supplierCode) {
        this.supplierCode = supplierCode;
    }
    
    public String getContactPerson() {
        return contactPerson;
    }
    
    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public int getServiceTypeID() {
        return serviceTypeID;
    }
    
    public void setServiceTypeID(int serviceTypeID) {
        this.serviceTypeID = serviceTypeID;
    }
    
    public int getCooperationStatusID() {
        return cooperationStatusID;
    }
    
    public void setCooperationStatusID(int cooperationStatusID) {
        this.cooperationStatusID = cooperationStatusID;
    }
    
    public String getServiceTypeName() {
        return serviceTypeName;
    }
    
    public void setServiceTypeName(String serviceTypeName) {
        this.serviceTypeName = serviceTypeName;
    }
    
    public String getStatusName() {
        return statusName;
    }
    
    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }
    
    public String getCity() {
        return city;
    }
    
    public void setCity(String city) {
        this.city = city;
    }
    
    public String getProvince() {
        return province;
    }
    
    public void setProvince(String province) {
        this.province = province;
    }
    
    public String getCountry() {
        return country;
    }
    
    public void setCountry(String country) {
        this.country = country;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    @Override
    public String toString() {
        return "Supplier{" +
                "supplierID=" + supplierID +
                ", supplierName='" + supplierName + '\'' +
                ", serviceType='" + serviceType + '\'' +
                ", email='" + email + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", status='" + status + '\'' +
                ", basePrice=" + basePrice +
                '}';
    }
}