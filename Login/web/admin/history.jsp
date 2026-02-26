<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="util.DatabaseConnection" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%
    // Check admin access
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    boolean isAdmin = "ADMIN".equals(role);
    
    if (username == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
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
        
        // Get monthly data
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
    <title>Lịch Sử Tour - VietAir Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/vietair-style.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; background: #f5f7fa; }
        .admin-container { display: flex; min-height: 100vh; }
        
        /* Sidebar */
        .sidebar { width: 260px; background: white; border-right: 1px solid #e5e7eb; display: flex; flex-direction: column; }
        .sidebar-header { padding: 1.5rem; border-bottom: 1px solid #e5e7eb; }
        .sidebar-brand { display: flex; align-items: center; gap: 12px; color: var(--primary-color); }
        .sidebar-brand i { font-size: 24px; }
        .sidebar-brand-text h3 { font-size: 16px; font-weight: 700; color: #1f2937; }
        .sidebar-brand-text p { font-size: 12px; color: #6b7280; }
        .sidebar-menu { flex: 1; padding: 1rem 0; }
        .menu-section { margin-bottom: 1.5rem; }
        .menu-title { padding: 0 1.5rem; font-size: 11px; font-weight: 600; color: #9ca3af; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 0.5rem; }
        .menu-item { display: flex; align-items: center; gap: 12px; padding: 0.75rem 1.5rem; color: #6b7280; text-decoration: none; transition: all 0.2s; }
        .menu-item:hover { background: #f9fafb; color: var(--primary-color); }
        .menu-item.active { background: #eff6ff; color: var(--primary-color); border-right: 3px solid var(--primary-color); font-weight: 600; }
        .menu-item i { width: 20px; text-align: center; }
        
        /* Main Content */
        .main-content { flex: 1; display: flex; flex-direction: column; }
        .top-bar { background: white; border-bottom: 1px solid #e5e7eb; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .top-bar-title h1 { font-size: 20px; font-weight: 700; color: #1f2937; }
        .content-area { flex: 1; padding: 2rem; overflow-y: auto; }
        
        /* Stats */
        .stats-row { display: grid; grid-template-columns: repeat(3, 1fr); gap: 1.5rem; margin-bottom: 2rem; }
        .stat-box { background: white; padding: 2rem; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); text-align: center; }
        .stat-box .number { font-size: 2.5rem; font-weight: 700; color: #2c5aa0; margin-bottom: 0.5rem; }
        .stat-box .label { font-size: 0.95rem; color: #666; }
        
        /* Charts */
        .charts-section { display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 2rem; }
        .chart-container { background: white; padding: 1.5rem; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        .chart-title { font-size: 1rem; font-weight: 600; color: #333; margin-bottom: 1.5rem; }
        .chart-wrapper { position: relative; height: 300px; }
        
        /* Table */
        .data-table { background: white; padding: 1.5rem; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        .table-title { font-size: 1rem; font-weight: 600; color: #333; margin-bottom: 1rem; }
        table { width: 100%; border-collapse: collapse; }
        thead { background: #f8f9fa; }
        th { padding: 12px; text-align: left; font-size: 0.85rem; font-weight: 600; color: #666; border-bottom: 2px solid #e9ecef; }
        td { padding: 12px; font-size: 0.9rem; color: #333; border-bottom: 1px solid #e9ecef; }
        tbody tr:hover { background: #f8f9fa; }
        .season-badge { padding: 4px 12px; border-radius: 12px; font-size: 0.85rem; font-weight: 600; }
        .season-high { background: #fee2e2; color: #dc2626; }
        .season-normal { background: #fef3c7; color: #d97706; }
        .season-low { background: #dbeafe; color: #2563eb; }
    </style>
</head>
<body>
    <div class="admin-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <div class="sidebar-brand">
                    <i class="fas fa-plane-departure"></i>
                    <div class="sidebar-brand-text">
                        <h3>VietAir</h3>
                        <p>Admin</p>
                    </div>
                </div>
            </div>
            <nav class="sidebar-menu">
                <div class="menu-section">
                    <div class="menu-title">Quản lý chính</div>
                    <a href="<%= request.getContextPath() %>/admin.jsp" class="menu-item">
                        <i class="fas fa-chart-line"></i>
                        <span>Dashboard</span>
                    </a>
                    <a href="<%= request.getContextPath() %>/admin/customers" class="menu-item">
                        <i class="fas fa-users"></i>
                        <span>Quản lý khách hàng</span>
                    </a>
                    <a href="<%= request.getContextPath() %>/admin/tours" class="menu-item">
                        <i class="fas fa-map-marked-alt"></i>
                        <span>Quản lý tour</span>
                    </a>
                    <a href="<%= request.getContextPath() %>/admin/orders" class="menu-item">
                        <i class="fas fa-ticket-alt"></i>
                        <span>Quản lý đơn hàng</span>
                    </a>
                    <a href="<%= request.getContextPath() %>/admin/history.jsp" class="menu-item active">
                        <i class="fas fa-history"></i>
                        <span>Lịch sử</span>
                    </a>
                </div>
                <div class="menu-section">
                    <div class="menu-title">Hệ thống</div>
                    <a href="<%= request.getContextPath() %>/index.jsp" class="menu-item">
                        <i class="fas fa-home"></i>
                        <span>Về trang chủ</span>
                    </a>
                    <a href="<%= request.getContextPath() %>/logout" class="menu-item">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Đăng xuất</span>
                    </a>
                </div>
            </nav>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <div class="top-bar">
                <div class="top-bar-title">
                    <h1>Lịch Sử Tour <%= minYear.equals(maxYear) ? minYear : minYear + "-" + maxYear %></h1>
                </div>
            </div>
            
            <div class="content-area">
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
                            <% for (Map.Entry<String, Map<String, Object>> entry : monthlyData.entrySet()) {
                                String month = entry.getKey();
                                Map<String, Object> data = entry.getValue();
                                int tourCount = (Integer) data.get("tourCount");
                                int bookings = (Integer) data.get("totalBookings");
                                double revenue = (Double) data.get("totalRevenue");
                                double avgPrice = (Double) data.get("avgPrice");
                                
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
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
    
    <script>
        const months = [<% boolean first = true; for (String month : monthlyData.keySet()) { if (!first) out.print(","); out.print("'" + month + "'"); first = false; } %>];
        const bookings = [<% first = true; for (Map<String, Object> data : monthlyData.values()) { if (!first) out.print(","); out.print(data.get("totalBookings")); first = false; } %>];
        const avgPrices = [<% first = true; for (Map<String, Object> data : monthlyData.values()) { if (!first) out.print(","); out.print(Math.round((Double) data.get("avgPrice"))); first = false; } %>];
        const labels = months.map(m => m.substring(2));
        
        // Booking Chart
        new Chart(document.getElementById('bookingChart'), {
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
                scales: { y: { beginAtZero: true } }
            }
        });
        
        // Price Chart
        new Chart(document.getElementById('priceChart'), {
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
                scales: { y: { beginAtZero: false } }
            }
        });
    </script>
</body>
</html>
