<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${tour != null ? 'Edit Experience' : 'New Experience'} | Da Nang Travel Hub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body style="background: #fdfdfd;">
    <div class="dashboard-wrapper">
        <jsp:include page="/common/_sidebar.jsp" />

        <main class="main-content">
            <header style="margin-bottom: 40px;">
                <a href="${pageContext.request.contextPath}/admin/tours" style="color: var(--text-muted); font-size: 0.9rem; text-decoration: none; margin-bottom: 10px; display: inline-block;">
                    <i class="fas fa-arrow-left"></i> Back to Inventory
                </a>
                <h1 style="color: var(--primary);">${tour != null ? 'Refine Experience' : 'Design New Experience'}</h1>
            </header>

            <form action="${pageContext.request.contextPath}/admin/tours" method="POST" class="card animate-up" style="max-width: 1000px; padding: 40px;">
                <input type="hidden" name="action" value="${tour != null ? 'update' : 'create'}">
                <c:if test="${tour != null}">
                    <input type="hidden" name="id" value="${tour.tourId}">
                </c:if>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px; margin-bottom: 30px;">
                    <!-- Basic Info -->
                    <div>
                        <div style="margin-bottom: 20px;">
                            <label style="display: block; margin-bottom: 8px; font-weight: 600;">Experience Name</label>
                            <input type="text" name="tourName" value="${tour.tourName}" required style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px;" placeholder="e.g., Ba Na Hills VIP Sunset Tour">
                        </div>
                        <div style="margin-bottom: 20px;">
                            <label style="display: block; margin-bottom: 8px; font-weight: 600;">Provider Partner</label>
                            <select name="providerId" required style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px;">
                                <c:forEach items="${providers}" var="p">
                                    <option value="${p.providerId}" ${tour.providerId == p.providerId ? 'selected' : ''}>${p.businessName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <!-- Analytics Trigger -->
                    <div style="background: rgba(10, 35, 81, 0.02); padding: 20px; border-radius: 8px; border: 1px dashed #ddd;">
                        <h4 style="margin-bottom: 10px;"><i class="fas fa-magic" style="color: var(--primary);"></i> AI Smart Pricing</h4>
                        <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 15px;">Automatically adjust pricing based on forecasted demand fluctuations for Da Nang festivals.</p>
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span style="font-size: 0.8rem; font-weight: 600;">Dynamic Pricing Active</span>
                            <label class="switch" style="position: relative; display: inline-block; width: 40px; height: 20px;">
                                <input type="checkbox" checked style="opacity: 0; width: 0; height: 0;">
                                <span style="position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0; background-color: var(--primary); border-radius: 20px;"></span>
                            </label>
                        </div>
                    </div>
                </div>

                <div style="margin-bottom: 30px;">
                    <label style="display: block; margin-bottom: 8px; font-weight: 600;">Short Narrative (Marketing)</label>
                    <textarea name="shortDesc" style="width: 100%; height: 80px; padding: 12px; border: 1px solid #ddd; border-radius: 6px;">${tour.shortDesc}</textarea>
                </div>

                <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-bottom: 30px;">
                    <div>
                        <label style="display: block; margin-bottom: 8px; font-weight: 600;">Base Price ($)</label>
                        <input type="number" step="0.01" name="price" value="${tour.price}" required style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px;">
                    </div>
                    <div>
                        <label style="display: block; margin-bottom: 8px; font-weight: 600;">Max Group Size</label>
                        <input type="number" name="maxPeople" value="${tour.maxPeople}" required style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px;">
                    </div>
                    <div>
                        <label style="display: block; margin-bottom: 8px; font-weight: 600;">Duration</label>
                        <input type="text" name="duration" value="${tour.duration}" placeholder="e.g., 1 Day, 3 Days 2 Nights" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px;">
                    </div>
                </div>

                <div style="display: flex; gap: 20px; margin-top: 40px; border-top: 1px solid #eee; padding-top: 30px;">
                    <button type="submit" class="btn btn-primary" style="padding: 12px 40px;">Publish Experience</button>
                    <button type="reset" class="btn" style="background: white; border: 1px solid #ddd;">Discard Changes</button>
                </div>
            </form>
        </main>
    </div>
</body>
</html>
