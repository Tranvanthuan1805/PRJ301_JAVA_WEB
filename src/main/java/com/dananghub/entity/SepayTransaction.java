package com.dananghub.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "SepayTransactions")
public class SepayTransaction implements Serializable {

    @Id
    @Column(name = "Id")
    private int id;

    @Column(name = "Gateway", length = 50)
    private String gateway;

    @Column(name = "TransactionDate", length = 50)
    private String transactionDate;

    @Column(name = "AccountNumber", length = 50)
    private String accountNumber;

    @Column(name = "Code", length = 100)
    private String code;

    @Column(name = "Content", length = 500)
    private String content;

    @Column(name = "TransferType", length = 20)
    private String transferType;

    @Column(name = "TransferAmount")
    private double transferAmount;

    @Column(name = "Accumulated")
    private double accumulated;

    @Column(name = "SubAccount", length = 50)
    private String subAccount;

    @Column(name = "ReferenceCode", length = 100)
    private String referenceCode;

    @Column(name = "Description", length = 500)
    private String description;

    @Column(name = "CreatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    public SepayTransaction() {
        this.createdAt = new Date();
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getGateway() { return gateway; }
    public void setGateway(String gateway) { this.gateway = gateway; }

    public String getTransactionDate() { return transactionDate; }
    public void setTransactionDate(String transactionDate) { this.transactionDate = transactionDate; }

    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getTransferType() { return transferType; }
    public void setTransferType(String transferType) { this.transferType = transferType; }

    public double getTransferAmount() { return transferAmount; }
    public void setTransferAmount(double transferAmount) { this.transferAmount = transferAmount; }

    public double getAccumulated() { return accumulated; }
    public void setAccumulated(double accumulated) { this.accumulated = accumulated; }

    public String getSubAccount() { return subAccount; }
    public void setSubAccount(String subAccount) { this.subAccount = subAccount; }

    public String getReferenceCode() { return referenceCode; }
    public void setReferenceCode(String referenceCode) { this.referenceCode = referenceCode; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
