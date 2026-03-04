<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Details #${order.orderId} | Da Nang Travel Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>
    <div class="dashboard-wrapper">
        <jsp:include page="/common/_sidebar.jsp" />

        <main class="main-content">
            <header style="margin-bottom: 40px; display: flex; justify-content: space-between; align-items: flex-end;">
                <div>
                    <a href="${pageContext.request.contextPath}/admin/orders" style="color: var(--text-muted); font-size: 0.9rem; text-decoration: none; margin-bottom: 10px; display: inline-block;">
                        <i class="fas fa-arrow-left"></i> Back to Registry
                    </a>
                    <h1 style="color: var(--primary);">Order #${order.orderId}</h1>
                    <p style="color: var(--text-muted);">Placed on <fmt:formatDate value="${order.orderDate}" pattern="dd MMMM yyyy HH:mm"/></p>
                </div>
                
                <form action="${pageContext.request.contextPath}/admin/orders" method="POST" style="display: flex; gap: 10px;">
                    <input type="hidden" name="action" value="updateStatus">
                    <input type="hidden" name="orderId" value="${order.orderId}">
                    <select name="status" class="btn" style="background: white; border: 1px solid #ddd;">
                        <option value="Pending" ${order.orderStatus == 'Pending' ? 'selected' : ''}>Pending</option>
                        <option value="Confirmed" ${order.orderStatus == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                        <option value="Completed" ${order.orderStatus == 'Completed' ? 'selected' : ''}>Completed</option>
                        <option value="Cancelled" ${order.orderStatus == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                    </select>
                    <button type="submit" class="btn btn-primary">Update Status</button>
                </form>
            </header>

            <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 30px;">
                <!-- Tour Items -->
                <section>
                    <div class="card">
                        <h3 style="margin-bottom: 25px;">Booked Experiences</h3>
                        <table style="width: 100%; border-collapse: collapse;">
                            <thead>
                                <tr style="text-align: left; border-bottom: 1px solid #eee;">
                                    <th style="padding-bottom: 15px;">Experience</th>
                                    <th style="padding-bottom: 15px;">Travel Date</th>
                                    <th style="padding-bottom: 15px;">Guests</th>
                                    <th style="padding-bottom: 15px; text-align: right;">Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${items}" var="item">
                                    <tr style="border-bottom: 1px solid #fafafa;">
                                        <td style="padding: 15px 0; font-weight: 600; color: var(--primary);">Tour ID: #${item.tourId}</td>
                                        <td style="padding: 15px 0;"><fmt:formatDate value="${item.tourDate}" pattern="dd MMM yyyy" /></td>
                                        <td style="padding: 15px 0;">${item.quantity}</td>
                                        <td style="padding: 15px 0; text-align: right; font-weight: 700;">$<fmt:formatNumber value="${item.subTotal}" pattern="#,###.00"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="3" style="padding-top: 25px; text-align: right; color: var(--text-muted);">Total Amount</td>
                                    <td style="padding-top: 25px; text-align: right; font-size: 1.5rem; font-weight: 800; color: var(--primary);">
                                        $<fmt:formatNumber value="${order.totalAmount}" pattern="#,###.00"/>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </section>

                <!-- Customer & Payment Info -->
                <aside>
                    <div class="card" style="margin-bottom: 30px;">
                        <h4 style="margin-bottom: 20px;"><i class="fas fa-user-circle"></i> Customer Information</h4>
                        <p style="font-weight: 700;">${order.customerName}</p>
                        <p style="color: var(--text-muted); font-size: 0.9rem; margin-top: 5px;">Customer ID: #${order.customerId}</p>
                        <button class="btn" style="width: 100%; margin-top: 20px; font-size: 0.8rem; border: 1px solid #ddd; background: white;">View Customer CRM</button>
                    </div>

                    <div class="card" style="background: rgba(46, 125, 50, 0.02); border-left: 4px solid var(--success);">
                        <h4 style="margin-bottom: 15px; color: var(--success);"><i class="fas fa-shield-alt"></i> Payment Verified</h4>
                        <p style="font-size: 0.85rem; color: #666;">
                            Transaction processed via <strong>Napam 24/7</strong>. 
                        </p>
                        <div style="margin-top: 15px; font-family: monospace; font-size: 0.75rem; color: #999;">
                            TXN: ACB-9832-11X-902
                        </div>
                    </div>
                </aside>
            </div>
        </main>
    </div>
</body>
</html>
