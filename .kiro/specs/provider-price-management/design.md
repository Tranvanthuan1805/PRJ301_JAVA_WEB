# Design Document: Provider Price Management

## Overview

Hệ thống Provider Price Management là một module quan trọng trong Da Nang Travel Hub, cho phép quản trị viên theo dõi, so sánh và phân tích giá dịch vụ từ các nhà cung cấp khác nhau. Module này giúp doanh nghiệp đưa ra quyết định tối ưu chi phí khi lựa chọn đối tác và định giá tour du lịch.

### Key Features

- Lưu trữ lịch sử thay đổi giá của các dịch vụ từ nhà cung cấp
- So sánh giá giữa các nhà cung cấp cho cùng loại dịch vụ
- Hiển thị xu hướng giá theo thời gian qua biểu đồ line chart
- Phân loại rủi ro thay đổi giá (Low/Medium/High Risk)
- Lọc và tìm kiếm dữ liệu theo loại dịch vụ

### Technology Stack

- **Backend**: Java EE (Jakarta EE), JPA/Hibernate
- **Frontend**: JSP, JSTL, Chart.js
- **Database**: SQL Server (via JPA)
- **Architecture**: MVC pattern with DAO layer

## Architecture

### System Architecture

Hệ thống tuân theo kiến trúc MVC (Model-View-Controller) với các layer rõ ràng:

```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                    │
│  ┌──────────────────────────────────────────────────┐  │
│  │  price-compare.jsp (View)                        │  │
│  │  - JSTL for data rendering                       │  │
│  │  - Chart.js for visualization                    │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                          ↕
┌─────────────────────────────────────────────────────────┐
│                    Controller Layer                      │
│  ┌──────────────────────────────────────────────────┐  │
│  │  PriceComparisonServlet                          │  │
│  │  - Handle HTTP requests                          │  │
│  │  - Route actions (compare, filter)               │  │
│  │  - Set request attributes                        │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                          ↕
┌─────────────────────────────────────────────────────────┐
│                    Data Access Layer                     │
│  ┌──────────────────────────────────────────────────┐  │
│  │  ProviderPriceHistoryDAO                         │  │
│  │  - JPA queries                                   │  │
│  │  - Data retrieval and filtering                  │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                          ↕
┌─────────────────────────────────────────────────────────┐
│                      Entity Layer                        │
│  ┌──────────────────────────────────────────────────┐  │
│  │  ProviderPriceHistory (JPA Entity)               │  │
│  │  Provider (JPA Entity)                           │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                          ↕
┌─────────────────────────────────────────────────────────┐
│                       Database                           │
│              SQL Server (ProviderPriceHistory)           │
└─────────────────────────────────────────────────────────┘
```

### Request Flow

1. User truy cập URL `/price-comparison?action=compare&serviceType=Hotel`
2. PriceComparisonServlet nhận request và parse parameters
3. Servlet gọi ProviderPriceHistoryDAO methods tương ứng
4. DAO thực thi JPA queries và trả về List<ProviderPriceHistory>
5. Servlet đặt data vào request attributes
6. Servlet forward request đến price-compare.jsp
7. JSP render data sử dụng JSTL và Chart.js

## Components and Interfaces

### 1. ProviderPriceHistoryDAO

**Responsibility**: Quản lý truy vấn dữ liệu lịch sử giá từ database

**Methods**:

```java
public class ProviderPriceHistoryDAO {
    
    // Lấy tất cả lịch sử giá theo loại dịch vụ
    public List<ProviderPriceHistory> findByServiceType(String serviceType)
    
    // So sánh giá giữa các NCC cho cùng dịch vụ
    public List<ProviderPriceHistory> comparePrice(String serviceType, String serviceName)
    
    // Lấy giá mới nhất của một NCC cho một dịch vụ
    public ProviderPriceHistory getLatestPrice(int providerId, String serviceName)
    
    // Lấy lịch sử giá của một NCC (đã có sẵn)
    public List<ProviderPriceHistory> findByProviderId(int providerId)
}
```

**Implementation Details**:

