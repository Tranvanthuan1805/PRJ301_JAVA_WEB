<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Analytics Dashboard | Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .ai-dashboard { display: flex; min-height: 100vh; background: #f0f2f5; }
        .ai-main { flex: 1; padding: 30px; overflow-y: auto; }

        .ai-header { display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 36px; }
        .ai-header h1 { font-size: 1.8rem; font-weight: 800; color: #1B1F3B; }
        .ai-header h1 i { background: linear-gradient(135deg, #8B5CF6, #EC4899); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .ai-header .date-range { display: flex; gap: 8px; }
        .ai-header .date-btn { padding: 8px 16px; border-radius: 10px; border: 1px solid #e2e8f0; background: white; font-weight: 600; font-size: .78rem; cursor: pointer; transition: all .3s; }
        .ai-header .date-btn.active { background: #1B1F3B; color: white; border-color: #1B1F3B; }

        /* Stat Cards */
        .stat-row { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: white; border-radius: 18px; padding: 24px; box-shadow: 0 2px 12px rgba(27,31,59,.05); position: relative; overflow: hidden; }
        .stat-card::before { content: ''; position: absolute; top: 0; left: 0; right: 0; height: 4px; }
        .stat-card:nth-child(1)::before { background: linear-gradient(90deg, #8B5CF6, #A78BFA); }
        .stat-card:nth-child(2)::before { background: linear-gradient(90deg, #10B981, #34D399); }
        .stat-card:nth-child(3)::before { background: linear-gradient(90deg, #F59E0B, #FBBF24); }
        .stat-card:nth-child(4)::before { background: linear-gradient(90deg, #EC4899, #F472B6); }
        .stat-card .stat-icon { width: 48px; height: 48px; border-radius: 14px; display: flex; align-items: center; justify-content: center; font-size: 1.2rem; margin-bottom: 14px; }
        .stat-card:nth-child(1) .stat-icon { background: rgba(139,92,246,.1); color: #8B5CF6; }
        .stat-card:nth-child(2) .stat-icon { background: rgba(16,185,129,.1); color: #10B981; }
        .stat-card:nth-child(3) .stat-icon { background: rgba(245,158,11,.1); color: #F59E0B; }
        .stat-card:nth-child(4) .stat-icon { background: rgba(236,72,153,.1); color: #EC4899; }
        .stat-card .stat-label { font-size: .78rem; color: #94a3b8; font-weight: 600; }
        .stat-card .stat-value { font-size: 1.6rem; font-weight: 800; color: #1B1F3B; margin-top: 4px; }
        .stat-card .stat-change { font-size: .72rem; font-weight: 700; margin-top: 6px; padding: 3px 8px; border-radius: 6px; display: inline-block; }
        .stat-change.up { background: rgba(16,185,129,.1); color: #10B981; }
        .stat-change.down { background: rgba(239,68,68,.1); color: #EF4444; }

        /* Charts Grid */
        .charts-grid { display: grid; grid-template-columns: 2fr 1fr; gap: 24px; margin-bottom: 30px; }
        .chart-card { background: white; border-radius: 18px; padding: 24px; box-shadow: 0 2px 12px rgba(27,31,59,.05); }
        .chart-card h3 { font-size: 1rem; font-weight: 700; color: #1B1F3B; margin-bottom: 20px; display: flex; align-items: center; gap: 8px; }
        .chart-card h3 i { color: #8B5CF6; }

        /* Questions Table */
        .questions-table { width: 100%; border-collapse: collapse; }
        .questions-table th { text-align: left; padding: 12px 14px; font-size: .75rem; font-weight: 700; color: #94a3b8; text-transform: uppercase; border-bottom: 2px solid #f1f5f9; }
        .questions-table td { padding: 12px 14px; font-size: .85rem; border-bottom: 1px solid #f8fafc; }
        .questions-table tr:hover { background: #fafbff; }
        .q-category { padding: 3px 10px; border-radius: 6px; font-size: .7rem; font-weight: 700; }
        .cat-booking { background: rgba(37,99,235,.1); color: #2563EB; }
        .cat-tour { background: rgba(16,185,129,.1); color: #10B981; }
        .cat-price { background: rgba(245,158,11,.1); color: #F59E0B; }
        .cat-general { background: rgba(107,114,128,.1); color: #6B7280; }
        .cat-complaint { background: rgba(239,68,68,.1); color: #EF4444; }

        .sentiment-tag { padding: 3px 8px; border-radius: 6px; font-size: .68rem; font-weight: 700; }
        .sent-positive { background: rgba(16,185,129,.1); color: #10B981; }
        .sent-neutral { background: rgba(107,114,128,.1); color: #6B7280; }
        .sent-negative { background: rgba(239,68,68,.1); color: #EF4444; }

        /* Behavior Section */
        .behavior-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; }
        .behavior-card { background: white; border-radius: 18px; padding: 24px; box-shadow: 0 2px 12px rgba(27,31,59,.05); }
        .behavior-card h3 { font-size: 1rem; font-weight: 700; margin-bottom: 20px; display: flex; align-items: center; gap: 8px; }
        .behavior-card h3 i { color: #EC4899; }

        .heatmap-row { display: flex; gap: 4px; margin-bottom: 4px; }
        .heatmap-cell { width: 14px; height: 14px; border-radius: 3px; }
        .heatmap-legend { display: flex; gap: 4px; align-items: center; margin-top: 10px; font-size: .7rem; color: #94a3b8; }

        .funnel-item { display: flex; align-items: center; gap: 14px; margin-bottom: 14px; }
        .funnel-bar { height: 32px; border-radius: 8px; display: flex; align-items: center; padding: 0 12px; font-size: .78rem; font-weight: 700; color: white; transition: width 1s ease; }
        .funnel-label { font-size: .82rem; font-weight: 600; color: #64748b; white-space: nowrap; min-width: 100px; }
        .funnel-count { font-size: .78rem; font-weight: 700; color: #1B1F3B; min-width: 50px; text-align: right; }

        /* Word Cloud */
        .word-cloud { display: flex; flex-wrap: wrap; gap: 8px; align-items: center; justify-content: center; padding: 20px; }
        .word-tag { padding: 6px 14px; border-radius: 20px; font-weight: 700; transition: all .3s; cursor: default; }
        .word-tag:hover { transform: scale(1.1); }

        @media(max-width:1024px) {
            .stat-row { grid-template-columns: repeat(2, 1fr); }
            .charts-grid, .behavior-grid { grid-template-columns: 1fr; }
        }
        @media(max-width:768px) {
            .ai-main { padding: 16px; }
            .stat-row { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="ai-dashboard">
        <jsp:include page="/common/_sidebar.jsp" />

        <main class="ai-main">
            <div class="ai-header">
                <div>
                    <h1><i class="fas fa-brain"></i> AI Analytics Dashboard</h1>
                    <p style="color:#64748b;margin-top:4px">Thống kê câu hỏi khách hàng & Phân tích hành vi</p>
                </div>
                <div class="date-range">
                    <button class="date-btn active" onclick="setRange(7)">7 ngày</button>
                    <button class="date-btn" onclick="setRange(30)">30 ngày</button>
                    <button class="date-btn" onclick="setRange(90)">90 ngày</button>
                </div>
            </div>

            <!-- Stats Row -->
            <div class="stat-row">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-comments"></i></div>
                    <div class="stat-label">Tổng câu hỏi</div>
                    <div class="stat-value" id="totalQuestions">${totalQuestions != null ? totalQuestions : '1,248'}</div>
                    <span class="stat-change up"><i class="fas fa-arrow-up"></i> +12.5%</span>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-clock"></i></div>
                    <div class="stat-label">Thời gian phản hồi TB</div>
                    <div class="stat-value" id="avgResponseTime">${avgResponseTime != null ? avgResponseTime : '1.2s'}</div>
                    <span class="stat-change up"><i class="fas fa-arrow-down"></i> -8.3%</span>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-smile"></i></div>
                    <div class="stat-label">Tỷ lệ hài lòng</div>
                    <div class="stat-value">87.6%</div>
                    <span class="stat-change up"><i class="fas fa-arrow-up"></i> +3.2%</span>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-users"></i></div>
                    <div class="stat-label">Khách tương tác</div>
                    <div class="stat-value">456</div>
                    <span class="stat-change up"><i class="fas fa-arrow-up"></i> +18.7%</span>
                </div>
            </div>

            <!-- Charts -->
            <div class="charts-grid">
                <div class="chart-card">
                    <h3><i class="fas fa-chart-line"></i> Xu hướng câu hỏi theo ngày</h3>
                    <canvas id="questionTrendChart" height="120"></canvas>
                </div>
                <div class="chart-card">
                    <h3><i class="fas fa-chart-pie"></i> Phân loại câu hỏi</h3>
                    <canvas id="categoryChart" height="200"></canvas>
                </div>
            </div>

            <!-- Recent Questions & Sentiment -->
            <div class="charts-grid">
                <div class="chart-card">
                    <h3><i class="fas fa-list-alt"></i> Câu hỏi gần đây</h3>
                    <table class="questions-table">
                        <thead>
                            <tr>
                                <th>Câu hỏi</th>
                                <th>Danh mục</th>
                                <th>Cảm xúc</th>
                                <th>Thời gian</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty recentQuestions}">
                                    <c:forEach items="${recentQuestions}" var="q">
                                        <tr>
                                            <td style="max-width:250px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap">${q.question}</td>
                                            <td><span class="q-category cat-${q.category != null ? q.category.toLowerCase() : 'general'}">${q.category != null ? q.category : 'General'}</span></td>
                                            <td><span class="sentiment-tag sent-${q.sentiment != null ? q.sentiment.toLowerCase() : 'neutral'}">${q.sentiment != null ? q.sentiment : 'Neutral'}</span></td>
                                            <td style="font-size:.75rem;color:#94a3b8"><fmt:formatDate value="${q.createdAt}" pattern="HH:mm dd/MM"/></td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr><td>Tour Bà Nà Hills giá bao nhiêu?</td><td><span class="q-category cat-price">PRICE</span></td><td><span class="sentiment-tag sent-neutral">Neutral</span></td><td style="font-size:.75rem;color:#94a3b8">09:15 08/03</td></tr>
                                    <tr><td>Có tour Hội An ban đêm không?</td><td><span class="q-category cat-tour">TOUR_INFO</span></td><td><span class="sentiment-tag sent-positive">Positive</span></td><td style="font-size:.75rem;color:#94a3b8">08:42 08/03</td></tr>
                                    <tr><td>Làm sao hủy tour đã đặt?</td><td><span class="q-category cat-booking">BOOKING</span></td><td><span class="sentiment-tag sent-negative">Negative</span></td><td style="font-size:.75rem;color:#94a3b8">08:15 08/03</td></tr>
                                    <tr><td>Tour nào phù hợp gia đình 4 người?</td><td><span class="q-category cat-general">GENERAL</span></td><td><span class="sentiment-tag sent-positive">Positive</span></td><td style="font-size:.75rem;color:#94a3b8">07:30 08/03</td></tr>
                                    <tr><td>Chất lượng dịch vụ kém</td><td><span class="q-category cat-complaint">COMPLAINT</span></td><td><span class="sentiment-tag sent-negative">Negative</span></td><td style="font-size:.75rem;color:#94a3b8">22:10 07/03</td></tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <div class="chart-card">
                    <h3><i class="fas fa-heart"></i> Phân tích cảm xúc</h3>
                    <canvas id="sentimentChart" height="200"></canvas>
                    <div style="margin-top:16px">
                        <div style="display:flex;justify-content:space-between;margin-bottom:8px">
                            <span style="font-size:.82rem;font-weight:600;color:#10B981"><i class="fas fa-smile"></i> Tích cực</span>
                            <span style="font-weight:700">67%</span>
                        </div>
                        <div style="height:8px;background:#e2e8f0;border-radius:4px;margin-bottom:10px">
                            <div style="width:67%;height:100%;background:linear-gradient(90deg,#10B981,#34D399);border-radius:4px;transition:width 1s"></div>
                        </div>
                        <div style="display:flex;justify-content:space-between;margin-bottom:8px">
                            <span style="font-size:.82rem;font-weight:600;color:#6B7280"><i class="fas fa-meh"></i> Trung lập</span>
                            <span style="font-weight:700">21%</span>
                        </div>
                        <div style="height:8px;background:#e2e8f0;border-radius:4px;margin-bottom:10px">
                            <div style="width:21%;height:100%;background:linear-gradient(90deg,#6B7280,#9CA3AF);border-radius:4px;transition:width 1s"></div>
                        </div>
                        <div style="display:flex;justify-content:space-between;margin-bottom:8px">
                            <span style="font-size:.82rem;font-weight:600;color:#EF4444"><i class="fas fa-frown"></i> Tiêu cực</span>
                            <span style="font-weight:700">12%</span>
                        </div>
                        <div style="height:8px;background:#e2e8f0;border-radius:4px">
                            <div style="width:12%;height:100%;background:linear-gradient(90deg,#EF4444,#F87171);border-radius:4px;transition:width 1s"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Behavior Analysis -->
            <h2 style="font-size:1.3rem;font-weight:800;color:#1B1F3B;margin:36px 0 20px;display:flex;align-items:center;gap:10px">
                <i class="fas fa-brain" style="color:#EC4899"></i> Phân tích Hành vi Khách hàng
            </h2>

            <div class="behavior-grid">
                <!-- Conversion Funnel -->
                <div class="behavior-card">
                    <h3><i class="fas fa-filter"></i> Phễu chuyển đổi</h3>
                    <div class="funnel-item">
                        <span class="funnel-label">Xem trang</span>
                        <div class="funnel-bar" style="width:100%;background:linear-gradient(90deg,#8B5CF6,#A78BFA)">12,450</div>
                    </div>
                    <div class="funnel-item">
                        <span class="funnel-label">Xem tour</span>
                        <div class="funnel-bar" style="width:72%;background:linear-gradient(90deg,#3B82F6,#60A5FA)">8,964</div>
                    </div>
                    <div class="funnel-item">
                        <span class="funnel-label">Thêm giỏ hàng</span>
                        <div class="funnel-bar" style="width:35%;background:linear-gradient(90deg,#10B981,#34D399)">4,357</div>
                    </div>
                    <div class="funnel-item">
                        <span class="funnel-label">Đặt tour</span>
                        <div class="funnel-bar" style="width:18%;background:linear-gradient(90deg,#F59E0B,#FBBF24)">2,243</div>
                    </div>
                    <div class="funnel-item">
                        <span class="funnel-label">Hoàn thành</span>
                        <div class="funnel-bar" style="width:14%;background:linear-gradient(90deg,#EC4899,#F472B6)">1,743</div>
                    </div>
                </div>

                <!-- Popular Keywords Word Cloud -->
                <div class="behavior-card">
                    <h3><i class="fas fa-cloud"></i> Từ khóa phổ biến</h3>
                    <div class="word-cloud">
                        <span class="word-tag" style="font-size:1.5rem;background:rgba(139,92,246,.1);color:#8B5CF6">Bà Nà Hills</span>
                        <span class="word-tag" style="font-size:1.1rem;background:rgba(16,185,129,.1);color:#10B981">Hội An</span>
                        <span class="word-tag" style="font-size:1.3rem;background:rgba(236,72,153,.1);color:#EC4899">Sơn Trà</span>
                        <span class="word-tag" style="font-size:.85rem;background:rgba(245,158,11,.1);color:#F59E0B">giá rẻ</span>
                        <span class="word-tag" style="font-size:1.2rem;background:rgba(37,99,235,.1);color:#2563EB">gia đình</span>
                        <span class="word-tag" style="font-size:.9rem;background:rgba(239,68,68,.1);color:#EF4444">hủy tour</span>
                        <span class="word-tag" style="font-size:1rem;background:rgba(6,182,212,.1);color:#06B6D4">Ngũ Hành Sơn</span>
                        <span class="word-tag" style="font-size:.95rem;background:rgba(168,85,247,.1);color:#A855F7">đặt trước</span>
                        <span class="word-tag" style="font-size:1.15rem;background:rgba(34,197,94,.1);color:#22C55E">khuyến mãi</span>
                        <span class="word-tag" style="font-size:.82rem;background:rgba(249,115,22,.1);color:#F97316">phương tiện</span>
                        <span class="word-tag" style="font-size:1rem;background:rgba(99,102,241,.1);color:#6366F1">lịch trình</span>
                        <span class="word-tag" style="font-size:.88rem;background:rgba(236,72,153,.1);color:#EC4899">thanh toán</span>
                    </div>
                </div>

                <!-- Activity Heatmap -->
                <div class="behavior-card">
                    <h3><i class="fas fa-fire"></i> Biểu đồ nhiệt hoạt động (Giờ × Thứ)</h3>
                    <div id="heatmap"></div>
                    <div class="heatmap-legend">
                        <span>Thấp</span>
                        <div style="width:14px;height:14px;background:#e0f2fe;border-radius:3px"></div>
                        <div style="width:14px;height:14px;background:#7dd3fc;border-radius:3px"></div>
                        <div style="width:14px;height:14px;background:#38bdf8;border-radius:3px"></div>
                        <div style="width:14px;height:14px;background:#0284c7;border-radius:3px"></div>
                        <div style="width:14px;height:14px;background:#0c4a6e;border-radius:3px"></div>
                        <span>Cao</span>
                    </div>
                </div>

                <!-- Top Pages -->
                <div class="behavior-card">
                    <h3><i class="fas fa-chart-bar"></i> Tour được xem nhiều nhất</h3>
                    <c:choose>
                        <c:when test="${not empty topTours}">
                            <c:forEach items="${topTours}" var="t" varStatus="i">
                                <div style="display:flex;align-items:center;gap:12px;margin-bottom:14px">
                                    <span style="width:28px;height:28px;border-radius:8px;background:${i.index < 3 ? 'linear-gradient(135deg,#FF6F61,#FF9A8B)' : '#f1f5f9'};color:${i.index < 3 ? 'white' : '#64748b'};display:flex;align-items:center;justify-content:center;font-size:.75rem;font-weight:800">${i.index + 1}</span>
                                    <div style="flex:1">
                                        <div style="font-weight:700;font-size:.85rem;color:#1B1F3B">${t[0]}</div>
                                        <div style="font-size:.72rem;color:#94a3b8">${t[1]} lượt xem</div>
                                    </div>
                                    <div style="height:6px;width:100px;background:#f1f5f9;border-radius:3px">
                                        <div style="height:100%;width:${t[2]}%;background:linear-gradient(90deg,#8B5CF6,#A78BFA);border-radius:3px"></div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="display:flex;align-items:center;gap:12px;margin-bottom:14px">
                                <span style="width:28px;height:28px;border-radius:8px;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:white;display:flex;align-items:center;justify-content:center;font-size:.75rem;font-weight:800">1</span>
                                <div style="flex:1"><div style="font-weight:700;font-size:.85rem;color:#1B1F3B">Tour Bà Nà Hills</div><div style="font-size:.72rem;color:#94a3b8">2,450 lượt xem</div></div>
                                <div style="height:6px;width:100px;background:#f1f5f9;border-radius:3px"><div style="height:100%;width:100%;background:linear-gradient(90deg,#8B5CF6,#A78BFA);border-radius:3px"></div></div>
                            </div>
                            <div style="display:flex;align-items:center;gap:12px;margin-bottom:14px">
                                <span style="width:28px;height:28px;border-radius:8px;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:white;display:flex;align-items:center;justify-content:center;font-size:.75rem;font-weight:800">2</span>
                                <div style="flex:1"><div style="font-weight:700;font-size:.85rem;color:#1B1F3B">Tour Hội An</div><div style="font-size:.72rem;color:#94a3b8">1,890 lượt xem</div></div>
                                <div style="height:6px;width:100px;background:#f1f5f9;border-radius:3px"><div style="height:100%;width:77%;background:linear-gradient(90deg,#8B5CF6,#A78BFA);border-radius:3px"></div></div>
                            </div>
                            <div style="display:flex;align-items:center;gap:12px;margin-bottom:14px">
                                <span style="width:28px;height:28px;border-radius:8px;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:white;display:flex;align-items:center;justify-content:center;font-size:.75rem;font-weight:800">3</span>
                                <div style="flex:1"><div style="font-weight:700;font-size:.85rem;color:#1B1F3B">Tour Sơn Trà</div><div style="font-size:.72rem;color:#94a3b8">1,564 lượt xem</div></div>
                                <div style="height:6px;width:100px;background:#f1f5f9;border-radius:3px"><div style="height:100%;width:64%;background:linear-gradient(90deg,#8B5CF6,#A78BFA);border-radius:3px"></div></div>
                            </div>
                            <div style="display:flex;align-items:center;gap:12px;margin-bottom:14px">
                                <span style="width:28px;height:28px;border-radius:8px;background:#f1f5f9;color:#64748b;display:flex;align-items:center;justify-content:center;font-size:.75rem;font-weight:800">4</span>
                                <div style="flex:1"><div style="font-weight:700;font-size:.85rem;color:#1B1F3B">Tour Ngũ Hành Sơn</div><div style="font-size:.72rem;color:#94a3b8">1,230 lượt xem</div></div>
                                <div style="height:6px;width:100px;background:#f1f5f9;border-radius:3px"><div style="height:100%;width:50%;background:linear-gradient(90deg,#8B5CF6,#A78BFA);border-radius:3px"></div></div>
                            </div>
                            <div style="display:flex;align-items:center;gap:12px;">
                                <span style="width:28px;height:28px;border-radius:8px;background:#f1f5f9;color:#64748b;display:flex;align-items:center;justify-content:center;font-size:.75rem;font-weight:800">5</span>
                                <div style="flex:1"><div style="font-weight:700;font-size:.85rem;color:#1B1F3B">Tour Cù Lao Chàm</div><div style="font-size:.72rem;color:#94a3b8">987 lượt xem</div></div>
                                <div style="height:6px;width:100px;background:#f1f5f9;border-radius:3px"><div style="height:100%;width:40%;background:linear-gradient(90deg,#8B5CF6,#A78BFA);border-radius:3px"></div></div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Question Trend Chart
        new Chart(document.getElementById('questionTrendChart'), {
            type: 'line',
            data: {
                labels: ['01/03', '02/03', '03/03', '04/03', '05/03', '06/03', '07/03', '08/03'],
                datasets: [{
                    label: 'Câu hỏi',
                    data: [45, 62, 78, 55, 90, 85, 120, 95],
                    borderColor: '#8B5CF6',
                    backgroundColor: 'rgba(139,92,246,.08)',
                    borderWidth: 3,
                    fill: true,
                    tension: 0.4,
                    pointRadius: 5,
                    pointBackgroundColor: '#8B5CF6',
                    pointBorderColor: 'white',
                    pointBorderWidth: 3
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, grid: { color: '#f1f5f9' } },
                    x: { grid: { display: false } }
                }
            }
        });

        // Category Pie Chart
        new Chart(document.getElementById('categoryChart'), {
            type: 'doughnut',
            data: {
                labels: ['Tour Info', 'Booking', 'Price', 'General', 'Complaint'],
                datasets: [{
                    data: [35, 25, 20, 15, 5],
                    backgroundColor: ['#10B981', '#2563EB', '#F59E0B', '#6B7280', '#EF4444'],
                    borderWidth: 0,
                    spacing: 3
                }]
            },
            options: {
                responsive: true,
                cutout: '65%',
                plugins: {
                    legend: { position: 'bottom', labels: { padding: 12, font: { size: 11, weight: '600' } } }
                }
            }
        });

        // Sentiment Chart
        new Chart(document.getElementById('sentimentChart'), {
            type: 'doughnut',
            data: {
                labels: ['Tích cực', 'Trung lập', 'Tiêu cực'],
                datasets: [{
                    data: [67, 21, 12],
                    backgroundColor: ['#10B981', '#6B7280', '#EF4444'],
                    borderWidth: 0,
                    spacing: 3
                }]
            },
            options: {
                responsive: true,
                cutout: '70%',
                plugins: { legend: { display: false } }
            }
        });

        // Activity Heatmap
        const heatmapEl = document.getElementById('heatmap');
        const days = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
        const colors = ['#e0f2fe', '#7dd3fc', '#38bdf8', '#0284c7', '#0c4a6e'];

        for (let d = 0; d < 7; d++) {
            const row = document.createElement('div');
            row.className = 'heatmap-row';
            row.innerHTML = '<span style="font-size:.65rem;color:#94a3b8;width:22px;text-align:right;margin-right:4px">' + days[d] + '</span>';
            for (let h = 6; h < 24; h++) {
                const cell = document.createElement('div');
                cell.className = 'heatmap-cell';
                const intensity = Math.floor(Math.random() * 5);
                cell.style.background = colors[intensity];
                cell.title = days[d] + ' ' + h + ':00 - ' + (intensity + 1) * 20 + '% hoạt động';
                row.appendChild(cell);
            }
            heatmapEl.appendChild(row);
        }
        // Hour labels
        const hourRow = document.createElement('div');
        hourRow.style.display = 'flex';
        hourRow.style.gap = '4px';
        hourRow.style.marginLeft = '26px';
        for (let h = 6; h < 24; h += 3) {
            const lbl = document.createElement('span');
            lbl.style.fontSize = '.6rem';
            lbl.style.color = '#94a3b8';
            lbl.style.width = '46px';
            lbl.textContent = h + 'h';
            hourRow.appendChild(lbl);
        }
        heatmapEl.appendChild(hourRow);

        function setRange(days) {
            document.querySelectorAll('.date-btn').forEach(b => b.classList.remove('active'));
            event.target.classList.add('active');
            // TODO: reload data for selected range
        }
    </script>
</body>
</html>
