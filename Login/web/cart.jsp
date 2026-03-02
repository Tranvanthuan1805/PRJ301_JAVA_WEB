<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/include/header.jsp">
    <jsp:param name="activeNav" value="cart" />
    <jsp:param name="pageTitle" value="Giỏ hàng của bạn" />
</jsp:include>

<div class="cart-container container py-5">
    <h2 class="section-title mb-4">🛒 Giỏ hàng của bạn</h2>

    <c:choose>
        <c:when test="${empty sessionScope.cart}">
            <div class="empty-cart text-center py-5">
                <i class="fas fa-shopping-basket fa-4x text-muted mb-3"></i>
                <p class="lead">Giỏ hàng của bạn đang trống!</p>
                <a href="${pageContext.request.contextPath}/explore" class="btn btn-primary mt-3">Khám phá các Tour ngay</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-responsive shadow-sm rounded-lg overflow-hidden bg-white mb-4">
                <table class="table table-hover mb-0">
                    <thead class="bg-light">
                        <tr>
                            <th>Hình ảnh</th>
                            <th>Tour du lịch</th>
                            <th class="text-right">Giá / người</th>
                            <th class="text-center">Số người</th>
                            <th class="text-right">Thành tiền</th>
                            <th class="text-center">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="total" value="0" />
                        <c:forEach var="item" items="${sessionScope.cart}">
                            <c:set var="total" value="${total + item.subTotal}" />
                            <tr>
                                <td style="width: 100px;">
                                    <img src="${item.tour.imageUrl}" alt="${item.tour.tourName}" 
                                         class="img-fluid rounded" style="width: 80px; height: 60px; object-fit: cover;">
                                </td>
                                <td>
                                    <h5 class="mb-1 text-dark">${item.tour.tourName}</h5>
                                    <small class="text-muted"><i class="fas fa-map-marker-alt"></i> ${item.tour.startLocation}</small>
                                </td>
                                <td class="text-right align-middle">
                                    <fmt:formatNumber value="${item.tour.price}" pattern="#,###"/>đ
                                </td>
                                <td class="text-center align-middle" style="width: 150px;">
                                    <div class="input-group input-group-sm mb-0">
                                        <input type="number" class="form-control text-center" value="${item.quantity}" min="1" readonly>
                                    </div>
                                </td>
                                <td class="text-right align-middle font-weight-bold text-primary">
                                    <fmt:formatNumber value="${item.subTotal}" pattern="#,###"/>đ
                                </td>
                                <td class="text-center align-middle">
                                    <a href="${pageContext.request.contextPath}/cart?action=remove&tourId=${item.tour.tourId}" 
                                       class="btn btn-sm btn-outline-danger" title="Xóa khỏi giỏ hàng">
                                        <i class="fas fa-trash"></i> Quay lại
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i> Đặt thêm tour để nhận thêm ưu đãi đặc biệt 
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-3 border-bottom pb-2">
                                <h5>Tạm tính:</h5>
                                <h5 class="text-dark"><fmt:formatNumber value="${total}" pattern="#,###"/>đ</h5>
                            </div>
                            <div class="d-flex justify-content-between mb-4">
                                <h4>Tổng cộng:</h4>
                                <h4 class="text-primary"><fmt:formatNumber value="${total}" pattern="#,###"/>đ</h4>
                            </div>
                            <form action="${pageContext.request.contextPath}/order" method="post">
                                <button type="submit" class="btn btn-primary btn-block btn-lg shadow">
                                    <i class="fas fa-check-circle"></i> Tiến hành Đặt tour & Thanh toán
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/include/footer.jsp" />
