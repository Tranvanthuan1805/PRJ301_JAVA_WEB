# 🔄 Sửa lỗi Redirect sau khi Đăng nhập

## 🎯 Vấn đề

Khi user click vào menu NCC:
1. ❌ Redirect đến login (vì chưa đăng nhập)
2. ❌ Đăng nhập bằng admin
3. ❌ Nhảy đến admin dashboard (không liên quan đến NCC)

**Kết quả:** User muốn xem NCC nhưng lại bị đưa đến admin dashboard

---

## ✅ Giải pháp

Thêm logic **"Return URL"** (URL quay lại):

1. Khi user chưa đăng nhập click NCC → redirect login **kèm returnUrl**
2. User đăng nhập
3. Sau khi đăng nhập → redirect về **returnUrl** (trang NCC) thay vì dashboard

---

## 🔧 Các thay đổi

### 1. AuthFilter.java

**Thay đổi:** Thêm returnUrl khi redirect login

```java
// Nếu chưa đăng nhập, redirect đến login với returnUrl
if (user == null) {
    String requestUri = request.getRequestURI();
    String returnUrl = requestUri.substring(contextPath.length());
    if (queryString != null && !queryString.isEmpty()) {
        returnUrl += "?" + queryString;
    }
    
    response.sendRedirect(contextPath + "/login.jsp?returnUrl=" + 
        java.net.URLEncoder.encode(returnUrl, "UTF-8"));
    return;
}
```

**Kết quả:**
- URL redirect: `/login.jsp?returnUrl=%2Fadmin%2Fproviders`
- Lưu lại trang mà user muốn truy cập

### 2. LoginServlet.java

**Thay đổi:** Kiểm tra returnUrl sau khi đăng nhập

```java
// Kiểm tra xem user muốn truy cập trang nào trước khi redirect login
String returnUrl = request.getParameter("returnUrl");
if (returnUrl != null && !returnUrl.isEmpty()) {
    // Nếu có returnUrl, redirect về trang đó
    response.sendRedirect(ctx + returnUrl);
    return;
}

// Nếu không có returnUrl, redirect theo role (default behavior)
String roleName = user.getRoleName();
if ("ADMIN".equals(roleName)) {
    response.sendRedirect(ctx + "/admin/dashboard");
} else if ("PROVIDER".equals(roleName)) {
    response.sendRedirect(ctx + "/provider/dashboard");
} else {
    response.sendRedirect(ctx + "/home");
}
```

**Kết quả:**
- Nếu có returnUrl → redirect về trang đó
- Nếu không có → redirect theo role (default)

### 3. login.jsp

**Thay đổi:** Thêm hidden input để lưu returnUrl

```html
<form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">
    <!-- Lưu returnUrl nếu có -->
    <c:if test="${not empty param.returnUrl}">
        <input type="hidden" name="returnUrl" value="${param.returnUrl}">
    </c:if>
    
    <!-- Form fields -->
    ...
</form>
```

**Kết quả:**
- returnUrl được gửi lại trong form POST
- LoginServlet nhận được returnUrl

---

## 📊 Flow Diagram

### Trước (Sai):
```
User click NCC
    ↓
Redirect login (không lưu URL)
    ↓
User đăng nhập admin
    ↓
Redirect /admin/dashboard ❌ (không liên quan NCC)
```

### Sau (Đúng):
```
User click NCC (/admin/providers)
    ↓
Redirect login?returnUrl=%2Fadmin%2Fproviders ✅
    ↓
User đăng nhập admin
    ↓
Redirect /admin/providers ✅ (quay lại trang NCC)
```

---

## 🧪 Test

### Bước 1: Xóa session (logout)
- Đóng trình duyệt hoặc xóa cookies

### Bước 2: Click menu NCC
- Truy cập: `http://localhost:8080/your-context/admin/providers`
- Kết quả: Redirect đến login

### Bước 3: Kiểm tra URL
- URL login phải có: `?returnUrl=%2Fadmin%2Fproviders`
- Nếu không có → có vấn đề với AuthFilter

### Bước 4: Đăng nhập admin
- Nhập username/password admin
- Click "ĐĂNG NHẬP"

### Bước 5: Kiểm tra kết quả
- ✅ Nếu redirect về `/admin/providers` → Thành công!
- ❌ Nếu redirect về `/admin/dashboard` → Có vấn đề

---

## 🐛 Troubleshooting

### Vấn đề 1: Vẫn redirect đến dashboard
**Nguyên nhân:** LoginServlet không nhận được returnUrl
**Giải pháp:**
1. Kiểm tra login.jsp có hidden input không
2. Kiểm tra form method là POST
3. Restart server

### Vấn đề 2: URL encoding lỗi
**Nguyên nhân:** returnUrl không được encode đúng
**Giải pháp:**
1. Kiểm tra URLEncoder.encode() trong AuthFilter
2. Kiểm tra login.jsp có decode đúng không

### Vấn đề 3: returnUrl bị mất
**Nguyên nhân:** Session timeout hoặc cookie bị xóa
**Giải pháp:**
1. Kiểm tra session timeout trong web.xml
2. Kiểm tra browser có chặn cookies không

---

## 📝 Các file đã sửa

1. ✅ `src/main/java/com/dananghub/filter/AuthFilter.java`
   - Thêm logic lưu returnUrl

2. ✅ `src/main/java/com/dananghub/controller/LoginServlet.java`
   - Thêm logic kiểm tra returnUrl
   - Xóa import không cần thiết

3. ✅ `src/main/webapp/login.jsp`
   - Thêm hidden input cho returnUrl

---

## 🎯 Kết quả cuối cùng

✅ User click NCC → Redirect login (lưu URL)
✅ User đăng nhập → Redirect về trang NCC
✅ User không cần đăng nhập → Truy cập NCC trực tiếp
✅ Admin vẫn redirect dashboard nếu không có returnUrl

---

## 💡 Lợi ích

1. **UX tốt hơn:** User được redirect về trang họ muốn
2. **Linh hoạt:** Có thể lưu bất kỳ URL nào
3. **Bảo mật:** Vẫn yêu cầu đăng nhập cho các trang cần thiết
4. **Mở rộng:** Có thể áp dụng cho các trang khác

---

## 🚀 Bước tiếp theo

1. Restart Tomcat server
2. Test flow đăng nhập
3. Kiểm tra redirect URL
4. Xác nhận user được redirect về trang NCC
