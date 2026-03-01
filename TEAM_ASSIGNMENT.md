# PHAN CONG CONG VIEC NHOM 1 - DA NANG TRAVEL HUB
# =============================================
# Moi thanh vien checkout nhanh ci-cd ve va bat dau lam module cua minh.
# Cac file co danh dau TODO + ten thanh vien.
# =============================================

## HUONG DAN CHECKOUT VA PHAT TRIEN

```bash
# 1. Clone hoac pull code moi nhat
git checkout ci-cd
git pull origin ci-cd

# 2. Tao nhanh rieng cho module cua ban
git checkout -b feature/module-X-ten-ban

# 3. Lam xong thi push va tao Pull Request ve ci-cd
git push origin feature/module-X-ten-ban
```

---

## TONG QUAN PHAN CONG

### Le Phuoc Sang - MODULE 1: Quan tri Nha cung cap
**Deadline: Tuan 1 (4/2 - 8/2) + Tuan 2 (9/2 - 14/2)**

| File da co (khung) | Can lam |
|---------------------|---------|
| `entity/Provider.java`            | Da xong |
| `entity/ProviderPriceHistory.java` | **MOI** - Entity da tao, can kiem tra |
| `dao/ProviderDAO.java`            | Da co, can bo sung them method |
| `dao/ProviderPriceHistoryDAO.java` | **MOI** - Can hoan thien cac TODO |
| `views/provider-management/`      | Can lam giao dien |

**TODO chi tiet:**
- [ ] Hoan thien `ProviderPriceHistoryDAO.java` (cac method so sanh gia)
- [ ] Tao trang quan ly NCC: CRUD danh sach NCC
- [ ] Tao trang so sanh gia: `views/provider-management/price-compare.jsp`
- [ ] Them bieu do line chart so sanh gia theo thoi gian
- [ ] Tao `ProviderServlet.java` (hoac bo sung vao cai hien co)

---

### Le Quang Minh - MODULE 2 + 3: Khach hang + Tour du lich
**Deadline: M2 (4/2 - 12/2) + M3 (13/2 - 23/2)**

| File da co (khung) | Can lam |
|---------------------|---------|
| `entity/Customer.java`           | Da xong |
| `entity/CustomerActivity.java`   | Da xong |
| `entity/InteractionHistory.java` | Da xong |
| `entity/Tour.java`               | Da xong, them 3 cot moi |
| `entity/TourSchedule.java`       | **MOI** - Entity da tao |
| `entity/TourPriceSeason.java`    | **MOI** - Entity da tao |
| `dao/CustomerDAO.java`           | Da co |
| `dao/ActivityDAO.java`           | Da co |
| `dao/TourDAO.java`               | Da co, can bo sung |
| `dao/TourScheduleDAO.java`       | **MOI** - Can hoan thien |
| `dao/TourPriceSeasonDAO.java`    | **MOI** - Can hoan thien |

**TODO chi tiet MODULE 2 (Khach hang):**
- [ ] Hoan thien trang `views/customer-management/` (danh sach + ho so khach)
- [ ] Tich hop `ActivityDAO` de hien thi lich su tuong tac
- [ ] Tao trang lich su tuong tac: `views/customer-management/history.jsp`

**TODO chi tiet MODULE 3 (Tour):**
- [ ] Hoan thien `TourScheduleDAO.java` (cac TODO)
- [ ] Hoan thien `TourPriceSeasonDAO.java` (cac TODO)
- [ ] Cap nhat `TourDAO.java`: them method tinh gia mua, dem booking
- [ ] Cap nhat `Tour.java`: them 3 cot moi (SeasonalPrice, CurrentBookings, PopularityScore)
- [ ] Cap nhat `detail.jsp`: hien thi lich khoi hanh + gia mua
- [ ] Tao trang admin quan ly mua gia
- [ ] Logic tu dong dong/mo tour

---

### Le Van Dai - MODULE 4: Gio hang & Dat tour
**Deadline: Tuan 1 (9/2 - 14/2) + Tuan 2 (23/2 - 1/3)**

| File da co (khung) | Can lam |
|---------------------|---------|
| `entity/Cart.java`     | Da co (session-only), can chuyen sang DB |
| `entity/CartItem.java` | Da co, can them JPA annotations |
| `dao/CartDAO.java`     | **MOI** - Can hoan thien tat ca TODO |
| `controller/BookingServlet.java` | Da co, can tich hop CartDAO |

**TODO chi tiet:**
- [ ] Chuyen `Cart.java` tu session-only sang JPA entity (them @Entity, @Table)
- [ ] Chuyen `CartItem.java` sang JPA entity
- [ ] Hoan thien `CartDAO.java` (tat ca method)
- [ ] Cap nhat `BookingServlet.java` de dung CartDAO thay vi session
- [ ] Cap nhat `cart.jsp` de doc tu DB
- [ ] Them logic phat hien abandoned cart (24h khong thao tac)
- [ ] Cap nhat gia realtime khi xem gio hang
- [ ] Xu ly dat tour: Cart -> Order -> Bookings

---

### Nguyen Minh Hieu - MODULE 5 + 6: Don hang + Thanh toan
**Deadline: M5 (3/2 - 10/2) + M6 (10/2 - 17/2)**

| File da co (khung) | Can lam |
|---------------------|---------|
| `entity/Order.java`              | Da xong, them cot RefundAmount |
| `entity/Booking.java`            | Da xong |
| `entity/Payment.java`            | Da xong |
| `entity/SubscriptionPlan.java`   | Da xong |
| `entity/ProviderSubscription.java` | Da xong |
| `entity/PaymentTransaction.java` | Da xong |
| `entity/SepayTransaction.java`   | Da xong |
| `dao/OrderDAO.java`              | Da co |
| `dao/BookingDAO.java`            | Da co |
| `dao/PaymentDAO.java`            | Da co |
| `dao/SubscriptionDAO.java`       | Da co |
| `controller/OrderServlet.java`   | Da co |
| `controller/MyOrderServlet.java` | Da co |
| `controller/payment/*`           | Da co 5 servlet |

