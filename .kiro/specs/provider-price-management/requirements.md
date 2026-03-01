# Requirements Document

## Introduction

Chức năng Provider Price Management cho phép hệ thống Da Nang Travel Hub theo dõi, so sánh và phân tích giá dịch vụ từ các nhà cung cấp (NCC) khác nhau. Hệ thống lưu trữ lịch sử thay đổi giá, hỗ trợ doanh nghiệp đưa ra quyết định tối ưu chi phí khi lựa chọn đối tác và định giá tour du lịch.

## Glossary

- **Price_History_DAO**: Data Access Object quản lý truy vấn dữ liệu lịch sử giá từ database
- **Provider**: Nhà cung cấp dịch vụ (khách sạn, vận chuyển, tour)
- **Service_Type**: Loại dịch vụ (Hotel, Flight, Tour, Transport)
- **Price_Record**: Bản ghi lịch sử giá bao gồm giá cũ, giá mới, ngày thay đổi
- **Latest_Price**: Giá mới nhất của một dịch vụ từ một NCC cụ thể
- **Price_Comparison_Servlet**: Servlet xử lý các request liên quan đến so sánh giá
- **Price_Comparison_JSP**: Trang JSP hiển thị giao diện so sánh giá
- **Chart_Component**: Biểu đồ line chart hiển thị xu hướng giá theo thời gian

## Requirements

### Requirement 1: Truy vấn lịch sử giá theo loại dịch vụ

**User Story:** Là một quản trị viên, tôi muốn xem tất cả lịch sử giá của một loại dịch vụ cụ thể, để có thể so sánh giá giữa các nhà cung cấp khác nhau.

#### Acceptance Criteria

1. WHEN quản trị viên chọn một Service_Type, THE Price_History_DAO SHALL trả về danh sách tất cả Price_Record của Service_Type đó
2. THE Price_History_DAO SHALL sắp xếp kết quả theo changeDate giảm dần
3. THE Price_History_DAO SHALL bao gồm thông tin Provider liên kết với mỗi Price_Record
4. WHEN Service_Type không tồn tại trong database, THE Price_History_DAO SHALL trả về danh sách rỗng

### Requirement 2: So sánh giá giữa các nhà cung cấp

**User Story:** Là một quản trị viên, tôi muốn so sánh giá của cùng một dịch vụ giữa các nhà cung cấp khác nhau, để chọn đối tác có giá tốt nhất.

#### Acceptance Criteria

1. WHEN quản trị viên yêu cầu so sánh giá cho một Service_Type và serviceName cụ thể, THE Price_History_DAO SHALL trả về Latest_Price của mỗi Provider
2. THE Price_History_DAO SHALL nhóm kết quả theo providerId
3. THE Price_History_DAO SHALL chỉ lấy bản ghi có changeDate mới nhất cho mỗi Provider
4. THE Price_History_DAO SHALL bao gồm thông tin Provider name và businessName trong kết quả
5. WHEN không có Price_Record nào cho serviceName được chỉ định, THE Price_History_DAO SHALL trả về danh sách rỗng

### Requirement 3: Lấy giá mới nhất của một nhà cung cấp

**User Story:** Là một quản trị viên, tôi muốn xem giá hiện tại của một dịch vụ cụ thể từ một nhà cung cấp, để cập nhật thông tin định giá tour.

#### Acceptance Criteria

1. WHEN quản trị viên yêu cầu Latest_Price với providerId và serviceName cụ thể, THE Price_History_DAO SHALL trả về một Price_Record duy nhất
2. THE Price_History_DAO SHALL sắp xếp theo changeDate giảm dần và lấy bản ghi đầu tiên
3. THE Price_History_DAO SHALL bao gồm oldPrice, newPrice, changeDate và note trong kết quả
4. WHEN không tìm thấy Price_Record phù hợp, THE Price_History_DAO SHALL trả về null

### Requirement 4: Xử lý request so sánh giá qua Servlet

**User Story:** Là một quản trị viên, tôi muốn truy cập trang so sánh giá qua URL, để xem giao diện phân tích giá.

#### Acceptance Criteria

1. WHEN quản trị viên truy cập URL với action là "compare", THE Price_Comparison_Servlet SHALL gọi Price_History_DAO để lấy dữ liệu so sánh
2. WHEN request chứa tham số serviceType, THE Price_Comparison_Servlet SHALL lọc dữ liệu theo Service_Type đó
3. WHEN request chứa tham số serviceName, THE Price_Comparison_Servlet SHALL gọi comparePrice với cả serviceType và serviceName
4. THE Price_Comparison_Servlet SHALL đặt dữ liệu vào request attribute với tên "priceComparisons"
5. THE Price_Comparison_Servlet SHALL forward request đến Price_Comparison_JSP
6. IF xảy ra lỗi trong quá trình xử lý, THEN THE Price_Comparison_Servlet SHALL đặt error message vào request và forward đến error page

