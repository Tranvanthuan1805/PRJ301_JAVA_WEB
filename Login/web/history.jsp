<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="util.DatabaseConnection" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%
    // Check admin access
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    
    if (username == null || !"ADMIN".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get tour statistics and monthly data
    int totalTours = 0;
    int totalMonths = 0;
    int totalDestinations = 0;
    String minYear = "";
    String maxYear = "";
    
    // Use LinkedHashMap to maintain insertion order
    Map<String, Map<String, Object>> monthlyData = new LinkedHashMap<>();
    
    Connection conn = null;
    try {
        conn = DatabaseConnection.getNewConnection();
        Statement stmt = conn.createStatement();
        
        // Count total tours
        ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as total FROM Tours");
        if (rs.next()) totalTours = rs.getInt("total");
        rs.close();
        
        // Count months
        rs = stmt.executeQuery("SELECT COUNT(DISTINCT FORMAT(startDate, 'yyyy-MM')) as total FROM Tours");
        if (rs.next()) totalMonths = rs.getInt("total");
        rs.close();
        
        // Count destinations
        rs = stmt.executeQuery("SELECT COUNT(DISTINCT destination) as total FROM Tours");
        if (rs.next()) totalDestinations = rs.getInt("total");
        rs.close();
        
        // Get year range
        rs = stmt.executeQuery("SELECT MIN(YEAR(startDate)) as minYear, MAX(YEAR(startDate)) as maxYear FROM Tours");
        if (rs.next()) {
            minYear = String.valueOf(rs.getInt("minYear"));
            maxYear = String.valueOf(rs.getInt("maxYear"));
        }
        rs.close();
        
        // Get monthly data - optimized query
        String sql = "SELECT " +
                     "FORMAT(startDate, 'yyyy-MM') as month, " +
                     "COUNT(*) as tourCount, " +
                     "SUM(currentCapacity) as totalBookings, " +
                     "SUM(price * currentCapacity) as totalRevenue, " +
                     "AVG(price) as avgPrice " +
                     "FROM Tours " +
                     "GROUP BY FORMAT(startDate, 'yyyy-MM') " +
                     "ORDER BY FORMAT(startDate, 'yyyy-MM')";
        
        rs = stmt.executeQuery(sql);
        while (rs.next()) {
            String month = rs.getString("month");
            Map<String, Object> data = new HashMap<>();
            data.put("tourCount", rs.getInt("tourCount"));
            data.put("totalBookings", rs.getInt("totalBookings"));
            data.put("totalRevenue", rs.getDouble("totalRevenue"));
            data.put("avgPrice", rs.getDouble("avgPrice"));
            monthlyData.put(month, data);
        }
        rs.close();
        
        stmt.close();
    } catch (Exception e) {
        out.println("<!-- Error: " + e.getMessage() + " -->");
    } finally {
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
    
    DecimalFormat df = new DecimalFormat("#,###");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử Tour - VietAir</title>
    <link rel="stylesheet" href="css/vietair-style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <style>
        body {
            background: #f5f7fa;
        }
        
        .history-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .page-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 2rem;
            padding: 1.5rem 0;
        }
        
        .page-header i {
            font-size: 24px;
            color: #007bff;
        }
        
        .page-header h1 {
            font-size: 1.75rem;
            font-weight: 700;
            color: #333;
            margin: 0;
        }
        
        .stats-row {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-box {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .stat-box .number {
            font-size: 2.5rem;
            font-weight: 700;
            color: #007bff;
            margin-bottom: 0.5rem;
        }
        
        .stat-box .label {
            font-size: 0.95rem;
            color: #666;
        }
        
        .charts-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .chart-container {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        
        .chart-title {
            font-size: 1rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 1.5rem;
        }
        
        .chart-wrapper {
            position: relative;
            height: 300px;
        }
        
        .data-table {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        
        .table-title {
            font-size: 1rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 1rem;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        thead {
            background: #f8f9fa;
        }
        
        th {
            padding: 12px;
            text-align: left;
            font-size: 0.85rem;
            font-weight: 600;
            color: #666;
            border-bottom: 2px solid #e9ecef;
        }
        
        td {
            padding: 12px;
            font-size: 0.9rem;
            color: #333;
            border-bottom: 1px solid #e9ecef;
        }
        
        tbody tr:hover {
            background: #f8f9fa;
        }
        
        .season-badge {
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        .season-high {
            background: #fee2e2;
            color: #dc2626;
        }
        
        .season-normal {
            background: #fef3c7;
            color: #d97706;
        }
        
        .season-low {
            background: #dbeafe;
            color: #2563eb;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="nav-brand">
                <div class="logo-container">
                    <i class="fas fa-plane-departure logo-icon"></i>
                    <span class="logo-text">VietAir</span>
                </div>
            </div>
            <nav class="nav-menu">
                <a href="index.jsp" class="nav-item">Trang chủ</a>
                <% if (isAdmin) { %>
                    <a href="admin/tours" class="nav-item">Tours</a>
                    <a href="admin/customers" class="nav-item">Khách hàng</a>
                    <a href="history.jsp" class="nav-item active">Lịch sử</a>
                <% } else { %>
                    <a href="tour?action=list" class="nav-item">Tours</a>
                <% } %>
            </nav>
            <div class="nav-actions">
                <span class="user-badge">ADMIN</span>
                <a href="logout" class="btn-logout">
                    <i class="fas fa-sign-out-alt"></i>
                    Đăng xuất
                </a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <div class="history-content">
        <div class="page-header">
            <i class="fas fa-chart-line"></i>
            <h1>Lịch sử Tour <%= minYear.equals(maxYear) ? minYear : minYear + "-" + maxYear %></h1>
        </div>
        
        <!-- Stats Overview -->
        <div class="stats-row">
            <div class="stat-box">
                <div class="number"><%= totalTours %></div>
                <div class="label">Tổng tours</div>
            </div>
            <div class="stat-box">
                <div class="number"><%= totalMonths %></div>
                <div class="label">Tháng dữ liệu</div>
            </div>
            <div class="stat-box">
                <div class="number"><%= totalDestinations %></div>
                <div class="label">Điểm đến</div>
            </div>
        </div>
        
        <!-- Charts -->
        <div class="charts-section">
            <div class="chart-container">
                <div class="chart-title">Lượt khách theo tháng</div>
                <div class="chart-wrapper">
                    <canvas id="bookingChart"></canvas>
                </div>
            </div>
            <div class="chart-container">
                <div class="chart-title">Giá trung bình theo tháng</div>
                <div class="chart-wrapper">
                    <canvas id="priceChart"></canvas>
                </div>
            </div>
        </div>
        
        <!-- Top Months Chart -->
        <div class="charts-section" style="grid-template-columns: 1fr;">
            <div class="chart-container">
                <div class="chart-title">Top 5 tháng cao điểm</div>
                <div class="chart-wrapper">
                    <canvas id="topMonthsChart"></canvas>
                </div>
            </div>
        </div>
        
        <!-- Data Table -->
        <div class="data-table">
            <div class="table-title">Bảng dữ liệu chi tiết</div>
            <table>
                <thead>
                    <tr>
                        <th>Tháng</th>
                        <th>Số tours</th>
                        <th>Lượt khách</th>
                        <th>Doanh thu</th>
                        <th>Giá TB</th>
                        <th>Mùa</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int rowCount = 0;
                        for (Map.Entry<String, Map<String, Object>> entry : monthlyData.entrySet()) {
                            String month = entry.getKey();
                            Map<String, Object> data = entry.getValue();
                            int tourCount = (Integer) data.get("tourCount");
                            int bookings = (Integer) data.get("totalBookings");
                            double revenue = (Double) data.get("totalRevenue");
                            double avgPrice = (Double) data.get("avgPrice");
                            
                            // Determine season based on bookings
                            String season = "";
                            String seasonClass = "";
                            if (bookings > 300000) {
                                season = "Cao điểm";
                                seasonClass = "season-high";
                            } else if (bookings > 150000) {
                                season = "Bình thường";
                                seasonClass = "season-normal";
                            } else {
                                season = "Thấp điểm";
                                seasonClass = "season-low";
                            }
                    %>
                    <tr>
                        <td><%= month %></td>
                        <td><%= tourCount %></td>
                        <td><%= df.format(bookings) %></td>
                        <td><%= df.format(revenue) %> VNĐ</td>
                        <td><%= df.format(avgPrice) %> VNĐ</td>
                        <td><span class="season-badge <%= seasonClass %>"><%= season %></span></td>
                    </tr>
                    <%
                            rowCount++;
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // Data from JSP
        const months = [<%
            boolean first = true;
            for (String month : monthlyData.keySet()) {
                if (!first) out.print(",");
                out.print("'" + month + "'");
                first = false;
            }
        %>];
        
        const bookings = [<%
            first = true;
            for (Map<String, Object> data : monthlyData.values()) {
                if (!first) out.print(",");
                out.print(data.get("totalBookings"));
                first = false;
            }
        %>];
        
        const avgPrices = [<%
            first = true;
            for (Map<String, Object> data : monthlyData.values()) {
                if (!first) out.print(",");
                out.print(Math.round((Double) data.get("avgPrice")));
                first = false;
            }
        %>];
        
        // Format labels (show only year-month)
        const labels = months.map(m => m.substring(2)); // Remove "20" prefix
        
        // Create Booking Chart
        const bookingCtx = document.getElementById('bookingChart').getContext('2d');
        new Chart(bookingCtx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Lượt khách',
                    data: bookings,
                    backgroundColor: 'rgba(54, 162, 235, 0.6)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: true,
                        position: 'top'
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return value.toLocaleString();
                            }
                        }
                    }
                }
            }
        });
        
        // Create Price Chart
        const priceCtx = document.getElementById('priceChart').getContext('2d');
        new Chart(priceCtx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Giá TB (VNĐ)',
                    data: avgPrices,
                    borderColor: 'rgba(255, 99, 132, 1)',
                    backgroundColor: 'rgba(255, 99, 132, 0.1)',
                    borderWidth: 2,
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: true,
                        position: 'top'
                    }
                },
                scales: {
                    y: {
                        beginAtZero: false,
                        ticks: {
                            callback: function(value) {
                                return value.toLocaleString();
                            }
                        }
                    }
                }
            }
        });
        
        // Find top 5 months with highest bookings
        const monthBookingPairs = months.map((month, index) => ({
            month: month,
            bookings: bookings[index]
        }));
        
        // Sort by bookings descending and take top 5
        monthBookingPairs.sort((a, b) => b.bookings - a.bookings);
        const top5 = monthBookingPairs.slice(0, 5);
        
        const top5Labels = top5.map(item => item.month.substring(2));
        const top5Data = top5.map(item => item.bookings);
        
        // Create Top Months Bar Chart
        const topMonthsCtx = document.getElementById('topMonthsChart').getContext('2d');
        new Chart(topMonthsCtx, {
            type: 'bar',
            data: {
                labels: top5Labels,
                datasets: [{
                    label: 'Lượt khách',
                    data: top5Data,
                    backgroundColor: 'rgba(34, 197, 94, 0.6)',
                    borderColor: 'rgba(34, 197, 94, 1)',
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                indexAxis: 'y',
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    x: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return value.toLocaleString();
                            }
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>
