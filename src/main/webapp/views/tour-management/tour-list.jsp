<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Tour Inventory | Da Nang Travel Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .tour-badge { position: absolute; top: 10px; right: 10px; color: white; padding: 4px 12px; border-radius: 20px; font-size: 0.7rem; font-weight: 700; }
        .tour-active { background: rgba(46, 125, 50, 0.9); }
        .tour-paused { background: rgba(238, 82, 82, 0.9); }
    </style>
</head>
<body>
    <div class="dashboard-wrapper">
        <jsp:include page="/common/_sidebar.jsp" />

        <main class="main-content">
            <header style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px;">
                <div>
                    <h1 style="color: var(--primary);">Tour Inventory</h1>
                    <p style="color: var(--text-muted);">Manage Da Nang travel experiences and occupancy.</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/tours?action=new" class="btn btn-primary">+ Create Experience</a>
            </header>

            <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 25px;">
                <c:forEach items="${tours}" var="t">
                    <div class="card animate-up" style="padding: 0; overflow: hidden; display: flex; flex-direction: column;">
                        <div style="position: relative; height: 180px;">
                            <img src="${t.imageUrl}" style="width: 100%; height: 100%; object-fit: cover;">
                             <div class="tour-badge ${t.active ? 'tour-active' : 'tour-paused'}">
                                 ${t.active ? 'ACTIVE' : 'PAUSED'}
                             </div>
                        </div>
                        <div style="padding: 20px; flex: 1;">
                            <h3 style="margin-bottom: 10px; color: var(--primary); font-size: 1.1rem;">${t.tourName}</h3>
                            <div style="display: flex; gap: 15px; margin-bottom: 15px; font-size: 0.8rem; color: var(--text-muted);">
                                <span><i class="fas fa-users"></i> Max ${t.maxPeople}</span>
                                <span><i class="fas fa-clock"></i> ${t.duration}</span>
                            </div>
                            
                            <!-- Dynamic Status Tracker -->
                            <div style="background: #f8f9fa; padding: 12px; border-radius: 8px; margin-bottom: 20px;">
                                <div style="display: flex; justify-content: space-between; font-size: 0.75rem; margin-bottom: 5px;">
                                    <span>Today's Occupancy</span>
                                    <span style="font-weight: 700;">64%</span>
                                </div>
                                <div style="height: 6px; background: #eee; border-radius: 3px; position: relative;">
                                    <div style="position: absolute; left: 0; top: 0; height: 100%; width: 64%; background: var(--primary); border-radius: 3px;"></div>
                                </div>
                            </div>

                            <div style="display: flex; justify-content: space-between; align-items: center; padding-top: 15px; border-top: 1px solid #f0f0f0;">
                                <span style="font-weight: 800; color: var(--success);">$<fmt:formatNumber value="${t.price}" pattern="#,###.00"/></span>
                                <div style="display: flex; gap: 10px;">
                                    <a href="${pageContext.request.contextPath}/admin/tours?action=edit&id=${t.tourId}" style="color: var(--primary);"><i class="fas fa-edit"></i></a>
                                    <a href="${pageContext.request.contextPath}/admin/tours?action=delete&id=${t.tourId}" style="color: #fa5252;" onclick="return confirm('Archive this tour?')"><i class="fas fa-archive"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${empty tours}">
                <div style="text-align: center; padding: 80px; background: white; border-radius: var(--radius); border: 1px dashed #ddd;">
                    <i class="fas fa-map-marked-alt" style="font-size: 3rem; color: #ddd; margin-bottom: 20px;"></i>
                    <p style="color: var(--text-muted);">No tours in inventory. Start building your Da Nang catalog!</p>
                </div>
            </c:if>
        </main>
    </div>
</body>
</html>
