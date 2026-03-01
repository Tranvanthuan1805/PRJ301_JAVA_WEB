<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phân Tích Tour - Admin</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; }
        
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 1.5rem 0; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .header-content { max-width: 1400px; margin: 0 auto; padding: 0 20px; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { font-size: 1.8rem; font-weight: 600; }
        .header-nav a { color: white; text-decoration: none; margin-left: 20px; padding: 8px 16px; border-radius: 5px; transition: background 0.3s; }
        .header-nav a:hover { background: rgba(255,255,255,0.2); }
        
        .container { max-width: 1400px; margin: 0 auto; padding: 30px 20px; }
        .page-title { text-align: center; margin-bottom: 30px; }
        .page-title h2 { font-size: 2rem; color: #2d3748; margin-bottom: 10px; }
        
        .analytics-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 30px; margin-bottom: 30px; }
        .analytics-card { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        .card-title { font-size: 1.3rem; font-weight: 600; color: #2d3748; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #e2e8f0; }
        
        table { width: 100%; border-collapse: collapse; }
        thead { background: #f7fafc; }
        th { padding: 12px; text-align: left; font-size: 0.9rem; font-weight: 600; color: #4a5568; border-bottom: 2px solid #e2e8f0; }
        td { padding: 12px; font-size: 0.95rem; color: #2d3748; border-bottom: 1px solid #e2e8f0; }
        tbody tr:hover { background: #f7fafc; }
        
        .occupancy-bar { width: 100%; height: 20px; background: #e2e8f0; border-radius: 10px; overflow: hidden; }
        .occupancy-fill { height: 100%; background: linear-gradient(90deg, #667eea 0%, #764ba2 100%); transition: width 0.3s; }
        .occupancy-text { font-size: 0.85rem; color: #4a5568; margin-top: 5px; }
        
        .rank-badge { display: inline-block; width: 30px; height: 30px; line-height: 30px; text-align: center; border-radius: 50%; font-weight: 600; font-size: 0.9rem; }
        .rank-1 { background: #ffd700; color: #fff; }
        .rank-2 { background: #c0c0c0; color: #fff; }
        .rank-3 { background: #cd7f32; color: #fff; }
        .rank-other { background: #e2e8f0; color: #4a5568; }
        
        .no-data { text-align: center; padding: 40px; color: #718096; }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1>📊 Phân Tích Tour</h1>
            <nav class="header-nav">
                <a href="${pageContext.request.contextPath}/admin.jsp">Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/tours">Quản lý Tour</a>
                <a href="${pageContext.request.contextPath}/admin/tour-history">Lịch sử</a>
                <a href="${pageContext.request.contextPath}/admin/tour-analytics">Phân tích</a>
                <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
            </nav>
        </div>
    </div>

    <div class="container">
        <div class="page-title">
            <h2>📈 Dữ Liệu Phân Tích Tour</h2>
        </div>

        <div class="analytics-grid">
            <!-- Top Booked Tours -->
            <div class="analytics-card">
                <div class="card-title">🏆 Tour Được Đặt Nhiều Nhất</div>
                <c:choose>
                    <c:when test="${not empty topBookedTours}">
                        <table>
                            <thead>
                                <tr>
                                    <th style="width: 50px;">Hạng</th>
                                    <th>Tên Tour</th>
                                    <th style="width: 100px;">Đã đặt</th>
                                    <th style="width: 100px;">Tổng chỗ</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="tour" items="${topBookedTours}" varStatus="status">
                                    <tr>
                                        <td>
                                            <c:choose>
                                                <c:when test="${status.index == 0}">
                                                    <span class="rank-badge rank-1">${status.index + 1}</span>
                                                </c:when>
                                                <c:when test="${status.index == 1}">
                                                    <span class="rank-badge rank-2">${status.index + 1}</span>
                                                </c:when>
                                                <c:when test="${status.index == 2}">
                                                    <span class="rank-badge rank-3">${status.index + 1}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="rank-badge rank-other">${status.index + 1}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${tour[0]}</td>
                                        <td><strong>${tour[1]}</strong></td>
                                        <td>${tour[2]}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">Chưa có dữ liệu</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Least Booked Tours -->
            <div class="analytics-card">
                <div class="card-title">📉 Tour Ít Người Đặt</div>
                <c:choose>
                    <c:when test="${not empty leastBookedTours}">
                        <table>
                            <thead>
                                <tr>
                                    <th style="width: 50px;">#</th>
                                    <th>Tên Tour</th>
                                    <th style="width: 100px;">Đã đặt</th>
                                    <th style="width: 100px;">Tổng chỗ</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="tour" items="${leastBookedTours}" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td>${tour[0]}</td>
                                        <td>${tour[1]}</td>
                                        <td>${tour[2]}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">Chưa có dữ liệu</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Occupancy Rates -->
        <div class="analytics-card">
            <div class="card-title">📊 Tỉ Lệ Lấp Đầy Chỗ</div>
            <c:choose>
                <c:when test="${not empty occupancyRates}">
                    <table>
                        <thead>
                            <tr>
                                <th>Tên Tour</th>
                                <th style="width: 120px;">Đã đặt</th>
                                <th style="width: 120px;">Tổng chỗ</th>
                                <th style="width: 300px;">Tỉ lệ lấp đầy</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="tour" items="${occupancyRates}">
                                <tr>
                                    <td>${tour[0]}</td>
                                    <td>${tour[1]}</td>
                                    <td>${tour[2]}</td>
                                    <td>
                                        <div class="occupancy-bar">
                                            <div class="occupancy-fill" style="width: ${tour[3]}%"></div>
                                        </div>
                                        <div class="occupancy-text">
                                            <fmt:formatNumber value="${tour[3]}" pattern="#0.0"/>%
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-data">Chưa có dữ liệu</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