- `findByServiceType`: Sử dụng JPQL query với WHERE clause và ORDER BY changeDate DESC
- `comparePrice`: Sử dụng subquery hoặc native query để lấy latest price của mỗi provider, GROUP BY providerId
- `getLatestPrice`: Query với WHERE conditions và setMaxResults(1)
- Tất cả methods sử dụng try-finally để đảm bảo EntityManager được đóng
- SQLException được catch và log, trả về empty list hoặc null

### 2. PriceComparisonServlet

**Responsibility**: Xử lý HTTP requests liên quan đến so sánh giá

**URL Mapping**: `/price-comparison`

**Supported Actions**:
- `compare`: So sánh giá giữa các nhà cung cấp
- `filter`: Lọc theo loại dịch vụ

**Request Parameters**:
- `action`: Action type (compare, filter)
- `serviceType`: Loại dịch vụ (Hotel, Flight, Tour, Transport)
- `serviceName`: Tên dịch vụ cụ thể (optional)

**Methods**:

```java
@WebServlet("/price-comparison")
public class PriceComparisonServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    
    private void handleCompare(HttpServletRequest request, HttpServletResponse response)
    
    private void handleFilter(HttpServletRequest request, HttpServletResponse response)
}
```

**Error Handling**:
- Catch exceptions và set error message vào request attribute
- Forward đến error page nếu có lỗi nghiêm trọng
- Log errors sử dụng servlet logging

### 3. price-compare.jsp

**Responsibility**: Hiển thị giao diện so sánh giá

**Components**:

1. **Service Type Filter Dropdown**
   - HTML select element với các options: Hotel, Flight, Tour, Transport
   - JavaScript onchange event để submit form

2. **Price Comparison Table**
   - JSTL <c:forEach> để lặp qua priceComparisons
   - Hiển thị: Provider name, Old Price, New Price, Change Date, Change %
   - Color coding dựa trên risk level

3. **Price Trend Chart**
   - Chart.js line chart
   - X-axis: changeDate
   - Y-axis: newPrice
   - Multiple lines (một line cho mỗi provider)
   - Interactive tooltips

**JSTL Tags Used**:
- `<c:forEach>`: Loop through data
- `<c:if>`, `<c:choose>`: Conditional rendering
- `<c:out>`: Safe output
- `<fmt:formatNumber>`: Format prices
- `<fmt:formatDate>`: Format dates

## Data Models

### ProviderPriceHistory Entity

```java
@Entity
@Table(name = "ProviderPriceHistory")
public class ProviderPriceHistory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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
    
    // Business logic method
    public double getPriceChangePercent() {
        if (oldPrice == null || oldPrice == 0) return 0;
        return ((newPrice - oldPrice) / oldPrice) * 100;
    }
}
```

### Provider Entity (Reference)

```java
@Entity
@Table(name = "Providers")
public class Provider {
    @Id
    private int providerId;
    
    @Column(name = "BusinessName", nullable = false)
    private String businessName;
    
    @Column(name = "ProviderType")
    private String providerType;
    
    // Other fields...
}
```

### Data Relationships

- ProviderPriceHistory N:1 Provider (Many price records per provider)
- EAGER fetch strategy để tránh LazyInitializationException khi access provider info trong JSP

### Service Types Enum

Mặc dù không implement như Java enum, system sử dụng các giá trị cố định:
- `Hotel`: Dịch vụ khách sạn
- `Flight`: Dịch vụ vé máy bay
- `Tour`: Dịch vụ tour du lịch
- `Transport`: Dịch vụ vận chuyển


## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system-essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

### Property 1: Service Type Filtering

*For any* service type and database state, when querying by service type, all returned price records should have a serviceType field matching the requested service type.

**Validates: Requirements 1.1**

### Property 2: Descending Date Order

*For any* list of price records returned by DAO methods (findByServiceType, findByProviderId), the records should be ordered by changeDate in descending order (newest first).

**Validates: Requirements 1.2, 3.2**

### Property 3: Provider Data Completeness

*For any* price record returned by DAO methods, the associated provider object should not be null and should contain valid businessName and providerId fields.

