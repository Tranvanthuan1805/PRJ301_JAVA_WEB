<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ Sơ Cá Nhân | Da Nang Travel Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        /* Profile Header */
        .profile-header{background:linear-gradient(135deg,#1B1F3B,#2D3561);padding:64px 0 90px;color:white;position:relative;overflow:hidden;margin-top:64px}
        .profile-header::before{content:'';position:absolute;width:500px;height:500px;background:radial-gradient(circle,rgba(255,111,97,.1),transparent 60%);top:-200px;right:-100px;border-radius:50%}
        .profile-header::after{content:'';position:absolute;width:300px;height:300px;background:radial-gradient(circle,rgba(0,180,216,.08),transparent 60%);bottom:-100px;left:-50px;border-radius:50%}
        .profile-header .container{display:flex;align-items:center;gap:28px;max-width:1280px;margin:0 auto;padding:0 30px;position:relative;z-index:1}
        .avatar-circle{width:90px;height:90px;border-radius:50%;background:linear-gradient(135deg,#FF6F61,#FF9A8B);display:flex;align-items:center;justify-content:center;font-size:2.2rem;font-weight:800;border:4px solid rgba(255,255,255,.2);box-shadow:0 8px 30px rgba(255,111,97,.3);flex-shrink:0}
        .profile-name{font-size:1.8rem;font-weight:800;margin-bottom:4px;letter-spacing:-.3px}
        .profile-email{opacity:.65;font-size:.9rem;display:flex;align-items:center;gap:6px}
        .profile-badge{display:inline-flex;align-items:center;gap:6px;padding:5px 14px;background:rgba(255,255,255,.1);border:1px solid rgba(255,255,255,.12);border-radius:999px;font-size:.75rem;font-weight:700;margin-top:8px;color:rgba(255,255,255,.8)}
        .profile-badge i{color:#FFB703}

        /* Content */
        .profile-content{display:grid;grid-template-columns:1fr 1fr;gap:28px;margin:-50px auto 60px;max-width:1280px;padding:0 30px;position:relative;z-index:10}

        .profile-card{background:white;border-radius:20px;padding:32px;box-shadow:0 4px 20px rgba(27,31,59,.06);border:1px solid #E8EAF0;animation:fadeUp .6s ease both}
        .profile-card:nth-child(2){animation-delay:.1s}
        @keyframes fadeUp{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}

        .profile-card h3{font-size:1.15rem;color:#1B1F3B;margin-bottom:28px;display:flex;align-items:center;gap:10px;font-weight:800}
        .profile-card h3 i{color:#FF6F61;font-size:1rem}

        .form-row{margin-bottom:20px}
        .form-row label{display:block;font-size:.8rem;font-weight:700;color:#1B1F3B;margin-bottom:6px;text-transform:uppercase;letter-spacing:.5px}
        .form-row .input-wrap{position:relative}
        .form-row .input-wrap i{position:absolute;left:16px;top:50%;transform:translateY(-50%);color:#A0A5C3;font-size:.85rem}
        .form-row input{width:100%;padding:13px 16px 13px 44px;border:2px solid #E8EAF0;border-radius:14px;font-family:'Plus Jakarta Sans',sans-serif;font-size:.9rem;transition:.3s;background:#F7F8FC;color:#1B1F3B}
        .form-row input:focus{outline:none;border-color:#FF6F61;box-shadow:0 0 0 4px rgba(255,111,97,.08);background:#fff}
        .form-row input[readonly]{background:#F0F1F5;color:#A0A5C3;cursor:not-allowed}

        .btn-save{display:inline-flex;align-items:center;gap:8px;padding:14px 32px;background:linear-gradient(135deg,#1B1F3B,#2D3561);color:white;border:none;border-radius:14px;font-weight:800;cursor:pointer;transition:.3s;font-family:'Plus Jakarta Sans',sans-serif;font-size:.9rem}
        .btn-save:hover{transform:translateY(-2px);box-shadow:0 10px 30px rgba(27,31,59,.25)}

        /* Activity */
        .activity-item{display:flex;gap:14px;padding:16px 0;border-bottom:1px solid #F5F6FA;transition:.2s}
        .activity-item:last-child{border-bottom:none}
        .activity-item:hover{background:#FAFBFF;margin:0 -12px;padding-left:12px;padding-right:12px;border-radius:12px}
        .activity-icon{width:40px;height:40px;border-radius:12px;display:flex;align-items:center;justify-content:center;flex-shrink:0;font-size:.85rem}
        .activity-icon.blue{background:rgba(0,180,216,.08);color:#00B4D8}
        .activity-icon.green{background:rgba(6,214,160,.08);color:#06D6A0}
        .activity-icon.orange{background:rgba(255,183,3,.08);color:#FFB703}
        .activity-text{font-size:.88rem;color:#1B1F3B;font-weight:500}
        .activity-time{font-size:.75rem;color:#A0A5C3;margin-top:4px;display:flex;align-items:center;gap:4px}

        /* Alerts */
        .alert-success{background:linear-gradient(135deg,#ECFDF5,#D1FAE5);color:#059669;padding:14px 18px;border-radius:14px;margin-bottom:22px;display:flex;align-items:center;gap:10px;font-size:.88rem;border:1px solid #A7F3D0;font-weight:600}
        .alert-error{background:linear-gradient(135deg,#FEF2F2,#FEE2E2);color:#DC2626;padding:14px 18px;border-radius:14px;margin-bottom:22px;display:flex;align-items:center;gap:10px;font-size:.88rem;border:1px solid #FECACA;font-weight:600}

        /* Empty */
        .empty-activity{text-align:center;padding:40px 20px;color:#A0A5C3}
        .empty-activity i{font-size:2.5rem;margin-bottom:12px;display:block;opacity:.3}

        @media(max-width:768px){
            .profile-content{grid-template-columns:1fr}
            .profile-header .container{flex-direction:column;text-align:center}
            .profile-email{justify-content:center}
        }
    </style>
</head>
<body>
    <jsp:include page="/common/_header.jsp" />

    <div class="profile-header">
        <div class="container">
            <div class="avatar-circle">${sessionScope.user.username.substring(0,1).toUpperCase()}</div>
            <div>
                <div class="profile-name">${user.fullName != null ? user.fullName : user.username}</div>
                <div class="profile-email"><i class="fas fa-envelope"></i> ${user.email}</div>
                <div class="profile-badge"><i class="fas fa-crown"></i> Thành viên Da Nang Hub</div>
            </div>
        </div>
    </div>

    <div class="profile-content">
        <div class="profile-card">
            <h3><i class="fas fa-user-edit"></i> Thông Tin Cá Nhân</h3>

            <c:if test="${not empty success}">
                <div class="alert-success"><i class="fas fa-check-circle"></i> ${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert-error"><i class="fas fa-exclamation-circle"></i> ${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/profile" method="post">
                <input type="hidden" name="action" value="update">
                <div class="form-row">
                    <label>Tên đăng nhập</label>
                    <div class="input-wrap">
                        <i class="fas fa-user"></i>
                        <input type="text" value="${user.username}" readonly>
                    </div>
                </div>
                <div class="form-row">
                    <label>Họ tên</label>
                    <div class="input-wrap">
                        <i class="fas fa-id-card"></i>
                        <input type="text" name="fullName" value="${user.fullName}" placeholder="Nhập họ tên đầy đủ">
                    </div>
                </div>
                <div class="form-row">
                    <label>Email</label>
                    <div class="input-wrap">
                        <i class="fas fa-envelope"></i>
                        <input type="email" name="email" value="${user.email}" placeholder="email@example.com">
                    </div>
                </div>
                <div class="form-row">
                    <label>Số điện thoại</label>
                    <div class="input-wrap">
                        <i class="fas fa-phone"></i>
                        <input type="text" name="phone" value="${user.phone}" placeholder="0xxx-xxx-xxx">
                    </div>
                </div>
                <div class="form-row">
                    <label>Địa chỉ</label>
                    <div class="input-wrap">
                        <i class="fas fa-map-marker-alt"></i>
                        <input type="text" name="address" value="${user.address}" placeholder="Địa chỉ của bạn">
                    </div>
                </div>
                <button type="submit" class="btn-save"><i class="fas fa-save"></i> Lưu Thay Đổi</button>
            </form>
        </div>

        <div class="profile-card">
            <h3><i class="fas fa-history"></i> Hoạt Động Gần Đây</h3>
            <c:choose>
                <c:when test="${not empty activities}">
                    <c:forEach items="${activities}" var="a" varStatus="loop">
                        <div class="activity-item">
                            <div class="activity-icon ${loop.index % 3 == 0 ? 'blue' : (loop.index % 3 == 1 ? 'green' : 'orange')}">
                                <i class="fas fa-${loop.index % 3 == 0 ? 'shopping-bag' : (loop.index % 3 == 1 ? 'check-circle' : 'star')}"></i>
                            </div>
                            <div>
                                <div class="activity-text">${a.actionDescription}</div>
                                <div class="activity-time"><i class="fas fa-clock"></i> <fmt:formatDate value="${a.actionDate}" pattern="dd/MM/yyyy HH:mm"/></div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-activity">
                        <i class="fas fa-clock"></i>
                        <p>Chưa có hoạt động nào</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <jsp:include page="/common/_footer.jsp" />
</body>
</html>
