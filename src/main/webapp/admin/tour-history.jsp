<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Tours | eztravel</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <style>
    *{margin:0;padding:0;box-sizing:border-box}
    body{font-family:'Inter',system-ui,sans-serif;background:#0F172A;color:#E2E8F0;-webkit-font-smoothing:antialiased;min-height:100vh}

    /* Sidebar */
    .sidebar{position:fixed;left:0;top:0;width:260px;height:100vh;background:#0B1120;border-right:1px solid rgba(255,255,255,.06);padding:24px 16px;display:flex;flex-direction:column;z-index:100}
    .sidebar .logo{font-family:'Playfair Display',serif;font-size:1.4rem;font-weight:800;color:#fff;padding:0 12px 24px;border-bottom:1px solid rgba(255,255,255,.06);margin-bottom:16px}
    .sidebar .logo .a{color:#60A5FA}
    .sidebar .badge-admin{display:inline-block;padding:2px 8px;border-radius:6px;background:rgba(239,68,68,.15);color:#F87171;font-size:.65rem;font-weight:700;margin-left:6px;vertical-align:middle}
    .sidebar nav{flex:1}
    .sidebar nav a{display:flex;align-items:center;gap:12px;padding:11px 16px;border-radius:10px;color:rgba(255,255,255,.5);font-size:.88rem;font-weight:500;transition:.3s;margin-bottom:2px;text-decoration:none}
    .sidebar nav a:hover{color:#fff;background:rgba(255,255,255,.06)}
    .sidebar nav a.active{color:#fff;background:rgba(59,130,246,.15);border:1px solid rgba(59,130,246,.2)}
    .sidebar nav a.active i{color:#60A5FA}
    .sidebar nav a i{width:20px;text-align:center;font-size:.85rem}
    .sidebar .nav-label{font-size:.68rem;text-transform:uppercase;letter-spacing:1.5px;color:rgba(255,255,255,.2);font-weight:700;padding:16px 16px 8px;margin-top:8px}
    .sidebar .user-box{padding:16px;border-top:1px solid rgba(255,255,255,.06);display:flex;align-items:center;gap:12px}
    .sidebar .user-box .avatar{width:38px;height:38px;border-radius:10px;background:linear-gradient(135deg,#EF4444,#F87171);display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:.85rem}
    .sidebar .user-box .uname{font-size:.85rem;color:#fff;font-weight:600}
    .sidebar .user-box .urole{font-size:.72rem;color:rgba(255,255,255,.4)}

    /* Main */
    .main{margin-left:260px;padding:32px 40px;min-height:100vh}
    .page-header{margin-bottom:32px}
    .page-header h1{font-size:1.8rem;font-weight:800;color:#fff;margin-bottom:8px}
    .page-header p{color:rgba(255,255,255,.5);font-size:.9rem}

    /* Stats */
    .stats{display:grid;grid-template-columns:repeat(3,1fr);gap:20px;margin-bottom:32px}
    .stat{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:24px;transition:.3s}
    .stat:hover{border-color:rgba(59,130,246,.2);transform:translateY(-2px)}
    .stat .icon{width:44px;height:44px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:1rem;margin-bottom:14px}
    .stat .label{font-size:.78rem;color:rgba(255,255,255,.4);font-weight:600;text-transform:uppercase;letter-spacing:1px;margin-bottom:6px}
    .stat .value{font-size:1.8rem;font-weight:800;color:#fff;letter-spacing:-1px}
    .icon-blue{background:rgba(59,130,246,.15);color:#60A5FA}
    .icon-green{background:rgba(16,185,129,.15);color:#34D399}
    .icon-orange{background:rgba(245,158,11,.15);color:#FBBF24}

    /* Filters */
    .filters{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:24px;margin-bottom:24px}
    .filter-row{display:flex;gap:15px;align-items:end}
    .filter-group{flex:1}
    .filter-group label{display:block;margin-bottom:8px;color:rgba(255,255,255,.6);font-size:.85rem;font-weight:600}
    .filter-group input{width:100%;padding:11px 14px;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.1);border-radius:10px;color:#fff;font-size:.88rem;font-family:inherit}
    .filter-group input:focus{outline:none;border-color:#60A5FA;background:rgba(255,255,255,.08)}
    .btn{padding:11px 22px;border:none;border-radius:10px;font-weight:600;font-size:.85rem;cursor:pointer;transition:.3s;font-family:inherit}
    .btn-primary{background:#3B82F6;color:#fff}
    .btn-primary:hover{background:#2563EB;transform:translateY(-1px)}

    /* Table */
    .table-container{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;overflow:hidden}
    table{width:100%;border-collapse:collapse}
    thead{background:rgba(255,255,255,.02)}
    th{padding:14px 16px;text-align:left;font-size:.72rem;text-transform:uppercase;letter-spacing:1px;color:rgba(255,255,255,.4);font-weight:700;border-bottom:1px solid rgba(255,255,255,.06)}
    td{padding:14px 16px;border-bottom:1px solid rgba(255,255,255,.04);font-size:.88rem;color:rgba(255,255,255,.7)}
    tbody tr:hover{background:rgba(255,255,255,.02)}
    .tour-name{font-weight:600;color:#fff}
    .badge{display:inline-block;padding:4px 12px;border-radius:999px;font-size:.72rem;font-weight:700}
    .badge-success{background:rgba(16,185,129,.15);color:#34D399}
    .badge-info{background:rgba(59,130,246,.15);color:#60A5FA}

    /* Pagination */
    .pagination{display:flex;justify-content:space-between;align-items:center;padding:20px;border-top:1px solid rgba(255,255,255,.06)}
    .pagination-info{color:rgba(255,255,255,.5);font-size:.85rem}
    .pagination-buttons{display:flex;gap:6px}
    .page-btn{padding:8px 14px;border:1px solid rgba(255,255,255,.1);background:rgba(255,255,255,.04);border-radius:8px;color:rgba(255,255,255,.7);font-size:.85rem;text-decoration:none;transition:.3s}
    .page-btn:hover{background:rgba(255,255,255,.08);color:#fff}
    .page-btn.active{background:#3B82F6;color:#fff;border-color:#3B82F6}
    
    /* Charts */
    .charts-grid{display:grid;grid-template-columns:1fr 1fr;gap:24px;margin-bottom:32px}
    .chart-card{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:24px}
    .chart-card h3{font-size:1.05rem;font-weight:700;color:#fff;margin-bottom:20px}
    .chart-container{position:relative;height:300px}
    </style>
</head>
<body>

<!-- Sidebar -->
<aside class="sidebar">
    <div class="logo"><img src="${pageContext.request.contextPath}/images/logo.png" style="width:36px;height:36px;border-radius:50%;display:inline-block;vertical-align:middle;margin-right:8px"><span style="vertical-align:middle"><span class="a">ez</span>travel</span> <span class="badge-admin">ADMIN</span></div>
    <nav>
        <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-chart-pie"></i> Tổng Quan</a>
        <a href="${pageContext.request.contextPath}/admin/customers"><i class="fas fa-users"></i> Khách Hàng</a>
        <div class="nav-label">Quản lý</div>
        <a href="${pageContext.request.contextPath}/admin/tours"><i class="fas fa-plane-departure"></i> Quản lý Tours</a>
        <a href="${pageContext.request.contextPath}/admin/tour-history" class="active"><i class="fas fa-history"></i> Lịch sử</a>
        <a href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-bag"></i> Đơn Hàng</a>
        <div class="nav-label">Hệ thống</div>
        <a href="${pageContext.request.contextPath}/explore"><i class="fas fa-eye"></i> Xem Website</a>
    </nav>
    <div class="user-box">
        <div class="avatar">${sessionScope.user.username.substring(0,1).toUpperCase()}</div>
        <div>
            <div class="uname">${sessionScope.user.username}</div>
            <div class="urole">Quản Trị Viên</div>
        </div>
    </div>
</aside>

<!-- Main -->
<main class="main">
    <div class="page-header">
        <h1><i class="fas fa-history"></i> Lịch Sử Tours</h1>
        <p>Danh sách các tour đã kết thúc (2020-2025)</p>
    </div>
    
    <!-- Stats -->
    <div class="stats">
        <div class="stat">
            <div class="icon icon-blue"><i class="fas fa-history"></i></div>
            <div class="label">Tổng tour đã kết thúc</div>
            <div class="value">${totalTours}</div>
        </div>
        <div class="stat">
            <div class="icon icon-green"><i class="fas fa-users"></i></div>
            <div class="label">Tổng lượt đặt</div>
            <div class="value">
                <c:set var="totalBookings" value="0"/>
                <c:forEach var="tour" items="${allTours}">
                    <c:set var="totalBookings" value="${totalBookings + tour.currentCapacity}"/>
                </c:forEach>
                <fmt:formatNumber value="${totalBookings}" pattern="#,###"/>
            </div>
        </div>
        <div class="stat">
            <div class="icon icon-orange"><i class="fas fa-coins"></i></div>
            <div class="label">Doanh thu ước tính</div>
            <div class="value">
                <c:set var="revenue" value="0"/>
                <c:forEach var="tour" items="${allTours}">
                    <c:set var="revenue" value="${revenue + (tour.currentCapacity * tour.price)}"/>
                </c:forEach>
                <fmt:formatNumber value="${revenue / 1000000000}" pattern="#,###.##"/>B
            </div>
        </div>
    </div>
    
    <!-- Charts -->
    <div class="charts-grid">
        <div class="chart-card">
            <h3><i class="fas fa-chart-bar"></i> Lượt khách theo tháng</h3>
            <div class="chart-container">
                <canvas id="bookingsChart"></canvas>
            </div>
        </div>
        <div class="chart-card">
            <h3><i class="fas fa-chart-line"></i> Doanh thu theo tháng</h3>
            <div class="chart-container">
                <canvas id="revenueChart"></canvas>
            </div>
        </div>
    </div>
    
    <!-- Filters -->
    <div class="filters">
        <form method="get" action="${pageContext.request.contextPath}/admin/tour-history">
            <div class="filter-row">
                <div class="filter-group">
                    <label><i class="fas fa-search"></i> Tìm kiếm</label>
                    <input type="text" name="search" placeholder="Tên tour, điểm đến..." value="${searchQuery}">
                </div>
                <button type="submit" class="btn btn-primary">Tìm kiếm</button>
            </div>
        </form>
    </div>
    
    <!-- Table -->
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>TÊN TOUR</th>
                    <th>ĐIỂM ĐẾN</th>
                    <th>THỜI GIAN DIỄN RA</th>
                    <th>SỐ LƯỢT ĐẶT</th>
                    <th>TỶ LỆ LẤP ĐẦY</th>
                    <th>DOANH THU</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty tours}">
                        <c:forEach var="tour" items="${tours}">
                            <tr>
                                <td>${tour.id}</td>
                                <td class="tour-name">${tour.name}</td>
                                <td>${tour.destination}</td>
                                <td>
                                    <fmt:formatDate value="${tour.startDate}" pattern="dd/MM/yyyy"/> - 
                                    <fmt:formatDate value="${tour.endDate}" pattern="dd/MM/yyyy"/>
                                </td>
                                <td>${tour.currentCapacity} người</td>
                                <td>
                                    <c:set var="occupancy" value="${(tour.currentCapacity * 100.0) / tour.maxCapacity}"/>
                                    <c:choose>
                                        <c:when test="${occupancy >= 80}">
                                            <span class="badge badge-success">
                                                <fmt:formatNumber value="${occupancy}" pattern="#.#"/>%
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-info">
                                                <fmt:formatNumber value="${occupancy}" pattern="#.#"/>%
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="font-weight:600;color:#34D399">
                                    <fmt:formatNumber value="${tour.currentCapacity * tour.price}" pattern="#,###"/> VNĐ
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7" style="text-align:center;padding:40px;color:rgba(255,255,255,.3)">
                                Không có tour nào
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        
        <!-- Pagination -->
        <div class="pagination">
            <div class="pagination-info">
                Hiển thị ${(currentPage - 1) * pageSize + 1} - ${currentPage * pageSize > totalTours ? totalTours : currentPage * pageSize} trong tổng số ${totalTours} tour
            </div>
            <div class="pagination-buttons">
                <c:if test="${currentPage > 1}">
                    <a href="?page=${currentPage - 1}&search=${searchQuery}" class="page-btn">‹</a>
                </c:if>
                
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <c:if test="${i == 1 || i == totalPages || (i >= currentPage - 2 && i <= currentPage + 2)}">
                        <a href="?page=${i}&search=${searchQuery}" 
                           class="page-btn ${i == currentPage ? 'active' : ''}">${i}</a>
                    </c:if>
                </c:forEach>
                
                <c:if test="${currentPage < totalPages}">
                    <a href="?page=${currentPage + 1}&search=${searchQuery}" class="page-btn">›</a>
                </c:if>
            </div>
        </div>
    </div>
</main>

<script>
// Prepare data from JSP - use ALL tours for charts
const tourData = [
    <c:forEach var="tour" items="${allTours}" varStatus="status">
    {
        month: '<fmt:formatDate value="${tour.startDate}" pattern="yyyy-MM"/>',
        bookings: ${tour.currentCapacity},
        revenue: ${tour.currentCapacity * tour.price}
    }<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];

console.log('Total tours loaded:', tourData.length);
console.log('Sample tour data:', tourData.slice(0, 3));

// Generate all months from 2020-01 to 2025-12
function generateMonths(startYear, endYear) {
    const months = [];
    for (let year = startYear; year <= endYear; year++) {
        for (let month = 1; month <= 12; month++) {
            months.push(year + '-' + String(month).padStart(2, '0'));
        }
    }
    return months;
}

const allMonths = generateMonths(2020, 2025);

// Aggregate data by month
const monthlyData = {};
allMonths.forEach(month => {
    monthlyData[month] = { bookings: 0, revenue: 0 };
});

tourData.forEach(item => {
    if (monthlyData[item.month] !== undefined) {
        monthlyData[item.month].bookings += item.bookings;
        monthlyData[item.month].revenue += item.revenue;
    }
});

const bookingsData = allMonths.map(m => monthlyData[m].bookings);
const revenueData = allMonths.map(m => monthlyData[m].revenue / 1000000000); // Convert to billions

console.log('Monthly data sample:', Object.entries(monthlyData).slice(0, 5));
console.log('Max bookings:', Math.max(...bookingsData).toLocaleString());
console.log('Max revenue (B):', Math.max(...revenueData).toFixed(2));

// Format labels to show only year or year-month for better readability
const labels = allMonths.map((m, i) => {
    const [year, month] = m.split('-');
    // Show label every 6 months
    if (i % 6 === 0) {
        return year + '-' + month;
    }
    return '';
});

// Chart.js default config
Chart.defaults.color = 'rgba(255,255,255,0.6)';
Chart.defaults.borderColor = 'rgba(255,255,255,0.1)';
Chart.defaults.font.family = 'Inter, system-ui, sans-serif';

// Bookings Chart
const bookingsCtx = document.getElementById('bookingsChart').getContext('2d');
new Chart(bookingsCtx, {
    type: 'bar',
    data: {
        labels: labels,
        datasets: [{
            label: 'Lượt khách',
            data: bookingsData,
            backgroundColor: 'rgba(59, 130, 246, 0.8)',
            borderColor: 'rgba(59, 130, 246, 1)',
            borderWidth: 1,
            borderRadius: 4
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: { display: false },
            tooltip: {
                backgroundColor: 'rgba(15, 23, 42, 0.95)',
                padding: 12,
                titleColor: '#fff',
                bodyColor: '#E2E8F0',
                borderColor: 'rgba(255,255,255,0.1)',
                borderWidth: 1,
                callbacks: {
                    title: function(context) {
                        return allMonths[context[0].dataIndex];
                    },
                    label: function(context) {
                        return 'Lượt khách: ' + context.parsed.y.toLocaleString() + ' người';
                    }
                }
            }
        },
        scales: {
            y: {
                beginAtZero: true,
                grid: { color: 'rgba(255,255,255,0.05)' },
                ticks: { 
                    color: 'rgba(255,255,255,0.6)',
                    callback: function(value) {
                        return value.toLocaleString();
                    }
                }
            },
            x: {
                grid: { display: false },
                ticks: { 
                    color: 'rgba(255,255,255,0.6)',
                    maxRotation: 45,
                    minRotation: 45
                }
            }
        }
    }
});

// Revenue Chart
const revenueCtx = document.getElementById('revenueChart').getContext('2d');
new Chart(revenueCtx, {
    type: 'line',
    data: {
        labels: labels,
        datasets: [{
            label: 'Doanh thu (triệu VNĐ)',
            data: revenueData,
            borderColor: 'rgba(16, 185, 129, 1)',
            backgroundColor: 'rgba(16, 185, 129, 0.1)',
            borderWidth: 2,
            fill: true,
            tension: 0.4,
            pointBackgroundColor: 'rgba(16, 185, 129, 1)',
            pointBorderColor: '#fff',
            pointBorderWidth: 2,
            pointRadius: 3,
            pointHoverRadius: 6
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: { display: false },
            tooltip: {
                backgroundColor: 'rgba(15, 23, 42, 0.95)',
                padding: 12,
                titleColor: '#fff',
                bodyColor: '#E2E8F0',
                borderColor: 'rgba(255,255,255,0.1)',
                borderWidth: 1,
                callbacks: {
                    title: function(context) {
                        return allMonths[context[0].dataIndex];
                    },
                    label: function(context) {
                        return 'Doanh thu: ' + context.parsed.y.toFixed(2) + ' tỷ VNĐ';
                    }
                }
            }
        },
        scales: {
            y: {
                beginAtZero: true,
                grid: { color: 'rgba(255,255,255,0.05)' },
                ticks: { 
                    color: 'rgba(255,255,255,0.6)',
                    callback: function(value) {
                        return value.toFixed(1) + 'B';
                    }
                }
            },
            x: {
                grid: { display: false },
                ticks: { 
                    color: 'rgba(255,255,255,0.6)',
                    maxRotation: 45,
                    minRotation: 45
                }
            }
        }
    }
});
</script>

</body>
</html>
