package model;

public class Provider {
    private int providerId;
    private String providerName;
    private String contactInfo;
    private String serviceType; // Hotel, Transport, Restaurant, etc.
    private boolean isCooperating;

    public Provider() {}

    public Provider(int providerId, String providerName, String contactInfo, String serviceType, boolean isCooperating) {
        this.providerId = providerId;
        this.providerName = providerName;
        this.contactInfo = contactInfo;
        this.serviceType = serviceType;
        this.isCooperating = isCooperating;
    }

    public int getProviderId() { return providerId; }
    public void setProviderId(int providerId) { this.providerId = providerId; }

    public String getProviderName() { return providerName; }
    public void setProviderName(String providerName) { this.providerName = providerName; }

    public String getContactInfo() { return contactInfo; }
    public void setContactInfo(String contactInfo) { this.contactInfo = contactInfo; }

    public String getServiceType() { return serviceType; }
    public void setServiceType(String serviceType) { this.serviceType = serviceType; }

    public boolean isCooperating() { return isCooperating; }
    public void setCooperating(boolean cooperating) { isCooperating = cooperating; }
}
