<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khám Phá & Quản Lý Nhà Cung Cấp | Da Nang Travel Hub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body { 
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f0f7ff 0%, #eff6ff 25%, #f5f3ff 50%, #fef9f3 75%, #f0f7ff 100%);
            background-attachment: fixed;
            min-height: 100vh;
            color: #2c3e50;
            overflow-x: hidden;
        }

        .main-wrapper { max-width: 1500px; margin: 0 auto; padding: 60px 20px; }

        /* ===== HERO BANNER ===== */
        .page-header {
            background: linear-gradient(135deg, #ff6b9d 0%, #c44569 25%, #f8a537 50%, #fbb040 75%, #ff6b9d 100%);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
            color: white;
            padding: 100px 60px;
            border-radius: 30px;
            margin-bottom: 70px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(255, 107, 157, 0.3);
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 500px;
            height: 500px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            filter: blur(60px);
        }

        .page-header::after {
            content: '';
            position: absolute;
            bottom: -30%;
            left: 5%;
            width: 400px;
            height: 400px;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 50%;
            filter: blur(50px);
        }

        .header-content {
            position: relative;
            z-index: 1;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 50px;
        }

        .header-text h1 {
            font-family: 'Playfair Display', serif;
            font-size: 4rem;
            font-weight: 900;
            margin-bottom: 18px;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            letter-spacing: -2px;
            line-height: 1.1;
        }

        .header-text p {
            font-size: 1.25rem;
            opacity: 0.95;
            font-weight: 300;
            margin-bottom: 10px;
            line-height: 1.6;
        }

        .travel-icons {
            display: flex;
            gap: 16px;
            margin-top: 20px;
            opacity: 0.9;
        }

        .travel-icons span {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 15px;
            font-weight: 600;
            padding: 8px 12px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 20px;
        }

        .header-buttons {
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .btn-header {
            padding: 16px 32px;
            background: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(10px);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.4);
            border-radius: 14px;
            cursor: pointer;
            font-weight: 700;
            transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-size: 16px;
            white-space: nowrap;
        }

        .btn-header:hover {
            background: rgba(255, 255, 255, 0.35);
            border-color: white;
            transform: translateY(-4px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.2);
        }

        /* ===== STATS ===== */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 28px;
            margin-bottom: 70px;
        }

        .stat-card {
            background: white;
            border-radius: 24px;
            padding: 45px 35px;
            box-shadow: 0 10px 40px rgba(68, 68, 68, 0.08);
            transition: all 0.5s cubic-bezier(0.34, 1.56, 0.64, 1);
            position: relative;
            overflow: hidden;
            text-align: center;
            border: 1px solid rgba(255, 107, 157, 0.1);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 200, 100, 0.2), transparent);
            transition: left 0.6s;
        }

        .stat-card:hover {
            transform: translateY(-18px);
            box-shadow: 0 25px 60px rgba(255, 107, 157, 0.2);
            border-color: rgba(255, 107, 157, 0.3);
        }

        .stat-card:hover::before {
            left: 100%;
        }

        .stat-icon {
            width: 100px;
            height: 100px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3.2rem;
            margin: 0 auto 25px;
            color: white;
            box-shadow: 0 12px 30px rgba(255, 107, 157, 0.3);
        }

        .stat-card:nth-child(1) .stat-icon {
            background: linear-gradient(135deg, #ff6b9d 0%, #c44569 100%);
        }

        .stat-card:nth-child(2) .stat-icon {
            background: linear-gradient(135deg, #f8a537 0%, #fbb040 100%);
        }

        .stat-card:nth-child(3) .stat-icon {
            background: linear-gradient(135deg, #26c6da 0%, #00bcd4 100%);
        }

        .stat-label {
            color: #7f8c8d;
            font-size: 0.95rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 15px;
        }

        .stat-value {
            font-size: 3.8rem;
            font-weight: 900;
            background: linear-gradient(135deg, #ff6b9d 0%, #f8a537 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        /* ===== FILTER SECTION ===== */
        .filter-section {
            background: white;
            border-radius: 24px;
            padding: 45px;
            margin-bottom: 50px;
            box-shadow: 0 10px 40px rgba(68, 68, 68, 0.08);
            border: 1px solid rgba(255, 107, 157, 0.1);
        }

        .filter-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 35px;
            font-size: 1.6rem;
            font-weight: 800;
            color: #2c3e50;
        }

        .filter-header i {
            color: #ff6b9d;
            font-size: 1.8rem;
        }

        .filter-controls {
            display: flex;
            gap: 16px;
            flex-wrap: wrap;
            align-items: stretch;
        }

        .search-wrapper {
            flex: 1;
            min-width: 300px;
            display: flex;
            gap: 12px;
        }

        .search-input {
            flex: 1;
            padding: 16px 24px;
            border: 2px solid #e0e0e0;
            border-radius: 14px;
            font-size: 15px;
            font-weight: 600;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s;
            background: #f8f9fa;
        }

        .search-input:focus {
            outline: none;
            border-color: #ff6b9d;
            background: white;
            box-shadow: 0 0 0 6px rgba(255, 107, 157, 0.1);
        }

        .search-input::placeholder {
            color: #a8a8a8;
        }

        .search-btn {
            padding: 16px 32px;
            background: linear-gradient(135deg, #ff6b9d 0%, #c44569 100%);
            color: white;
            border: none;
            border-radius: 14px;
            cursor: pointer;
            font-weight: 700;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 10px 30px rgba(255, 107, 157, 0.3);
            font-family: 'Poppins', sans-serif;
            font-size: 15px;
        }

        .search-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(255, 107, 157, 0.4);
        }

        .filter-select {
            padding: 16px 24px;
            border: 2px solid #e0e0e0;
            border-radius: 14px;
            background: #f8f9fa;
            cursor: pointer;
            font-weight: 700;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s;
            color: #2c3e50;
        }

        .filter-select:hover {
            border-color: #ff6b9d;
            background: white;
        }

        .filter-select:focus {
            outline: none;
            border-color: #ff6b9d;
            box-shadow: 0 0 0 6px rgba(255, 107, 157, 0.1);
        }

        .filter-select option {
            background: white;
            color: #2c3e50;
        }

        /* ===== COMPARISON BAR ===== */
        .comparison-bar {
            background: linear-gradient(135deg, rgba(255, 107, 157, 0.08) 0%, rgba(248, 165, 55, 0.08) 100%);
            border: 2px solid rgba(255, 107, 157, 0.2);
            border-radius: 18px;
            padding: 28px;
            margin-bottom: 40px;
            display: none;
            animation: slideDown 0.4s ease;
        }

        .comparison-bar.active {
            display: block;
        }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .comparison-bar h3 {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            color: #ff6b9d;
            font-size: 1.2rem;
            font-weight: 800;
        }

        .comparison-items {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }

        .comparison-item {
            background: linear-gradient(135deg, #ff6b9d 0%, #c44569 100%);
            color: white;
            padding: 10px 18px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 700;
            box-shadow: 0 6px 20px rgba(255, 107, 157, 0.3);
            font-size: 14px;
        }

        .comparison-item button {
            background: rgba(255, 255, 255, 0.3);
            border: none;
            cursor: pointer;
            color: white;
            padding: 4px 10px;
            border-radius: 6px;
            font-weight: 900;
            transition: all 0.3s;
        }

        .comparison-item button:hover {
            background: rgba(255, 255, 255, 0.5);
        }

        .comparison-buttons {
            display: flex;
            gap: 12px;
        }

        .btn-compare-action {
            padding: 12px 28px;
            background: linear-gradient(135deg, #ff6b9d 0%, #c44569 100%);
            color: white;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-weight: 700;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 6px 20px rgba(255, 107, 157, 0.3);
        }

        .btn-compare-action:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(255, 107, 157, 0.4);
        }

        /* ===== PROVIDER CARDS GRID ===== */
        .providers-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(360px, 1fr));
            gap: 28px;
            margin-bottom: 50px;
        }

        .provider-card {
            background: white;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(68, 68, 68, 0.08);
            transition: all 0.5s cubic-bezier(0.34, 1.56, 0.64, 1);
            position: relative;
            display: flex;
            flex-direction: column;
            border: 1px solid rgba(255, 107, 157, 0.1);
        }

        .provider-card:hover {
            transform: translateY(-16px);
            box-shadow: 0 30px 70px rgba(255, 107, 157, 0.25);
            border-color: rgba(255, 107, 157, 0.3);
        }

        .provider-card.selected {
            border: 3px solid #10b981;
            box-shadow: 0 0 0 6px rgba(16, 185, 129, 0.1), 0 30px 70px rgba(255, 107, 157, 0.25);
        }

        .provider-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: linear-gradient(90deg, #ff6b9d, #f8a537, #26c6da);
        }

        .provider-header {
            padding: 32px 28px 24px;
            border-bottom: 1px solid #f0f0f0;
        }

        .provider-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 15px;
            margin-bottom: 16px;
        }

        .provider-name {
            font-size: 1.3rem;
            font-weight: 800;
            color: #2c3e50;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .verify-badge {
            color: #10b981;
            font-size: 1.2rem;
        }

        .rating-badge {
            background: linear-gradient(135deg, #f8a537 0%, #fbb040 100%);
            color: white;
            padding: 10px 16px;
            border-radius: 14px;
            font-weight: 800;
            text-align: center;
            box-shadow: 0 6px 20px rgba(248, 165, 55, 0.3);
            min-width: 70px;
        }

        .provider-type {
            display: inline-block;
            background: linear-gradient(135deg, rgba(255, 107, 157, 0.1) 0%, rgba(248, 165, 55, 0.1) 100%);
            color: #ff6b9d;
            padding: 8px 16px;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 700;
            margin-top: 10px;
            border: 1px solid rgba(255, 107, 157, 0.2);
        }

        .provider-content {
            padding: 24px 28px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .provider-info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            margin-bottom: 24px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #7f8c8d;
            font-size: 0.95rem;
            font-weight: 600;
        }

        .info-item i {
            color: #ff6b9d;
            width: 22px;
            text-align: center;
        }

        .status-badges {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 24px;
            padding-top: 16px;
            border-top: 1px solid #f0f0f0;
        }

        .badge {
            padding: 8px 14px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .badge-verified {
            background: rgba(16, 185, 129, 0.15);
            color: #10b981;
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .badge-active {
            background: rgba(59, 130, 246, 0.15);
            color: #3b82f6;
            border: 1px solid rgba(59, 130, 246, 0.3);
        }

        .provider-actions {
            display: flex;
            gap: 12px;
            margin-top: auto;
        }

        .action-btn {
            flex: 1;
            padding: 12px 14px;
            border: 2px solid transparent;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            cursor: pointer;
            font-weight: 700;
            transition: all 0.3s;
            font-size: 13px;
            background: white;
            color: #2c3e50;
            font-family: 'Poppins', sans-serif;
        }

        .btn-view {
            border-color: #3b82f6;
            color: #3b82f6;
            background: rgba(59, 130, 246, 0.08);
        }

        .btn-view:hover {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
            transform: translateY(-2px);
        }

        .btn-history {
            border-color: #ec4899;
            color: #ec4899;
            background: rgba(236, 72, 153, 0.08);
        }

        .btn-history:hover {
            background: linear-gradient(135deg, #ec4899 0%, #db2777 100%);
            color: white;
            transform: translateY(-2px);
        }

        .btn-compare {
            border-color: #ff6b9d;
            color: #ff6b9d;
            background: rgba(255, 107, 157, 0.08);
        }

        .btn-compare:hover {
            background: linear-gradient(135deg, #ff6b9d 0%, #c44569 100%);
            color: white;
            transform: translateY(-2px);
        }

        /* ===== EMPTY STATE ===== */
        .empty-state {
            text-align: center;
            padding: 100px 40px;
            background: white;
            border-radius: 24px;
            box-shadow: 0 10px 40px rgba(68, 68, 68, 0.08);
            grid-column: 1/-1;
            border: 1px solid rgba(255, 107, 157, 0.1);
        }

        .empty-icon {
            font-size: 5rem;
            background: linear-gradient(135deg, #ff6b9d 0%, #f8a537 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 25px;
        }

        .empty-title {
            font-size: 1.8rem;
            font-weight: 800;
            color: #2c3e50;
            margin-bottom: 12px;
        }

        .empty-text {
            color: #7f8c8d;
            font-size: 1.05rem;
            margin-bottom: 30px;
        }

        /* ===== MODAL ===== */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
            animation: fadeIn 0.3s;
        }

        .modal.active {
            display: flex;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .modal-content {
            background: white;
            border-radius: 28px;
            padding: 50px 45px;
            max-width: 650px;
            width: 90%;
            max-height: 85vh;
            overflow-y: auto;
            box-shadow: 0 40px 80px rgba(0, 0, 0, 0.3);
            position: relative;
            animation: modalSlide 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
            border: 1px solid rgba(255, 107, 157, 0.1);
        }

        @keyframes modalSlide {
            from { opacity: 0; transform: scale(0.9) translateY(30px); }
            to { opacity: 1; transform: scale(1) translateY(0); }
        }

        .modal-close {
            position: absolute;
            right: 24px;
            top: 24px;
            background: linear-gradient(135deg, #f8f9fa 0%, #e0e0e0 100%);
            border: none;
            font-size: 2rem;
            cursor: pointer;
            color: #7f8c8d;
            transition: all 0.3s;
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
        }

        .modal-close:hover {
            background: linear-gradient(135deg, #ff6b9d 0%, #c44569 100%);
            color: white;
            transform: rotate(90deg);
        }

        .modal-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.3rem;
            font-weight: 900;
            margin-bottom: 35px;
            color: #2c3e50;
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .modal-title i {
            color: #ff6b9d;
        }

        .form-group {
            margin-bottom: 30px;
        }

        .form-group label {
            display: block;
            margin-bottom: 12px;
            font-weight: 800;
            color: #2c3e50;
            font-size: 1rem;
        }

        .required {
            color: #ef4444;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 16px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 14px;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s;
            font-size: 15px;
            font-weight: 600;
            background: #f8f9fa;
        }

        .form-group input::placeholder,
        .form-group textarea::placeholder {
            color: #a8a8a8;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #ff6b9d;
            background: white;
            box-shadow: 0 0 0 6px rgba(255, 107, 157, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 110px;
        }

        .form-group select option {
            background: white;
            color: #2c3e50;
        }

        .btn-submit {
            padding: 18px 40px;
            background: linear-gradient(135deg, #ff6b9d 0%, #c44569 100%);
            color: white;
            border: none;
            border-radius: 14px;
            cursor: pointer;
            font-weight: 800;
            transition: all 0.3s;
            width: 100%;
            font-size: 1.05rem;
            box-shadow: 0 12px 32px rgba(255, 107, 157, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            font-family: 'Poppins', sans-serif;
        }

        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 16px 40px rgba(255, 107, 157, 0.4);
        }

        .btn-submit:active {
            transform: translateY(-1px);
        }

        /* ===== SCROLLBAR ===== */
        ::-webkit-scrollbar { width: 10px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb {
            background: rgba(255, 107, 157, 0.5);
            border-radius: 5px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: rgba(255, 107, 157, 0.8);
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 768px) {
            .main-wrapper { padding: 40px 16px; }
            .page-header { padding: 50px 30px; margin-bottom: 50px; }
            .header-text h1 { font-size: 2.8rem; }
            .header-content { flex-direction: column; gap: 30px; }
            .header-buttons { flex-direction: row; }
            .filter-controls { flex-direction: column; }
            .search-wrapper { width: 100%; }
            .providers-grid { grid-template-columns: 1fr; }
            .modal-content { padding: 35px 25px; }
            .modal-title { font-size: 1.8rem; }
        }
    </style>
</head>
<body>
    <div class="main-wrapper">
        <!-- HERO BANNER -->
        <div class="page-header">
            <div class="header-content">
                <div class="header-text">
                    <h1>✨ Khám Phá Đối Tác Du Lịch</h1>
                    <p>Tìm kiếm và so sánh các nhà cung cấp dịch vụ du lịch hàng đầu tại Đà Nẵng</p>
                    <div class="travel-icons">
                        <span>🏨 Khách sạn</span>
                        <span>🗺️ Tour</span>
                        <span>🚌 Vận chuyển</span>
                    </div>
                </div>
                <div class="header-buttons">
                    <button class="btn-header" onclick="openRegisterModal()"><i class="fas fa-plus-circle"></i> Đăng Ký NCC</button>
                    <button class="btn-header" onclick="openPriceComparisonModal()"><i class="fas fa-chart-bar"></i> So Sánh</button>
                </div>
            </div>
        </div>

        <!-- STATS CARDS -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-hotel"></i></div>
                <span class="stat-label">Khách Sạn</span>
                <p class="stat-value"><c:set var="hotelCount" value="0" /><c:forEach items="${providers}" var="p"><c:if test="${p.providerType == 'Hotel'}"><c:set var="hotelCount" value="${hotelCount + 1}" /></c:if></c:forEach>${hotelCount}</p>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-passport"></i></div>
                <span class="stat-label">Công Ty Tour</span>
                <p class="stat-value"><c:set var="tourCount" value="0" /><c:forEach items="${providers}" var="p"><c:if test="${p.providerType == 'TourOperator'}"><c:set var="tourCount" value="${tourCount + 1}" /></c:if></c:forEach>${tourCount}</p>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-shuttle-van"></i></div>
                <span class="stat-label">Vận Chuyển</span>
                <p class="stat-value"><c:set var="transportCount" value="0" /><c:forEach items="${providers}" var="p"><c:if test="${p.providerType == 'Transport'}"><c:set var="transportCount" value="${transportCount + 1}" /></c:if></c:forEach>${transportCount}</p>
            </div>
        </div>

        <!-- COMPARISON BAR -->
        <div class="comparison-bar" id="comparisonBar">
            <h3><i class="fas fa-check-circle"></i> NCC Được Chọn</h3>
            <div class="comparison-items" id="comparisonItems"></div>
            <div class="comparison-buttons">
                <button class="btn-compare-action" onclick="viewPriceComparison()"><i class="fas fa-balance-scale"></i> So Sánh</button>
                <button class="btn-compare-action" style="background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);" onclick="clearComparison()"><i class="fas fa-trash"></i> Xóa</button>
            </div>
        </div>

        <!-- FILTER SECTION -->
        <div class="filter-section">
            <div class="filter-header"><i class="fas fa-search"></i> Tìm Kiếm & Lọc</div>
            <form method="get" action="${pageContext.request.contextPath}/admin/providers" class="filter-controls">
                <div class="search-wrapper">
                    <input type="text" name="search" class="search-input" placeholder="Nhập tên nhà cung cấp..." value="${param.search}">
                    <button type="submit" class="search-btn"><i class="fas fa-search"></i> Tìm</button>
                </div>
                <select name="type" class="filter-select" onchange="this.form.submit()">
                    <option value="">Tất Cả Loại</option>
                    <option value="Hotel" ${param.type == 'Hotel' ? 'selected' : ''}>🏨 Khách Sạn</option>
                    <option value="TourOperator" ${param.type == 'TourOperator' ? 'selected' : ''}>🗺️ Công Ty Tour</option>
                    <option value="Transport" ${param.type == 'Transport' ? 'selected' : ''}>🚌 Vận Chuyển</option>
                </select>
            </form>
        </div>

        <!-- PROVIDERS GRID -->
        <div class="providers-grid">
            <c:choose>
                <c:when test="${empty providers}">
                    <div class="empty-state">
                        <i class="empty-icon fas fa-compass"></i>
                        <h3 class="empty-title">Không Tìm Thấy Nhà Cung Cấp</h3>
                        <p class="empty-text">Hãy thử tìm kiếm lại hoặc đăng ký nhà cung cấp mới</p>
                        <button class="btn-header" onclick="openRegisterModal()"><i class="fas fa-plus-circle"></i> Đăng Ký Ngay</button>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${providers}" var="provider">
                        <div class="provider-card" id="card-${provider.providerId}">
                            <div class="provider-header">
                                <div class="provider-top">
                                    <h3 class="provider-name">${provider.businessName}<c:if test="${provider.verified}"><i class="fas fa-check-circle verify-badge"></i></c:if></h3>
                                    <div class="rating-badge"><fmt:formatNumber value="${provider.rating}" pattern="#.#" /> ⭐</div>
                                </div>
                                <span class="provider-type">${provider.providerType}</span>
                            </div>
                            <div class="provider-content">
                                <div class="provider-info-grid">
                                    <div class="info-item"><i class="fas fa-tag"></i> #${provider.providerId}</div>
                                    <div class="info-item"><i class="fas fa-calendar-check"></i> ${provider.totalTours} tours</div>
                                    <div class="info-item"><i class="fas fa-money-bill"></i> <fmt:formatNumber value="${provider.averagePrice}" pattern="#,###" /> VND</div>
                                    <div class="info-item"><i class="fas fa-fire"></i> <fmt:formatNumber value="${provider.rating}" pattern="#.#" /></div>
                                </div>
                                <div class="status-badges">
                                    <span class="badge ${provider.verified ? 'badge-verified' : 'badge-active'}"><i class="fas fa-${provider.verified ? 'check' : 'clock'}"></i> ${provider.verified ? 'Xác Minh' : 'Chờ Duyệt'}</span>
                                    <span class="badge badge-active"><i class="fas fa-${provider.active ? 'play' : 'pause'}"></i> ${provider.active ? 'Hoạt Động' : 'Tạm Ngừng'}</span>
                                </div>
                                <div class="provider-actions">
                                    <button class="action-btn btn-view" onclick="viewDetail(${provider.providerId})"><i class="fas fa-eye"></i> Chi Tiết</button>
                                    <button class="action-btn btn-history" onclick="viewPriceHistory(${provider.providerId})"><i class="fas fa-clock"></i> Lịch Sử</button>
                                    <button class="action-btn btn-compare" onclick="toggleCompare(${provider.providerId}, '${provider.businessName}')"><i class="fas fa-plus"></i> Chọn</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- REGISTER MODAL -->
    <div class="modal" id="registerModal">
        <div class="modal-content">
            <button class="modal-close" onclick="closeModal('registerModal')">&times;</button>
            <h2 class="modal-title"><i class="fas fa-user-tie"></i> Đăng Ký Nhà Cung Cấp</h2>
            <form method="post" action="${pageContext.request.contextPath}/admin/providers?action=register">
                <div class="form-group">
                    <label>Tên Cửa Hàng <span class="required">*</span></label>
                    <input type="text" name="businessName" placeholder="Vd: Sunset Resort & Spa..." required>
                </div>
                <div class="form-group">
                    <label>Loại Dịch Vụ <span class="required">*</span></label>
                    <select name="providerType" required>
                        <option value="">-- Chọn Loại --</option>
                        <option value="Hotel">🏨 Khách Sạn</option>
                        <option value="TourOperator">🗺️ Công Ty Tour</option>
                        <option value="Transport">🚌 Dịch Vụ Vận Chuyển</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Rằng Phép Kinh Doanh <span class="required">*</span></label>
                    <input type="text" name="businessLicense" placeholder="Số giấy phép..." required>
                </div>
                <div class="form-group">
                    <label>📧 Email Liên Hệ</label>
                    <input type="email" name="email" placeholder="info@company.vn">
                </div>
                <div class="form-group">
                    <label>☎️ Điện Thoại</label>
                    <input type="tel" name="phone" placeholder="+84 236 123 456">
                </div>
                <button type="submit" class="btn-submit"><i class="fas fa-paper-plane"></i> Gửi Đăng Ký</button>
            </form>
        </div>
    </div>

    <!-- PRICE HISTORY MODAL -->
    <div class="modal" id="historyModal">
        <div class="modal-content">
            <button class="modal-close" onclick="closeModal('historyModal')">&times;</button>
            <h2 class="modal-title"><i class="fas fa-history"></i> Lịch Sử Giá</h2>
            <div id="historyContent"></div>
        </div>
    </div>

    <!-- PRICE COMPARISON MODAL -->
    <div class="modal" id="priceComparisonModal">
        <div class="modal-content">
            <button class="modal-close" onclick="closeModal('priceComparisonModal')">&times;</button>
            <h2 class="modal-title"><i class="fas fa-chart-bar"></i> So Sánh Giá</h2>
            <div id="priceComparisonContent"></div>
        </div>
    </div>

    <script>
        let selectedProviders = [];

        function openRegisterModal() { document.getElementById('registerModal').classList.add('active'); }
        function openPriceComparisonModal() { document.getElementById('priceComparisonModal').classList.add('active'); }
        function closeModal(id) { document.getElementById(id).classList.remove('active'); }
        function viewDetail(id) { window.location.href = '${pageContext.request.contextPath}/admin/providers?action=detail&id=' + id; }

        function toggleCompare(id, name) {
            const card = document.getElementById('card-' + id);
            const idx = selectedProviders.findIndex(p => p.id === id);
            if (idx === -1) {
                if (selectedProviders.length < 5) {
                    selectedProviders.push({id, name});
                    card.classList.add('selected');
                } else alert('Tối đa 5 nhà cung cấp!');
            } else {
                selectedProviders.splice(idx, 1);
                card.classList.remove('selected');
            }
            updateComparisonBar();
        }

        function updateComparisonBar() {
            const bar = document.getElementById('comparisonBar');
            const items = document.getElementById('comparisonItems');
            if (selectedProviders.length === 0) {
                bar.classList.remove('active');
                return;
            }
            bar.classList.add('active');
            items.innerHTML = selectedProviders.map(p => `<div class="comparison-item">${p.name} <button type="button" onclick="toggleCompare(${p.id}, '${p.name}')">✕</button></div>`).join('');
        }

        function viewPriceComparison() {
            if (selectedProviders.length < 2) { alert('Chọn tối thiểu 2 nhà cung cấp!'); return; }
            const ids = selectedProviders.map(p => p.id).join(',');
            window.location.href = '${pageContext.request.contextPath}/admin/providers?action=comparison&ids=' + ids;
        }

        function clearComparison() {
            selectedProviders = [];
            document.querySelectorAll('.provider-card.selected').forEach(c => c.classList.remove('selected'));
            updateComparisonBar();
        }

        function viewPriceHistory(id) {
            const modal = document.getElementById('historyModal');
            const content = document.getElementById('historyContent');
            content.innerHTML = '<p style="text-align: center; padding: 40px; color: #7f8c8d;"><i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: #ff6b9d;"></i><br>Đang tải...</p>';
            setTimeout(() => {
                content.innerHTML = '<div style="background: linear-gradient(135deg, rgba(255, 107, 157, 0.08) 0%, rgba(248, 165, 55, 0.08) 100%); padding: 25px; border-radius: 16px; border: 1px solid rgba(255, 107, 157, 0.2); margin-top: 20px;"><h4 style="margin-bottom: 20px; color: #2c3e50; font-weight: 800;">📊 Lịch sử thay đổi giá</h4><table style="width: 100%; border-collapse: collapse;"><tr style="background: transparent;"><th style="padding: 14px; text-align: left; font-weight: 800; color: #ff6b9d; border-bottom: 2px solid rgba(255, 107, 157, 0.2);">Dịch Vụ</th><th style="padding: 14px; text-align: left; font-weight: 800; color: #ff6b9d; border-bottom: 2px solid rgba(255, 107, 157, 0.2);">Giá Cũ</th><th style="padding: 14px; text-align: left; font-weight: 800; color: #ff6b9d; border-bottom: 2px solid rgba(255, 107, 157, 0.2);">Giá Mới</th><th style="padding: 14px; text-align: left; font-weight: 800; color: #ff6b9d; border-bottom: 2px solid rgba(255, 107, 157, 0.2);">Ngày</th></tr><tr style="border-bottom: 1px solid rgba(255, 107, 157, 0.1);"><td style="padding: 14px; color: #2c3e50; font-weight: 700;">🛏️ Phòng Deluxe</td><td style="padding: 14px; color: #7f8c8d;">1,500,000</td><td style="padding: 14px; color: #10b981; font-weight: 700;">1,800,000</td><td style="padding: 14px; color: #7f8c8d;">02/03/2026</td></tr><tr><td style="padding: 14px; color: #2c3e50; font-weight: 700;">🗺️ Tour 3 Ngày</td><td style="padding: 14px; color: #7f8c8d;">5,000,000</td><td style="padding: 14px; color: #10b981; font-weight: 700;">5,500,000</td><td style="padding: 14px; color: #7f8c8d;">01/03/2026</td></tr></table></div>';
            }, 500);
            modal.classList.add('active');
        }

        window.onclick = function(e) {
            document.querySelectorAll('.modal').forEach(m => {
                if (e.target === m) m.classList.remove('active');
            });
        }
    </script>
</body>
</html>