**Validates: Requirements 1.3, 2.4**

### Property 4: Empty Result for Non-Existent Data

*For any* query with non-existent service type, service name, or provider ID, the DAO should return an empty list (for list-returning methods) or null (for single-record methods) without throwing exceptions.

**Validates: Requirements 1.4, 2.5, 3.4**

### Property 5: Latest Price Uniqueness

*For any* service type and service name, when comparing prices across providers, each provider should appear at most once in the results with their most recent price record (maximum changeDate for that provider).

**Validates: Requirements 2.1, 2.2, 2.3**

### Property 6: Single Record Return

*For any* valid providerId and serviceName combination, getLatestPrice should return either null or a single ProviderPriceHistory object (not a list), and if non-null, it should be the record with the maximum changeDate for that provider and service.

**Validates: Requirements 3.1, 3.2**

### Property 7: Price Record Completeness

*For any* price record returned by getLatestPrice, the record should contain non-null values for priceId, newPrice, and changeDate fields (oldPrice and note may be null).

**Validates: Requirements 3.3**

### Property 8: Price Change Calculation

*For any* ProviderPriceHistory object with non-null and non-zero oldPrice, the getPriceChangePercent() method should return ((newPrice - oldPrice) / oldPrice) * 100. When oldPrice is null or zero, it should return 0.

**Validates: Requirements 5.3**

### Property 9: Servlet Request Attribute Setting

*For any* successful servlet request with action="compare", the request should have a "priceComparisons" attribute set containing a List of ProviderPriceHistory objects before forwarding to the JSP.

**Validates: Requirements 4.4**

### Property 10: Servlet Parameter Processing

*For any* request with serviceType parameter, the servlet should pass this parameter to the DAO filtering method, and the returned data should only contain records matching that service type.

**Validates: Requirements 4.2, 4.3**

### Property 11: Exception Handling in DAO

*For any* SQLException or JPA exception occurring in DAO methods, the method should log the error and return an empty list or null (depending on return type) without propagating the exception to the caller.

**Validates: Requirements 8.1**

### Property 12: Servlet Error Handling

*For any* exception occurring during servlet request processing, the servlet should set an error message in the request attributes and forward to an error page without exposing stack traces to the user.

**Validates: Requirements 4.6, 8.2**

### Property 13: Resource Cleanup

*For any* DAO method execution (successful or failed), the EntityManager should be closed in a finally block to prevent resource leaks.

**Validates: Requirements 8.5**

## Error Handling

### DAO Layer Error Handling

**SQLException/JPA Exceptions**:
- Catch all persistence exceptions in DAO methods
- Log error details using java.util.logging or SLF4J
- Return empty list or null instead of propagating exception
- Example:
```java
public List<ProviderPriceHistory> findByServiceType(String serviceType) {
    EntityManager em = emf.createEntityManager();
    try {
        return em.createQuery(
            "SELECT p FROM ProviderPriceHistory p WHERE p.serviceType = :type ORDER BY p.changeDate DESC",
            ProviderPriceHistory.class
        ).setParameter("type", serviceType).getResultList();
    } catch (Exception e) {
        logger.log(Level.SEVERE, "Error querying by service type: " + serviceType, e);
        return new ArrayList<>();
    } finally {
        em.close();
    }
}
```

**EntityManager Connection Failures**:
- If EntityManagerFactory cannot create EntityManager, throw RuntimeException with clear message
- This indicates configuration or database connectivity issues
- Should be caught at servlet layer

### Servlet Layer Error Handling

**Invalid Parameters**:
- Validate action parameter (must be "compare" or "filter")
- Validate serviceType parameter (must be one of: Hotel, Flight, Tour, Transport)
- Set error message in request attribute: `request.setAttribute("errorMessage", "Invalid service type")`
- Forward to error page or display inline error

**DAO Exceptions**:
- Catch any RuntimeException from DAO layer
- Log error with request details
- Set user-friendly error message
- Forward to error page