### Requirement 5: Hiển thị dữ liệu so sánh giá trên JSP

**User Story:** Là một quản trị viên, tôi muốn xem bảng so sánh giá với dữ liệu thực từ database, để đưa ra quyết định kinh doanh.

#### Acceptance Criteria

1. THE Price_Comparison_JSP SHALL sử dụng JSTL để lặp qua danh sách priceComparisons
2. THE Price_Comparison_JSP SHALL hiển thị Provider name, oldPrice, newPrice, changeDate cho mỗi Price_Record
3. THE Price_Comparison_JSP SHALL tính và hiển thị phần trăm thay đổi giá bằng cách gọi getPriceChangePercent
4. WHEN phần trăm thay đổi lớn hơn 20%, THE Price_Comparison_JSP SHALL hiển thị màu đỏ với label "High Risk"
5. WHEN phần trăm thay đổi từ 10% đến 20%, THE Price_Comparison_JSP SHALL hiển thị màu vàng với label "Medium Risk"
6. WHEN phần trăm thay đổi nhỏ hơn 10%, THE Price_Comparison_JSP SHALL hiển thị màu xanh với label "Low Risk"
7. WHEN danh sách priceComparisons rỗng, THE Price_Comparison_JSP SHALL hiển thị thông báo "No price data available"

### Requirement 6: Hiển thị biểu đồ xu hướng giá

**User Story:** Là một quản trị viên, tôi muốn xem biểu đồ line chart thể hiện xu hướng giá theo thời gian, để phân tích biến động giá của các nhà cung cấp.

#### Acceptance Criteria

1. THE Price_Comparison_JSP SHALL tích hợp thư viện Chart.js để vẽ biểu đồ
2. WHEN trang được load, THE Chart_Component SHALL lấy dữ liệu từ priceComparisons attribute
3. THE Chart_Component SHALL vẽ một đường line cho mỗi Provider
4. THE Chart_Component SHALL sử dụng changeDate làm trục X và newPrice làm trục Y
5. THE Chart_Component SHALL hiển thị legend với tên của mỗi Provider
6. THE Chart_Component SHALL cho phép hover để xem chi tiết giá tại mỗi điểm dữ liệu
7. WHEN không có dữ liệu, THE Chart_Component SHALL hiển thị placeholder text "No data available for chart"

### Requirement 7: Lọc dữ liệu theo loại dịch vụ

**User Story:** Là một quản trị viên, tôi muốn lọc dữ liệu so sánh giá theo loại dịch vụ, để tập trung phân tích một loại dịch vụ cụ thể.

#### Acceptance Criteria

1. THE Price_Comparison_JSP SHALL hiển thị dropdown select với các Service_Type (Hotel, Flight, Tour, Transport)
2. WHEN quản trị viên chọn một Service_Type từ dropdown, THE Price_Comparison_JSP SHALL gửi request đến Price_Comparison_Servlet với tham số serviceType
3. THE Price_Comparison_Servlet SHALL reload trang với dữ liệu đã lọc
4. THE Price_Comparison_JSP SHALL giữ giá trị đã chọn trong dropdown sau khi reload
5. THE Price_Comparison_JSP SHALL cập nhật cả bảng và biểu đồ với dữ liệu đã lọc

### Requirement 8: Xử lý lỗi và validation

**User Story:** Là một quản trị viên, tôi muốn hệ thống xử lý lỗi một cách rõ ràng, để biết khi nào có vấn đề xảy ra.

#### Acceptance Criteria

1. WHEN Price_History_DAO gặp SQLException, THE Price_History_DAO SHALL log lỗi và trả về danh sách rỗng hoặc null
2. WHEN Price_Comparison_Servlet nhận được request với tham số không hợp lệ, THE Price_Comparison_Servlet SHALL đặt error message vào request attribute
3. THE Price_Comparison_JSP SHALL kiểm tra sự tồn tại của error message và hiển thị nó ở đầu trang
4. WHEN EntityManager không thể tạo connection, THE Price_History_DAO SHALL throw RuntimeException với thông báo rõ ràng
5. THE Price_Comparison_Servlet SHALL đóng EntityManager trong khối finally để tránh memory leak
