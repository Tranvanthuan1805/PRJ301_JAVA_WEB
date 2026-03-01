# Implementation Plan: Provider Price Management

## Overview

Triển khai module Provider Price Management cho phép quản trị viên theo dõi, so sánh và phân tích giá dịch vụ từ các nhà cung cấp. Module sử dụng Java EE với JPA/Hibernate cho backend, JSP/JSTL cho frontend, và Chart.js cho visualization.

## Tasks

- [x] 1. Thiết lập cấu trúc dự án và entities
  - [x] 1.1 Tạo hoặc cập nhật ProviderPriceHistory entity
    - Định nghĩa các fields với JPA annotations (@Entity, @Table, @Column)
    - Thiết lập relationship với Provider entity (@ManyToOne, @JoinColumn)
    - Implement method getPriceChangePercent() để tính phần trăm thay đổi giá
    - _Requirements: 5.3, 8.4_
  
  - [ ]* 1.2 Write property test for price change calculation
    - **Property 8: Price Change Calculation**
    - **Validates: Requirements 5.3**
    - Test với các giá trị random oldPrice và newPrice
    - Verify công thức: ((newPrice - oldPrice) / oldPrice) * 100
    - Test edge cases: oldPrice = 0, oldPrice = null
  
  - [x] 1.3 Verify Provider entity tồn tại và có đầy đủ fields
    - Kiểm tra Provider entity có providerId, businessName, providerType
    - Đảm bảo relationship với ProviderPriceHistory được thiết lập đúng
    - _Requirements: 1.3, 2.4_

- [x] 2. Implement ProviderPriceHistoryDAO
  - [x] 2.1 Tạo ProviderPriceHistoryDAO class với EntityManagerFactory
    - Setup EntityManagerFactory injection hoặc initialization
    - Implement constructor và resource management
    - _Requirements: 8.5_
  
  - [x] 2.2 Implement findByServiceType method
    - Viết JPQL query với WHERE clause và ORDER BY changeDate DESC
    - Implement try-catch-finally với EntityManager cleanup
    - Return empty list khi có exception
    - _Requirements: 1.1, 1.2, 1.3, 1.4_
  
  - [ ]* 2.3 Write property test for service type filtering
    - **Property 1: Service Type Filtering**
    - **Validates: Requirements 1.1**
    - Generate random service types và database states
    - Verify tất cả records trả về match với service type requested
  
  - [ ]* 2.4 Write property test for descending date order
    - **Property 2: Descending Date Order**
    - **Validates: Requirements 1.2**
    - Generate random lists of price records với random dates
    - Verify list được sort theo changeDate DESC
  
  - [x] 2.5 Implement comparePrice method
    - Viết query để lấy latest price của mỗi provider cho service type và service name
    - Group by providerId và lấy record với changeDate mới nhất
    - Include provider information trong kết quả
    - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5_
  
  - [ ]* 2.6 Write property test for latest price uniqueness
    - **Property 5: Latest Price Uniqueness**
    - **Validates: Requirements 2.1, 2.2, 2.3**
    - Generate random service types và multiple price records per provider
    - Verify mỗi provider chỉ xuất hiện một lần với changeDate lớn nhất
  
  - [x] 2.7 Implement getLatestPrice method
    - Query với WHERE conditions (providerId và serviceName)
    - ORDER BY changeDate DESC và setMaxResults(1)
    - Return null nếu không tìm thấy
    - _Requirements: 3.1, 3.2, 3.3, 3.4_
  
  - [ ]* 2.8 Write property test for single record return
    - **Property 6: Single Record Return**
    - **Validates: Requirements 3.1, 3.2**
    - Generate random provider IDs và service names
    - Verify method returns single object hoặc null, không phải list
  
  - [ ]* 2.9 Write property test for empty result handling
    - **Property 4: Empty Result for Non-Existent Data**
    - **Validates: Requirements 1.4, 2.5, 3.4**
    - Generate random non-existent IDs và names
    - Verify returns empty list hoặc null without exception

- [ ] 3. Checkpoint - Verify DAO layer hoạt động đúng
  - Ensure all tests pass, ask the user if questions arise.

- [x] 4. Implement PriceComparisonServlet
  - [x] 4.1 Tạo PriceComparisonServlet với @WebServlet annotation
    - Setup servlet mapping: /price-comparison
    - Initialize ProviderPriceHistoryDAO instance
    - Implement doGet method với action routing
    - _Requirements: 4.1_
  
  - [x] 4.2 Implement handleCompare method
    - Parse serviceType và serviceName parameters từ request
    - Gọi DAO methods tương ứng (comparePrice hoặc findByServiceType)
    - Set priceComparisons attribute vào request
    - Forward đến price-compare.jsp
    - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5_
  
  - [x] 4.3 Implement handleFilter method
    - Parse serviceType parameter
    - Gọi DAO.findByServiceType
    - Set filtered data vào request attribute
    - Forward đến JSP
    - _Requirements: 7.2, 7.3_
  
  - [x] 4.4 Implement error handling trong servlet
    - Catch exceptions và set error message vào request
    - Forward đến error page khi có lỗi
    - Implement finally block để cleanup resources
    - _Requirements: 4.6, 8.2, 8.5_
  
  - [ ]* 4.5 Write property test for servlet request attribute setting
    - **Property 9: Servlet Request Attribute Setting**
    - **Validates: Requirements 4.4**
    - Generate random valid requests
    - Verify priceComparisons attribute được set
  
  - [ ]* 4.6 Write property test for servlet parameter processing
    - **Property 10: Servlet Parameter Processing**
    - **Validates: Requirements 4.2, 4.3**
    - Generate random serviceType parameters
    - Verify filtered results match parameter