**Resource Management**:
- Use try-finally to ensure EntityManager cleanup
- Example:
```java
EntityManager em = null;
try {
    em = emf.createEntityManager();
    // Process request
} catch (Exception e) {
    logger.log(Level.SEVERE, "Error processing request", e);
    request.setAttribute("errorMessage", "An error occurred while processing your request");
    request.getRequestDispatcher("/error.jsp").forward(request, response);
} finally {
    if (em != null && em.isOpen()) {
        em.close();
    }
}
```

### JSP Layer Error Handling

**Empty Data**:
- Check if priceComparisons attribute is null or empty
- Display user-friendly message: "No price data available"
- Example:
```jsp
<c:choose>
    <c:when test="${empty priceComparisons}">
        <p class="no-data">No price data available</p>
    </c:when>
    <c:otherwise>
        <!-- Render table and chart -->
    </c:otherwise>
</c:choose>
```

**Error Messages**:
- Check for errorMessage attribute at top of page
- Display in prominent alert box
- Example:
```jsp
<c:if test="${not empty errorMessage}">
    <div class="alert alert-danger">
        <c:out value="${errorMessage}" />
    </div>
</c:if>
```

**Null Safety**:
- Use JSTL <c:out> for safe output (prevents XSS)
- Check for null before accessing nested properties
- Use default values: `${empty price.oldPrice ? 'N/A' : price.oldPrice}`

## Testing Strategy

### Dual Testing Approach

This feature requires both unit testing and property-based testing for comprehensive coverage:

**Unit Tests**: Focus on specific examples, edge cases, and integration points
**Property Tests**: Verify universal properties across all inputs through randomization

### Unit Testing

**DAO Layer Tests**:
- Test findByServiceType with each service type (Hotel, Flight, Tour, Transport)
- Test comparePrice with known data and verify correct grouping
- Test getLatestPrice with specific provider and service combinations
- Test edge cases: empty database, null parameters, non-existent IDs
- Test EntityManager cleanup in error scenarios
- Mock EntityManager for testing exception handling

**Entity Tests**:
- Test getPriceChangePercent with various oldPrice/newPrice combinations
- Test edge cases: oldPrice = 0, oldPrice = null, negative prices
- Test calculation accuracy with decimal values

**Servlet Tests**:
- Test doGet with different action parameters
- Test request attribute setting
- Test forwarding to correct JSP
- Test error handling with invalid parameters
- Mock HttpServletRequest and HttpServletResponse
- Verify DAO method invocations using Mockito

**Integration Tests**:
- Test end-to-end flow from servlet to DAO to database
- Test with real database (H2 in-memory for testing)
- Verify JSTL rendering with sample data
- Test Chart.js data format

### Property-Based Testing

