# Deployment Checklist - Customer Management Module

## Pre-Deployment

### 1. Database Setup
- [ ] SQL Server đang chạy
- [ ] Database `AdminUser` đã tồn tại
- [ ] Chạy script `CUSTOMER_MANAGEMENT_SETUP.sql`
- [ ] Kiểm tra bảng `Customers` đã tạo
- [ ] Kiểm tra bảng `CustomerActivities` đã tạo
- [ ] Kiểm tra sample data đã insert (5 customers)
- [ ] Test query: `SELECT * FROM Customers`

### 2. Project Configuration
- [ ] File `DBUtil.java` có connection string đúng
- [ ] Database name: `AdminUser`
- [ ] Username/password đúng
- [ ] Port: 1433 (hoặc port của bạn)
- [ ] `trustServerCertificate=true` nếu dùng localhost

### 3. Dependencies
- [ ] File `mssql-jdbc-12.2.0.jre8.jar` trong `WEB-INF/lib/`
- [ ] Jakarta Servlet API (Tomcat 10+ tự có)
- [ ] JSTL library trong `WEB-INF/lib/`

### 4. Build Project
- [ ] Clean project: `ant clean` hoặc NetBeans Clean
- [ ] Build project: `ant dist` hoặc NetBeans Build
- [ ] Không có compilation errors
- [ ] File `Login.war` được tạo trong `dist/`

## Deployment

### 5. Deploy to Tomcat
- [ ] Tomcat đang chạy
- [ ] Copy `Login.war` vào `Tomcat/webapps/`
- [ ] Tomcat tự động extract WAR
- [ ] Folder `Login/` xuất hiện trong `webapps/`
- [ ] Không có errors trong `catalina.out`

### 6. Verify Deployment
- [ ] Truy cập: `http://localhost:8080/Login/`
- [ ] Không có 404 error
- [ ] Truy cập: `http://localhost:8080/Login/login.jsp`
- [ ] Trang login hiển thị đúng

## Post-Deployment Testing

### 7. Authentication Tests
- [ ] Login với ADMIN account
- [ ] Redirect đến `admin.jsp`
- [ ] Thấy card "Quản lý Khách hàng"
- [ ] Logout thành công

### 8. Customer List Tests
- [ ] Truy cập `/admin/customers`
- [ ] Hiển thị danh sách 5 khách hàng mẫu
- [ ] Header VietAir style hiển thị đúng
- [ ] Search box hoạt động
- [ ] Filter dropdown hoạt động
- [ ] Stats card hiển thị số đúng
- [ ] Table có blue gradient header
- [ ] Status badges có màu đúng

### 9. Search & Filter Tests
- [ ] Search "Nguyễn" → tìm thấy khách hàng
- [ ] Search "gmail.com" → tìm thấy email
- [ ] Search "0901" → tìm thấy phone
- [ ] Filter "active" → chỉ hiển thị active
- [ ] Filter "banned" → chỉ hiển thị banned
- [ ] Click "Làm mới" → reset về danh sách đầy đủ

### 10. Pagination Tests
- [ ] Nếu > 10 customers, pagination xuất hiện
- [ ] Click số trang → chuyển trang đúng
- [ ] Click prev/next arrows → hoạt động
- [ ] Current page được highlight

### 11. Customer Detail Tests
- [ ] Click "Xem" bất kỳ customer nào
- [ ] Hiển thị trang chi tiết
- [ ] Thông tin cơ bản hiển thị đầy đủ
- [ ] Form edit hiển thị đúng
- [ ] Stats boxes hiển thị số đúng
- [ ] Timeline activities hiển thị

### 12. Update Tests
- [ ] Sửa tên customer
- [ ] Click "Lưu thay đổi"
- [ ] Alert success xuất hiện
- [ ] Thông tin đã được cập nhật
- [ ] Kiểm tra database: `SELECT * FROM Customers WHERE id = X`

### 13. Lock/Unlock Tests
- [ ] Customer có status "active"
- [ ] Click "Khóa tài khoản"
- [ ] Confirm dialog xuất hiện
- [ ] Click OK
- [ ] Alert success xuất hiện
- [ ] Status chuyển sang "banned"
- [ ] Button đổi thành "Mở khóa"
- [ ] Click "Mở khóa"
- [ ] Status chuyển lại "active"