- [x] 5. Implement price-compare.jsp
  - [x] 5.1 Tạo JSP structure với JSTL imports
    - Import JSTL core và fmt taglibs
    - Setup HTML structure với Bootstrap hoặc CSS framework
    - _Requirements: 5.1_
  
  - [x] 5.2 Implement service type filter dropdown
    - Tạo HTML select element với options: Hotel, Flight, Tour, Transport
    - Implement JavaScript onchange event để submit form
    - Giữ selected value sau khi reload
    - _Requirements: 7.1, 7.2, 7.4_
  
  - [x] 5.3 Implement price comparison table
    - Sử dụng JSTL <c:forEach> để loop qua priceComparisons
    - Hiển thị Provider name, oldPrice, newPrice, changeDate
    - Gọi getPriceChangePercent() và hiển thị phần trăm thay đổi
    - _Requirements: 5.1, 5.2, 5.3_
  
  - [x] 5.4 Implement risk level color coding
    - Tính phần trăm thay đổi giá
    - Apply màu đỏ cho > 20% (High Risk)
    - Apply màu vàng cho 10-20% (Medium Risk)
    - Apply màu xanh cho < 10% (Low Risk)
    - _Requirements: 5.4, 5.5, 5.6_
  
  - [x] 5.5 Implement empty data handling
    - Check if priceComparisons is empty
    - Hiển thị "No price data available" message
    - _Requirements: 5.7_
  
  - [x] 5.6 Implement error message display
    - Check for errorMessage attribute
    - Hiển thị error message ở đầu trang trong alert box
    - _Requirements: 8.3_

- [x] 6. Implement Chart.js visualization
  - [x] 6.1 Integrate Chart.js library
    - Add Chart.js CDN link vào JSP
    - Tạo canvas element cho chart
    - _Requirements: 6.1_
  
  - [x] 6.2 Implement price trend line chart
    - Extract data từ priceComparisons attribute
    - Transform data thành Chart.js format (labels và datasets)
    - Tạo một line cho mỗi provider
    - Setup X-axis (changeDate) và Y-axis (newPrice)
    - _Requirements: 6.2, 6.3, 6.4_
  
  - [x] 6.3 Implement chart interactivity
    - Enable tooltips để show chi tiết giá
    - Add legend với tên providers
    - _Requirements: 6.5, 6.6_
  
  - [x] 6.4 Handle empty chart data
    - Check if data is empty
    - Display "No data available for chart" placeholder
    - _Requirements: 6.7_

- [x] 7. Implement comprehensive error handling
  - [x] 7.1 Add logging throughout DAO layer
    - Setup java.util.logging hoặc SLF4J
    - Log errors trong catch blocks
    - _Requirements: 8.1_
  
  - [x] 7.2 Verify EntityManager cleanup
    - Ensure finally blocks close EntityManager
    - Test với error scenarios
    - _Requirements: 8.5_
  
  - [ ]* 7.3 Write property test for exception handling in DAO
    - **Property 11: Exception Handling in DAO**
    - **Validates: Requirements 8.1**
    - Generate scenarios that trigger exceptions
    - Verify returns empty/null without propagating exception
  
  - [ ]* 7.4 Write property test for servlet error handling
    - **Property 12: Servlet Error Handling**
    - **Validates: Requirements 4.6, 8.2**
    - Generate random invalid requests và error scenarios
    - Verify error message set và forwards to error page
  
  - [ ]* 7.5 Write property test for resource cleanup
    - **Property 13: Resource Cleanup**
    - **Validates: Requirements 8.5**
    - Generate random DAO method calls (success và failure)
    - Verify EntityManager.close() được gọi

- [x] 8. Integration và testing
  - [x] 8.1 Wire all components together
    - Verify servlet có thể gọi DAO methods
    - Verify JSP có thể access request attributes
    - Test end-to-end flow từ URL đến rendered page
    - _Requirements: All_
  
  - [ ]* 8.2 Write integration tests
    - Test complete flow: HTTP request → Servlet → DAO → Database → JSP
    - Test với real database (H2 in-memory)
    - Verify JSTL rendering với sample data
    - _Requirements: All_
  
  - [ ]* 8.3 Write unit tests for edge cases
    - Test null parameters
    - Test empty database
    - Test invalid service types
    - Test date formatting
    - Test price formatting

- [ ] 9. Final checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

## Notes

- Tasks marked with `*` are optional and can be skipped for faster MVP
- Each task references specific requirements for traceability
- Property tests sử dụng QuickTheories library với minimum 100 iterations
- All property tests phải có tag format: `Feature: provider-price-management, Property N: Title`
- EntityManager cleanup là critical để tránh memory leaks
- JSTL được sử dụng cho safe output và prevent XSS
- Chart.js cần data trong format: {labels: [], datasets: [{label, data, borderColor}]}
