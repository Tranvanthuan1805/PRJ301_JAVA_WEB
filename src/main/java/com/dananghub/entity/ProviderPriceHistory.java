package com.dananghub.entity;

/**
 * ====================================================
 * MODULE 1: QUAN TRI NHA CUNG CAP - Le Phuoc Sang
 * ====================================================
 * Bang: ProviderPriceHistory
 * Chuc nang: Theo doi va so sanh gia dich vu giua cac NCC
 *   - Luu lich su thay doi gia cua tung NCC
 *   - Ho tro doanh nghiep lua chon doi tac toi uu chi phi
 *
 * Lien ket: Providers (1:N) -> ProviderPriceHistory
 *
 * TODO cho Sang:
 *   1. Tao ProviderPriceHistoryDAO.java
 *      - findByProviderId(int providerId)
 *      - findByServiceType(String serviceType)
 *      - comparePrice(String serviceType) -> so sanh gia giua NCC
 *      - getLatestPrice(int providerId, String serviceName)
 *   2. Tao ProviderPriceServlet.java (hoac tich hop vao ProviderServlet hien co)
 *   3. Tao trang JSP so sanh gia: views/provider-management/price-compare.jsp
 *   4. Them bieu do line chart so sanh gia theo thoi gian
 * ====================================================
 */

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "ProviderPriceHistory")
public class ProviderPriceHistory implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "PriceId")
    private int priceId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "ProviderId", nullable = false)
    private Provider provider;

    @Column(name = "ServiceType", nullable = false, length = 50)
    private String serviceType; // Hotel, Flight, Tour, Transport

    @Column(name = "ServiceName", nullable = false, length = 200)
    private String serviceName;

    @Column(name = "OldPrice")
    private Double oldPrice;

    @Column(name = "NewPrice", nullable = false)
    private double newPrice;

    @Column(name = "ChangeDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date changeDate;

    @Column(name = "Note", length = 500)
    private String note;

    public ProviderPriceHistory() {}

    // TODO Sang: Tinh % thay doi gia
    public double getPriceChangePercent() {
        if (oldPrice == null || oldPrice == 0) return 0;
        return ((newPrice - oldPrice) / oldPrice) * 100;
    }

    // Getters and Setters
    public int getPriceId() { return priceId; }
    public void setPriceId(int priceId) { this.priceId = priceId; }

    public Provider getProvider() { return provider; }
    public void setProvider(Provider provider) { this.provider = provider; }

    public String getServiceType() { return serviceType; }
    public void setServiceType(String serviceType) { this.serviceType = serviceType; }

    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }

    public Double getOldPrice() { return oldPrice; }
    public void setOldPrice(Double oldPrice) { this.oldPrice = oldPrice; }

    public double getNewPrice() { return newPrice; }
    public void setNewPrice(double newPrice) { this.newPrice = newPrice; }

    public Date getChangeDate() { return changeDate; }
    public void setChangeDate(Date changeDate) { this.changeDate = changeDate; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
}
