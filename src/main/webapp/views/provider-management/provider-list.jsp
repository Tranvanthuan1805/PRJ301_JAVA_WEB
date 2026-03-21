<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Provider Management | Da Nang Travel Hub</title>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
            <style>
                .provider-toast {
                    position: fixed;
                    bottom: 24px;
                    right: 24px;
                    z-index: 9999;
                    display: flex;
                    align-items: flex-start;
                    gap: 12px;
                    background: #fff;
                    border-left: 4px solid #4c6ef5;
                    border-radius: 8px;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, .15);
                    padding: 14px 16px;
                    min-width: 300px;
                    max-width: 380px;
                    opacity: 0;
                    transform: translateY(20px);
                    transition: opacity .35s, transform .35s;
                }

                .provider-toast.show {
                    opacity: 1;
                    transform: translateY(0);
                }

                .provider-toast-icon {
                    font-size: 1.4rem;
                    color: #4c6ef5;
                    padding-top: 2px;
                }

                .provider-toast-body {
                    flex: 1;
                    font-size: .9rem;
                    line-height: 1.5;
                }

                .provider-toast-close {
                    background: none;
                    border: none;
                    font-size: 1.2rem;
                    cursor: pointer;
                    color: #aaa;
                }
            </style>
        </head>

        <body>
            <div class="dashboard-wrapper">
                <jsp:include page="/common/_sidebar.jsp" />

                <main class="main-content">
                    <header
                        style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px;">
                        <div>
                            <h1 style="color: var(--primary);">Provider Management</h1>
                            <p style="color: var(--text-muted);">Manage your hotels, airlines, and transport partners.
                            </p>
                        </div>
                        <div style="display: flex; gap: 15px;">
                            <a href="${pageContext.request.contextPath}/admin/providers?action=comparison" class="btn"
                                style="background: white; border: 1px solid #ddd;"><i class="fas fa-balance-scale"></i>
                                Comparison</a>
                            <button class="btn btn-primary">+ Add Provider</button>
                        </div>
                    </header>

                    <!-- Provider Table -->
                    <section class="card animate-up">
                        <table style="width: 100%; border-collapse: collapse;">
                            <thead>
                                <tr style="text-align: left; border-bottom: 2px solid #eee;">
                                    <th style="padding: 15px;">Business Name</th>
                                    <th style="padding: 15px;">Type</th>
                                    <th style="padding: 15px;">Rating</th>
                                    <th style="padding: 15px;">Verification</th>
                                    <th style="padding: 15px;">Status</th>
                                    <th style="padding: 15px;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${providers}" var="p">
                                    <tr style="border-bottom: 1px solid #f9f9f9;">
                                        <td style="padding: 15px;">
                                            <div style="font-weight: 700;">${p.businessName}</div>
                                            <small style="color: var(--text-muted);">ID: #${p.providerId}</small>
                                        </td>
                                        <td style="padding: 15px;">
                                            <span class="badge"
                                                style="background: #edf2ff; color: #4c6ef5; padding: 4px 10px; border-radius: 20px; font-size: 0.8rem;">
                                                ${p.providerType}
                                            </span>
                                        </td>
                                        <td style="padding: 15px; color: #f1c40f;">
                                            <i class="fas fa-star"></i> ${p.rating}
                                        </td>
                                        <td style="padding: 15px;">
                                            <c:choose>
                                                <c:when test="${p.verified}">
                                                    <span style="color: var(--success);"><i
                                                            class="fas fa-check-circle"></i> Verified</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: #fab005;"><i class="fas fa-clock"></i>
                                                        Pending</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="padding: 15px;">
                                            <span
                                                style="background: ${p.active ? '#ecfdf5' : '#fff5f5'}; color: ${p.active ? '#059669' : '#fa5252'}; padding: 4px 10px; border-radius: 20px; font-size: 0.8rem;">
                                                ${p.active ? 'Active' : 'Inactive'}
                                            </span>
                                        </td>
                                        <td style="padding: 15px;">
                                            <a href="${pageContext.request.contextPath}/admin/providers?action=edit&id=${p.providerId}"
                                                style="color: var(--primary); margin-right: 15px;"><i
                                                    class="fas fa-edit"></i></a>
                                            <a href="#" style="color: #fa5252;"><i class="fas fa-trash"></i></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <c:if test="${empty providers}">
                            <div style="text-align: center; padding: 50px;">
                                <img src="https://cdn-icons-png.flaticon.com/512/4076/4076478.png" width="100"
                                    style="opacity: 0.2; margin-bottom: 20px;">
                                <p style="color: var(--text-muted);">No partners found. Start by adding your first
                                    provider!</p>
                            </div>
                        </c:if>
                    </section>
                </main>
            </div>
            <!-- Realtime SSE: thông báo khi có NCC đăng ký mới -->
            <script>window._contextPath = '${pageContext.request.contextPath}';</script>
            <script src="${pageContext.request.contextPath}/js/provider-realtime.js"></script>
        </body>

        </html>