**Testing Library**: Use **QuickTheories** for Java (https://github.com/quicktheories/QuickTheories)

**Configuration**: Each property test should run minimum 100 iterations

**Property Test Tag Format**: 
```java
// Feature: provider-price-management, Property 1: Service Type Filtering
```

**Property Tests to Implement**:

1. **Property 1: Service Type Filtering**
   - Generate: Random service types, random database states
   - Test: All returned records match requested service type
   - Tag: `Feature: provider-price-management, Property 1: Service Type Filtering`

2. **Property 2: Descending Date Order**
   - Generate: Random lists of price records with random dates
   - Test: Verify list is sorted by changeDate DESC
   - Tag: `Feature: provider-price-management, Property 2: Descending Date Order`

3. **Property 3: Provider Data Completeness**
   - Generate: Random price records
   - Test: Provider object is non-null with valid fields
   - Tag: `Feature: provider-price-management, Property 3: Provider Data Completeness`

4. **Property 4: Empty Result for Non-Existent Data**
   - Generate: Random non-existent IDs and names
   - Test: Returns empty list or null without exception
   - Tag: `Feature: provider-price-management, Property 4: Empty Result for Non-Existent Data`

5. **Property 5: Latest Price Uniqueness**
   - Generate: Random service types, names, and multiple price records per provider
   - Test: Each provider appears once with maximum changeDate
   - Tag: `Feature: provider-price-management, Property 5: Latest Price Uniqueness`

6. **Property 6: Single Record Return**
   - Generate: Random provider IDs and service names
   - Test: Returns single object or null, not a list
   - Tag: `Feature: provider-price-management, Property 6: Single Record Return`

7. **Property 7: Price Record Completeness**
   - Generate: Random price records
   - Test: Required fields are non-null
   - Tag: `Feature: provider-price-management, Property 7: Price Record Completeness`

8. **Property 8: Price Change Calculation**
   - Generate: Random oldPrice and newPrice values
   - Test: Calculation matches formula, handles edge cases
   - Tag: `Feature: provider-price-management, Property 8: Price Change Calculation`

9. **Property 9: Servlet Request Attribute Setting**
   - Generate: Random valid requests
   - Test: priceComparisons attribute is set
   - Tag: `Feature: provider-price-management, Property 9: Servlet Request Attribute Setting`

10. **Property 10: Servlet Parameter Processing**
    - Generate: Random serviceType parameters
    - Test: Filtered results match parameter
    - Tag: `Feature: provider-price-management, Property 10: Servlet Parameter Processing`

11. **Property 11: Exception Handling in DAO**
    - Generate: Random scenarios that trigger exceptions
    - Test: Returns empty/null without propagating exception
    - Tag: `Feature: provider-price-management, Property 11: Exception Handling in DAO`

12. **Property 12: Servlet Error Handling**
    - Generate: Random invalid requests and error scenarios
    - Test: Error message set, forwards to error page
    - Tag: `Feature: provider-price-management, Property 12: Servlet Error Handling`

13. **Property 13: Resource Cleanup**
    - Generate: Random DAO method calls (success and failure)
    - Test: EntityManager.close() is called
    - Tag: `Feature: provider-price-management, Property 13: Resource Cleanup`

### Test Data Generation

**Generators for Property Tests**:
```java
// Service type generator
Gen<String> serviceTypes = Gen.of("Hotel", "Flight", "Tour", "Transport");

// Price generator (positive doubles)
Gen<Double> prices = Gen.doubleRange(0.01, 10000.0);

// Date generator (recent dates)
Gen<Date> dates = Gen.longRange(
    System.currentTimeMillis() - 365L * 24 * 60 * 60 * 1000,
    System.currentTimeMillis()
).map(Date::new);

// Provider ID generator
Gen<Integer> providerIds = Gen.intRange(1, 1000);

// Service name generator
Gen<String> serviceNames = Gen.of(
    "Deluxe Room", "Standard Room", "Economy Flight", 
    "Business Flight", "City Tour", "Beach Tour"
);
```

### Testing Best Practices

1. **Isolation**: Each test should be independent, use fresh database state
2. **Cleanup**: Use @After or @AfterEach to clean up test data
3. **Mocking**: Mock external dependencies (EntityManager, HttpServletRequest)
4. **Coverage**: Aim for 80%+ code coverage on DAO and Servlet layers
5. **Performance**: Property tests with 100 iterations should complete in < 5 seconds
6. **Assertions**: Use descriptive assertion messages
7. **Edge Cases**: Explicitly test boundary conditions in unit tests
8. **Documentation**: Each test should have clear javadoc explaining what it tests

### Example Property Test

```java
import static org.quicktheories.QuickTheory.qt;
import static org.quicktheories.generators.SourceDSL.*;

// Feature: provider-price-management, Property 8: Price Change Calculation
@Test
public void priceChangePercentCalculationIsCorrect() {
    qt()
        .forAll(
            doubles().between(0.01, 10000.0), // oldPrice
            doubles().between(0.01, 10000.0)  // newPrice
        )
        .checkAssert((oldPrice, newPrice) -> {
            ProviderPriceHistory record = new ProviderPriceHistory();
            record.setOldPrice(oldPrice);
            record.setNewPrice(newPrice);
            
            double expected = ((newPrice - oldPrice) / oldPrice) * 100;
            double actual = record.getPriceChangePercent();
            
            assertEquals(expected, actual, 0.001, 
                "Price change % should be calculated correctly");
        });
}
```