### 14. Authorization Tests
- [ ] Logout khỏi ADMIN
- [ ] Login với USER account
- [ ] Thử truy cập `/admin/customers`
- [ ] Bị redirect về `error.jsp`
- [ ] Logout
- [ ] Thử truy cập `/admin/customers` (chưa login)
- [ ] Bị redirect về `login.jsp`

### 15. UI/UX Tests
- [ ] Header có blue gradient
- [ ] Logo VietAir hiển thị
- [ ] Navigation menu hoạt động
- [ ] Cards có shadow
- [ ] Hover effects hoạt động
- [ ] Buttons có gradient
- [ ] Transitions mượt mà
- [ ] Icons Font Awesome hiển thị
- [ ] Responsive trên mobile (resize browser)

### 16. UTF-8 Tests
- [ ] Tên tiếng Việt hiển thị đúng
- [ ] Địa chỉ tiếng Việt hiển thị đúng
- [ ] Search tiếng Việt hoạt động
- [ ] Update tiếng Việt hoạt động
- [ ] Không có ký tự lỗi (???, □□□)

### 17. Error Handling Tests
- [ ] Truy cập customer không tồn tại: `/admin/customers?action=view&id=999`
- [ ] Xử lý lỗi gracefully
- [ ] Submit form với data invalid
- [ ] Error message hiển thị
- [ ] Database connection fail → error page

### 18. Performance Tests
- [ ] Page load < 2 seconds
- [ ] Search response < 1 second
- [ ] Update response < 1 second
- [ ] No memory leaks (check Tomcat logs)
- [ ] No connection pool exhaustion

## Production Checklist

### 19. Security Review
- [ ] AuthFilter hoạt động đúng
- [ ] SQL injection không thành công
- [ ] XSS không thành công
- [ ] Session timeout hoạt động (30 phút)
- [ ] HTTPS enabled (production)
- [ ] Passwords không hardcode
- [ ] Sensitive data không log

### 20. Code Review
- [ ] Không có System.out.println() debug
- [ ] Không có TODO comments chưa xử lý
- [ ] Exception handling đầy đủ
- [ ] Resource cleanup (close connections)
- [ ] Code formatting consistent
- [ ] Comments đầy đủ

### 21. Documentation Review
- [ ] README.md đầy đủ
- [ ] QUICK_START_GUIDE.md rõ ràng
- [ ] API documentation (nếu có)
- [ ] Database schema documented
- [ ] Deployment guide đầy đủ

### 22. Backup & Rollback Plan
- [ ] Backup database trước khi deploy
- [ ] Backup code cũ
- [ ] Có rollback plan
- [ ] Test rollback procedure
- [ ] Document rollback steps

## Sign-Off

### Developer
- [ ] All features implemented
- [ ] All tests passed
- [ ] Code reviewed
- [ ] Documentation complete
- [ ] Ready for QA

**Developer**: _________________ **Date**: _________

### QA
- [ ] Functional tests passed
- [ ] UI/UX tests passed
- [ ] Security tests passed
- [ ] Performance acceptable
- [ ] Ready for production

**QA**: _________________ **Date**: _________

### Deployment
- [ ] Deployed to production
- [ ] Smoke tests passed
- [ ] Monitoring enabled
- [ ] Team notified

**DevOps**: _________________ **Date**: _________

## Post-Deployment

### 23. Monitoring
- [ ] Check Tomcat logs: `catalina.out`
- [ ] Check application logs
- [ ] Monitor database connections
- [ ] Monitor response times
- [ ] Monitor error rates

### 24. User Acceptance
- [ ] Admin users trained
- [ ] User feedback collected
- [ ] Issues documented
- [ ] Support plan in place

## Rollback Procedure (If Needed)

1. Stop Tomcat
2. Remove `Login/` folder from `webapps/`
3. Remove `Login.war` from `webapps/`
4. Restore old `Login.war`
5. Restore database backup
6. Start Tomcat
7. Verify old version working

## Support Contacts

- **Developer**: [Your Name/Email]
- **DBA**: [DBA Name/Email]
- **DevOps**: [DevOps Name/Email]
- **Manager**: [Manager Name/Email]

## Notes

- Deployment date: __________
- Version: 1.0.0
- Environment: Production/Staging/Development
- Special instructions: ___________________________

---

**Status**: ⬜ Not Started | 🟡 In Progress | ✅ Complete | ❌ Failed

**Overall Status**: _____________

**Deployed By**: _________________ **Date**: _________
