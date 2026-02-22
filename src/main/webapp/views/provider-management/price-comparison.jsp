<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Price Comparison Analysis | Da Nang Travel Hub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>
    <div class="dashboard-wrapper">
        <jsp:include page="/common/_sidebar.jsp" />

        <main class="main-content">
            <header style="margin-bottom: 40px;">
                <h1 style="color: var(--primary);">Price Comparison Analysis</h1>
                <p style="color: var(--text-muted);">Benchmarking partner costs to optimize tour pricing.</p>
            </header>

            <!-- Price Benchmarking Table -->
            <section class="card animate-up" style="margin-bottom: 40px;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px;">
                    <h3>Market Benchmark: Da Nang High Season</h3>
                    <div style="display: flex; gap: 10px;">
                        <select class="btn" style="background: white; border: 1px solid #ddd; font-size: 0.8rem;">
                            <option>June 2026</option>
                            <option>July 2026</option>
                        </select>
                    </div>
                </div>
                
                <table style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr style="text-align: left; background: #f8f9fa;">
                            <th style="padding: 15px;">Provider Name</th>
                            <th style="padding: 15px;">Standard Price</th>
                            <th style="padding: 15px;">Peak Season </th>
                            <th style="padding: 15px;">Variation</th>
                            <th style="padding: 15px;">Impact on Tour</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr style="border-bottom: 1px solid #eee;">
                            <td style="padding: 15px; font-weight: 600;">InterContinental Sun Peninsula</td>
                            <td style="padding: 15px;">$450/night</td>
                            <td style="padding: 15px;">$580/night</td>
                            <td style="padding: 15px; color: #fa5252;">+28.8%</td>
                            <td style="padding: 15px;"><span style="color: #fa5252; font-weight: 700;">High Risk</span></td>
                        </tr>
                        <tr style="border-bottom: 1px solid #eee;">
                            <td style="padding: 15px; font-weight: 600;">Furama Resort Da Nang</td>
                            <td style="padding: 15px;">$210/night</td>
                            <td style="padding: 15px;">$240/night</td>
                            <td style="padding: 15px; color: var(--success);">+14.2%</td>
                            <td style="padding: 15px;"><span style="color: var(--success); font-weight: 700;">Stable</span></td>
                        </tr>
                        <tr style="border-bottom: 1px solid #eee;">
                            <td style="padding: 15px; font-weight: 600;">Thanh Cong Transport</td>
                            <td style="padding: 15px;">$50/day</td>
                            <td style="padding: 15px;">$55/day</td>
                            <td style="padding: 15px; color: var(--success);">+10.0%</td>
                            <td style="padding: 15px;"><span style="color: var(--success); font-weight: 700;">Low Risk</span></td>
                        </tr>
                    </tbody>
                </table>
            </section>

            <!-- Visual Comparison Placeholder -->
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">
                <div class="card" style="border-top: 4px solid var(--accent);">
                    <h4 style="margin-bottom: 15px;"><i class="fas fa-chart-line"></i> Price Trend Index</h4>
                    <div style="height: 200px; background: #f1f2f6; border-radius: 8px; display: flex; align-items: center; justify-content: center;">
                        <p style="color: #ccc; font-style: italic;">Dynamic chart visualization of price fluctuations over the last 12 months.</p>
                    </div>
                </div>
                <div class="card" style="border-top: 4px solid var(--success);">
                    <h4 style="margin-bottom: 15px;"><i class="fas fa-hand-holding-usd"></i> Profit Margin Optimizer</h4>
                    <p style="font-size: 0.9rem; margin-bottom: 15px; color: var(--text-muted);">Automatically adjust tour retail prices based on provider cost shifts.</p>
                    <button class="btn btn-primary" style="width: 100%;">Recalculate All Tours</button>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
