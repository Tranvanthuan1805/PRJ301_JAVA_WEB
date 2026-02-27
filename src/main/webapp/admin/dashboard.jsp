<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Da Nang Travel Hub Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
    body{font-family:'Plus Jakarta Sans',system-ui,sans-serif;background:#F7F8FC;color:#1B1F3B;-webkit-font-smoothing:antialiased}
    .dashboard-wrapper{display:flex;min-height:100vh}
    .main-content{flex:1;margin-left:260px;padding:30px 35px}

    /* Header */
    .dash-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:35px}
    .dash-header h1{font-size:1.8rem;font-weight:800;color:#1B1F3B;letter-spacing:-.3px}
    .dash-header p{color:#6B7194;font-size:.9rem;margin-top:4px}
    .dash-actions{display:flex;gap:12px}
    .btn-outline{display:inline-flex;align-items:center;gap:8px;padding:10px 20px;border-radius:12px;font-weight:700;font-size:.85rem;border:2px solid #E8EAF0;cursor:pointer;font-family:inherit;transition:.3s;background:#fff;color:#6B7194}
    .btn-outline:hover{border-color:#1B1F3B;color:#1B1F3B}
    .btn-accent{display:inline-flex;align-items:center;gap:8px;padding:10px 20px;border-radius:12px;font-weight:700;font-size:.85rem;border:none;cursor:pointer;font-family:inherit;transition:.3s;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;box-shadow:0 4px 12px rgba(255,111,97,.2)}
    .btn-accent:hover{transform:translateY(-2px);box-shadow:0 8px 20px rgba(255,111,97,.3)}

    /* Stats */
    .stat-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:20px;margin-bottom:30px}
    .stat-card{background:#fff;padding:26px;border-radius:18px;box-shadow:0 2px 12px rgba(27,31,59,.04);border:1px solid #E8EAF0;transition:.3s;position:relative;overflow:hidden}
    .stat-card:hover{transform:translateY(-4px);box-shadow:0 8px 25px rgba(27,31,59,.08)}
    .stat-card .label{font-size:.82rem;color:#6B7194;font-weight:600;margin-bottom:10px;display:flex;align-items:center;gap:8px}
    .stat-card .label i{font-size:.75rem}
    .stat-card .value{font-size:2rem;font-weight:800;color:#1B1F3B;letter-spacing:-1px}
    .stat-card .trend{font-size:.78rem;margin-top:8px;display:flex;align-items:center;gap:4px;font-weight:700}
    .trend-up{color:#059669}
    .trend-down{color:#DC2626}
    .stat-card.highlight{border-left:4px solid #FF6F61}
    .stat-card .deco{position:absolute;top:-15px;right:-15px;width:80px;height:80px;border-radius:50%;opacity:.06}
    .deco-blue{background:#00B4D8}
    .deco-green{background:#06D6A0}
    .deco-orange{background:#FFB703}
    .deco-red{background:#FF6F61}

    /* Cards */
    .card{background:#fff;border-radius:18px;padding:28px;box-shadow:0 2px 12px rgba(27,31,59,.04);border:1px solid #E8EAF0;margin-bottom:25px}
    .card h3{font-size:1.1rem;font-weight:800;color:#1B1F3B;margin-bottom:20px;display:flex;align-items:center;gap:10px}
    .card h3 i{color:#FF6F61}

    /* AI Panel */
    .ai-panel{border-left:4px solid #1B1F3B}
    .ai-panel .ai-header{display:flex;align-items:center;gap:14px;margin-bottom:24px}
    .ai-panel .ai-header .ai-icon{width:48px;height:48px;border-radius:14px;background:linear-gradient(135deg,#1B1F3B,#2D3561);display:flex;align-items:center;justify-content:center;color:#fff;font-size:1.2rem}
    .ai-panel .ai-header h3{margin-bottom:0}
    .ai-chart{background:#F7F8FC;height:280px;border-radius:14px;display:flex;align-items:center;justify-content:center;overflow:hidden;position:relative;border:1px solid #E8EAF0}
    .ai-chart p{color:#A0A5C3;font-style:italic;z-index:2;text-align:center;padding:0 20px}
    .ai-chart::after{content:'';position:absolute;bottom:0;left:0;width:100%;height:60%;background:linear-gradient(0deg,rgba(27,31,59,.04),transparent)}
    .ai-metrics{display:grid;grid-template-columns:1fr 1fr;gap:16px;margin-top:20px}
    .ai-metric{padding:18px;background:#F7F8FC;border-radius:12px;border:1px solid #E8EAF0}
    .ai-metric small{font-size:.75rem;color:#A0A5C3;text-transform:uppercase;letter-spacing:.5px;font-weight:700}
    .ai-metric .val{font-weight:800;color:#1B1F3B;margin-top:6px;font-size:.95rem}
    .ai-metric .val.success{color:#059669}

    /* Table */
    .data-table{width:100%;border-collapse:collapse}
    .data-table thead th{background:#F7F8FC;padding:13px 18px;text-align:left;font-size:.72rem;text-transform:uppercase;letter-spacing:1.2px;color:#A0A5C3;font-weight:700;border-bottom:1px solid #E8EAF0}
    .data-table tbody td{padding:14px 18px;border-bottom:1px solid #F5F6FA;font-size:.88rem;color:#4A4E6F}
    .data-table tbody tr:hover{background:#FAFBFF}
    .data-table tbody tr:last-child td{border-bottom:none}
    .status-badge{padding:4px 12px;border-radius:999px;font-size:.72rem;font-weight:700;letter-spacing:.3px}
    .badge-green{background:#ECFDF5;color:#059669}
    .badge-yellow{background:#FFF8E1;color:#D97706}

    @media(max-width:1024px){.stat-grid{grid-template-columns:repeat(2,1fr)}}
    @media(max-width:768px){.main-content{margin-left:0;padding:16px}.stat-grid{grid-template-columns:1fr}.ai-metrics{grid-template-columns:1fr}}
    </style>
</head>
<body>
    <div class="dashboard-wrapper">
        <jsp:include page="/common/_sidebar.jsp" />

        <main class="main-content">
            <header class="dash-header">
                <div>
                    <h1>Tổng Quan Hệ Thống</h1>
                    <p>Xin chào, <strong>${sessionScope.user.username}</strong> 👋</p>
                </div>
                <div class="dash-actions">
                    <button class="btn-outline"><i class="fas fa-download"></i> Xuất Báo Cáo</button>
                    <a href="${pageContext.request.contextPath}/admin/tours?action=create" class="btn-accent"><i class="fas fa-plus"></i> Tạo Tour</a>
                </div>
            </header>

            <!-- Stats -->
            <section class="stat-grid">
                <div class="stat-card">
                    <div class="deco deco-blue"></div>
                    <div class="label"><i class="fas fa-shopping-bag"></i> Tổng Đơn Hàng</div>
                    <div class="value">${totalBookings}</div>
                    <div class="trend trend-up"><i class="fas fa-arrow-up"></i> +12% so với tháng trước</div>
                </div>
                <div class="stat-card">
                    <div class="deco deco-green"></div>
                    <div class="label"><i class="fas fa-dollar-sign"></i> Doanh Thu</div>
                    <div class="value"><fmt:formatNumber value="${grossRevenue}" type="number" groupingUsed="true"/>đ</div>
                    <div class="trend trend-up"><i class="fas fa-arrow-up"></i> +8% so với tháng trước</div>
                </div>
                <div class="stat-card">
                    <div class="deco deco-orange"></div>
                    <div class="label"><i class="fas fa-map-marked-alt"></i> Tours Đang Hoạt Động</div>
                    <div class="value">${activeTours}</div>
                </div>
                <div class="stat-card highlight">
                    <div class="deco deco-red"></div>
                    <div class="label"><i class="fas fa-clock"></i> Đơn Chờ Xử Lý</div>
                    <div class="value" style="color:#FF6F61">${pendingRequests}</div>
                </div>
            </section>

            <!-- AI Panel -->
            <section class="card ai-panel">
                <div class="ai-header">
                    <div class="ai-icon"><i class="fas fa-brain"></i></div>
                    <h3>AI Dự Báo Nhu Cầu</h3>
                </div>
                <div class="ai-chart">
                    <p><i class="fas fa-chart-area" style="font-size:2rem;display:block;margin-bottom:12px;opacity:.3"></i>AI đang phân tích xu hướng đặt tour cho Lễ hội Pháo hoa Quốc tế Đà Nẵng...</p>
                </div>
                <div class="ai-metrics">
                    <div class="ai-metric">
                        <small>Độ Tin Cậy</small>
                        <div class="val success">94.2%</div>
                    </div>
                    <div class="ai-metric">
                        <small>Khuyến Nghị</small>
                        <div class="val">Tăng 15% công suất "Tour Sông Hàn"</div>
                    </div>
                </div>
            </section>

            <!-- Recent Activity -->
            <section class="card">
                <h3><i class="fas fa-history"></i> Hoạt Động Gần Đây</h3>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Khách Hàng</th>
                            <th>Tour</th>
                            <th>Số Tiền</th>
                            <th>Trạng Thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>Nguyễn Văn A</strong></td>
                            <td>Bà Nà Hills Trọn Ngày</td>
                            <td style="font-weight:700;color:#059669">2,400,000đ</td>
                            <td><span class="status-badge badge-green">Đã xác nhận</span></td>
                        </tr>
                        <tr>
                            <td><strong>Trần Thị B</strong></td>
                            <td>Hội An Phố Cổ</td>
                            <td style="font-weight:700;color:#059669">1,700,000đ</td>
                            <td><span class="status-badge badge-yellow">Chờ xác nhận</span></td>
                        </tr>
                    </tbody>
                </table>
            </section>
        </main>
    </div>
    <jsp:include page="/views/ai-chatbot/chatbot.jsp" />
</body>
</html>