**TODO chi tiet MODULE 5 (Don hang):**
- [ ] Bo sung cot `RefundAmount` vao `Order.java`
- [ ] Them logic huy tour va hoan tien trong `OrderServlet.java`
- [ ] Them trang chi tiet don: `views/order-management/order-detail.jsp`
- [ ] Quy trinh: Pending -> Confirmed -> Completed / Cancelled
- [ ] Tu dong cap nhat MonthlyRevenue khi don hoan thanh

**TODO chi tiet MODULE 6 (Thanh toan):**
- [ ] Cap nhat goi dich vu: FREE, PRO_MONTHLY, PRO_QUARTERLY, PRO_YEARLY
- [ ] Them logic kiem tra quyen truy cap AI (goi PRO con han)
- [ ] Test API SePay bang Postman
- [ ] Trang quan ly subscription: gia han, nang cap, het han

---

### Tran Van Thuan (LEADER) - MODULE 7 + 8: AI Forecasting + Chatbot
**Deadline: M7 (4/2 - 18/2) + M8 (10/2 - 20/2)**

| File da co (khung) | Can lam |
|---------------------|---------|
| `entity/MonthlyRevenue.java` | Da xong, them 3 cot moi |
| `entity/AILog.java`          | Da xong |
| `dao/ActivityDAO.java`       | Xem de lay du lieu cho AI |
| `controller/AIChatServlet.java` | Da co |

**TODO chi tiet MODULE 7 (AI Forecasting):**
- [ ] Bo sung cot `NetRevenue`, `CancelledOrders`, `CancelRate` vao `MonthlyRevenue.java`
- [ ] Tao `RevenueDAO.java` de lay du lieu bao cao
- [ ] Tich hop thuật toan Time-series du bao doanh thu
- [ ] Trang bao cao: `views/ai-forecasting/` (bieu do + du bao)
- [ ] Logic kiem tra quyen: chi goi PRO moi xem duoc

**TODO chi tiet MODULE 8 (AI Chatbot):**
- [ ] Cap nhat `AIChatServlet.java` de kiem tra quyen PRO truoc khi dung
- [ ] Tich hop Chatbot AI tu van du lich
- [ ] Luu log vao `AILogs` table
- [ ] Trang chatbot: `views/ai-chatbot/`

---

## CAU TRUC THU MUC

```
src/main/java/com/dananghub/
├── entity/          <- Cac class Entity (JPA)
│   ├── Role.java                    [CHUNG]
│   ├── User.java                    [CHUNG]
│   ├── Provider.java                [SANG - M1]
│   ├── ProviderPriceHistory.java    [SANG - M1] MOI
│   ├── Customer.java                [MINH - M2]
│   ├── CustomerActivity.java        [MINH - M2]
│   ├── InteractionHistory.java      [MINH - M2]
│   ├── Category.java                [MINH - M3]
│   ├── Tour.java                    [MINH - M3]
│   ├── TourImage.java               [MINH - M3]
│   ├── TourSchedule.java            [MINH - M3] MOI
│   ├── TourPriceSeason.java         [MINH - M3] MOI
│   ├── Cart.java                    [DAI - M4] Can chuyen sang JPA
│   ├── CartItem.java                [DAI - M4] Can chuyen sang JPA
│   ├── Order.java                   [HIEU - M5]
│   ├── Booking.java                 [HIEU - M5]
│   ├── Payment.java                 [HIEU - M6]
│   ├── SubscriptionPlan.java        [HIEU - M6]
│   ├── ProviderSubscription.java    [HIEU - M6]
│   ├── PaymentTransaction.java      [HIEU - M6]
│   ├── SepayTransaction.java        [HIEU - M6]
│   ├── MonthlyRevenue.java          [THUAN - M7]
│   └── AILog.java                   [THUAN - M8]
├── dao/             <- Cac class truy van DB
│   ├── ProviderDAO.java             [SANG - M1]
│   ├── ProviderPriceHistoryDAO.java [SANG - M1] MOI
│   ├── CustomerDAO.java             [MINH - M2]
│   ├── ActivityDAO.java             [MINH - M2]
│   ├── TourDAO.java                 [MINH - M3]
│   ├── TourScheduleDAO.java         [MINH - M3] MOI
│   ├── TourPriceSeasonDAO.java      [MINH - M3] MOI
│   ├── CartDAO.java                 [DAI - M4] MOI
│   ├── OrderDAO.java                [HIEU - M5]
│   ├── BookingDAO.java              [HIEU - M5]
│   ├── PaymentDAO.java              [HIEU - M6]
│   └── SubscriptionDAO.java         [HIEU - M6]
└── controller/      <- Cac Servlet xu ly request
    ├── TourServlet.java             [MINH - M3]
    ├── AdminCustomerServlet.java    [MINH - M2]
    ├── BookingServlet.java          [DAI - M4]
    ├── OrderServlet.java            [HIEU - M5]
    ├── MyOrderServlet.java          [HIEU - M5]
    ├── payment/                     [HIEU - M6]
    └── AIChatServlet.java           [THUAN - M8]
```

## DATABASE
- File SQL: `database/DaNangTravelHub_V5_Final.sql`
- So do ERD: `database/ERD_Viewer.html` (mo bang trinh duyet)
- Tai lieu: `database/ERD_Database_Design.md`
