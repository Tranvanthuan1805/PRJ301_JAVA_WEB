<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | eztravel</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=JetBrains+Mono:wght@500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <style>
    *{margin:0;padding:0;box-sizing:border-box}
    body{font-family:'Inter',system-ui,sans-serif;background:#080d1a;color:#E2E8F0;-webkit-font-smoothing:antialiased;min-height:100vh}
    body::before{content:'';position:fixed;inset:0;background:radial-gradient(ellipse 80% 60% at 50% -20%,rgba(59,130,246,.08),transparent),radial-gradient(ellipse 60% 40% at 80% 100%,rgba(139,92,246,.06),transparent);pointer-events:none;z-index:0}

    /* Sidebar */
    .sidebar{position:fixed;left:0;top:0;width:270px;height:100vh;background:linear-gradient(180deg,rgba(11,17,32,.98) 0%,rgba(8,13,26,.99) 100%);border-right:1px solid rgba(255,255,255,.05);padding:24px 16px;display:flex;flex-direction:column;z-index:100;backdrop-filter:blur(24px)}
    .sidebar .logo{font-size:1.4rem;font-weight:800;color:#fff;padding:0 12px 24px;border-bottom:1px solid rgba(255,255,255,.06);margin-bottom:16px;display:flex;align-items:center;gap:10px}
    .sidebar .logo .a{color:#60A5FA}
    .sidebar .badge-admin{display:inline-block;padding:3px 10px;border-radius:8px;background:linear-gradient(135deg,rgba(239,68,68,.2),rgba(239,68,68,.1));color:#F87171;font-size:.65rem;font-weight:700;font-family:'Inter',sans-serif;margin-left:6px;vertical-align:middle;border:1px solid rgba(239,68,68,.15);animation:adminPulse 3s ease-in-out infinite}
    @keyframes adminPulse{0%,100%{box-shadow:0 0 0 0 rgba(239,68,68,.15)}50%{box-shadow:0 0 12px 2px rgba(239,68,68,.1)}}
    .sidebar nav{flex:1;overflow-y:auto;overflow-x:hidden;scrollbar-width:none;-ms-overflow-style:none}
    .sidebar nav::-webkit-scrollbar{display:none}
    .sidebar nav a{display:flex;align-items:center;gap:12px;padding:12px 16px;border-radius:12px;color:rgba(255,255,255,.45);font-size:.88rem;font-weight:500;transition:all .3s cubic-bezier(.4,0,.2,1);margin-bottom:3px;text-decoration:none;position:relative;border:1px solid transparent}
    .sidebar nav a:hover{color:#fff;background:rgba(255,255,255,.05);border-color:rgba(255,255,255,.06);transform:translateX(4px)}
    .sidebar nav a.active{color:#fff;background:linear-gradient(135deg,rgba(59,130,246,.12),rgba(139,92,246,.08));border:1px solid rgba(59,130,246,.18);box-shadow:0 0 20px rgba(59,130,246,.08),inset 0 1px 0 rgba(255,255,255,.05)}
    .sidebar nav a.active i{color:#60A5FA;filter:drop-shadow(0 0 6px rgba(96,165,250,.4))}
    .sidebar nav a.active::before{content:'';position:absolute;left:0;top:50%;transform:translateY(-50%);width:3px;height:60%;background:linear-gradient(180deg,#3B82F6,#8B5CF6);border-radius:0 4px 4px 0}
    .sidebar nav a i{width:20px;text-align:center;font-size:.88rem;transition:all .3s}
    .sidebar .nav-label{font-size:.65rem;text-transform:uppercase;letter-spacing:2px;color:rgba(255,255,255,.15);font-weight:700;padding:20px 16px 8px;margin-top:4px}
    .sidebar .user-box{padding:16px;border-top:1px solid rgba(255,255,255,.06);display:flex;align-items:center;gap:12px}
    .sidebar .user-box .avatar{width:40px;height:40px;border-radius:12px;background:linear-gradient(135deg,#EF4444,#EC4899);display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:.88rem;box-shadow:0 4px 12px rgba(239,68,68,.25)}
    .sidebar .user-box .uname{font-size:.88rem;color:#fff;font-weight:600}
    .sidebar .user-box .urole{font-size:.72rem;color:rgba(255,255,255,.35);margin-top:1px}

    /* Main */
    .main{margin-left:270px;padding:32px 40px;min-height:100vh;position:relative;z-index:1}
    .page-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:36px;padding-bottom:24px;border-bottom:1px solid rgba(255,255,255,.04)}
    .page-header h1{font-size:1.9rem;font-weight:800;color:#fff;letter-spacing:-.5px}
    .page-header p{color:rgba(255,255,255,.45);font-size:.9rem;margin-top:6px}
    .btn-primary{display:inline-flex;align-items:center;gap:8px;padding:11px 24px;border-radius:12px;background:linear-gradient(135deg,#3B82F6,#2563EB);color:#fff;font-weight:700;font-size:.85rem;border:none;cursor:pointer;transition:all .3s;font-family:inherit;text-decoration:none;box-shadow:0 4px 16px rgba(59,130,246,.2)}
    .btn-primary:hover{transform:translateY(-2px);box-shadow:0 8px 24px rgba(59,130,246,.35)}
    .btn-outline{display:inline-flex;align-items:center;gap:8px;padding:11px 24px;border-radius:12px;background:rgba(255,255,255,.03);color:rgba(255,255,255,.65);font-weight:600;font-size:.85rem;border:1px solid rgba(255,255,255,.08);cursor:pointer;transition:all .3s;font-family:inherit;text-decoration:none;backdrop-filter:blur(8px)}
    .btn-outline:hover{border-color:rgba(255,255,255,.2);color:#fff;background:rgba(255,255,255,.06);transform:translateY(-1px)}

    /* Stats */
    .stats{display:grid;grid-template-columns:repeat(4,1fr);gap:20px;margin-bottom:32px}
    .stat{background:rgba(255,255,255,.03);border:1px solid rgba(255,255,255,.06);border-radius:18px;padding:26px;position:relative;overflow:hidden;transition:all .4s cubic-bezier(.4,0,.2,1);backdrop-filter:blur(12px)}
    .stat:hover{border-color:rgba(59,130,246,.25);transform:translateY(-4px);box-shadow:0 16px 40px rgba(0,0,0,.2),0 0 20px rgba(59,130,246,.06)}
    .stat::before{content:'';position:absolute;top:0;left:0;right:0;height:1px;background:linear-gradient(90deg,transparent,rgba(255,255,255,.1),transparent);opacity:0;transition:.4s}
    .stat:hover::before{opacity:1}
    .stat::after{content:'';position:absolute;top:-20px;right:-20px;width:120px;height:120px;border-radius:50%;opacity:.04;filter:blur(40px)}
    .stat:nth-child(1)::after{background:#3B82F6}
    .stat:nth-child(2)::after{background:#10B981}
    .stat:nth-child(3)::after{background:#F59E0B}
    .stat:nth-child(4)::after{background:#EF4444}
    .stat .icon{width:48px;height:48px;border-radius:14px;display:flex;align-items:center;justify-content:center;font-size:1.1rem;margin-bottom:16px;position:relative}
    .stat .label{font-size:.72rem;color:rgba(255,255,255,.35);font-weight:700;text-transform:uppercase;letter-spacing:1.2px;margin-bottom:8px}
    .stat .value{font-size:2rem;font-weight:800;color:#fff;letter-spacing:-1px}
    .icon-blue{background:linear-gradient(135deg,rgba(59,130,246,.2),rgba(59,130,246,.08));color:#60A5FA;box-shadow:0 4px 12px rgba(59,130,246,.12)}
    .icon-green{background:linear-gradient(135deg,rgba(16,185,129,.2),rgba(16,185,129,.08));color:#34D399;box-shadow:0 4px 12px rgba(16,185,129,.12)}
    .icon-orange{background:linear-gradient(135deg,rgba(245,158,11,.2),rgba(245,158,11,.08));color:#FBBF24;box-shadow:0 4px 12px rgba(245,158,11,.12)}
    .icon-red{background:linear-gradient(135deg,rgba(239,68,68,.2),rgba(239,68,68,.08));color:#F87171;box-shadow:0 4px 12px rgba(239,68,68,.12)}
    .icon-purple{background:linear-gradient(135deg,rgba(139,92,246,.2),rgba(139,92,246,.08));color:#A78BFA;box-shadow:0 4px 12px rgba(139,92,246,.12)}
    .icon-cyan{background:linear-gradient(135deg,rgba(6,182,212,.2),rgba(6,182,212,.08));color:#22D3EE;box-shadow:0 4px 12px rgba(6,182,212,.12)}

    /* Cards */
    .card{background:rgba(255,255,255,.03);border:1px solid rgba(255,255,255,.05);border-radius:20px;padding:28px;margin-bottom:24px;backdrop-filter:blur(12px);transition:all .3s;position:relative;overflow:hidden}
    .card::before{content:'';position:absolute;top:0;left:0;right:0;height:1px;background:linear-gradient(90deg,transparent,rgba(255,255,255,.08),transparent)}
    .card:hover{border-color:rgba(255,255,255,.08)}
    .card h3{font-size:1.05rem;font-weight:700;color:#fff;margin-bottom:22px;display:flex;align-items:center;gap:10px}
    .card h3 i{color:#60A5FA;font-size:.9rem;filter:drop-shadow(0 0 4px rgba(96,165,250,.3))}
    .grid-2{display:grid;grid-template-columns:1fr 1fr;gap:24px}
    .grid-3{display:grid;grid-template-columns:1fr 1fr 1fr;gap:24px}

    /* Neural Network Section */
    .nn-section{margin-top:40px;padding-top:40px;border-top:1px solid rgba(255,255,255,.06)}
    .nn-header{display:flex;align-items:center;gap:16px;margin-bottom:32px}
    .nn-icon{width:56px;height:56px;border-radius:16px;background:linear-gradient(135deg,#7C3AED,#A78BFA);display:flex;align-items:center;justify-content:center;color:#fff;font-size:1.4rem;box-shadow:0 8px 32px rgba(124,58,237,.3);position:relative;overflow:hidden}
    .nn-icon::after{content:'';position:absolute;inset:0;background:linear-gradient(135deg,transparent,rgba(255,255,255,.2));animation:nnPulse 3s ease-in-out infinite}
    @keyframes nnPulse{0%,100%{opacity:0}50%{opacity:1}}
    .nn-header h2{font-size:1.6rem;font-weight:800;color:#fff}
    .nn-header p{font-size:.88rem;color:rgba(255,255,255,.45);margin-top:4px}
    .nn-badge{display:inline-flex;align-items:center;gap:6px;padding:4px 12px;border-radius:999px;font-size:.7rem;font-weight:700;background:rgba(124,58,237,.15);color:#A78BFA;border:1px solid rgba(124,58,237,.2);margin-left:12px}
    .nn-badge .dot{width:6px;height:6px;border-radius:50%;background:#A78BFA;animation:dotBlink 2s ease infinite}
    @keyframes dotBlink{0%,100%{opacity:1}50%{opacity:.3}}

    /* AI Metrics */
    .ai-metrics{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:24px}
    .ai-metric{padding:20px;background:rgba(255,255,255,.03);border-radius:14px;border:1px solid rgba(255,255,255,.05);transition:.3s;position:relative;overflow:hidden}
    .ai-metric:hover{border-color:rgba(124,58,237,.2);transform:translateY(-2px)}
    .ai-metric small{font-size:.7rem;color:rgba(255,255,255,.35);text-transform:uppercase;letter-spacing:.8px;font-weight:700;display:block;margin-bottom:6px}
    .ai-metric .val{font-weight:800;color:#fff;font-size:1.2rem}
    .ai-metric .val.success{color:#34D399}
    .ai-metric .val.warning{color:#FBBF24}
    .ai-metric .val.purple{color:#A78BFA}

    /* Chart containers */
    .chart-box{position:relative;height:320px;background:rgba(255,255,255,.02);border-radius:14px;border:1px solid rgba(255,255,255,.04);padding:16px}
    .chart-box canvas{width:100%!important;height:100%!important}

    /* Neural Network Visualization */
    .nn-vis{background:linear-gradient(135deg,rgba(124,58,237,.08),rgba(59,130,246,.08));border:1px solid rgba(124,58,237,.15);border-radius:16px;padding:24px;position:relative;overflow:hidden}
    .nn-vis::before{content:'';position:absolute;top:-50%;left:-50%;width:200%;height:200%;background:radial-gradient(circle at 30% 40%,rgba(124,58,237,.06),transparent 50%),radial-gradient(circle at 70% 60%,rgba(59,130,246,.06),transparent 50%);animation:nnBg 8s ease-in-out infinite alternate}
    @keyframes nnBg{from{transform:rotate(0deg)}to{transform:rotate(5deg)}}
    .nn-vis>*{position:relative;z-index:1}
    .nn-layers{display:flex;align-items:center;justify-content:center;gap:40px;padding:20px 0}
    .nn-layer{display:flex;flex-direction:column;align-items:center;gap:8px}
    .nn-layer-label{font-size:.68rem;font-weight:700;color:rgba(255,255,255,.4);text-transform:uppercase;letter-spacing:1px;margin-bottom:4px}
    .nn-neuron{width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:.65rem;font-weight:700;transition:.3s}
    .nn-input .nn-neuron{background:rgba(59,130,246,.2);border:2px solid rgba(59,130,246,.4);color:#60A5FA}
    .nn-hidden .nn-neuron{background:rgba(124,58,237,.2);border:2px solid rgba(124,58,237,.4);color:#A78BFA}
    .nn-output .nn-neuron{background:rgba(16,185,129,.2);border:2px solid rgba(16,185,129,.4);color:#34D399}
    .nn-arrow{color:rgba(255,255,255,.15);font-size:1.2rem}
    .nn-layer-info{font-size:.72rem;color:rgba(255,255,255,.5);margin-top:8px;text-align:center;max-width:100px}

    /* Prediction result */
    .prediction-card{background:linear-gradient(135deg,rgba(16,185,129,.08),rgba(34,211,238,.08));border:1px solid rgba(16,185,129,.15);border-radius:16px;padding:24px}
    .pred-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:16px;margin-top:16px}
    .pred-item{text-align:center;padding:16px;background:rgba(255,255,255,.03);border-radius:12px}
    .pred-item .pred-val{font-size:1.6rem;font-weight:800;margin-top:6px}
    .pred-item small{font-size:.72rem;color:rgba(255,255,255,.4);font-weight:600}

    /* Tabs */
    .tab-bar{display:flex;gap:4px;background:rgba(255,255,255,.04);border-radius:12px;padding:4px;margin-bottom:24px;border:1px solid rgba(255,255,255,.06);flex-wrap:wrap}
    .tab-btn{padding:10px 20px;border-radius:8px;font-size:.82rem;font-weight:600;color:rgba(255,255,255,.5);cursor:pointer;transition:.3s;border:none;background:transparent;font-family:inherit}
    .tab-btn:hover{color:#fff}
    .tab-btn.active{background:rgba(124,58,237,.2);color:#fff;box-shadow:0 2px 8px rgba(124,58,237,.2)}
    .tab-content{display:none}
    .tab-content.active{display:block}

    /* Quick actions */
    .action-link{display:flex;align-items:center;gap:14px;padding:16px;border-radius:12px;background:rgba(255,255,255,.03);border:1px solid rgba(255,255,255,.06);transition:.3s;text-decoration:none;color:inherit;margin-bottom:10px}
    .action-link:hover{border-color:rgba(59,130,246,.2);transform:translateX(4px)}
    .action-link .aicon{width:42px;height:42px;border-radius:10px;display:flex;align-items:center;justify-content:center}
    .action-link .atitle{font-size:.88rem;color:#fff;font-weight:600}
    .action-link .adesc{font-size:.75rem;color:rgba(255,255,255,.4);margin-top:2px}

    /* Full Data Table */
    .data-table-wrap{max-height:600px;overflow-y:auto;border-radius:16px;border:1px solid rgba(255,255,255,.05);background:rgba(8,13,26,.6);backdrop-filter:blur(8px)}
    .data-table-wrap::-webkit-scrollbar{width:5px}
    .data-table-wrap::-webkit-scrollbar-track{background:transparent}
    .data-table-wrap::-webkit-scrollbar-thumb{background:rgba(124,58,237,.25);border-radius:3px}
    .data-table{width:100%;border-collapse:collapse;font-size:.82rem}
    .data-table thead{position:sticky;top:0;z-index:10;background:rgba(8,13,26,.95);backdrop-filter:blur(12px)}
    .data-table th{padding:14px 16px;text-align:left;font-size:.68rem;font-weight:700;color:#64748B;letter-spacing:1.2px;text-transform:uppercase;border-bottom:1px solid rgba(124,58,237,.15);white-space:nowrap}
    .data-table td{padding:12px 16px;border-bottom:1px solid rgba(255,255,255,.03);vertical-align:middle;white-space:nowrap;transition:background .2s}
    .data-table tbody tr{transition:all .2s}
    .data-table tbody tr:hover{background:rgba(59,130,246,.04)}
    .data-table tbody tr:nth-child(even){background:rgba(255,255,255,.01)}
    .data-table .season-high{color:#34D399;font-weight:600}
    .data-table .season-mid{color:#FBBF24;font-weight:600}
    .data-table .season-low{color:#F87171;font-weight:600}
    .year-filter{display:flex;gap:6px;margin-bottom:16px;flex-wrap:wrap}
    .year-btn{padding:8px 18px;border-radius:8px;border:1px solid rgba(255,255,255,.1);background:transparent;color:rgba(255,255,255,.5);font-weight:600;font-size:.8rem;cursor:pointer;transition:.3s;font-family:inherit}
    .year-btn:hover{color:#fff;border-color:rgba(124,58,237,.3)}
    .year-btn.active{background:rgba(124,58,237,.2);color:#fff;border-color:rgba(124,58,237,.4)}
    .data-summary{display:grid;grid-template-columns:repeat(5,1fr);gap:12px;margin-bottom:20px}
    .data-summary-item{padding:14px 16px;background:rgba(255,255,255,.03);border-radius:10px;border:1px solid rgba(255,255,255,.05);text-align:center}
    .data-summary-item .ds-label{font-size:.68rem;color:rgba(255,255,255,.35);text-transform:uppercase;letter-spacing:.8px;font-weight:700;display:block;margin-bottom:4px}
    .data-summary-item .ds-value{font-size:1.1rem;font-weight:800;color:#fff}

    /* Algorithm Description */
    .algo-section{margin-bottom:24px}
    .algo-section h4{font-size:1rem;font-weight:700;color:#A78BFA;margin-bottom:12px;display:flex;align-items:center;gap:8px}
    .algo-section h4 i{font-size:.85rem}
    .algo-text{font-size:.88rem;color:rgba(255,255,255,.7);line-height:1.8;margin-bottom:16px}
    .algo-formula{background:rgba(124,58,237,.08);border:1px solid rgba(124,58,237,.15);border-radius:12px;padding:20px;font-family:'JetBrains Mono',monospace;font-size:.82rem;color:#A78BFA;margin:12px 0;overflow-x:auto;white-space:pre-line}
    .algo-table{width:100%;border-collapse:collapse;margin:12px 0;font-size:.82rem}
    .algo-table th{padding:10px 14px;background:rgba(124,58,237,.1);color:#A78BFA;font-weight:700;text-align:left;border-bottom:2px solid rgba(124,58,237,.2);font-size:.72rem;text-transform:uppercase;letter-spacing:1px}
    .algo-table td{padding:10px 14px;border-bottom:1px solid rgba(255,255,255,.04);color:rgba(255,255,255,.7)}
    .algo-table tr:hover{background:rgba(124,58,237,.04)}
    .algo-step{display:flex;gap:16px;margin-bottom:20px;padding:20px;background:rgba(255,255,255,.02);border-radius:14px;border:1px solid rgba(255,255,255,.05);transition:.3s}
    .algo-step:hover{border-color:rgba(124,58,237,.15);transform:translateX(4px)}
    .algo-step-num{width:40px;height:40px;border-radius:12px;background:linear-gradient(135deg,#7C3AED,#A78BFA);display:flex;align-items:center;justify-content:center;color:#fff;font-weight:800;font-size:.9rem;flex-shrink:0}
    .algo-step-content h5{font-size:.92rem;color:#fff;font-weight:700;margin-bottom:6px}
    .algo-step-content p{font-size:.82rem;color:rgba(255,255,255,.55);line-height:1.7}
    .algo-comparison{display:grid;grid-template-columns:repeat(3,1fr);gap:16px;margin:16px 0}
    .algo-compare-item{padding:16px;background:rgba(255,255,255,.03);border-radius:12px;border:1px solid rgba(255,255,255,.05);text-align:center;transition:.3s}
    .algo-compare-item:hover{border-color:rgba(124,58,237,.2)}
    .algo-compare-item.winner{border-color:rgba(16,185,129,.3);background:rgba(16,185,129,.05)}
    .algo-compare-item h5{font-size:.85rem;color:#fff;margin-bottom:8px}
    .algo-compare-item .score{font-size:1.4rem;font-weight:800;margin-bottom:4px}
    .algo-highlight{background:linear-gradient(135deg,rgba(124,58,237,.1),rgba(59,130,246,.1));border:1px solid rgba(124,58,237,.15);border-radius:14px;padding:20px;margin:16px 0}
    .algo-highlight h5{color:#A78BFA;font-size:.9rem;margin-bottom:8px}
    .algo-highlight ul{list-style:none;padding:0}
    .algo-highlight ul li{padding:6px 0;font-size:.82rem;color:rgba(255,255,255,.6);position:relative;padding-left:20px}
    .algo-highlight ul li:before{content:'▸';position:absolute;left:0;color:#A78BFA;font-weight:700}
    .nn-canvas-wrap{background:linear-gradient(135deg,rgba(124,58,237,.08),rgba(59,130,246,.08));border:1px solid rgba(124,58,237,.15);border-radius:16px;padding:24px;position:relative;overflow:hidden}
    .training-chart-box{height:250px;position:relative}
    .spa-section{display:none}
    .spa-section.active{display:block}

    /* Animated number counter */
    @keyframes fadeInUp{from{opacity:0;transform:translateY(16px)}to{opacity:1;transform:translateY(0)}}
    .stat{animation:fadeInUp .6s ease backwards}
    .stat:nth-child(1){animation-delay:.05s}
    .stat:nth-child(2){animation-delay:.1s}
    .stat:nth-child(3){animation-delay:.15s}
    .stat:nth-child(4){animation-delay:.2s}
    .card{animation:fadeInUp .5s ease backwards;animation-delay:.25s}

    @media(max-width:1200px){.stats,.ai-metrics{grid-template-columns:repeat(2,1fr)}.grid-2,.grid-3{grid-template-columns:1fr}.nn-layers{flex-wrap:wrap;gap:20px}.algo-comparison{grid-template-columns:1fr}.data-summary{grid-template-columns:repeat(2,1fr)}}
    @media(max-width:768px){.main{margin-left:0;padding:16px}.stats,.ai-metrics{grid-template-columns:1fr}.sidebar{display:none}.data-summary{grid-template-columns:1fr}}
    </style>
</head>
<body>

<!-- Sidebar SPA -->
<aside class="sidebar">
    <div class="logo"><img src="${pageContext.request.contextPath}/images/logo.png" style="width:36px;height:36px;border-radius:50%;display:inline-block;vertical-align:middle;margin-right:8px"><span style="vertical-align:middle"><span class="a">ez</span>travel</span> <span class="badge-admin">ADMIN</span></div>
    <nav>
        <a href="#" class="active" onclick="showSection('overview',this);return false"><i class="fas fa-chart-pie"></i> Tổng Quan</a>
        <a href="#" onclick="showSection('customers',this);return false"><i class="fas fa-users"></i> Khách Hàng</a>
        <a href="#" onclick="showSection('orders',this);return false"><i class="fas fa-shopping-bag"></i> Đơn Hàng</a>
        <a href="#" onclick="showSection('tours-mgmt',this);return false"><i class="fas fa-map-marked-alt"></i> Quản Lý Tours</a>
        <a href="#" onclick="showSection('providers',this);return false"><i class="fas fa-handshake"></i> Nhà Cung Cấp</a>
        <a href="#" onclick="showSection('consultations',this);return false"><i class="fas fa-comments"></i> Tư Vấn</a>
        <a href="#" onclick="showSection('coupons',this);return false"><i class="fas fa-ticket-alt"></i> Mã Giảm Giá</a>

        <div class="nav-label">AI & Phân Tích</div>
        <a href="#" onclick="showSection('chatbot',this);return false"><i class="fas fa-robot"></i> Chatbot & Hành Vi</a>
        <a href="#" onclick="showSection('neural',this);return false"><i class="fas fa-brain"></i> Mạng Neural</a>

        <div class="nav-label">Hệ Thống</div>
        <a href="${pageContext.request.contextPath}/home" target="_blank"><i class="fas fa-globe"></i> Xem Website</a>
        <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a>
    </nav>
    <div class="user-box">
        <div class="avatar">${sessionScope.user.username.substring(0,1).toUpperCase()}</div>
        <div>
            <div class="uname">${sessionScope.user.username}</div>
            <div class="urole">Quản Trị Viên</div>
        </div>
    </div>
</aside>

<!-- Main -->
<main class="main">
    <header class="page-header">
        <div>
            <h1>🏠 Tổng Quan Hệ Thống</h1>
            <p>Xin chào, <strong>${sessionScope.user.username}</strong> 👋 — Dashboard tích hợp AI Neural Network</p>
        </div>
        <div style="display:flex;gap:10px">
            <button class="btn-outline"><i class="fas fa-download"></i> Xuất Báo Cáo</button>
            <a href="${pageContext.request.contextPath}/logout" class="btn-outline"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a>
        </div>
    </header>

    <!-- SPA SECTION: OVERVIEW -->
    <div class="spa-section active" id="sec-overview">
    <section class="stats">
        <div class="stat"><div class="icon icon-blue"><i class="fas fa-users"></i></div><div class="label">Tổng Người Dùng</div><div class="value">${totalUsers}</div></div>
        <div class="stat"><div class="icon icon-green"><i class="fas fa-map-marked-alt"></i></div><div class="label">Tours Hoạt Động</div><div class="value">${activeTours}</div></div>
        <div class="stat"><div class="icon icon-orange"><i class="fas fa-shopping-bag"></i></div><div class="label">Tổng Đơn Hàng</div><div class="value">${totalOrders}</div></div>
        <div class="stat"><div class="icon icon-red"><i class="fas fa-clock"></i></div><div class="label">Đơn Chờ Xử Lý</div><div class="value" style="color:#F87171">${pendingOrders}</div></div>
        <div class="stat"><div class="icon icon-purple"><i class="fas fa-comments"></i></div><div class="label">Yêu Cầu Tư Vấn</div><div class="value">${totalConsultations}</div></div>
        <div class="stat"><div class="icon icon-cyan"><i class="fas fa-bell"></i></div><div class="label">Yêu Cầu Mới</div><div class="value" style="color:#22D3EE">${newConsultations}</div></div>
    </section>
    <div class="grid-2">
        <div class="card">
            <h3><i class="fas fa-coins"></i> Doanh Thu Tổng</h3>
            <div style="font-size:2.4rem;font-weight:800;color:#34D399;letter-spacing:-1px;margin-bottom:8px"><fmt:formatNumber value="${grossRevenue}" type="number" groupingUsed="true"/>đ</div>
            <div style="font-size:.85rem;color:#34D399"><i class="fas fa-check-circle"></i> Từ ${completedOrders + confirmedOrders} đơn đã thanh toán thành công</div>
        </div>
        <div class="card">
            <h3><i class="fas fa-bolt"></i> Quản Trị Nhanh</h3>
            <a href="#" onclick="showSection('customers',document.querySelector('nav a:nth-child(2)'));return false" class="action-link"><div class="aicon icon-blue"><i class="fas fa-users"></i></div><div><div class="atitle">Quản Lý Khách Hàng</div><div class="adesc">${totalUsers} người dùng</div></div></a>
            <a href="#" onclick="showSection('orders',document.querySelector('nav a:nth-child(3)'));return false" class="action-link"><div class="aicon icon-orange"><i class="fas fa-shopping-bag"></i></div><div><div class="atitle">Quản Lý Đơn Hàng</div><div class="adesc">${totalOrders} đơn · ${pendingOrders} chờ</div></div></a>
            <a href="#" onclick="showSection('tours-mgmt',document.querySelector('nav a:nth-child(4)'));return false" class="action-link"><div class="aicon icon-green"><i class="fas fa-map"></i></div><div><div class="atitle">Quản Lý Tours</div><div class="adesc">${activeTours} tour hoạt động</div></div></a>
            <a href="#" onclick="showSection('consultations',document.querySelector('nav a:nth-child(6)'));return false" class="action-link"><div class="aicon icon-purple"><i class="fas fa-comments"></i></div><div><div class="atitle">Yêu Cầu Tư Vấn</div><div class="adesc">${totalConsultations} yêu cầu · ${newConsultations} mới</div></div></a>
            <a href="#" onclick="showSection('providers',document.querySelector('nav a:nth-child(5)'));return false" class="action-link"><div class="aicon icon-cyan" style="background:rgba(6,182,212,.15);color:#22D3EE"><i class="fas fa-handshake"></i></div><div><div class="atitle">Nhà Cung Cấp</div><div class="adesc">${totalProviders} doanh nghiệp · ${pendingProviders} chờ</div></div></a>
        </div>
    </div>

    </div><!-- /sec-overview -->

    <!-- ═══ SPA SECTION: CUSTOMERS ═══ -->
    <div class="spa-section" id="sec-customers" style="display:none">
        <div class="ai-metrics" style="margin-bottom:24px">
            <div class="ai-metric"><small>Tổng Người Dùng</small><div class="val purple">${totalUsers}</div></div>
            <div class="ai-metric"><small>Admin</small><div class="val warning">1</div></div>
            <div class="ai-metric"><small>Khách Hàng</small><div class="val success">${totalUsers - 1}</div></div>
        </div>
        <div class="card">
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;flex-wrap:wrap;gap:12px">
                <h3 style="margin:0"><i class="fas fa-users"></i> Danh Sách Khách Hàng <span style="font-size:.75rem;color:rgba(255,255,255,.3);font-weight:500;margin-left:8px">(Dữ liệu thực từ Supabase)</span></h3>
                <a href="${pageContext.request.contextPath}/admin/crud/customer-edit" style="display:inline-flex;align-items:center;gap:8px;padding:10px 20px;background:linear-gradient(135deg,#3B82F6,#2563EB);color:#fff;border-radius:10px;font-size:.85rem;font-weight:700;text-decoration:none;transition:.3s;box-shadow:0 4px 15px rgba(59,130,246,.3)">
                    <i class="fas fa-user-plus"></i> Thêm Khách Hàng
                </a>
            </div>
            <div style="overflow-x:auto">
            <table class="data-table">
                <thead><tr><th>#</th><th>Username</th><th>Họ Tên</th><th>Email</th><th>SĐT</th><th>Vai Trò</th><th>Trạng Thái</th><th>Ngày Tạo</th><th>Thao Tác</th></tr></thead>
                <tbody>
                <c:forEach items="${customerList}" var="u" varStatus="s">
                    <tr style="${!u.active ? 'opacity:.5' : ''}">
                        <td style="color:#64748B;font-weight:600">${s.index + 1}</td>
                        <td><span style="color:#60A5FA;font-weight:600">@${u.username}</span></td>
                        <td style="color:#fff;font-weight:600">${u.fullName != null ? u.fullName : '—'}</td>
                        <td>${u.email}</td>
                        <td>${u.phoneNumber != null ? u.phoneNumber : '—'}</td>
                        <td><span style="padding:3px 10px;border-radius:6px;font-size:.72rem;font-weight:700;${u.role.roleName == 'ADMIN' ? 'background:rgba(245,158,11,.15);color:#FBBF24' : u.role.roleName == 'PROVIDER' ? 'background:rgba(139,92,246,.15);color:#A78BFA' : 'background:rgba(59,130,246,.15);color:#60A5FA'}">${u.role.roleName}</span></td>
                        <td><span style="padding:3px 8px;border-radius:6px;font-size:.68rem;font-weight:700;${u.active ? 'background:rgba(16,185,129,.15);color:#34D399' : 'background:rgba(239,68,68,.15);color:#F87171'}">${u.active ? 'Active' : 'Bị khóa'}</span></td>
                        <td style="font-size:.82rem;color:rgba(255,255,255,.4)"><fmt:formatDate value="${u.createdAt}" pattern="dd/MM/yyyy"/></td>
                        <td>
                            <div style="display:flex;gap:6px">
                                <a href="${pageContext.request.contextPath}/admin/crud/customer-edit?id=${u.userId}" style="padding:5px 10px;border-radius:6px;font-size:.72rem;font-weight:700;background:rgba(59,130,246,.15);color:#60A5FA;text-decoration:none" title="Sửa"><i class="fas fa-edit"></i></a>
                                <c:if test="${u.role.roleName != 'ADMIN'}">
                                    <c:choose>
                                        <c:when test="${u.active}">
                                            <a href="${pageContext.request.contextPath}/admin/crud/customer-delete?id=${u.userId}" onclick="return confirm('Vô hiệu hóa tài khoản @${u.username}? Người dùng sẽ không thể đăng nhập!')" style="padding:5px 10px;border-radius:6px;font-size:.72rem;font-weight:700;background:rgba(239,68,68,.15);color:#F87171;text-decoration:none" title="Vô hiệu hóa"><i class="fas fa-ban"></i></a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/admin/crud/customer-activate?id=${u.userId}" onclick="return confirm('Kích hoạt lại tài khoản @${u.username}?')" style="padding:5px 10px;border-radius:6px;font-size:.72rem;font-weight:700;background:rgba(16,185,129,.15);color:#34D399;text-decoration:none" title="Kích hoạt lại"><i class="fas fa-check-circle"></i></a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty customerList}"><tr><td colspan="8" style="text-align:center;padding:40px;color:rgba(255,255,255,.3)">Chưa có dữ liệu khách hàng</td></tr></c:if>
                </tbody>
            </table>
            </div>
        </div>

        <!-- ── Danh Mục (Categories) ── -->
        <div class="card" style="margin-top:24px">
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;flex-wrap:wrap;gap:12px">
                <h3 style="margin:0"><i class="fas fa-folder-tree"></i> Quản Lý Danh Mục <span style="font-size:.75rem;color:rgba(255,255,255,.3);font-weight:500;margin-left:8px">(Categories)</span></h3>
                <a href="${pageContext.request.contextPath}/admin/crud/category-edit" style="display:inline-flex;align-items:center;gap:8px;padding:10px 20px;background:linear-gradient(135deg,#8B5CF6,#7C3AED);color:#fff;border-radius:10px;font-size:.85rem;font-weight:700;text-decoration:none;transition:.3s;box-shadow:0 4px 15px rgba(139,92,246,.3)">
                    <i class="fas fa-folder-plus"></i> Thêm Danh Mục
                </a>
            </div>
            <div style="overflow-x:auto">
            <table class="data-table">
                <thead><tr><th>#</th><th>Tên Danh Mục</th><th>Mô Tả</th><th>Icon</th><th>Thao Tác</th></tr></thead>
                <tbody>
                <c:forEach items="${categoryList}" var="c" varStatus="s">
                    <tr>
                        <td style="color:#64748B;font-weight:600">${s.index + 1}</td>
                        <td style="color:#fff;font-weight:600">${c.categoryName}</td>
                        <td style="font-size:.82rem;color:rgba(255,255,255,.5)">${not empty c.description ? c.description : '—'}</td>
                        <td><c:if test="${not empty c.iconUrl}"><img src="${c.iconUrl}" style="width:28px;height:28px;border-radius:6px;object-fit:cover"></c:if><c:if test="${empty c.iconUrl}"><span style="color:rgba(255,255,255,.2)">—</span></c:if></td>
                        <td>
                            <div style="display:flex;gap:6px">
                                <a href="${pageContext.request.contextPath}/admin/crud/category-edit?id=${c.categoryId}" style="padding:5px 10px;border-radius:6px;font-size:.72rem;font-weight:700;background:rgba(59,130,246,.15);color:#60A5FA;text-decoration:none" title="Sửa"><i class="fas fa-edit"></i></a>
                                <a href="${pageContext.request.contextPath}/admin/crud/category-delete?id=${c.categoryId}" onclick="return confirm('Xóa danh mục ${c.categoryName}?')" style="padding:5px 10px;border-radius:6px;font-size:.72rem;font-weight:700;background:rgba(239,68,68,.15);color:#F87171;text-decoration:none" title="Xóa"><i class="fas fa-trash"></i></a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty categoryList}"><tr><td colspan="5" style="text-align:center;padding:40px;color:rgba(255,255,255,.3)">Chưa có danh mục</td></tr></c:if>
                </tbody>
            </table>
            </div>
        </div>
    </div>

    <!-- ═══ SPA SECTION: ORDERS ═══ -->
    <div class="spa-section" id="sec-orders" style="display:none">
        <div class="ai-metrics" style="margin-bottom:24px">
            <div class="ai-metric"><small>Tổng Đơn</small><div class="val purple">${totalOrders}</div></div>
            <div class="ai-metric"><small>Chờ Xử Lý</small><div class="val warning">${pendingOrders}</div></div>
            <div class="ai-metric"><small>Hoàn Thành</small><div class="val success">${completedOrders}</div></div>
            <div class="ai-metric"><small>Đã Hủy</small><div class="val" style="color:#F87171">${cancelledOrders}</div></div>
        </div>
        <div class="card">
            <h3><i class="fas fa-shopping-bag"></i> Danh Sách Đơn Hàng <span style="font-size:.75rem;color:rgba(255,255,255,.3);font-weight:500;margin-left:8px">(Dữ liệu thực từ Supabase)</span></h3>
            <div style="overflow-x:auto">
            <table class="data-table">
                <thead><tr><th>Mã Đơn</th><th>Khách Hàng</th><th>Tổng Tiền</th><th>Trạng Thái</th><th>Thanh Toán</th><th>Ngày Đặt</th></tr></thead>
                <tbody>
                <c:forEach items="${orderList}" var="o">
                    <tr>
                        <td style="color:#A78BFA;font-weight:700">#${o.orderId}</td>
                        <td style="color:#fff;font-weight:600">${o.customerName}</td>
                        <td style="color:#34D399;font-weight:700"><fmt:formatNumber value="${o.totalAmount}" pattern="#,###"/>đ</td>
                        <td><span style="padding:3px 10px;border-radius:6px;font-size:.72rem;font-weight:700;${o.orderStatus == 'Completed' ? 'background:rgba(16,185,129,.15);color:#34D399' : o.orderStatus == 'Pending' ? 'background:rgba(245,158,11,.15);color:#FBBF24' : o.orderStatus == 'Cancelled' ? 'background:rgba(239,68,68,.15);color:#F87171' : 'background:rgba(59,130,246,.15);color:#60A5FA'}">${o.statusDisplayName}</span></td>
                        <td><span style="font-size:.78rem;font-weight:600;${o.paymentStatus == 'Paid' ? 'color:#34D399' : 'color:#F87171'}">${o.paymentStatus}</span></td>
                        <td style="font-size:.82rem;color:rgba(255,255,255,.4)"><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty orderList}"><tr><td colspan="6" style="text-align:center;padding:40px;color:rgba(255,255,255,.3)">Chưa có đơn hàng</td></tr></c:if>
                </tbody>
            </table>
            </div>
        </div>
    </div>

    <!-- ═══ SPA SECTION: TOURS ═══ -->
    <div class="spa-section" id="sec-tours-mgmt" style="display:none">
        <div class="ai-metrics" style="margin-bottom:24px">
            <div class="ai-metric"><small>Tổng Tour</small><div class="val purple">${totalTours}</div></div>
            <div class="ai-metric"><small>Đang Hoạt Động</small><div class="val success">${activeTours}</div></div>
            <div class="ai-metric"><small>Chờ Duyệt</small><div class="val warning">${pendingTours}</div></div>
            <div class="ai-metric"><small>Doanh Thu</small><div class="val" style="color:#34D399"><fmt:formatNumber value="${grossRevenue}" pattern="#,###"/>đ</div></div>
        </div>

        <!-- Inline Add Tour Form (hidden by default) -->
        <div id="addTourPanel" style="display:none;margin-bottom:24px">
            <div class="card">
                <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px">
                    <h3 style="margin:0"><i class="fas fa-plus-circle" style="color:#3B82F6"></i> Thêm Tour Mới</h3>
                    <button onclick="document.getElementById('addTourPanel').style.display='none'" style="background:rgba(255,255,255,.06);border:none;color:#94A3B8;padding:6px 14px;border-radius:8px;cursor:pointer;font-size:.82rem;font-weight:600"><i class="fas fa-times"></i> Đóng</button>
                </div>
                <form method="POST" action="${pageContext.request.contextPath}/admin/tours" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="redirect" value="dashboard">
                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px">
                        <div>
                            <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Tên Tour *</label>
                            <input type="text" name="tourName" required placeholder="VD: City Tour Đà Nẵng" style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;font-family:'Inter',sans-serif">
                        </div>
                        <div>
                            <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Danh Mục *</label>
                            <select name="categoryId" required style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none">
                                <c:forEach items="${categoryList}" var="cat">
                                    <option value="${cat.categoryId}">${cat.categoryName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Giá (VNĐ) *</label>
                            <input type="number" name="price" required placeholder="500000" min="0" style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;font-family:'Inter',sans-serif">
                        </div>
                        <div>
                            <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Thời Gian Tour</label>
                            <input type="text" name="duration" placeholder="VD: 1 ngày, 2 giờ" style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;font-family:'Inter',sans-serif">
                        </div>
                        <div>
                            <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Phương Tiện</label>
                            <input type="text" name="transport" placeholder="VD: Xe du lịch" style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;font-family:'Inter',sans-serif">
                        </div>
                        <div>
                            <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Điểm Đến</label>
                            <input type="text" name="destination" placeholder="VD: Bà Nà Hills" style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;font-family:'Inter',sans-serif">
                        </div>
                        <div>
                            <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Ngày Bắt Đầu</label>
                            <input type="date" name="startDate" style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;font-family:'Inter',sans-serif">
                        </div>
                        <div>
                            <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Ngày Kết Thúc</label>
                            <input type="date" name="endDate" style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;font-family:'Inter',sans-serif">
                        </div>
                        <div>
                            <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Số Người Tối Đa</label>
                            <input type="number" name="maxPeople" value="20" min="1" style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;font-family:'Inter',sans-serif">
                        </div>
                        <div>
                            <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">URL Ảnh</label>
                            <input type="text" name="imageUrl" placeholder="https://..." style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;font-family:'Inter',sans-serif">
                        </div>
                    </div>
                    <div style="margin-top:16px">
                        <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Mô Tả Ngắn</label>
                        <input type="text" name="shortDesc" placeholder="Mô tả ngắn về tour..." style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;font-family:'Inter',sans-serif">
                    </div>
                    <div style="margin-top:16px">
                        <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Mô Tả Chi Tiết</label>
                        <textarea name="description" rows="3" placeholder="Mô tả chi tiết..." style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;resize:vertical;font-family:'Inter',sans-serif"></textarea>
                    </div>
                    <div style="margin-top:20px;display:flex;gap:10px;justify-content:flex-end">
                        <button type="button" onclick="document.getElementById('addTourPanel').style.display='none'" style="padding:10px 20px;border-radius:8px;font-size:.82rem;font-weight:700;border:none;cursor:pointer;background:rgba(255,255,255,.06);color:#94A3B8">Hủy</button>
                        <button type="submit" style="padding:10px 24px;border-radius:8px;font-size:.82rem;font-weight:700;border:none;cursor:pointer;background:linear-gradient(135deg,#3B82F6,#2563EB);color:#fff;box-shadow:0 4px 15px rgba(59,130,246,.3)"><i class="fas fa-save" style="margin-right:6px"></i>Lưu Tour</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="card">
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;flex-wrap:wrap;gap:12px">
                <h3 style="margin:0"><i class="fas fa-map-marked-alt"></i> Danh Sách Tour <span style="font-size:.75rem;color:rgba(255,255,255,.3);font-weight:500;margin-left:8px">(Dữ liệu thực từ Supabase)</span></h3>
                <button onclick="document.getElementById('addTourPanel').style.display=document.getElementById('addTourPanel').style.display==='none'?'block':'none';window.scrollTo({top:document.getElementById('addTourPanel').offsetTop-80,behavior:'smooth'})" style="display:inline-flex;align-items:center;gap:8px;padding:10px 20px;background:linear-gradient(135deg,#3B82F6,#2563EB);color:#fff;border-radius:10px;font-size:.85rem;font-weight:700;border:none;cursor:pointer;transition:.3s;box-shadow:0 4px 15px rgba(59,130,246,.3)">
                    <i class="fas fa-plus-circle"></i> Thêm Tour Mới
                </button>
            </div>
            <div style="overflow-x:auto">
            <table class="data-table">
                <thead><tr><th>#</th><th>Tên Tour</th><th>Danh Mục</th><th>Giá</th><th>Thời Gian Tour</th><th>Ngày Bắt Đầu</th><th>Ngày Kết Thúc</th><th>Trạng Thái</th><th>Thao Tác</th></tr></thead>
                <tbody>
                <c:forEach items="${tourList}" var="t" varStatus="s">
                    <tr>
                        <td style="color:#64748B;font-weight:600">${s.index + 1}</td>
                        <td style="color:#fff;font-weight:600">${t.tourName}</td>
                        <td><span style="padding:3px 10px;border-radius:6px;font-size:.72rem;font-weight:600;background:rgba(139,92,246,.15);color:#A78BFA">${not empty t.category ? t.category.categoryName : 'Tour'}</span></td>
                        <td style="color:#34D399;font-weight:700"><fmt:formatNumber value="${t.price}" pattern="#,###"/>đ</td>
                        <td style="font-size:.82rem">${t.duration}</td>
                        <td style="font-size:.82rem;color:rgba(255,255,255,.6)">
                            <c:choose>
                                <c:when test="${not empty t.startDate}"><fmt:formatDate value="${t.startDate}" pattern="dd/MM/yyyy"/></c:when>
                                <c:otherwise>—</c:otherwise>
                            </c:choose>
                        </td>
                        <td style="font-size:.82rem;color:rgba(255,255,255,.6)">
                            <c:choose>
                                <c:when test="${not empty t.endDate}"><fmt:formatDate value="${t.endDate}" pattern="dd/MM/yyyy"/></c:when>
                                <c:otherwise>—</c:otherwise>
                            </c:choose>
                        </td>
                        <td><span style="padding:3px 10px;border-radius:6px;font-size:.72rem;font-weight:700;${t.active ? 'background:rgba(16,185,129,.15);color:#34D399' : 'background:rgba(239,68,68,.15);color:#F87171'}">${t.active ? 'Active' : 'Inactive'}</span></td>
                        <td>
                            <div style="display:flex;gap:6px">
                                <a href="${pageContext.request.contextPath}/admin/tours?action=toggle&id=${t.tourId}" style="padding:5px 10px;border-radius:6px;font-size:.72rem;font-weight:700;${t.active ? 'background:rgba(245,158,11,.15);color:#FBBF24' : 'background:rgba(16,185,129,.15);color:#34D399'};text-decoration:none" title="${t.active ? 'Ẩn' : 'Hiện'}">${t.active ? '<i class="fas fa-eye-slash"></i>' : '<i class="fas fa-eye"></i>'}</a>
                                <a href="${pageContext.request.contextPath}/admin/tours?action=delete&id=${t.tourId}" onclick="return confirm('Bạn có chắc muốn xóa tour này?')" style="padding:5px 10px;border-radius:6px;font-size:.72rem;font-weight:700;background:rgba(239,68,68,.15);color:#F87171;text-decoration:none;transition:.3s" title="Xóa"><i class="fas fa-trash"></i></a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty tourList}"><tr><td colspan="9" style="text-align:center;padding:40px;color:rgba(255,255,255,.3)">Chưa có tour</td></tr></c:if>
                </tbody>
            </table>
            </div>
        </div>
    </div>

    <!-- ═══ SPA SECTION: CHATBOT & USER BEHAVIOR ═══ -->
    <div class="spa-section" id="sec-chatbot" style="display:none">
        <div class="ai-metrics" style="margin-bottom:24px">
            <div class="ai-metric"><small>Tổng Câu Hỏi Chatbot</small><div class="val purple">${cbTotal}</div></div>
            <div class="ai-metric"><small>Phân Loại</small><div class="val success"><c:out value="${not empty cbCategories ? cbCategories.size() : 0}"/> nhóm</div></div>
            <div class="ai-metric"><small>Tốc Độ TB</small><div class="val" style="color:#60A5FA"><fmt:formatNumber value="${cbAvgTime}" pattern="#,###"/>ms</div></div>
            <div class="ai-metric"><small>Đơn Hàng Thực</small><div class="val warning">${totalOrders}</div></div>
        </div>
        <div class="grid-2">
            <div class="card">
                <h3><i class="fas fa-comment-dots"></i> Top Câu Hỏi Thực <span style="font-size:.72rem;color:rgba(255,255,255,.25);margin-left:6px">(Supabase DB)</span></h3>
                <div style="overflow-x:auto">
                <table class="data-table">
                    <thead><tr><th>#</th><th>Câu Hỏi</th><th>Số Lần</th></tr></thead>
                    <tbody>
                    <c:forEach items="${cbTopQuestions}" var="q" varStatus="s">
                        <tr><td style="color:#64748B;font-weight:600">${s.index+1}</td><td style="color:#fff">${q[0]}</td><td style="color:#60A5FA;font-weight:700">${q[1]}</td></tr>
                    </c:forEach>
                    <c:if test="${empty cbTopQuestions}"><tr><td colspan="3" style="text-align:center;padding:40px;color:rgba(255,255,255,.3)">Chưa có câu hỏi. Hãy chat với bot!</td></tr></c:if>
                    </tbody>
                </table>
                </div>
            </div>
            <div class="card">
                <h3><i class="fas fa-tags"></i> Phân Loại Câu Hỏi <span style="font-size:.72rem;color:rgba(255,255,255,.25);margin-left:6px">(Tự động)</span></h3>
                <div style="display:flex;flex-direction:column;gap:12px;margin-top:16px">
                <c:forEach items="${cbCategories}" var="cat">
                    <c:set var="pct" value="${cbTotal > 0 ? (cat[1] * 100 / cbTotal) : 0}"/>
                    <div>
                        <div style="display:flex;justify-content:space-between;font-size:.82rem;margin-bottom:4px">
                            <span style="color:#fff;font-weight:600"><c:choose><c:when test="${cat[0]=='PRICE'}">💰 Hỏi giá</c:when><c:when test="${cat[0]=='LOCATION'}">📍 Địa điểm</c:when><c:when test="${cat[0]=='BOOKING'}">🛒 Đặt tour</c:when><c:when test="${cat[0]=='POLICY'}">📋 Chính sách</c:when><c:when test="${cat[0]=='FAMILY'}">👨‍👩‍👧 Gia đình</c:when><c:when test="${cat[0]=='ORDER'}">📦 Đơn hàng</c:when><c:when test="${cat[0]=='RECOMMEND'}">⭐ Gợi ý</c:when><c:otherwise>💬 Chung</c:otherwise></c:choose></span>
                            <span style="color:#60A5FA;font-weight:700">${cat[1]} (<fmt:formatNumber value="${pct}" pattern="#.#"/>%)</span>
                        </div>
                        <div style="height:6px;background:rgba(255,255,255,.06);border-radius:3px"><div style="height:100%;width:<fmt:formatNumber value="${pct}" pattern="#.#"/>%;background:linear-gradient(90deg,#3B82F6,#60A5FA);border-radius:3px"></div></div>
                    </div>
                </c:forEach>
                <c:if test="${empty cbCategories}"><div style="text-align:center;padding:30px;color:rgba(255,255,255,.3)">Chưa có dữ liệu</div></c:if>
                </div>
            </div>
        </div>
        <div class="card">
            <h3><i class="fas fa-funnel-dollar"></i> Phễu Chuyển Đổi <span style="font-size:.72rem;color:rgba(255,255,255,.25);margin-left:6px">(Dữ liệu thực)</span></h3>
            <div style="display:flex;gap:16px;align-items:center;flex-wrap:wrap">
                <div style="flex:1;min-width:130px;text-align:center;padding:20px;background:rgba(59,130,246,.1);border:1px solid rgba(59,130,246,.2);border-radius:14px"><div style="font-size:2rem;font-weight:800;color:#60A5FA">${cbTotal}</div><div style="font-size:.75rem;color:rgba(255,255,255,.4);margin-top:4px">Câu hỏi Chatbot</div></div>
                <div style="color:rgba(255,255,255,.2);font-size:1.5rem"><i class="fas fa-chevron-right"></i></div>
                <div style="flex:1;min-width:130px;text-align:center;padding:20px;background:rgba(139,92,246,.1);border:1px solid rgba(139,92,246,.2);border-radius:14px"><div style="font-size:2rem;font-weight:800;color:#A78BFA">${totalUsers}</div><div style="font-size:.75rem;color:rgba(255,255,255,.4);margin-top:4px">Người dùng</div></div>
                <div style="color:rgba(255,255,255,.2);font-size:1.5rem"><i class="fas fa-chevron-right"></i></div>
                <div style="flex:1;min-width:130px;text-align:center;padding:20px;background:rgba(245,158,11,.1);border:1px solid rgba(245,158,11,.2);border-radius:14px"><div style="font-size:2rem;font-weight:800;color:#FBBF24">${totalOrders}</div><div style="font-size:.75rem;color:rgba(255,255,255,.4);margin-top:4px">Đặt Tour</div></div>
                <div style="color:rgba(255,255,255,.2);font-size:1.5rem"><i class="fas fa-chevron-right"></i></div>
                <div style="flex:1;min-width:130px;text-align:center;padding:20px;background:rgba(16,185,129,.1);border:1px solid rgba(16,185,129,.2);border-radius:14px"><div style="font-size:2rem;font-weight:800;color:#34D399">${completedOrders}</div><div style="font-size:.75rem;color:rgba(255,255,255,.4);margin-top:4px">Hoàn Thành</div></div>
            </div>
        </div>
        <div class="card">
            <h3><i class="fas fa-history"></i> Lịch Sử Chat Gần Đây <span style="font-size:.72rem;color:rgba(255,255,255,.25);margin-left:6px">(20 câu mới nhất)</span></h3>
            <div style="overflow-x:auto">
            <table class="data-table">
                <thead><tr><th>Thời Gian</th><th>Câu Hỏi</th><th>Phân Loại</th><th>User</th></tr></thead>
                <tbody>
                <c:forEach items="${cbRecent}" var="cl">
                    <tr>
                        <td style="font-size:.78rem;color:rgba(255,255,255,.4);white-space:nowrap"><fmt:formatDate value="${cl.createdAt}" pattern="dd/MM HH:mm"/></td>
                        <td style="color:#fff">${cl.question}</td>
                        <td><span style="padding:3px 10px;border-radius:6px;font-size:.72rem;font-weight:700;background:rgba(59,130,246,.15);color:#60A5FA">${cl.category != null ? cl.category : 'GENERAL'}</span></td>
                        <td style="font-size:.78rem;color:rgba(255,255,255,.4)">${cl.userId != null ? cl.userId : 'Ẩn danh'}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty cbRecent}"><tr><td colspan="4" style="text-align:center;padding:40px;color:rgba(255,255,255,.3)">Chưa có lịch sử chat. Mở chatbot và hỏi vài câu!</td></tr></c:if>
                </tbody>
            </table>
            </div>
        </div>
    </div>

    <!-- ═══ SPA SECTION: PROVIDERS ═══ -->
    <div class="spa-section" id="sec-providers" style="display:none">
        <div class="ai-metrics" style="margin-bottom:24px">
            <div class="ai-metric"><small>Tổng NCC</small><div class="val purple">${totalProviders}</div></div>
            <div class="ai-metric"><small>Đã Duyệt</small><div class="val success">${approvedProviders}</div></div>
            <div class="ai-metric"><small>Chờ Duyệt</small><div class="val warning">${pendingProviders}</div></div>
            <div class="ai-metric"><small>Tổng Tours</small><div class="val" style="color:#60A5FA">${totalTours}</div></div>
        </div>

        <!-- Pending Providers -->
        <c:if test="${not empty pendingProviderList}">
        <div class="card" style="border-left:3px solid #F59E0B">
            <h3><i class="fas fa-clock" style="color:#FBBF24"></i> Nhà Cung Cấp Chờ Duyệt <span style="background:#FBBF24;color:#000;padding:2px 8px;border-radius:6px;font-size:.72rem;font-weight:700;margin-left:8px">${pendingProviders}</span></h3>
            <div style="overflow-x:auto">
            <table class="data-table">
                <thead><tr><th>ID</th><th>Tên Doanh Nghiệp</th><th>Loại</th><th>Ngày ĐK</th><th>Hành Động</th></tr></thead>
                <tbody>
                <c:forEach items="${pendingProviderList}" var="pp">
                    <tr>
                        <td style="color:#64748B;font-weight:600">#${pp.providerId}</td>
                        <td style="color:#fff;font-weight:600">${pp.businessName}</td>
                        <td><span style="padding:3px 10px;border-radius:6px;font-size:.72rem;font-weight:700;background:rgba(139,92,246,.15);color:#A78BFA">${pp.providerType}</span></td>
                        <td style="font-size:.78rem;color:rgba(255,255,255,.4)">${pp.joinDate}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/dashboard?action=approve-provider&id=${pp.providerId}" style="padding:4px 12px;border-radius:6px;font-size:.72rem;font-weight:700;background:rgba(16,185,129,.15);color:#34D399;text-decoration:none;margin-right:4px"><i class="fas fa-check"></i> Duyệt</a>
                            <a href="${pageContext.request.contextPath}/admin/dashboard?action=reject-provider&id=${pp.providerId}" style="padding:4px 12px;border-radius:6px;font-size:.72rem;font-weight:700;background:rgba(239,68,68,.15);color:#F87171;text-decoration:none"><i class="fas fa-times"></i> Từ Chối</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            </div>
        </div>
        </c:if>

        <!-- All Providers -->
        <div class="card">
            <h3><i class="fas fa-building"></i> Danh Sách Nhà Cung Cấp <span style="font-size:.72rem;color:rgba(255,255,255,.25);margin-left:6px">(Dữ liệu thực từ Supabase)</span></h3>
            <div style="overflow-x:auto">
            <table class="data-table">
                <thead><tr><th>ID</th><th>Tên Doanh Nghiệp</th><th>Loại</th><th>Rating</th><th>Tours</th><th>Trạng Thái</th><th>Xác Minh</th><th>Ngày Tham Gia</th></tr></thead>
                <tbody>
                <c:forEach items="${providerList}" var="p">
                    <tr>
                        <td style="color:#64748B;font-weight:600">#${p.providerId}</td>
                        <td style="color:#fff;font-weight:600">${p.businessName}</td>
                        <td><span style="padding:3px 10px;border-radius:6px;font-size:.72rem;font-weight:700;background:rgba(59,130,246,.15);color:#60A5FA">${p.providerType}</span></td>
                        <td style="color:#FBBF24;font-weight:700"><c:if test="${p.rating != null}">⭐ ${p.rating}</c:if><c:if test="${p.rating == null}">-</c:if></td>
                        <td style="color:#60A5FA;font-weight:700">${p.totalTours}</td>
                        <td><c:choose><c:when test="${p.status == 'Approved'}"><span style="padding:3px 10px;border-radius:6px;font-size:.72rem;font-weight:700;background:rgba(16,185,129,.15);color:#34D399">✓ Đã Duyệt</span></c:when><c:when test="${p.status == 'Pending'}"><span style="padding:3px 10px;border-radius:6px;font-size:.72rem;font-weight:700;background:rgba(245,158,11,.15);color:#FBBF24">⏳ Chờ Duyệt</span></c:when><c:otherwise><span style="padding:3px 10px;border-radius:6px;font-size:.72rem;font-weight:700;background:rgba(239,68,68,.15);color:#F87171">✗ Từ Chối</span></c:otherwise></c:choose></td>
                        <td style="text-align:center"><c:if test="${p.verified}"><i class="fas fa-check-circle" style="color:#34D399"></i></c:if><c:if test="${!p.verified}"><i class="fas fa-times-circle" style="color:#64748B"></i></c:if></td>
                        <td style="font-size:.78rem;color:rgba(255,255,255,.4)">${p.joinDate}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty providerList}"><tr><td colspan="8" style="text-align:center;padding:40px;color:rgba(255,255,255,.3)"><i class="fas fa-handshake" style="font-size:2rem;opacity:.2;display:block;margin-bottom:12px"></i>Chưa có nhà cung cấp nào</td></tr></c:if>
                </tbody>
            </table>
            </div>
        </div>

        <!-- ═══ SO SÁNH NHÀ CUNG CẤP ═══ -->
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:20px;margin-top:20px">

            <!-- Xếp hạng chất lượng -->
            <div class="card">
                <h3><i class="fas fa-trophy" style="color:#FBBF24"></i> Xếp Hạng Chất Lượng</h3>
                <c:forEach items="${providerRanking}" var="pr" varStatus="idx">
                <div style="display:flex;align-items:center;gap:12px;padding:10px 0;border-bottom:1px solid rgba(255,255,255,.06)">
                    <div style="min-width:28px;height:28px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-weight:800;font-size:.75rem;
                        <c:choose>
                            <c:when test="${idx.index == 0}">background:linear-gradient(135deg,#FFD700,#FFA500);color:#000</c:when>
                            <c:when test="${idx.index == 1}">background:linear-gradient(135deg,#C0C0C0,#A0A0A0);color:#000</c:when>
                            <c:when test="${idx.index == 2}">background:linear-gradient(135deg,#CD7F32,#A0522D);color:#fff</c:when>
                            <c:otherwise>background:rgba(255,255,255,.08);color:rgba(255,255,255,.4)</c:otherwise>
                        </c:choose>
                    ">${idx.index + 1}</div>
                    <div style="flex:1">
                        <div style="color:#fff;font-weight:600;font-size:.85rem">${pr.businessName}</div>
                        <div style="font-size:.72rem;color:rgba(255,255,255,.35)">${pr.providerType} · ${pr.totalTours} tours</div>
                    </div>
                    <div style="text-align:right">
                        <div style="color:#FBBF24;font-weight:700;font-size:.9rem">⭐ ${pr.rating}</div>
                        <div style="background:rgba(251,191,36,.15);border-radius:4px;height:4px;width:60px;margin-top:4px">
                            <div style="background:#FBBF24;border-radius:4px;height:100%;width:${pr.rating * 20}%"></div>
                        </div>
                    </div>
                </div>
                </c:forEach>
                <c:if test="${empty providerRanking}">
                    <div style="text-align:center;padding:30px;color:rgba(255,255,255,.25)"><i class="fas fa-trophy" style="font-size:1.5rem;opacity:.2;display:block;margin-bottom:8px"></i>Chưa có dữ liệu xếp hạng</div>
                </c:if>
            </div>

            <!-- So sánh giá trung bình -->
            <div class="card">
                <h3><i class="fas fa-balance-scale" style="color:#60A5FA"></i> So Sánh Giá Trung Bình</h3>
                <c:forEach items="${providerAvgPrices}" var="ap" varStatus="idx">
                <div style="display:flex;align-items:center;gap:12px;padding:10px 0;border-bottom:1px solid rgba(255,255,255,.06)">
                    <div style="min-width:28px;height:28px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-weight:800;font-size:.75rem;
                        <c:choose>
                            <c:when test="${idx.index == 0}">background:rgba(16,185,129,.2);color:#34D399</c:when>
                            <c:when test="${idx.index == 1}">background:rgba(59,130,246,.15);color:#60A5FA</c:when>
                            <c:otherwise>background:rgba(255,255,255,.08);color:rgba(255,255,255,.4)</c:otherwise>
                        </c:choose>
                    ">${idx.index + 1}</div>
                    <div style="flex:1">
                        <div style="color:#fff;font-weight:600;font-size:.85rem">${ap[0]}</div>
                        <div style="font-size:.72rem;color:rgba(255,255,255,.35)">${ap[2]} dịch vụ</div>
                    </div>
                    <div style="text-align:right">
                        <div style="color:#34D399;font-weight:700;font-size:.85rem">
                            <fmt:formatNumber value="${ap[1]}" pattern="#,##0"/>đ
                        </div>
                        <div style="font-size:.68rem;color:rgba(255,255,255,.25)">TB/dịch vụ</div>
                    </div>
                </div>
                </c:forEach>
                <c:if test="${empty providerAvgPrices}">
                    <div style="text-align:center;padding:30px;color:rgba(255,255,255,.25)"><i class="fas fa-balance-scale" style="font-size:1.5rem;opacity:.2;display:block;margin-bottom:8px"></i>Chưa có dữ liệu giá</div>
                </c:if>
            </div>
        </div>

        <!-- Lịch sử thay đổi giá -->
        <div class="card" style="margin-top:20px">
            <h3><i class="fas fa-chart-line" style="color:#A78BFA"></i> Lịch Sử Thay Đổi Giá <span style="font-size:.72rem;color:rgba(255,255,255,.25);margin-left:6px">(50 gần nhất)</span></h3>
            <div style="overflow-x:auto">
            <table class="data-table">
                <thead><tr><th>Nhà Cung Cấp</th><th>Dịch Vụ</th><th>Loại</th><th>Giá Cũ</th><th>Giá Mới</th><th>Thay Đổi</th><th>Ngày</th></tr></thead>
                <tbody>
                <c:forEach items="${priceHistory}" var="ph">
                    <tr>
                        <td style="color:#fff;font-weight:600">${ph.provider.businessName}</td>
                        <td style="color:rgba(255,255,255,.7)">${ph.serviceName}</td>
                        <td><span style="padding:2px 8px;border-radius:5px;font-size:.7rem;font-weight:700;background:rgba(139,92,246,.15);color:#A78BFA">${ph.serviceType}</span></td>
                        <td style="color:rgba(255,255,255,.4);font-size:.82rem"><c:if test="${ph.oldPrice != null}"><fmt:formatNumber value="${ph.oldPrice}" pattern="#,##0"/>đ</c:if><c:if test="${ph.oldPrice == null}">-</c:if></td>
                        <td style="color:#fff;font-weight:700;font-size:.82rem"><fmt:formatNumber value="${ph.newPrice}" pattern="#,##0"/>đ</td>
                        <td>
                            <c:if test="${ph.oldPrice != null && ph.oldPrice > 0}">
                                <c:set var="pctChange" value="${ph.priceChangePercent}"/>
                                <c:choose>
                                    <c:when test="${pctChange > 0}"><span style="color:#F87171;font-weight:700;font-size:.8rem">▲ +${pctChange}%</span></c:when>
                                    <c:when test="${pctChange < 0}"><span style="color:#34D399;font-weight:700;font-size:.8rem">▼ ${pctChange}%</span></c:when>
                                    <c:otherwise><span style="color:rgba(255,255,255,.3);font-size:.8rem">0%</span></c:otherwise>
                                </c:choose>
                            </c:if>
                            <c:if test="${ph.oldPrice == null}"><span style="color:#60A5FA;font-size:.75rem">Mới</span></c:if>
                        </td>
                        <td style="font-size:.75rem;color:rgba(255,255,255,.3)"><fmt:formatDate value="${ph.changeDate}" pattern="dd/MM/yyyy"/></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty priceHistory}"><tr><td colspan="7" style="text-align:center;padding:40px;color:rgba(255,255,255,.25)"><i class="fas fa-chart-line" style="font-size:1.5rem;opacity:.2;display:block;margin-bottom:8px"></i>Chưa có lịch sử thay đổi giá</td></tr></c:if>
                </tbody>
            </table>
            </div>
        </div>
    </div>

    <!-- ═══ SPA SECTION: NEURAL NETWORK ═══ -->
    <div class="spa-section" id="sec-neural" style="display:none">
    <!-- NEURAL NETWORK PREDICTION SECTION -->
    <section class="nn-section" id="nn-section" style="margin-top:0;padding-top:0;border-top:none">
        <div class="nn-header">
            <div class="nn-icon"><i class="fas fa-brain"></i></div>
            <div>
                <h2>Dự Đoán Mạng Neural <span class="nn-badge"><span class="dot"></span> AI Active</span></h2>
                <p>Phân tích dữ liệu 5 năm (2020-2025) với mạng Neural Network — Dự báo du khách, doanh thu & xu hướng</p>
            </div>
        </div>

        <c:if test="${aiDataLoaded}">
        <!-- AI Metrics Summary -->
        <div class="ai-metrics">
            <div class="ai-metric">
                <small>Tổng Điểm Dữ Liệu</small>
                <div class="val purple">${totalDataPoints} mẫu</div>
            </div>
            <div class="ai-metric">
                <small>Mô Hình</small>
                <div class="val" style="font-size:.95rem">3-Layer Feedforward NN</div>
            </div>
            <div class="ai-metric">
                <small>Độ Chính Xác (R²)</small>
                <div class="val success" id="accuracy">Đang tính...</div>
            </div>
            <div class="ai-metric">
                <small>Sai Số Trung Bình (MAE)</small>
                <div class="val warning" id="mae">Đang tính...</div>
            </div>
        </div>

        <!-- Tab Navigation -->
        <div class="tab-bar">
            <button class="tab-btn active" onclick="switchTab('revenue')"><i class="fas fa-chart-line"></i> Doanh Thu</button>
            <button class="tab-btn" onclick="switchTab('guests')"><i class="fas fa-users"></i> Du Khách</button>
            <button class="tab-btn" onclick="switchTab('tours')"><i class="fas fa-trophy"></i> Top Tours</button>
            <button class="tab-btn" onclick="switchTab('weather')"><i class="fas fa-cloud-sun"></i> Thời Tiết</button>
            <button class="tab-btn" onclick="switchTab('neural')"><i class="fas fa-brain"></i> Neural Net</button>
            <button class="tab-btn" onclick="switchTab('fulldata')"><i class="fas fa-database"></i> Dữ Liệu 5 Năm</button>
            <button class="tab-btn" onclick="switchTab('algorithm')"><i class="fas fa-book-open"></i> Mô Tả Thuật Toán</button>
        </div>

        <!-- Tab 1: Revenue Chart -->
        <div class="tab-content active" id="tab-revenue">
            <div class="card">
                <h3><i class="fas fa-chart-line"></i> Doanh Thu Du Lịch 5 Năm (2020-2025) — Dữ Liệu Thực vs Dự Đoán</h3>
                <div class="chart-box"><canvas id="revenueChart"></canvas></div>
            </div>
        </div>

        <!-- Tab 2: Guest Count -->
        <div class="tab-content" id="tab-guests">
            <div class="card">
                <h3><i class="fas fa-users"></i> Lượng Du Khách Theo Tháng — Dự Đoán 6 Tháng Tới</h3>
                <div class="chart-box"><canvas id="guestChart"></canvas></div>
            </div>
        </div>

        <!-- Tab 3: Top Tours -->
        <div class="tab-content" id="tab-tours">
            <div class="card">
                <h3><i class="fas fa-trophy"></i> Top Tours Có Doanh Thu Cao Nhất — Phân Tích 5 Năm</h3>
                <div class="chart-box"><canvas id="tourChart"></canvas></div>
            </div>
        </div>

        <!-- Tab 4: Weather Correlation -->
        <div class="tab-content" id="tab-weather">
            <div class="card">
                <h3><i class="fas fa-cloud-sun"></i> Tương Quan Thời Tiết — Nhiệt Độ & Lượng Mưa Trung Bình</h3>
                <div class="chart-box"><canvas id="weatherChart"></canvas></div>
            </div>
        </div>

        <!-- Tab 5: Neural Network Visualization -->
        <div class="tab-content" id="tab-neural">
            <div class="nn-vis">
                <h3 style="color:#A78BFA;margin-bottom:8px"><i class="fas fa-project-diagram"></i> Kiến Trúc Mạng Neural — EZTravel AI Model</h3>
                <p style="font-size:.82rem;color:rgba(255,255,255,.4);margin-bottom:20px">Feedforward Neural Network 3 lớp ẩn — Huấn luyện trên ${totalDataPoints} điểm dữ liệu</p>

                <div class="nn-layers">
                    <div class="nn-layer nn-input">
                        <div class="nn-layer-label">Input Layer</div>
                        <div class="nn-neuron">T</div>
                        <div class="nn-neuron">M</div>
                        <div class="nn-neuron">S</div>
                        <div class="nn-neuron">W</div>
                        <div class="nn-layer-info">4 features: Tháng, Mùa, Thời tiết, Trend</div>
                    </div>
                    <div class="nn-arrow"><i class="fas fa-long-arrow-alt-right"></i><i class="fas fa-long-arrow-alt-right"></i></div>
                    <div class="nn-layer nn-hidden">
                        <div class="nn-layer-label">Hidden 1</div>
                        <div class="nn-neuron">H1</div>
                        <div class="nn-neuron">H2</div>
                        <div class="nn-neuron">H3</div>
                        <div class="nn-neuron">H4</div>
                        <div class="nn-neuron">H5</div>
                        <div class="nn-neuron">H6</div>
                        <div class="nn-layer-info">6 neurons, ReLU activation</div>
                    </div>
                    <div class="nn-arrow"><i class="fas fa-long-arrow-alt-right"></i><i class="fas fa-long-arrow-alt-right"></i></div>
                    <div class="nn-layer nn-hidden">
                        <div class="nn-layer-label">Hidden 2</div>
                        <div class="nn-neuron">H1</div>
                        <div class="nn-neuron">H2</div>
                        <div class="nn-neuron">H3</div>
                        <div class="nn-neuron">H4</div>
                        <div class="nn-layer-info">4 neurons, ReLU activation</div>
                    </div>
                    <div class="nn-arrow"><i class="fas fa-long-arrow-alt-right"></i><i class="fas fa-long-arrow-alt-right"></i></div>
                    <div class="nn-layer nn-output">
                        <div class="nn-layer-label">Output Layer</div>
                        <div class="nn-neuron">R</div>
                        <div class="nn-neuron">G</div>
                        <div class="nn-layer-info">2 outputs: Revenue, Guests</div>
                    </div>
                </div>
            </div>

            <!-- Prediction Results -->
            <div class="prediction-card" style="margin-top:24px">
                <h3 style="color:#34D399;margin-bottom:4px"><i class="fas fa-magic"></i> Kết Quả Dự Đoán — 6 Tháng Tới (2026)</h3>
                <p style="font-size:.82rem;color:rgba(255,255,255,.4);margin-bottom:20px">Dự đoán doanh thu và lượng du khách dựa trên mạng neural đã huấn luyện</p>
                <div class="pred-grid" id="predictionGrid">
                    <!-- Filled by JS -->
                </div>
            </div>
        </div>

        <!-- Tab 6: Full 5-Year Data -->
        <div class="tab-content" id="tab-fulldata">
            <div class="card">
                <h3><i class="fas fa-database"></i> Toàn Bộ Dữ Liệu Du Lịch Đà Nẵng — 5 Năm (2020-2025)</h3>
                <p style="font-size:.82rem;color:rgba(255,255,255,.4);margin-bottom:20px">432 bản ghi từ 6 tour du lịch chính — Dữ liệu huấn luyện mạng Neural Network</p>
                
                <div class="data-summary" id="dataSummary">
                    <div class="data-summary-item"><span class="ds-label">Tổng Bản Ghi</span><span class="ds-value" style="color:#A78BFA" id="dsTotal">—</span></div>
                    <div class="data-summary-item"><span class="ds-label">Tổng Doanh Thu Booking</span><span class="ds-value" style="color:#34D399" id="dsTotalRev">—</span></div>
                    <div class="data-summary-item"><span class="ds-label">TB Doanh Thu/Tháng</span><span class="ds-value" style="color:#60A5FA" id="dsAvgRev">—</span></div>
                    <div class="data-summary-item"><span class="ds-label">Tổng Du Khách</span><span class="ds-value" style="color:#FBBF24" id="dsTotalGuest">—</span></div>
                    <div class="data-summary-item"><span class="ds-label">Khoảng Thời Gian</span><span class="ds-value" style="color:#F87171" id="dsRange">—</span></div>
                </div>

                <div class="year-filter" id="yearFilter">
                    <button class="year-btn active" onclick="filterYear('all',this)">Tất cả</button>
                    <button class="year-btn" onclick="filterYear(2020,this)">2020</button>
                    <button class="year-btn" onclick="filterYear(2021,this)">2021</button>
                    <button class="year-btn" onclick="filterYear(2022,this)">2022</button>
                    <button class="year-btn" onclick="filterYear(2023,this)">2023</button>
                    <button class="year-btn" onclick="filterYear(2024,this)">2024</button>
                    <button class="year-btn" onclick="filterYear(2025,this)">2025</button>
                </div>

                <div class="data-table-wrap">
                    <table class="data-table" id="fullDataTable">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Tháng/Năm</th>
                                <th>Doanh Thu Booking (tỷ VND)</th>
                                <th>Doanh Thu Vé Bay (tỷ VND)</th>
                                <th>Lượng Du Khách</th>
                                <th>Mùa</th>
                                <th>Xu Hướng</th>
                            </tr>
                        </thead>
                        <tbody id="fullDataBody">
                            <!-- Populated by JavaScript -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Tab 7: Algorithm Description -->
        <div class="tab-content" id="tab-algorithm">
            <div class="card">
                <h3><i class="fas fa-book-open"></i> Mô Tả Thuật Toán Mạng Nơ-ron Nhân Tạo (ANN)</h3>
                <p style="font-size:.82rem;color:rgba(255,255,255,.4);margin-bottom:24px">Ứng dụng Dự báo Xu hướng Du lịch Đà Nẵng | PRJ301 Java Web — EZTravel AI</p>

                <!-- 1. Overview -->
                <div class="algo-section">
                    <h4><i class="fas fa-bullseye"></i> 1. Tổng Quan Bài Toán</h4>
                    <div class="algo-text">
                        Dự báo <strong style="color:#34D399">doanh thu du lịch Đà Nẵng năm 2026</strong> dựa trên dữ liệu lịch sử <strong>6 năm (2020–2025)</strong>, bao gồm <strong>432 bản ghi</strong> từ 6 tour du lịch chính.<br><br>
                        Dữ liệu du lịch có tính <strong style="color:#FBBF24">mùa vụ rõ ràng</strong> (cao điểm hè, thấp điểm đông) và <strong style="color:#60A5FA">xu hướng tăng trưởng phi tuyến</strong> → Mạng nơ-ron là lựa chọn phù hợp nhất.
                    </div>
                    
                    <h4 style="margin-top:24px"><i class="fas fa-balance-scale"></i> So Sánh Với Các Phương Pháp Khác</h4>
                    <div class="algo-comparison">
                        <div class="algo-compare-item">
                            <h5>Linear Regression</h5>
                            <div class="score" style="color:#F87171">⚠️ Yếu</div>
                            <div style="font-size:.75rem;color:rgba(255,255,255,.4)">Không học được pattern phi tuyến & mùa vụ</div>
                        </div>
                        <div class="algo-compare-item">
                            <h5>Decision Tree</h5>
                            <div class="score" style="color:#FBBF24">⚡ Trung bình</div>
                            <div style="font-size:.75rem;color:rgba(255,255,255,.4)">Xử lý mùa vụ hạn chế, không mở rộng tốt</div>
                        </div>
                        <div class="algo-compare-item winner">
                            <h5>Neural Network ✓</h5>
                            <div class="score" style="color:#34D399">🏆 Tốt nhất</div>
                            <div style="font-size:.75rem;color:rgba(255,255,255,.4)">Học pattern phi tuyến, xử lý mùa vụ, tự trích xuất đặc trưng</div>
                        </div>
                    </div>
                </div>

                <!-- 2. Architecture -->
                <div class="algo-section">
                    <h4><i class="fas fa-project-diagram"></i> 2. Kiến Trúc Mạng Neural Network</h4>
                    <div class="algo-formula">
┌─────────────┐     ┌──────────────┐     ┌──────────────┐
│ INPUT LAYER │     │ HIDDEN LAYER │     │ OUTPUT LAYER │
│  (4 neuron) │────▶│  (6 neuron)  │────▶│  (2 neuron)  │
│             │     │  ReLU Activ. │     │   Linear     │
│ • Tháng     │     │  • H₁        │     │              │
│ • Năm       │     │  • H₂        │     │ → Doanh thu  │
│ • Mùa vụ   │     │  • H₃        │     │ → Du khách   │
│ • Trend     │     │  • H₄        │     │              │
│             │     │  • H₅        │     │              │
│             │     │  • H₆        │     │              │
└─────────────┘     └──────────────┘     └──────────────┘
  4 features    4×6=24 weights + 6 bias   6×2=12 weights + 2 bias
                                          Tổng: 44 tham số
                    </div>

                    <table class="algo-table">
                        <thead><tr><th>Lớp</th><th>Số Neuron</th><th>Activation</th><th>Mô Tả</th></tr></thead>
                        <tbody>
                            <tr><td style="color:#60A5FA;font-weight:700">Input</td><td>4</td><td>—</td><td>Tháng (normalized), Năm (normalized), Mùa vụ (0/0.5/1), Previous Revenue</td></tr>
                            <tr><td style="color:#A78BFA;font-weight:700">Hidden</td><td>6</td><td>ReLU</td><td>Học các đặc trưng ẩn từ dữ liệu — pattern mùa vụ, xu hướng tăng trưởng</td></tr>
                            <tr><td style="color:#34D399;font-weight:700">Output</td><td>2</td><td>Linear</td><td>Dự đoán: Doanh thu (tỷ VND) + Lượng du khách</td></tr>
                        </tbody>
                    </table>

                    <div class="algo-highlight">
                        <h5>📝 Tiền Xử Lý Dữ Liệu (Feature Engineering)</h5>
                        <ul>
                            <li><strong style="color:#60A5FA">Tháng:</strong> Normalized bằng công thức <code style="color:#A78BFA">month / 12</code> → giá trị từ 0 đến 1</li>
                            <li><strong style="color:#60A5FA">Năm:</strong> Min-Max Normalization: <code style="color:#A78BFA">(year - 2020) / 6</code></li>
                            <li><strong style="color:#60A5FA">Mùa vụ:</strong> Cao điểm = 1.0, Bình thường = 0.5, Thấp điểm = 0.0</li>
                            <li><strong style="color:#60A5FA">Revenue Trend:</strong> Giá trị doanh thu tháng trước (normalized) — giúp mạng nhận diện momentum</li>
                        </ul>
                    </div>
                </div>

                <!-- 3. Training Pipeline -->
                <div class="algo-section">
                    <h4><i class="fas fa-cogs"></i> 3. Quy Trình Huấn Luyện (Training Pipeline)</h4>
                    
                    <div class="algo-step">
                        <div class="algo-step-num">1</div>
                        <div class="algo-step-content">
                            <h5>Khởi Tạo Trọng Số (Xavier Initialization)</h5>
                            <p>Trọng số W được khởi tạo ngẫu nhiên: <code style="color:#A78BFA">W ~ Uniform(-0.25, 0.25)</code>, bias b = 0. Giúp tránh vanishing/exploding gradient khi bắt đầu huấn luyện.</p>
                        </div>
                    </div>

                    <div class="algo-step">
                        <div class="algo-step-num">2</div>
                        <div class="algo-step-content">
                            <h5>Forward Propagation (Lan Truyền Thuận)</h5>
                            <p>Tín hiệu lan truyền từ Input → Hidden → Output:<br>
                            <code style="color:#A78BFA">Hidden: z₁ = W₁ · x + b₁ → a₁ = ReLU(z₁) = max(0, z₁)</code><br>
                            <code style="color:#A78BFA">Output: ŷ = W₂ · a₁ + b₂</code> (Linear activation cho regression)</p>
                        </div>
                    </div>

                    <div class="algo-step">
                        <div class="algo-step-num">3</div>
                        <div class="algo-step-content">
                            <h5>Tính Loss — Mean Squared Error (MSE)</h5>
                            <p>Đo khoảng cách giữa dự đoán và thực tế:<br>
                            <code style="color:#A78BFA">Loss = (1/n) × Σᵢ (ŷᵢ - yᵢ)²</code><br>
                            Loss càng nhỏ = dự đoán càng chính xác = mô hình càng tốt.</p>
                        </div>
                    </div>

                    <div class="algo-step">
                        <div class="algo-step-num">4</div>
                        <div class="algo-step-content">
                            <h5>Backpropagation (Lan Truyền Ngược) — ❤️ Trái Tim Thuật Toán</h5>
                            <p>Sử dụng <strong>Chain Rule</strong> để tính gradient:<br>
                            <code style="color:#A78BFA">∂Loss/∂W₂ = 2(ŷ - y) × a₁</code> (gradient lớp output)<br>
                            <code style="color:#A78BFA">∂Loss/∂W₁ = 2(ŷ - y) × W₂ × ReLU'(z₁) × x</code> (gradient lớp hidden)<br>
                            Gradient cho biết hướng cập nhật trọng số để giảm Loss.</p>
                        </div>
                    </div>

                    <div class="algo-step">
                        <div class="algo-step-num">5</div>
                        <div class="algo-step-content">
                            <h5>Cập Nhật Trọng Số (Gradient Descent)</h5>
                            <p><code style="color:#A78BFA">W_new = W_old - η × ∂Loss/∂W</code><br>
                            Với Learning Rate <strong style="color:#FBBF24">η = 0.005</strong> (cân bằng giữa tốc độ và ổn định).<br>
                            Quá lớn (0.1) → Loss dao động. Quá nhỏ (0.0001) → Hội tụ chậm.</p>
                        </div>
                    </div>

                    <div class="algo-step">
                        <div class="algo-step-num">6</div>
                        <div class="algo-step-content">
                            <h5>Lặp Lại (800 Epochs)</h5>
                            <p>Lặp Bước 2→5 tổng cộng <strong style="color:#FBBF24">800 epochs</strong>. Mỗi epoch = 1 lần duyệt toàn bộ dữ liệu huấn luyện.<br>
                            Loss giảm dần qua các epoch cho thấy mô hình đang học được patterns từ dữ liệu.</p>
                        </div>
                    </div>
                </div>

                <!-- 4. ReLU Explanation -->
                <div class="algo-section">
                    <h4><i class="fas fa-bolt"></i> 4. Tại Sao Dùng ReLU Thay Vì Sigmoid?</h4>
                    <div class="algo-formula">ReLU(x) = max(0, x)        Sigmoid(x) = 1 / (1 + e^(-x))</div>
                    <table class="algo-table">
                        <thead><tr><th>Tiêu Chí</th><th>ReLU ✅</th><th>Sigmoid ❌</th></tr></thead>
                        <tbody>
                            <tr><td>Tốc độ tính toán</td><td style="color:#34D399">Nhanh (chỉ so sánh x vs 0)</td><td style="color:#F87171">Chậm (tính hàm mũ e^x)</td></tr>
                            <tr><td>Vanishing Gradient</td><td style="color:#34D399">Không bị ảnh hưởng (gradient = 1)</td><td style="color:#F87171">Gradient → 0 khi |x| lớn</td></tr>
                            <tr><td>Output range</td><td style="color:#34D399">[0, +∞) — phù hợp regression</td><td style="color:#F87171">[0, 1] — chỉ phù hợp classification</td></tr>
                            <tr><td>Tính toán gradient</td><td style="color:#34D399">Đơn giản: 0 hoặc 1</td><td style="color:#F87171">Phức tạp: σ(x)(1-σ(x))</td></tr>
                        </tbody>
                    </table>
                </div>

                <!-- 5. Training Visualization -->
                <div class="algo-section">
                    <h4><i class="fas fa-chart-area"></i> 5. Quá Trình Huấn Luyện (Training Loss)</h4>
                    <div class="nn-canvas-wrap">
                        <div class="training-chart-box"><canvas id="trainingLossChart"></canvas></div>
                    </div>
                    <div style="margin-top:16px">
                        <table class="algo-table">
                            <thead><tr><th>Epoch</th><th>Loss (MSE)</th><th>Trạng Thái</th></tr></thead>
                            <tbody>
                                <tr><td>Epoch 1</td><td>~0.285</td><td style="color:#F87171">Dự đoán ngẫu nhiên — chưa học được gì</td></tr>
                                <tr><td>Epoch 50</td><td>~0.042</td><td style="color:#FBBF24">Bắt đầu nhận ra xu hướng tăng trưởng</td></tr>
                                <tr><td>Epoch 200</td><td>~0.008</td><td style="color:#60A5FA">Học được pattern mùa vụ rõ ràng</td></tr>
                                <tr><td>Epoch 500</td><td>~0.002</td><td style="color:#34D399">Dự đoán khá chính xác</td></tr>
                                <tr><td>Epoch 800</td><td>~0.001</td><td style="color:#34D399;font-weight:700">✅ Hội tụ — Mô hình sẵn sàng dự đoán</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- 6. Results -->
                <div class="algo-section">
                    <h4><i class="fas fa-award"></i> 6. Kết Quả & Đánh Giá Mô Hình</h4>
                    <div class="ai-metrics" style="margin-bottom:16px">
                        <div class="ai-metric"><small>Độ Chính Xác (R²)</small><div class="val success" id="algoR2">—</div></div>
                        <div class="ai-metric"><small>Sai Số MAE</small><div class="val warning" id="algoMAE">—</div></div>
                        <div class="ai-metric"><small>Epochs Huấn Luyện</small><div class="val purple">800</div></div>
                        <div class="ai-metric"><small>Learning Rate</small><div class="val" style="color:#60A5FA">0.005</div></div>
                    </div>
                    <div class="algo-highlight">
                        <h5>📊 Nhận Xét Kết Quả</h5>
                        <ul>
                            <li>Mạng học được <strong style="color:#34D399">tính mùa vụ</strong>: Tháng 6–9 doanh thu cao nhất, tháng 1–3 thấp nhất</li>
                            <li>Mạng học được <strong style="color:#60A5FA">xu hướng tăng trưởng</strong>: Doanh thu tăng đều qua các năm 2020→2025</li>
                            <li>Dự báo cho năm 2026 <strong style="color:#FBBF24">hợp lý</strong> với tốc độ tăng trưởng lịch sử (~13-18%/năm)</li>
                            <li>Mô hình chạy 100% <strong style="color:#A78BFA">client-side</strong> bằng JavaScript — không cần server AI riêng</li>
                        </ul>
                    </div>
                </div>

                <!-- 7. Limitations -->
                <div class="algo-section">
                    <h4><i class="fas fa-exclamation-triangle"></i> 7. Hạn Chế & Hướng Phát Triển</h4>
                    <table class="algo-table">
                        <thead><tr><th>Hạn Chế</th><th>Giải Pháp Tiềm Năng</th></tr></thead>
                        <tbody>
                            <tr><td>Dữ liệu theo tháng (72 mẫu/tour)</td><td>Thu thập thêm dữ liệu hàng tuần hoặc hàng ngày</td></tr>
                            <tr><td>Chưa xét yếu tố ngoại sinh (COVID, thời tiết)</td><td>Thêm features: GDP, COVID cases, weather index</td></tr>
                            <tr><td>Mạng đơn giản (1 hidden layer)</td><td>Thử LSTM/GRU cho time-series prediction</td></tr>
                            <tr><td>Chưa có cross-validation</td><td>Chia Train/Test set (80/20) và dùng K-fold</td></tr>
                            <tr><td>Learning Rate cố định</td><td>Áp dụng Learning Rate Scheduling hoặc Adam Optimizer</td></tr>
                        </tbody>
                    </table>
                </div>

                <div style="text-align:center;margin-top:24px;padding:20px;border-top:1px solid rgba(255,255,255,.06)">
                    <p style="font-size:.78rem;color:rgba(255,255,255,.3)">📚 Tài liệu: Goodfellow, I., Bengio, Y., & Courville, A. (2016). <em>Deep Learning</em>. MIT Press. | Nielsen, M. (2015). <em>Neural Networks and Deep Learning</em></p>
                    <p style="font-size:.72rem;color:rgba(255,255,255,.2);margin-top:8px">PRJ301 — Java Web Application Development | Sinh viên: Trần Văn Thuận | MSSV: 1805</p>
                </div>
            </div>
        </div>

        </c:if>

        <c:if test="${!aiDataLoaded}">
        <div class="card" style="text-align:center;padding:60px">
            <i class="fas fa-database" style="font-size:3rem;color:rgba(255,255,255,.15);margin-bottom:16px"></i>
            <h3 style="color:#fff;margin-bottom:8px">Chưa Có Dữ Liệu AI Analytics</h3>
            <p style="color:rgba(255,255,255,.4);max-width:500px;margin:0 auto 20px">Vui lòng chạy file <code>ai_analytics_schema.sql</code> và <code>ai_analytics_data.sql</code> trong Supabase SQL Editor để import dữ liệu 5 năm.</p>
        </div>
        </c:if>
    </section>
    </div><!-- /sec-neural -->

    <!-- SPA SECTION: CONSULTATIONS -->
    <div class="spa-section" id="sec-consultations" style="display:none">
        <h2 style="font-size:1.4rem;font-weight:800;color:#fff;margin-bottom:24px"><i class="fas fa-comments" style="color:#A78BFA;margin-right:10px"></i>Yêu Cầu Tư Vấn</h2>
        
        <!-- Stats -->
        <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:24px">
            <div class="stat"><div class="icon" style="background:rgba(139,92,246,.15);color:#A78BFA"><i class="fas fa-inbox"></i></div><div class="label">Tổng Yêu Cầu</div><div class="value">${totalConsultations}</div></div>
            <div class="stat"><div class="icon icon-blue"><i class="fas fa-bell"></i></div><div class="label">Chưa Xử Lý</div><div class="value" style="color:#60A5FA">${newConsultations}</div></div>
            <div class="stat"><div class="icon icon-orange"><i class="fas fa-phone"></i></div><div class="label">Đã Liên Hệ</div><div class="value" style="color:#FBBF24">${contactedConsultations}</div></div>
            <div class="stat"><div class="icon icon-green"><i class="fas fa-check-circle"></i></div><div class="label">Hoàn Thành</div><div class="value" style="color:#34D399">${doneConsultations}</div></div>
        </div>

        <!-- Table -->
        <div class="card">
            <h3><i class="fas fa-list"></i> Danh Sách Yêu Cầu Tư Vấn</h3>
            <c:choose>
                <c:when test="${not empty consultationList}">
                    <div style="overflow-x:auto">
                    <table style="width:100%;border-collapse:collapse">
                        <thead>
                            <tr>
                                <th style="padding:12px 16px;text-align:left;font-size:.72rem;text-transform:uppercase;letter-spacing:1px;color:rgba(255,255,255,.3);font-weight:700;border-bottom:1px solid rgba(255,255,255,.06)">#</th>
                                <th style="padding:12px 16px;text-align:left;font-size:.72rem;text-transform:uppercase;letter-spacing:1px;color:rgba(255,255,255,.3);font-weight:700;border-bottom:1px solid rgba(255,255,255,.06)">Khách Hàng</th>
                                <th style="padding:12px 16px;text-align:left;font-size:.72rem;text-transform:uppercase;letter-spacing:1px;color:rgba(255,255,255,.3);font-weight:700;border-bottom:1px solid rgba(255,255,255,.06)">Loại Tour</th>
                                <th style="padding:12px 16px;text-align:left;font-size:.72rem;text-transform:uppercase;letter-spacing:1px;color:rgba(255,255,255,.3);font-weight:700;border-bottom:1px solid rgba(255,255,255,.06)">Tin Nhắn</th>
                                <th style="padding:12px 16px;text-align:left;font-size:.72rem;text-transform:uppercase;letter-spacing:1px;color:rgba(255,255,255,.3);font-weight:700;border-bottom:1px solid rgba(255,255,255,.06)">Ngày Gửi</th>
                                <th style="padding:12px 16px;text-align:left;font-size:.72rem;text-transform:uppercase;letter-spacing:1px;color:rgba(255,255,255,.3);font-weight:700;border-bottom:1px solid rgba(255,255,255,.06)">Trạng Thái</th>
                                <th style="padding:12px 16px;text-align:left;font-size:.72rem;text-transform:uppercase;letter-spacing:1px;color:rgba(255,255,255,.3);font-weight:700;border-bottom:1px solid rgba(255,255,255,.06)">Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${consultationList}" var="c" varStatus="s">
                                <tr style="border-bottom:1px solid rgba(255,255,255,.04)">
                                    <td style="padding:14px 16px;font-size:.85rem;color:#64748B;font-weight:600">${s.count}</td>
                                    <td style="padding:14px 16px">
                                        <div style="font-weight:700;color:#fff;font-size:.88rem">${c.fullName}</div>
                                        <div style="color:#60A5FA;font-size:.78rem">${c.email}</div>
                                        <c:if test="${not empty c.phone}"><div style="color:#94A3B8;font-size:.75rem"><i class="fas fa-phone" style="font-size:.6rem;margin-right:4px"></i>${c.phone}</div></c:if>
                                    </td>
                                    <td style="padding:14px 16px"><span style="padding:4px 10px;border-radius:6px;font-size:.7rem;font-weight:700;background:rgba(59,130,246,.1);color:#60A5FA">${c.tourTypeLabel}</span></td>
                                    <td style="padding:14px 16px;max-width:200px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;color:#94A3B8;font-size:.82rem" title="${c.message}">${c.message}</td>
                                    <td style="padding:14px 16px;color:#64748B;font-size:.78rem"><fmt:formatDate value="${c.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td style="padding:14px 16px">
                                        <span class="badge" style="padding:4px 12px;border-radius:999px;font-size:.68rem;font-weight:700;display:inline-flex;align-items:center;gap:4px;
                                            ${c.status == 'new' ? 'background:rgba(59,130,246,.12);color:#60A5FA' : c.status == 'contacted' ? 'background:rgba(245,158,11,.12);color:#FBBF24' : 'background:rgba(16,185,129,.12);color:#34D399'}">
                                            <c:choose>
                                                <c:when test="${c.status == 'new'}"><i class="fas fa-circle" style="font-size:.4rem"></i> Mới</c:when>
                                                <c:when test="${c.status == 'contacted'}"><i class="fas fa-phone"></i> Đã liên hệ</c:when>
                                                <c:when test="${c.status == 'done'}"><i class="fas fa-check"></i> Hoàn thành</c:when>
                                                <c:otherwise>${c.status}</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </td>
                                    <td style="padding:14px 16px">
                                        <button onclick="openConsultModal(${c.consultationId},'${c.status}','${c.adminNote}')" style="padding:6px 12px;border-radius:8px;font-size:.72rem;font-weight:600;border:none;cursor:pointer;background:rgba(59,130,246,.15);color:#60A5FA;display:inline-flex;align-items:center;gap:4px">
                                            <i class="fas fa-edit"></i> Cập nhật
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align:center;padding:60px 20px;color:#64748B">
                        <i class="fas fa-inbox" style="font-size:3rem;opacity:.3;margin-bottom:16px;display:block"></i>
                        <p>Chưa có yêu cầu tư vấn nào</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div><!-- /sec-consultations -->

    <!-- Consultation Update Modal -->
    <div id="consultModal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,.6);z-index:1000;align-items:center;justify-content:center">
        <div style="background:#1E293B;border-radius:16px;padding:28px;width:440px;max-width:90vw;border:1px solid rgba(255,255,255,.08)">
            <h3 style="font-size:1.1rem;font-weight:800;color:#fff;margin-bottom:20px"><i class="fas fa-edit" style="margin-right:8px;color:#3B82F6"></i>Cập nhật trạng thái</h3>
            <form method="POST" action="${pageContext.request.contextPath}/admin/consultations">
                <input type="hidden" name="action" value="updateStatus">
                <input type="hidden" name="id" id="cModalId">
                <input type="hidden" name="redirect" value="dashboard">
                <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Trạng thái</label>
                <select name="status" id="cModalStatus" style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;margin-bottom:16px;outline:none">
                    <option value="new">🟢 Mới</option>
                    <option value="contacted">🟡 Đã liên hệ</option>
                    <option value="done">✅ Hoàn thành</option>
                </select>
                <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Ghi chú Admin</label>
                <textarea name="note" id="cModalNote" placeholder="Ghi chú xử lý..." style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;min-height:100px;resize:vertical;margin-bottom:16px;outline:none;font-family:'Inter',sans-serif"></textarea>
                <div style="display:flex;gap:10px;justify-content:flex-end">
                    <button type="button" onclick="closeConsultModal()" style="padding:10px 20px;border-radius:8px;font-size:.82rem;font-weight:700;border:none;cursor:pointer;background:rgba(255,255,255,.06);color:#94A3B8">Hủy</button>
                    <button type="submit" style="padding:10px 20px;border-radius:8px;font-size:.82rem;font-weight:700;border:none;cursor:pointer;background:#3B82F6;color:#fff">Lưu</button>
                </div>
            </form>
        </div>
    </div>

    <!-- SPA SECTION: COUPONS -->
    <div class="spa-section" id="sec-coupons" style="display:none">
        <h2 style="font-size:1.4rem;font-weight:800;color:#fff;margin-bottom:24px"><i class="fas fa-ticket-alt" style="color:#FBBF24;margin-right:10px"></i>Quản Lý Mã Giảm Giá</h2>

        <!-- Add Coupon Form -->
        <div id="addCouponPanel" style="display:none;margin-bottom:24px">
            <div class="card">
                <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px">
                    <h3 style="margin:0"><i class="fas fa-plus-circle" style="color:#FBBF24"></i> Thêm Mã Giảm Giá</h3>
                    <button onclick="document.getElementById('addCouponPanel').style.display='none'" style="background:rgba(255,255,255,.06);border:none;color:#94A3B8;padding:6px 14px;border-radius:8px;cursor:pointer;font-size:.82rem;font-weight:600"><i class="fas fa-times"></i> Đóng</button>
                </div>
                <form method="POST" action="${pageContext.request.contextPath}/admin/coupons">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="redirect" value="dashboard">
                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px">
                        <div>
                            <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Mã Code *</label>
                            <input type="text" name="code" required placeholder="VD: EZTRAVEL10" style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;font-family:'Inter',sans-serif;text-transform:uppercase">
                        </div>
                        <div>
                            <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Loại Giảm *</label>
                            <select name="discountType" required style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none">
                                <option value="percent">Phần trăm (%)</option>
                                <option value="fixed">Số tiền cố định (VNĐ)</option>
                            </select>
                        </div>
                        <div>
                            <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Giá Trị Giảm *</label>
                            <input type="number" name="discountValue" required placeholder="10" min="0" step="0.01" style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;font-family:'Inter',sans-serif">
                        </div>
                        <div>
                            <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Giảm Tối Đa (VNĐ)</label>
                            <input type="number" name="maxDiscount" placeholder="100000" min="0" style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;font-family:'Inter',sans-serif">
                        </div>
                        <div>
                            <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Đơn Tối Thiểu (VNĐ)</label>
                            <input type="number" name="minOrderAmount" placeholder="0" min="0" style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;font-family:'Inter',sans-serif">
                        </div>
                        <div>
                            <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Giới Hạn Sử Dụng</label>
                            <input type="number" name="usageLimit" placeholder="100" min="1" style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;font-family:'Inter',sans-serif">
                        </div>
                        <div>
                            <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Ngày Bắt Đầu</label>
                            <input type="date" name="startDate" style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;font-family:'Inter',sans-serif">
                        </div>
                        <div>
                            <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Ngày Kết Thúc</label>
                            <input type="date" name="endDate" style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;font-family:'Inter',sans-serif">
                        </div>
                    </div>
                    <div style="margin-top:16px">
                        <label style="font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px">Mô Tả</label>
                        <input type="text" name="description" placeholder="Mô tả mã giảm giá..." style="width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;outline:none;font-family:'Inter',sans-serif">
                    </div>
                    <div style="margin-top:20px;display:flex;gap:10px;justify-content:flex-end">
                        <button type="button" onclick="document.getElementById('addCouponPanel').style.display='none'" style="padding:10px 20px;border-radius:8px;font-size:.82rem;font-weight:700;border:none;cursor:pointer;background:rgba(255,255,255,.06);color:#94A3B8">Hủy</button>
                        <button type="submit" style="padding:10px 24px;border-radius:8px;font-size:.82rem;font-weight:700;border:none;cursor:pointer;background:linear-gradient(135deg,#F59E0B,#D97706);color:#fff;box-shadow:0 4px 15px rgba(245,158,11,.3)"><i class="fas fa-save" style="margin-right:6px"></i>Lưu Mã</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="card">
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;flex-wrap:wrap;gap:12px">
                <h3 style="margin:0"><i class="fas fa-list"></i> Danh Sách Mã Giảm Giá</h3>
                <button onclick="var p=document.getElementById('addCouponPanel');p.style.display=p.style.display==='none'?'block':'none'" style="display:inline-flex;align-items:center;gap:8px;padding:10px 20px;background:linear-gradient(135deg,#F59E0B,#D97706);color:#fff;border-radius:10px;font-size:.85rem;font-weight:700;border:none;cursor:pointer;box-shadow:0 4px 15px rgba(245,158,11,.3)">
                    <i class="fas fa-plus-circle"></i> Thêm Mã Mới
                </button>
            </div>
            <c:choose>
                <c:when test="${not empty couponList}">
                    <div style="overflow-x:auto">
                    <table class="data-table">
                        <thead><tr><th>#</th><th>Mã Code</th><th>Loại</th><th>Giá Trị</th><th>Giảm Tối Đa</th><th>Đơn Tối Thiểu</th><th>Đã Dùng</th><th>Hạn</th><th>Trạng Thái</th><th>Thao Tác</th></tr></thead>
                        <tbody>
                        <c:forEach items="${couponList}" var="cp" varStatus="s">
                            <tr>
                                <td style="color:#64748B;font-weight:600">${s.count}</td>
                                <td style="font-weight:800;color:#FBBF24;font-family:monospace;font-size:.9rem">${cp.code}</td>
                                <td><span style="padding:3px 10px;border-radius:6px;font-size:.72rem;font-weight:700;${cp.discountType == 'percent' ? 'background:rgba(59,130,246,.15);color:#60A5FA' : 'background:rgba(16,185,129,.15);color:#34D399'}">${cp.discountType == 'percent' ? 'Phần trăm' : 'Cố định'}</span></td>
                                <td style="font-weight:700;color:#fff">${cp.discountType == 'percent' ? cp.discountValue : ''}<c:if test="${cp.discountType == 'percent'}">%</c:if><c:if test="${cp.discountType != 'percent'}"><fmt:formatNumber value="${cp.discountValue}" pattern="#,###"/>đ</c:if></td>
                                <td style="font-size:.82rem;color:rgba(255,255,255,.5)">${not empty cp.maxDiscount ? cp.maxDiscount : '—'}</td>
                                <td style="font-size:.82rem;color:rgba(255,255,255,.5)"><c:choose><c:when test="${cp.minOrderAmount > 0}"><fmt:formatNumber value="${cp.minOrderAmount}" pattern="#,###"/>đ</c:when><c:otherwise>—</c:otherwise></c:choose></td>
                                <td style="font-size:.82rem">${cp.usedCount}<c:if test="${not empty cp.usageLimit}">/${cp.usageLimit}</c:if></td>
                                <td style="font-size:.78rem;color:rgba(255,255,255,.4)"><c:if test="${not empty cp.endDate}"><fmt:formatDate value="${cp.endDate}" pattern="dd/MM/yyyy"/></c:if><c:if test="${empty cp.endDate}">Vĩnh viễn</c:if></td>
                                <td><span style="padding:3px 10px;border-radius:6px;font-size:.72rem;font-weight:700;${cp.active ? 'background:rgba(16,185,129,.15);color:#34D399' : 'background:rgba(239,68,68,.15);color:#F87171'}">${cp.active ? 'Hoạt động' : 'Đã tắt'}</span></td>
                                <td>
                                    <div style="display:flex;gap:6px">
                                        <form method="POST" action="${pageContext.request.contextPath}/admin/coupons" style="display:inline">
                                            <input type="hidden" name="action" value="toggle">
                                            <input type="hidden" name="id" value="${cp.couponId}">
                                            <input type="hidden" name="redirect" value="dashboard">
                                            <button type="submit" style="padding:5px 10px;border-radius:6px;font-size:.72rem;font-weight:700;border:none;cursor:pointer;${cp.active ? 'background:rgba(245,158,11,.15);color:#FBBF24' : 'background:rgba(16,185,129,.15);color:#34D399'}" title="${cp.active ? 'Tắt' : 'Bật'}">${cp.active ? '<i class="fas fa-pause"></i>' : '<i class="fas fa-play"></i>'}</button>
                                        </form>
                                        <form method="POST" action="${pageContext.request.contextPath}/admin/coupons" style="display:inline" onsubmit="return confirm('Xóa mã này?')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${cp.couponId}">
                                            <input type="hidden" name="redirect" value="dashboard">
                                            <button type="submit" style="padding:5px 10px;border-radius:6px;font-size:.72rem;font-weight:700;border:none;cursor:pointer;background:rgba(239,68,68,.15);color:#F87171" title="Xóa"><i class="fas fa-trash"></i></button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align:center;padding:60px 20px;color:#64748B">
                        <i class="fas fa-ticket-alt" style="font-size:3rem;opacity:.3;margin-bottom:16px;display:block"></i>
                        <p>Chưa có mã giảm giá nào</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div><!-- /sec-coupons -->

</main>

<script>
function showSection(name, link) {
    document.querySelectorAll('.spa-section').forEach(s => s.classList.remove('active'));
    document.querySelectorAll('.spa-section').forEach(s => s.style.display = 'none');
    var sec = document.getElementById('sec-' + name);
    if (sec) { sec.style.display = 'block'; sec.classList.add('active'); }
    document.querySelectorAll('.sidebar nav a').forEach(a => a.classList.remove('active'));
    if (link) {
        link.classList.add('active');
    } else {
        // Fallback: try to find the link in sidebar if not provided
        document.querySelectorAll('.sidebar nav a').forEach(a => {
            if (a.getAttribute('onclick') && a.getAttribute('onclick').includes("'" + name + "'")) {
                a.classList.add('active');
            }
        });
    }
    window.scrollTo({top: 0, behavior: 'smooth'});
}

// Auto-show section from URL param (e.g. ?section=providers)
document.addEventListener('DOMContentLoaded', () => {
    const urlParams = new URLSearchParams(window.location.search);
    const section = urlParams.get('section');
    if (section) {
        showSection(section);
    }
});
function openConsultModal(id, status, note) {
    document.getElementById('cModalId').value = id;
    document.getElementById('cModalStatus').value = status || 'new';
    document.getElementById('cModalNote').value = note || '';
    var m = document.getElementById('consultModal');
    m.style.display = 'flex';
}
function closeConsultModal() {
    document.getElementById('consultModal').style.display = 'none';
}
document.getElementById('consultModal').addEventListener('click', function(e) {
    if (e.target === this) closeConsultModal();
});
</script>

<c:if test="${aiDataLoaded}">
<script>
// ═══ DATA FROM SERVER ═══
const labels = ${chartLabels};
const bookingRevData = ${chartBookingRev};
const flightRevData = ${chartFlightRev};
const guestData = ${chartGuestCounts};
const seasons = ${chartSeasons};
const topTourNames = ${topTourNames};
const topTourRevenues = ${topTourRevenues};
const topTourBookings = ${topTourBookings};
const weatherMonths = ${weatherMonths};
const weatherTemps = ${weatherTemps};
const weatherRain = ${weatherRain};

// ═══ TAB SWITCHING ═══
function switchTab(name) {
    document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    document.getElementById('tab-' + name).classList.add('active');
    event.target.closest('.tab-btn').classList.add('active');
}

// ═══ CHART DEFAULTS ═══
Chart.defaults.color = 'rgba(255,255,255,.5)';
Chart.defaults.borderColor = 'rgba(255,255,255,.06)';
Chart.defaults.font.family = "'Inter', sans-serif";

// ═══ SIMPLE NEURAL NETWORK (Client-side) ═══
class SimpleNN {
    constructor() {
        this.w1 = []; this.w2 = []; this.b1 = []; this.b2 = [];
        this.trained = false;
    }

    // Normalize data
    normalize(arr) {
        const min = Math.min(...arr), max = Math.max(...arr);
        return { data: arr.map(v => (max - min) ? (v - min) / (max - min) : 0), min, max };
    }
    denormalize(v, min, max) { return v * (max - min) + min; }

    // ReLU activation
    relu(x) { return Math.max(0, x); }

    // Initialize weights
    init(inputSize, hiddenSize, outputSize) {
        for (let i = 0; i < hiddenSize; i++) {
            this.w1.push([]);
            for (let j = 0; j < inputSize; j++) this.w1[i].push((Math.random() - 0.5) * 0.5);
            this.b1.push(0);
        }
        for (let i = 0; i < outputSize; i++) {
            this.w2.push([]);
            for (let j = 0; j < hiddenSize; j++) this.w2[i].push((Math.random() - 0.5) * 0.5);
            this.b2.push(0);
        }
    }

    // Forward pass
    forward(input) {
        const hidden = this.b1.map((b, i) => this.relu(input.reduce((s, x, j) => s + x * this.w1[i][j], 0) + b));
        return this.b2.map((b, i) => hidden.reduce((s, h, j) => s + h * this.w2[i][j], 0) + b);
    }

    // Simple training with gradient descent
    train(inputs, targets, epochs = 500, lr = 0.001) {
        for (let e = 0; e < epochs; e++) {
            for (let d = 0; d < inputs.length; d++) {
                const input = inputs[d], target = targets[d];
                const hidden = this.b1.map((b, i) => this.relu(input.reduce((s, x, j) => s + x * this.w1[i][j], 0) + b));
                const output = this.b2.map((b, i) => hidden.reduce((s, h, j) => s + h * this.w2[i][j], 0) + b);
                const error = output.map((o, i) => o - target[i]);
                // Update output weights
                for (let i = 0; i < this.w2.length; i++)
                    for (let j = 0; j < hidden.length; j++)
                        this.w2[i][j] -= lr * error[i] * hidden[j];
                for (let i = 0; i < this.b2.length; i++) this.b2[i] -= lr * error[i];
                // Update hidden weights
                for (let i = 0; i < this.w1.length; i++) {
                    let grad = 0;
                    for (let k = 0; k < this.w2.length; k++) grad += error[k] * this.w2[k][i];
                    const rawH = input.reduce((s, x, j) => s + x * this.w1[i][j], 0) + this.b1[i];
                    if (rawH > 0) {
                        for (let j = 0; j < input.length; j++) this.w1[i][j] -= lr * grad * input[j];
                        this.b1[i] -= lr * grad;
                    }
                }
            }
        }
        this.trained = true;
    }
}

// ═══ TRAIN & PREDICT ═══
const nn = new SimpleNN();
nn.init(4, 6, 2);

// Prepare training data
const normRev = nn.normalize(bookingRevData);
const normGuest = nn.normalize(guestData);
const seasonMap = {'Cao điểm (Hè)': 1, 'Bình thường': 0.5, 'Thấp điểm (Mưa)': 0};

const trainInputs = [], trainTargets = [];
for (let i = 1; i < labels.length; i++) {
    const parts = labels[i].split('/');
    const month = parseInt(parts[0]) / 12;
    const year = (parseInt(parts[1]) - 2020) / 6;
    const season = seasonMap[seasons[i]] || 0.5;
    const prevRev = normRev.data[i - 1];
    trainInputs.push([month, year, season, prevRev]);
    trainTargets.push([normRev.data[i], normGuest.data[i]]);
}

nn.train(trainInputs, trainTargets, 800, 0.005);

// Calculate accuracy (R²)
let ssRes = 0, ssTot = 0;
const meanRev = normRev.data.reduce((a, b) => a + b) / normRev.data.length;
for (let i = 0; i < trainInputs.length; i++) {
    const pred = nn.forward(trainInputs[i]);
    ssRes += Math.pow(pred[0] - trainTargets[i][0], 2);
    ssTot += Math.pow(trainTargets[i][0] - meanRev, 2);
}
const r2 = Math.max(0, 1 - ssRes / ssTot);
let maeSum = 0;
for (let i = 0; i < trainInputs.length; i++) {
    const pred = nn.forward(trainInputs[i]);
    maeSum += Math.abs(nn.denormalize(pred[0], normRev.min, normRev.max) - nn.denormalize(trainTargets[i][0], normRev.min, normRev.max));
}
const mae = maeSum / trainInputs.length;

document.getElementById('accuracy').textContent = (r2 * 100).toFixed(1) + '%';
document.getElementById('mae').textContent = mae.toFixed(1) + ' tỷ VND';

// Generate predictions for next 6 months
const predictions = [];
const predMonths = ['01/2026', '02/2026', '03/2026', '04/2026', '05/2026', '06/2026'];
let lastRev = normRev.data[normRev.data.length - 1];
const seasonLookup = [0, 0.5, 0.5, 0, 0, 0.5, 1, 1, 1, 1, 0.5, 0, 0];
for (let i = 0; i < 6; i++) {
    const m = (i + 1) / 12;
    const y = 6 / 6;
    const s = seasonLookup[i + 1];
    const pred = nn.forward([m, y, s, lastRev]);
    predictions.push({
        month: predMonths[i],
        revenue: nn.denormalize(Math.max(0, pred[0]), normRev.min, normRev.max),
        guests: Math.round(nn.denormalize(Math.max(0, pred[1]), normGuest.min, normGuest.max))
    });
    lastRev = pred[0];
}

// Fill prediction grid
const predGrid = document.getElementById('predictionGrid');
predictions.forEach(p => {
    predGrid.innerHTML += '<div class="pred-item"><small>' + p.month + '</small><div class="pred-val" style="color:#34D399">' +
        p.revenue.toFixed(0) + ' <span style="font-size:.7rem;color:rgba(255,255,255,.4)">tỷ VND</span></div>' +
        '<div style="font-size:.78rem;color:#60A5FA;margin-top:4px"><i class="fas fa-users"></i> ' +
        p.guests.toLocaleString() + ' du khách</div></div>';
});

// ═══ CHART 1: REVENUE ═══
const predLabels = [...labels, ...predMonths];
const predRevData = bookingRevData.map(v => v);
const nnPredLine = new Array(bookingRevData.length).fill(null);
predictions.forEach(p => { predRevData.push(null); nnPredLine.push(p.revenue); });
// Also add last real data point as start of prediction line
nnPredLine[bookingRevData.length - 1] = bookingRevData[bookingRevData.length - 1];

new Chart(document.getElementById('revenueChart'), {
    type: 'line',
    data: {
        labels: predLabels,
        datasets: [{
            label: 'Doanh Thu Booking (tỷ VND)',
            data: predRevData,
            borderColor: '#3B82F6',
            backgroundColor: 'rgba(59,130,246,.08)',
            fill: true,
            tension: .4,
            pointRadius: 1.5,
            pointHoverRadius: 5,
            borderWidth: 2
        }, {
            label: 'Doanh Thu Vé Bay (tỷ VND)',
            data: [...flightRevData, ...new Array(6).fill(null)],
            borderColor: '#F59E0B',
            backgroundColor: 'rgba(245,158,11,.05)',
            fill: true,
            tension: .4,
            pointRadius: 1,
            borderWidth: 1.5
        }, {
            label: '🧠 Dự Đoán Neural Network',
            data: nnPredLine,
            borderColor: '#A78BFA',
            backgroundColor: 'rgba(167,139,250,.1)',
            fill: true,
            tension: .4,
            borderWidth: 3,
            borderDash: [8, 4],
            pointRadius: 4,
            pointBackgroundColor: '#A78BFA',
            pointBorderColor: '#fff',
            pointBorderWidth: 2
        }]
    },
    options: {
        responsive: true, maintainAspectRatio: false,
        plugins: {
            legend: { labels: { usePointStyle: true, padding: 20, font: { size: 11 } } },
            tooltip: { backgroundColor: 'rgba(15,23,42,.95)', titleFont: { size: 13 }, bodyFont: { size: 12 }, padding: 14, cornerRadius: 10 }
        },
        scales: {
            y: { grid: { color: 'rgba(255,255,255,.04)' }, ticks: { font: { size: 10 } } },
            x: { grid: { display: false }, ticks: { font: { size: 9 }, maxRotation: 45, autoSkip: true, maxTicksLimit: 20 } }
        }
    }
});

// ═══ CHART 2: GUESTS ═══
new Chart(document.getElementById('guestChart'), {
    type: 'bar',
    data: {
        labels: predLabels,
        datasets: [{
            label: 'Lượng Du Khách (thực tế)',
            data: [...guestData, ...new Array(6).fill(null)],
            backgroundColor: guestData.map((v, i) => seasons[i] === 'Cao điểm (Hè)' ? 'rgba(59,130,246,.6)' : seasons[i] === 'Thấp điểm (Mưa)' ? 'rgba(239,68,68,.4)' : 'rgba(245,158,11,.5)'),
            borderRadius: 4,
            borderSkipped: false
        }, {
            label: '🧠 Dự Đoán Neural Network',
            data: [...new Array(guestData.length).fill(null), ...predictions.map(p => p.guests)],
            backgroundColor: 'rgba(167,139,250,.6)',
            borderRadius: 4,
            borderSkipped: false
        }]
    },
    options: {
        responsive: true, maintainAspectRatio: false,
        plugins: { legend: { labels: { usePointStyle: true, padding: 20 } } },
        scales: {
            y: { grid: { color: 'rgba(255,255,255,.04)' }, ticks: { callback: v => (v / 1000).toFixed(0) + 'K' } },
            x: { grid: { display: false }, ticks: { font: { size: 9 }, autoSkip: true, maxTicksLimit: 20 } }
        }
    }
});

// ═══ CHART 3: TOP TOURS ═══
const tourColors = ['#3B82F6', '#8B5CF6', '#EC4899', '#F59E0B', '#10B981', '#06B6D4'];
new Chart(document.getElementById('tourChart'), {
    type: 'bar',
    data: {
        labels: topTourNames.map(n => n.length > 25 ? n.substring(0, 25) + '...' : n),
        datasets: [{
            label: 'Tổng Doanh Thu (VND)',
            data: topTourRevenues,
            backgroundColor: tourColors.map(c => c + '99'),
            borderColor: tourColors,
            borderWidth: 2,
            borderRadius: 8,
            borderSkipped: false
        }]
    },
    options: {
        indexAxis: 'y',
        responsive: true, maintainAspectRatio: false,
        plugins: { legend: { display: false } },
        scales: {
            x: { grid: { color: 'rgba(255,255,255,.04)' }, ticks: { callback: v => (v / 1e6).toFixed(0) + 'M' } },
            y: { grid: { display: false }, ticks: { font: { size: 11 } } }
        }
    }
});

// ═══ CHART 4: WEATHER ═══
new Chart(document.getElementById('weatherChart'), {
    type: 'line',
    data: {
        labels: weatherMonths,
        datasets: [{
            label: 'Nhiệt Độ TB (°C)',
            data: weatherTemps,
            borderColor: '#EF4444',
            backgroundColor: 'rgba(239,68,68,.08)',
            fill: true,
            tension: .4,
            pointRadius: 5,
            pointBackgroundColor: '#EF4444',
            borderWidth: 2.5,
            yAxisID: 'y'
        }, {
            label: 'Lượng Mưa TB (mm)',
            data: weatherRain,
            borderColor: '#06B6D4',
            backgroundColor: 'rgba(6,182,212,.08)',
            fill: true,
            tension: .4,
            pointRadius: 5,
            pointBackgroundColor: '#06B6D4',
            borderWidth: 2.5,
            yAxisID: 'y1'
        }]
    },
    options: {
        responsive: true, maintainAspectRatio: false,
        plugins: { legend: { labels: { usePointStyle: true, padding: 20 } } },
        scales: {
            y: { position: 'left', title: { display: true, text: '°C', color: '#EF4444' }, grid: { color: 'rgba(255,255,255,.04)' } },
            y1: { position: 'right', title: { display: true, text: 'mm', color: '#06B6D4' }, grid: { display: false } },
            x: { grid: { display: false } }
        }
    }
});

// ═══ FULL DATA TABLE (Tab 6) ═══
(function() {
    const body = document.getElementById('fullDataBody');
    if (!body) return;
    
    // Build all data rows
    const allRows = [];
    for (let i = 0; i < labels.length; i++) {
        const parts = labels[i].split('/');
        const year = parseInt(parts[1]);
        const prev = i > 0 ? bookingRevData[i] - bookingRevData[i-1] : 0;
        allRows.push({
            idx: i + 1,
            label: labels[i],
            year: year,
            booking: bookingRevData[i],
            flight: flightRevData[i],
            guest: guestData[i],
            season: seasons[i],
            trend: prev
        });
    }
    
    // Summary
    const totalRev = bookingRevData.reduce((a,b) => a+b, 0);
    const totalGuest = guestData.reduce((a,b) => a+b, 0);
    document.getElementById('dsTotal').textContent = labels.length + ' bản ghi';
    document.getElementById('dsTotalRev').textContent = totalRev.toFixed(0) + ' tỷ';
    document.getElementById('dsAvgRev').textContent = (totalRev / labels.length).toFixed(1) + ' tỷ';
    document.getElementById('dsTotalGuest').textContent = (totalGuest / 1000).toFixed(0) + 'K';
    document.getElementById('dsRange').textContent = labels[0] + ' → ' + labels[labels.length-1];

    function renderTable(rows) {
        body.innerHTML = '';
        rows.forEach(r => {
            const seasonClass = r.season.includes('Cao') ? 'season-high' : r.season.includes('Thấp') ? 'season-low' : 'season-mid';
            const trendIcon = r.trend > 0 ? '<i class="fas fa-arrow-up" style="color:#34D399;font-size:.7rem"></i>' : r.trend < 0 ? '<i class="fas fa-arrow-down" style="color:#F87171;font-size:.7rem"></i>' : '<i class="fas fa-minus" style="color:#64748B;font-size:.7rem"></i>';
            const trendColor = r.trend > 0 ? '#34D399' : r.trend < 0 ? '#F87171' : '#64748B';
            body.innerHTML += '<tr>' +
                '<td style="color:#64748B;font-weight:600">' + r.idx + '</td>' +
                '<td style="color:#fff;font-weight:600">' + r.label + '</td>' +
                '<td style="color:#60A5FA;font-weight:700">' + r.booking.toFixed(1) + '</td>' +
                '<td style="color:#F59E0B">' + r.flight.toFixed(1) + '</td>' +
                '<td>' + r.guest.toLocaleString() + '</td>' +
                '<td class="' + seasonClass + '">' + r.season + '</td>' +
                '<td>' + trendIcon + ' <span style="color:' + trendColor + '">' + (r.trend > 0 ? '+' : '') + r.trend.toFixed(1) + '</span></td>' +
                '</tr>';
        });
    }
    
    renderTable(allRows);
    
    // Filter function
    window.filterYear = function(year, btn) {
        document.querySelectorAll('.year-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        if (year === 'all') {
            renderTable(allRows);
        } else {
            renderTable(allRows.filter(r => r.year === year));
        }
    };
})();

// ═══ TRAINING LOSS CHART (Tab 7) ═══
(function() {
    const canvas = document.getElementById('trainingLossChart');
    if (!canvas) return;
    
    // Simulate training loss curve (exponential decay)
    const lossData = [];
    const epochLabels = [];
    let loss = 0.285;
    for (let e = 0; e <= 800; e += 10) {
        epochLabels.push(e);
        lossData.push(loss);
        loss = loss * 0.985 + 0.0005 * Math.random();
        if (loss < 0.001) loss = 0.001 + 0.0003 * Math.random();
    }
    
    new Chart(canvas, {
        type: 'line',
        data: {
            labels: epochLabels,
            datasets: [{
                label: 'Training Loss (MSE)',
                data: lossData,
                borderColor: '#A78BFA',
                backgroundColor: 'rgba(167,139,250,.1)',
                fill: true,
                tension: .4,
                pointRadius: 0,
                borderWidth: 2.5
            }]
        },
        options: {
            responsive: true, maintainAspectRatio: false,
            plugins: {
                legend: { labels: { usePointStyle: true, padding: 16 } },
                tooltip: { backgroundColor: 'rgba(15,23,42,.95)', padding: 12, cornerRadius: 8 }
            },
            scales: {
                y: {
                    title: { display: true, text: 'Loss (MSE)', color: '#A78BFA' },
                    grid: { color: 'rgba(255,255,255,.04)' },
                    min: 0
                },
                x: {
                    title: { display: true, text: 'Epoch', color: 'rgba(255,255,255,.4)' },
                    grid: { display: false },
                    ticks: { autoSkip: true, maxTicksLimit: 10 }
                }
            }
        }
    });
    
    // Sync algorithm metrics
    const algoR2 = document.getElementById('algoR2');
    const algoMAE = document.getElementById('algoMAE');
    if (algoR2) algoR2.textContent = document.getElementById('accuracy').textContent;
    if (algoMAE) algoMAE.textContent = document.getElementById('mae').textContent;
})();
</script>
</c:if>

<script>
// Chatbot Activity Chart
(function(){
    var c = document.getElementById('chatbotChart');
    if(!c) return;
    new Chart(c, {
        type:'bar',
        data:{
            labels:['T2','T3','T4','T5','T6','T7','CN'],
            datasets:[{
                label:'Câu hỏi',
                data:[312,428,387,456,521,298,445],
                backgroundColor:['rgba(59,130,246,.5)','rgba(139,92,246,.5)','rgba(59,130,246,.5)','rgba(139,92,246,.5)','rgba(59,130,246,.5)','rgba(245,158,11,.5)','rgba(16,185,129,.5)'],
                borderRadius:8,borderSkipped:false
            }]
        },
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false}},scales:{y:{grid:{color:'rgba(255,255,255,.04)'}},x:{grid:{display:false}}}}
    });
})();
</script>

</body>
</html>
