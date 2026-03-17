<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gửi Feedback Tour | eztravel</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .feedback-page { padding: 120px 0 60px; min-height: 100vh; background: #f8fafc; }

        .feedback-card { max-width: 760px; margin: 0 auto; background: white; border-radius: 24px; padding: 40px; box-shadow: 0 8px 32px rgba(27,31,59,.08); }
        .feedback-card h1 { font-size: 1.6rem; font-weight: 800; color: #1B1F3B; margin-bottom: 8px; }
        .feedback-card .subtitle { color: #64748b; font-size: .9rem; margin-bottom: 32px; }

        /* Star Rating */
        .rating-group { margin-bottom: 28px; }
        .rating-group label { display: block; font-weight: 700; color: #1B1F3B; margin-bottom: 10px; font-size: .9rem; }
        .stars { display: flex; gap: 6px; direction: rtl; justify-content: flex-end; }
        .stars input { display: none; }
        .stars label { font-size: 2rem; color: #d1d5db; cursor: pointer; transition: all .2s; }
        .stars label:hover, .stars label:hover ~ label, .stars input:checked ~ label { color: #f59e0b; transform: scale(1.15); }
        .stars-sm label { font-size: 1.3rem; }

        /* Criteria Grid */
        .criteria-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 28px; }
        .criteria-item { background: #f8fafc; border-radius: 16px; padding: 18px; }
        .criteria-item .criteria-label { font-size: .82rem; font-weight: 700; color: #1B1F3B; margin-bottom: 8px; display: flex; align-items: center; gap: 6px; }
        .criteria-item .criteria-label i { color: #FF6F61; }

        /* Form Elements */
        .form-group { margin-bottom: 24px; }
        .form-group label { display: block; font-weight: 700; color: #1B1F3B; margin-bottom: 8px; font-size: .9rem; }
        .form-group textarea { width: 100%; padding: 14px 18px; border: 2px solid #e2e8f0; border-radius: 14px; font-family: inherit; font-size: .88rem; resize: vertical; min-height: 100px; transition: border-color .3s; box-sizing: border-box; }
        .form-group textarea:focus { border-color: #FF6F61; outline: none; }

        .recommend-toggle { display: flex; gap: 14px; }
        .recommend-option { flex: 1; padding: 16px; border: 2px solid #e2e8f0; border-radius: 14px; text-align: center; cursor: pointer; transition: all .3s; }
        .recommend-option:hover { border-color: #FF6F61; }
        .recommend-option.selected { border-color: #10B981; background: rgba(16,185,129,.06); }
        .recommend-option i { display: block; font-size: 1.5rem; margin-bottom: 6px; }
        .recommend-option span { font-size: .82rem; font-weight: 700; }

        .submit-btn { width: 100%; padding: 16px; background: linear-gradient(135deg, #FF6F61, #FF9A8B); color: white; border: none; border-radius: 14px; font-weight: 800; font-size: 1rem; cursor: pointer; transition: all .3s; }
        .submit-btn:hover { transform: translateY(-3px); box-shadow: 0 10px 30px rgba(255,111,97,.3); }

        .success-msg { text-align: center; padding: 60px 20px; }
        .success-msg i { font-size: 4rem; color: #10B981; margin-bottom: 16px; }

        /* My Feedback List */
        .pending-list { list-style: none; padding: 0; }
        .pending-item { background: white; border-radius: 16px; padding: 22px; margin-bottom: 16px; box-shadow: 0 2px 12px rgba(27,31,59,.05); display: flex; align-items: center; gap: 18px; transition: all .3s; }
        .pending-item:hover { transform: translateX(6px); box-shadow: 0 6px 24px rgba(27,31,59,.1); }
        .pending-item img { width: 80px; height: 60px; border-radius: 12px; object-fit: cover; }
        .pending-item .info { flex: 1; }
        .pending-item h4 { font-size: .95rem; font-weight: 700; color: #1B1F3B; }
        .pending-item .date { font-size: .78rem; color: #94a3b8; }
        .pending-item .feedback-btn { padding: 10px 22px; background: linear-gradient(135deg, #FF6F61, #FF9A8B); color: white; border: none; border-radius: 10px; font-weight: 700; font-size: .82rem; cursor: pointer; text-decoration: none; transition: all .3s; }
        .pending-item .feedback-btn:hover { transform: scale(1.05); }

        @media(max-width:768px) {
            .feedback-page { padding: 90px 0 40px; }
            .feedback-card { margin: 0 16px; padding: 24px; }
            .criteria-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <jsp:include page="/common/_header.jsp" />

    <section class="feedback-page">
        <div class="container">

            <c:choose>
                <%-- FORM: Gửi feedback --%>
                <c:when test="${param.action == 'form' && order != null}">
                    <div class="feedback-card">
                        <h1><i class="fas fa-star" style="color:#f59e0b;margin-right:8px"></i> Đánh giá trải nghiệm</h1>
                        <p class="subtitle">Chia sẻ cảm nhận của bạn về tour để giúp chúng tôi cải thiện dịch vụ</p>

                        <c:if test="${not empty error}">
                            <div style="background:rgba(239,68,68,.1);color:#EF4444;padding:14px;border-radius:12px;margin-bottom:20px;font-weight:600;font-size:.88rem">
                                <i class="fas fa-exclamation-circle"></i> ${error}
                            </div>
                        </c:if>

                        <form id="feedbackForm" onsubmit="submitFeedback(event)">
                            <input type="hidden" name="action" value="submit">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <input type="hidden" name="tourId" id="tourIdInput">

                            <%-- Overall Rating --%>
                            <div class="rating-group">
                                <label>Đánh giá tổng thể *</label>
                                <div class="stars">
                                    <input type="radio" name="overallRating" id="star5" value="5"><label for="star5"><i class="fas fa-star"></i></label>
                                    <input type="radio" name="overallRating" id="star4" value="4"><label for="star4"><i class="fas fa-star"></i></label>
                                    <input type="radio" name="overallRating" id="star3" value="3"><label for="star3"><i class="fas fa-star"></i></label>
                                    <input type="radio" name="overallRating" id="star2" value="2"><label for="star2"><i class="fas fa-star"></i></label>
                                    <input type="radio" name="overallRating" id="star1" value="1"><label for="star1"><i class="fas fa-star"></i></label>
                                </div>
                            </div>

                            <%-- Sub Criteria --%>
                            <div class="criteria-grid">
                                <div class="criteria-item">
                                    <div class="criteria-label"><i class="fas fa-user-tie"></i> Hướng dẫn viên</div>
                                    <div class="stars stars-sm">
                                        <input type="radio" name="guideRating" id="g5" value="5"><label for="g5"><i class="fas fa-star"></i></label>
                                        <input type="radio" name="guideRating" id="g4" value="4"><label for="g4"><i class="fas fa-star"></i></label>
                                        <input type="radio" name="guideRating" id="g3" value="3"><label for="g3"><i class="fas fa-star"></i></label>
                                        <input type="radio" name="guideRating" id="g2" value="2"><label for="g2"><i class="fas fa-star"></i></label>
                                        <input type="radio" name="guideRating" id="g1" value="1"><label for="g1"><i class="fas fa-star"></i></label>
                                    </div>
                                </div>
                                <div class="criteria-item">
                                    <div class="criteria-label"><i class="fas fa-bus"></i> Phương tiện</div>
                                    <div class="stars stars-sm">
                                        <input type="radio" name="transportRating" id="t5" value="5"><label for="t5"><i class="fas fa-star"></i></label>
                                        <input type="radio" name="transportRating" id="t4" value="4"><label for="t4"><i class="fas fa-star"></i></label>
                                        <input type="radio" name="transportRating" id="t3" value="3"><label for="t3"><i class="fas fa-star"></i></label>
                                        <input type="radio" name="transportRating" id="t2" value="2"><label for="t2"><i class="fas fa-star"></i></label>
                                        <input type="radio" name="transportRating" id="t1" value="1"><label for="t1"><i class="fas fa-star"></i></label>
                                    </div>
                                </div>
                                <div class="criteria-item">
                                    <div class="criteria-label"><i class="fas fa-utensils"></i> Ăn uống</div>
                                    <div class="stars stars-sm">
                                        <input type="radio" name="foodRating" id="f5" value="5"><label for="f5"><i class="fas fa-star"></i></label>
                                        <input type="radio" name="foodRating" id="f4" value="4"><label for="f4"><i class="fas fa-star"></i></label>
                                        <input type="radio" name="foodRating" id="f3" value="3"><label for="f3"><i class="fas fa-star"></i></label>
                                        <input type="radio" name="foodRating" id="f2" value="2"><label for="f2"><i class="fas fa-star"></i></label>
                                        <input type="radio" name="foodRating" id="f1" value="1"><label for="f1"><i class="fas fa-star"></i></label>
                                    </div>
                                </div>
                                <div class="criteria-item">
                                    <div class="criteria-label"><i class="fas fa-coins"></i> Giá trị</div>
                                    <div class="stars stars-sm">
                                        <input type="radio" name="valueRating" id="v5" value="5"><label for="v5"><i class="fas fa-star"></i></label>
                                        <input type="radio" name="valueRating" id="v4" value="4"><label for="v4"><i class="fas fa-star"></i></label>
                                        <input type="radio" name="valueRating" id="v3" value="3"><label for="v3"><i class="fas fa-star"></i></label>
                                        <input type="radio" name="valueRating" id="v2" value="2"><label for="v2"><i class="fas fa-star"></i></label>
                                        <input type="radio" name="valueRating" id="v1" value="1"><label for="v1"><i class="fas fa-star"></i></label>
                                    </div>
                                </div>
                            </div>

                            <%-- Comment --%>
                            <div class="form-group">
                                <label><i class="fas fa-comment" style="color:#2563EB;margin-right:6px"></i> Nhận xét chi tiết</label>
                                <textarea name="comment" placeholder="Chia sẻ trải nghiệm của bạn..."></textarea>
                            </div>

                            <%-- Would Recommend --%>
                            <div class="form-group">
                                <label>Bạn có giới thiệu tour này cho bạn bè?</label>
                                <div class="recommend-toggle">
                                    <div class="recommend-option" onclick="selectRecommend(true, this)">
                                        <i class="fas fa-thumbs-up" style="color:#10B981"></i>
                                        <span>Có, chắc chắn!</span>
                                    </div>
                                    <div class="recommend-option" onclick="selectRecommend(false, this)">
                                        <i class="fas fa-thumbs-down" style="color:#EF4444"></i>
                                        <span>Chưa hài lòng</span>
                                    </div>
                                </div>
                                <input type="hidden" name="wouldRecommend" id="wouldRecommend" value="true">
                            </div>

                            <%-- Improvement --%>
                            <div class="form-group">
                                <label><i class="fas fa-lightbulb" style="color:#f59e0b;margin-right:6px"></i> Góp ý cải thiện (tùy chọn)</label>
                                <textarea name="improvement" placeholder="Điều gì bạn muốn chúng tôi cải thiện?" style="min-height:70px"></textarea>
                            </div>

                            <button type="submit" class="submit-btn">
                                <i class="fas fa-paper-plane"></i> Gửi Feedback
                            </button>
                        </form>
                    </div>
                </c:when>

                <%-- DEFAULT: Danh sách orders cần feedback --%>
                <c:otherwise>
                    <div style="max-width:760px;margin:0 auto">
                        <h1 style="font-size:1.8rem;font-weight:800;color:#1B1F3B;margin-bottom:8px">
                            <i class="fas fa-clipboard-check" style="color:#10B981"></i> Feedback Tour đã tham gia
                        </h1>
                        <p style="color:#64748b;margin-bottom:32px">Chia sẻ cảm nhận về những tour bạn đã hoàn thành</p>

                        <c:choose>
                            <c:when test="${empty pendingFeedback}">
                                <div style="text-align:center;padding:60px;background:white;border-radius:20px;box-shadow:0 4px 20px rgba(27,31,59,.06)">
                                    <i class="fas fa-check-circle" style="font-size:3rem;color:#10B981;margin-bottom:16px;display:block"></i>
                                    <h3 style="color:#1B1F3B;margin-bottom:8px">Tuyệt vời!</h3>
                                    <p style="color:#64748b">Bạn đã gửi feedback cho tất cả tour đã hoàn thành</p>
                                    <a href="${pageContext.request.contextPath}/tour" style="display:inline-block;margin-top:20px;padding:12px 28px;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:white;border-radius:12px;font-weight:700;text-decoration:none">
                                        Khám phá tour mới
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <ul class="pending-list">
                                    <c:forEach items="${pendingFeedback}" var="item">
                                        <li class="pending-item">
                                            <img src="${item[1].imageUrl != null ? item[1].imageUrl : 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=200'}" alt="">
                                            <div class="info">
                                                <h4>${item[1].tourName}</h4>
                                                <div class="date">Đơn hàng #${item[0].orderId} • <fmt:formatDate value="${item[0].orderDate}" pattern="dd/MM/yyyy"/></div>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/feedback?action=form&orderId=${item[0].orderId}&tourId=${item[1].tourId}" class="feedback-btn">
                                                <i class="fas fa-star"></i> Đánh giá
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <jsp:include page="/common/_footer.jsp" />

    <script>
        function selectRecommend(value, el) {
            document.querySelectorAll('.recommend-option').forEach(o => o.classList.remove('selected'));
            el.classList.add('selected');
            document.getElementById('wouldRecommend').value = value;
        }

        // Set tourId from URL
        const urlParams = new URLSearchParams(window.location.search);
        const tourIdInput = document.getElementById('tourIdInput');
        if (tourIdInput && urlParams.get('tourId')) {
            tourIdInput.value = urlParams.get('tourId');
        }

        function submitFeedback(e) {
            e.preventDefault();
            const form = document.getElementById('feedbackForm');
            const formData = new FormData(form);

            // Validate overall rating
            if (!formData.get('overallRating')) {
                alert('Vui lòng chọn đánh giá tổng thể');
                return;
            }

            const body = new URLSearchParams(formData).toString();

            fetch('${pageContext.request.contextPath}/feedback', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: body
            })
            .then(r => r.json())
            .then(data => {
                if (data.success) {
                    form.innerHTML = '<div class="success-msg"><i class="fas fa-check-circle"></i><h2 style="color:#1B1F3B;margin-bottom:8px">Cảm ơn bạn!</h2><p style="color:#64748b">Feedback của bạn đã được ghi nhận thành công</p><a href="${pageContext.request.contextPath}/feedback" style="display:inline-block;margin-top:20px;padding:12px 28px;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:white;border-radius:12px;font-weight:700;text-decoration:none">Quay lại</a></div>';
                } else {
                    alert(data.message);
                }
            });
        }
    </script>
</body>
</html>
