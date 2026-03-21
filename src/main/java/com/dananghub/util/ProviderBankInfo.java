package com.dananghub.util;

public class ProviderBankInfo {
    private int providerId;
    private String bankName;
    private String accountNumber;
    private String accountName;

    public ProviderBankInfo() {}

    public ProviderBankInfo(int providerId, String bankName, String accountNumber, String accountName) {
        this.providerId = providerId;
        this.bankName = bankName;
        this.accountNumber = accountNumber;
        this.accountName = accountName;
    }

    public int getProviderId() { return providerId; }
    public void setProviderId(int providerId) { this.providerId = providerId; }
    
    public String getBankName() { return bankName; }
    public void setBankName(String bankName) { this.bankName = bankName; }

    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }

    public String getAccountName() { return accountName; }
    public void setAccountName(String accountName) { this.accountName = accountName; }
}
