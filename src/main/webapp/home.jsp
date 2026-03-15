<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>eztravel | Đặt Tour Du Lịch Đà Nẵng</title>
                <link
                    href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=Playfair+Display:wght@700;800;900&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
                <style>
                    /* ═══ RESET ═══ */
                    *,
                    *::before,
                    *::after {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box
                    }

                    html {
                        scroll-behavior: smooth
                    }

                    body {
                        font-family: 'Inter', system-ui, sans-serif;
                        background: #F7F8FC;
                        color: #1B1F3B;
                        line-height: 1.65;
                        -webkit-font-smoothing: antialiased;
                        overflow-x: hidden
                    }

                    a {
                        text-decoration: none;
                        color: inherit;
                        transition: .3s
                    }

                    img {
                        max-width: 100%;
                        display: block
                    }

                    ul {
                        list-style: none
                    }

                    /* ═══ HERO — PREMIUM TRAVEL 2026 ═══ */
                    .hero{position:relative;min-height:92vh;display:flex;align-items:center;justify-content:center;overflow:hidden;padding:120px 0 60px}
                    .hero-bg{position:absolute;inset:0;z-index:0;background:url('${pageContext.request.contextPath}/images/hero-bg.jpg') center/cover no-repeat}
                    .hero-video{position:absolute;inset:0;width:100%;height:100%;object-fit:cover;z-index:0;opacity:0;transition:opacity 1.5s ease}
                    .hero-video.loaded{opacity:1}
                    .hero-overlay{position:absolute;inset:0;background:linear-gradient(180deg,rgba(10,15,30,.35) 0%,rgba(10,15,30,.25) 30%,rgba(10,15,30,.55) 70%,rgba(10,15,30,.85) 100%);z-index:1}
                    .hero-overlay::before{content:'';position:absolute;inset:0;background:radial-gradient(ellipse at 50% 40%,transparent 0%,rgba(10,15,30,.3) 100%)}
                    .hero::after{content:'';position:absolute;bottom:0;left:0;right:0;height:150px;background:linear-gradient(transparent,#F7F8FC);z-index:2}

                    .hero-content{position:relative;z-index:3;max-width:920px;margin:0 auto;padding:0 24px;width:100%;text-align:center}

                    /* Badge */
                    .hero-badge{display:inline-flex;align-items:center;gap:8px;padding:8px 22px;background:rgba(255,255,255,.06);backdrop-filter:blur(20px) saturate(180%);-webkit-backdrop-filter:blur(20px) saturate(180%);border:1px solid rgba(255,255,255,.1);border-radius:999px;font-size:.76rem;font-weight:600;color:rgba(255,255,255,.92);margin-bottom:28px;animation:heroFadeUp .7s ease;letter-spacing:.2px}
                    .hero-badge .dot{width:7px;height:7px;background:#34D399;border-radius:50%;animation:dotPulse 2s ease infinite;box-shadow:0 0 8px rgba(52,211,153,.5)}
                    @keyframes dotPulse{0%,100%{opacity:1;transform:scale(1)}50%{opacity:.4;transform:scale(1.6)}}

                    /* Title */
                    .hero-content h1{font-family:'Playfair Display',serif;font-size:clamp(1.6rem,4.5vw,3.2rem);font-weight:900;color:#fff;line-height:1.15;margin-bottom:18px;text-shadow:0 4px 20px rgba(0,0,0,.25);letter-spacing:-.01em;animation:heroFadeUp .7s ease .1s both}
                    .hero-content h1 .hero-accent{color:#FFD166;position:relative;text-shadow:0 0 20px rgba(255,209,102,.4),0 4px 20px rgba(0,0,0,.3)}
                    .hero-content h1 .hero-accent::after{content:'';position:absolute;bottom:-4px;left:0;right:0;height:3px;background:linear-gradient(90deg,#FFD166,#FF9F1C);border-radius:2px;opacity:.8}
                    .hero-content>p.hero-sub{font-size:1.02rem;color:rgba(255,255,255,.7);max-width:560px;margin:0 auto 36px;line-height:1.75;animation:heroFadeUp .7s ease .18s both;font-weight:400}

                    @keyframes heroFadeUp{from{opacity:0;transform:translateY(24px)}to{opacity:1;transform:translateY(0)}}

                    /* SEARCH PANEL — Premium Glass */
                    .search-panel{position:relative;background:rgba(255,255,255,.92);backdrop-filter:blur(28px) saturate(200%);-webkit-backdrop-filter:blur(28px) saturate(200%);border-radius:20px;max-width:880px;margin:0 auto;box-shadow:0 25px 80px rgba(0,0,0,.2),0 0 0 1px rgba(255,255,255,.4) inset;animation:heroFadeUp .7s ease .25s both;overflow:hidden}
                    .search-panel::before{content:'';position:absolute;top:0;left:0;right:0;height:1px;background:linear-gradient(90deg,transparent 5%,rgba(255,255,255,.95) 50%,transparent 95%);z-index:5}

                    .search-row{display:flex;align-items:stretch;position:relative;z-index:5}
                    .search-field{flex:1;padding:20px 22px;position:relative;transition:background .3s}
                    .search-field:hover{background:rgba(37,99,235,.02)}
                    .search-field+.search-field{border-left:1px solid rgba(0,0,0,.06)}
                    .search-field-label{display:flex;align-items:center;gap:7px;font-size:.68rem;font-weight:800;color:#374151;margin-bottom:8px;letter-spacing:.6px;text-transform:uppercase}
                    .search-field-label i{width:22px;height:22px;display:flex;align-items:center;justify-content:center;border-radius:6px;font-size:.62rem}
                    .search-field-label i.fa-map-marker-alt{background:rgba(239,68,68,.1);color:#EF4444}
                    .search-field-label i.fa-calendar-alt{background:rgba(37,99,235,.1);color:#2563EB}
                    .search-field-label i.fa-wallet{background:rgba(16,185,129,.1);color:#10B981}
                    .search-field input,.search-field select{border:none;outline:none;font-size:.9rem;width:100%;background:transparent;color:#111827;font-family:'Inter',sans-serif;font-weight:500}
                    .search-field input::placeholder{color:#9CA3AF;font-weight:400}
                    .search-field select{cursor:pointer;-webkit-appearance:none;appearance:none;color:#6B7280}
                    .search-actions{display:flex;align-items:center;padding:0 16px}
                    .search-btn{position:relative;padding:15px 36px;background:linear-gradient(135deg,#2563EB 0%,#3B82F6 50%,#60A5FA 100%);color:#fff;border:none;border-radius:14px;font-weight:700;font-size:.88rem;cursor:pointer;display:flex;align-items:center;gap:8px;font-family:'Inter',sans-serif;transition:all .35s cubic-bezier(.4,0,.2,1);white-space:nowrap;box-shadow:0 8px 28px rgba(37,99,235,.35);overflow:hidden;letter-spacing:.2px}
                    .search-btn::before{content:'';position:absolute;top:0;left:-100%;width:100%;height:100%;background:linear-gradient(90deg,transparent,rgba(255,255,255,.2),transparent);transition:.7s}
                    .search-btn:hover::before{left:100%}
                    .search-btn:hover{transform:translateY(-3px) scale(1.02);box-shadow:0 12px 36px rgba(37,99,235,.45)}
                    .search-btn:active{transform:translateY(0) scale(.98)}

                    /* SEARCH TABS */
                    .search-tabs{display:flex;align-items:center;gap:0;border-bottom:1px solid rgba(0,0,0,.06);padding:0 8px;position:relative;z-index:5;background:rgba(248,250,252,.6)}
                    .search-tab{display:flex;align-items:center;gap:7px;padding:15px 20px;font-size:.82rem;font-weight:600;color:#6B7280;border-bottom:2.5px solid transparent;transition:all .3s;text-decoration:none;white-space:nowrap;position:relative}
                    .search-tab:hover{color:#2563EB;background:rgba(37,99,235,.03)}
                    .search-tab.active{color:#2563EB;border-bottom-color:#2563EB;font-weight:700;background:rgba(37,99,235,.04)}
                    .search-tab i{font-size:.78rem;width:20px;text-align:center}

                    /* Popular Destinations */
                    .hero-popular{display:flex;align-items:center;justify-content:center;gap:8px;margin-top:22px;animation:heroFadeUp .7s ease .38s both;flex-wrap:wrap}
                    .hero-popular-label{font-size:.72rem;color:rgba(255,255,255,.5);font-weight:600;letter-spacing:.3px}
                    .hero-popular-tag{padding:6px 14px;background:rgba(255,255,255,.08);backdrop-filter:blur(10px);border:1px solid rgba(255,255,255,.1);border-radius:999px;font-size:.72rem;font-weight:600;color:rgba(255,255,255,.85);cursor:pointer;transition:all .3s;text-decoration:none}
                    .hero-popular-tag:hover{background:rgba(255,255,255,.18);border-color:rgba(255,255,255,.25);transform:translateY(-2px);color:#fff}
                    .hero-popular-tag i{margin-right:4px;font-size:.65rem}

                    /* Scroll Indicator */
                    .scroll-hint{display:flex;flex-direction:column;align-items:center;cursor:pointer;margin-top:32px;animation:heroFadeUp .7s ease .45s both;transition:opacity .3s}
                    .scroll-hint:hover{opacity:.9}
                    .scroll-hint:hover .scroll-arrow{transform:translateY(5px)}
                    .scroll-hint-text{font-size:.68rem;color:rgba(255,255,255,.45);letter-spacing:.15em;text-transform:uppercase;font-weight:600;margin-bottom:8px}
                    .scroll-arrow{width:32px;height:32px;border-radius:50%;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.1);display:flex;align-items:center;justify-content:center;color:rgba(255,255,255,.5);font-size:.75rem;transition:all .3s;animation:scrollFloat 2.5s ease-in-out infinite}
                    @keyframes scrollFloat{0%,100%{transform:translateY(0)}50%{transform:translateY(6px)}}

                    /* ═══ HERO RESPONSIVE ═══ */
                    @media(max-width:1024px){
                        .hero{min-height:85vh;padding:100px 0 50px}
                        .hero-content{max-width:760px}
                        .search-panel{max-width:720px}
                    }
                    @media(max-width:768px){
                        .hero{min-height:auto;padding:90px 0 40px}
                        .hero-content{padding:0 16px}
                        .hero-content h1{font-size:clamp(1.4rem,5vw,2rem);white-space:normal;line-height:1.25}
                        .hero-content>p.hero-sub{font-size:.9rem;margin-bottom:24px;max-width:420px}
                        .hero-badge{font-size:.7rem;padding:6px 16px;margin-bottom:20px}
                        .search-panel{border-radius:16px;margin:0 4px}
                        .search-tabs{overflow-x:auto;-webkit-overflow-scrolling:touch;scrollbar-width:none;gap:0;padding:0 4px}
                        .search-tabs::-webkit-scrollbar{display:none}
                        .search-tab{padding:12px 14px;font-size:.76rem;flex-shrink:0}
                        .search-row{flex-direction:column}
                        .search-field+.search-field{border-left:none;border-top:1px solid rgba(0,0,0,.05)}
                        .search-field{padding:14px 18px}
                        .search-actions{padding:10px 16px 16px}
                        .search-btn{width:100%;justify-content:center;padding:14px;border-radius:12px}
                        .hero-popular{gap:6px}
                        .hero-popular-tag{padding:5px 12px;font-size:.68rem}
                        .scroll-hint{margin-top:20px}
                    }
                    @media(max-width:640px){
                        .hero{padding:80px 0 30px}
                        .hero-content h1{font-size:1.35rem}
                        .hero-content>p.hero-sub{font-size:.84rem;line-height:1.65}
                        .search-field-label{font-size:.64rem}
                        .search-field input,.search-field select{font-size:.84rem}
                    }
                    @media(max-width:480px){
                        .hero-content h1{font-size:1.2rem}
                        .hero-badge{font-size:.65rem;gap:6px;padding:5px 14px}
                        .hero-popular-label{display:none}
                        .search-tab{padding:10px 12px;font-size:.72rem;gap:5px}
                        .search-tab i{font-size:.7rem}
                    }

                    /* MAP */
                    /* FLOATING MAP UI (FROM IMAGE) */
                    .map-float-container{max-width:1100px;margin:-80px auto 60px;position:relative;z-index:100;padding:0 20px}
                    .map-card{background:#fff;border-radius:24px;overflow:hidden;box-shadow:0 15px 45px rgba(0,0,0,0.12);border:4px solid #fff;height:380px;position:relative}
                    .map-card iframe{width:100%;height:100%;border:0;filter:saturate(1.1)}
                    
                    .btn-floating-loc{position:absolute;top:20px;left:20px;z-index:10;display:flex;align-items:center;gap:10px;padding:12px 20px;background:#fff;color:#1E293B;border:none;border-radius:12px;font-size:0.85rem;font-weight:800;cursor:pointer;box-shadow:0 8px 20px rgba(0,0,0,0.15);transition:all 0.3s}
                    .btn-floating-loc i{color:#2563EB;font-size:1rem}
                    .btn-floating-loc:hover{transform:translateY(-2px);box-shadow:0 12px 25px rgba(0,0,0,0.2)}
                    
                    @media(max-width:768px){
                        .map-float-container{margin-top:-40px}
                        .map-card{height:280px;border-radius:16px}
                    }

                    /* Hide old float cards */
                    .hero-right,.float-card{display:none}

                    @media(max-width:768px){
                        .hero{min-height:auto;padding:80px 0 40px}
                        .search-row{flex-direction:column}
                        .search-field+.search-field{border-left:none;border-top:1px solid #E5E7EB}
                        .search-actions{padding:8px}
                        .search-btn{width:100%;justify-content:center}
                        .hero-cats{gap:8px}
                        .hero-cat{min-width:68px;padding:10px 12px}
                        .map-wrap{height:280px}
                    }

                    .float-card p {
                        font-size: .78rem;
                        opacity: .65
                    }

                    /* ═══ CATEGORIES ═══ */
                    .cats {
                        max-width: 1440px;
                        margin: -70px auto 0;
                        padding: 0 24px;
                        position: relative;
                        z-index: 10
                    }

                    .cats-grid {
                        display: grid;
                        grid-template-columns: repeat(4, 1fr);
                        gap: 20px
                    }

                    .cat {
                        background: #fff;
                        border-radius: 20px;
                        padding: 32px 24px;
                        text-align: center;
                        cursor: pointer;
                        border: 1px solid #E8EAF0;
                        box-shadow: 0 4px 20px rgba(27, 31, 59, .05);
                        transition: .4s cubic-bezier(.175, .885, .32, 1.275);
                        position: relative;
                        overflow: hidden
                    }

                    .cat::before {
                        content: '';
                        position: absolute;
                        inset: 0;
                        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
                        opacity: 0;
                        transition: .4s;
                        z-index: 0
                    }

                    .cat:hover::before {
                        opacity: 1
                    }

                    .cat:hover {
                        transform: translateY(-10px);
                        box-shadow: 0 20px 50px rgba(255, 111, 97, .2)
                    }

                    .cat>* {
                        position: relative;
                        z-index: 1
                    }

                    .cat .ci {
                        width: 64px;
                        height: 64px;
                        border-radius: 18px;
                        background: linear-gradient(135deg, rgba(255, 111, 97, .08), rgba(255, 154, 139, .04));
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        margin: 0 auto 16px;
                        font-size: 1.5rem;
                        color: #FF6F61;
                        transition: .4s
                    }

                    .cat:hover .ci {
                        background: rgba(255, 255, 255, .2);
                        color: #fff;
                        transform: scale(1.12) rotate(-5deg)
                    }

                    .cat .cn {
                        font-weight: 700;
                        color: #1B1F3B;
                        font-size: 1rem;
                        transition: .3s
                    }

                    .cat:hover .cn {
                        color: #fff
                    }

                    .cat .cd {
                        font-size: .82rem;
                        color: #A0A5C3;
                        margin-top: 6px;
                        transition: .3s
                    }

                    .cat:hover .cd {
                        color: rgba(255, 255, 255, .8)
                    }

                    /* ═══ STATS ═══ */
                    .stats {
                        max-width: 1440px;
                        margin: 50px auto;
                        padding: 0 24px
                    }

                    .stats-bar {
                        display: grid;
                        grid-template-columns: repeat(4, 1fr);
                        background: transparent;
                        border-radius: 24px;
                        position: relative;
                        overflow: hidden
                    }

                    .stats-bar::before {
                        display: none
                    }

                    .st {
                        padding: 42px 28px;
                        text-align: center;
                        position: relative;
                        border-right: 1px solid rgba(0, 0, 0, .08)
                    }

                    .st:last-child {
                        border-right: none
                    }

                    .st .num {
                        font-size: 2.4rem;
                        font-weight: 800;
                        color: #F97316;
                        letter-spacing: -1px
                    }

                    .st .lab {
                        font-size: .88rem;
                        color: #64748B;
                        margin-top: 6px;
                        font-weight: 500
                    }

                    /* ═══ SECTION HEADER ═══ */
                    .sh {
                        display: flex;
                        justify-content: space-between;
                        align-items: flex-end;
                        margin-bottom: 48px;
                        max-width: 1440px;
                        margin-left: auto;
                        margin-right: auto;
                        padding: 0 24px
                    }

                    .sh h2 {
                        font-size: 2.2rem;
                        font-weight: 800;
                        color: #1B1F3B;
                        letter-spacing: -.5px
                    }

                    .sh .sub {
                        color: #6B7194;
                        margin-top: 10px;
                        font-size: 1rem
                    }

                    .sh .more {
                        color: #FF6F61;
                        font-weight: 700;
                        font-size: .95rem;
                        display: flex;
                        align-items: center;
                        gap: 6px;
                        flex-shrink: 0
                    }

                    .sh .more:hover {
                        gap: 12px
                    }

                    /* ═══ TOUR CARDS ═══ */
                    .tours {
                        max-width: 1440px;
                        margin: 0 auto 100px;
                        padding: 0 24px
                    }

                    .tour-grid {
                        display: grid;
                        grid-template-columns: repeat(3, 1fr);
                        gap: 28px
                    }

                    .tc {
                        background: #fff;
                        border-radius: 20px;
                        overflow: hidden;
                        border: 1px solid #E8EAF0;
                        box-shadow: 0 2px 8px rgba(27, 31, 59, .04);
                        transition: .4s;
                        display: flex;
                        flex-direction: column
                    }

                    .tc:hover {
                        transform: translateY(-10px);
                        box-shadow: 0 25px 60px rgba(27, 31, 59, .1)
                    }

                    .tc .iw {
                        position: relative;
                        height: 250px;
                        overflow: hidden
                    }

                    .tc .iw img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                        transition: transform .7s cubic-bezier(.4, 0, .2, 1)
                    }

                    .tc:hover .iw img {
                        transform: scale(1.1)
                    }

                    .tc .bov {
                        position: absolute;
                        top: 16px;
                        left: 16px;
                        display: flex;
                        gap: 8px
                    }

                    .tc .bt {
                        padding: 6px 14px;
                        border-radius: 999px;
                        font-size: .72rem;
                        font-weight: 700;
                        letter-spacing: .3px
                    }

                    .bt-d {
                        background: rgba(27, 31, 59, .7);
                        backdrop-filter: blur(10px);
                        color: #fff
                    }

                    .bt-a {
                        background: rgba(255, 111, 97, .88);
                        color: #fff
                    }

                    .tc .wl {
                        position: absolute;
                        top: 16px;
                        right: 16px;
                        width: 38px;
                        height: 38px;
                        border-radius: 50%;
                        background: rgba(255, 255, 255, .85);
                        backdrop-filter: blur(10px);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        cursor: pointer;
                        transition: .3s;
                        border: none;
                        color: #A0A5C3;
                        font-size: .9rem
                    }

                    .tc .wl:hover {
                        background: #fff;
                        color: #FF6F61;
                        transform: scale(1.12)
                    }

                    .tc .ct {
                        padding: 24px;
                        flex: 1;
                        display: flex;
                        flex-direction: column
                    }

                    .tc .loc {
                        font-size: .75rem;
                        text-transform: uppercase;
                        letter-spacing: 1.5px;
                        color: #A0A5C3;
                        font-weight: 700;
                        margin-bottom: 8px;
                        display: flex;
                        align-items: center;
                        gap: 5px
                    }

                    .tc .ct h3 {
                        font-size: 1.15rem;
                        color: #1B1F3B;
                        margin-bottom: 10px;
                        line-height: 1.4;
                        font-weight: 700
                    }

                    .tc .desc {
                        color: #6B7194;
                        font-size: .88rem;
                        line-height: 1.6;
                        display: -webkit-box;
                        -webkit-line-clamp: 2;
                        line-clamp: 2;
                        -webkit-box-orient: vertical;
                        overflow: hidden;
                        margin-bottom: 20px
                    }

                    .tc .bot {
                        margin-top: auto;
                        padding-top: 20px;
                        border-top: 1px solid #E8EAF0;
                        display: flex;
                        justify-content: space-between;
                        align-items: center
                    }

                    .tc .pl {
                        font-size: .75rem;
                        color: #A0A5C3
                    }

                    .tc .pr {
                        font-size: 1.3rem;
                        font-weight: 800;
                        color: #1B1F3B
                    }

                    .tc .pr span {
                        font-size: .82rem;
                        font-weight: 500;
                        color: #A0A5C3
                    }

                    .btn-book {
                        padding: 10px 24px;
                        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
                        color: #fff;
                        border: none;
                        border-radius: 999px;
                        font-weight: 700;
                        cursor: pointer;
                        transition: .3s;
                        font-size: .85rem;
                        font-family: inherit;
                        box-shadow: 0 4px 12px rgba(255, 111, 97, .2)
                    }

                    .btn-book:hover {
                        transform: scale(1.06);
                        box-shadow: 0 8px 20px rgba(255, 111, 97, .35)
                    }

                    /* Empty state */
                    .empty {
                        text-align: center;
                        padding: 100px 30px;
                        background: #fff;
                        border-radius: 24px;
                        box-shadow: 0 4px 20px rgba(27, 31, 59, .04)
                    }

                    .empty .em {
                        font-size: 5rem;
                        margin-bottom: 18px;
                        filter: grayscale(.3)
                    }

                    .empty h3 {
                        color: #1B1F3B;
                        margin-bottom: 10px;
                        font-size: 1.4rem
                    }

                    .empty p {
                        color: #6B7194;
                        max-width: 400px;
                        margin: 0 auto 25px
                    }

                    /* ═══ CTA ═══ */
                    .cta {
                        background: #1B1F3B;
                        padding: 110px 0;
                        position: relative;
                        overflow: hidden
                    }

                    .cta::before {
                        content: '';
                        position: absolute;
                        width: 600px;
                        height: 600px;
                        background: radial-gradient(circle, rgba(255, 111, 97, .12), transparent 60%);
                        top: -200px;
                        left: -100px;
                        border-radius: 50%
                    }

                    .cta::after {
                        content: '';
                        position: absolute;
                        width: 500px;
                        height: 500px;
                        background: radial-gradient(circle, rgba(0, 180, 216, .1), transparent 60%);
                        bottom: -200px;
                        right: -100px;
                        border-radius: 50%
                    }

                    .cta-inner {
                        max-width: 1440px;
                        margin: 0 auto;
                        padding: 0 24px;
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 80px;
                        align-items: center;
                        position: relative;
                        z-index: 1
                    }

                    .cta h2 {
                        font-size: 2.8rem;
                        font-weight: 800;
                        color: #fff;
                        margin-bottom: 20px;
                        line-height: 1.2;
                        letter-spacing: -.5px
                    }

                    .cta h2 .hl {
                        color: #FF6F61
                    }

                    .cta>div p,
                    .cta-inner>div:first-child p {
                        font-size: 1.05rem;
                        color: rgba(255, 255, 255, .6);
                        margin-bottom: 35px;
                        line-height: 1.7
                    }

                    .nl-form {
                        display: flex;
                        gap: 10px
                    }

                    .nl-form input {
                        flex: 1;
                        padding: 16px 24px;
                        border-radius: 999px;
                        border: 2px solid rgba(255, 255, 255, .1);
                        background: rgba(255, 255, 255, .06);
                        color: #fff;
                        font-size: .95rem;
                        outline: none;
                        font-family: inherit;
                        transition: .3s
                    }

                    .nl-form input::placeholder {
                        color: rgba(255, 255, 255, .35)
                    }

                    .nl-form input:focus {
                        border-color: #FF6F61;
                        background: rgba(255, 255, 255, .1)
                    }

                    .feats {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 18px
                    }

                    .feat {
                        background: rgba(255, 255, 255, .04);
                        border: 1px solid rgba(255, 255, 255, .06);
                        border-radius: 16px;
                        padding: 28px;
                        transition: .5s cubic-bezier(.175, .885, .32, 1.275)
                    }

                    .feat:hover {
                        background: rgba(255, 255, 255, .08);
                        transform: translateY(-6px);
                        border-color: rgba(255, 255, 255, .12)
                    }

                    .feat .fi {
                        font-size: 1.8rem;
                        margin-bottom: 14px
                    }

                    .feat h4 {
                        font-size: .95rem;
                        color: #fff;
                        margin-bottom: 6px;
                        font-weight: 700
                    }

                    .feat p {
                        font-size: .82rem;
                        color: rgba(255, 255, 255, .45);
                        line-height: 1.5
                    }

                    /* ═══ FOOTER ═══ */
                    .foot {
                        background: #1B1F3B;
                        color: #fff;
                        padding: 80px 0 30px;
                        position: relative;
                        overflow: hidden
                    }

                    .foot::before {
                        content: '';
                        position: absolute;
                        width: 400px;
                        height: 400px;
                        background: radial-gradient(circle, rgba(255, 111, 97, .05), transparent 60%);
                        top: -200px;
                        right: -100px;
                        border-radius: 50%
                    }

                    .foot-inner {
                        max-width: 1280px;
                        margin: 0 auto;
                        padding: 0 30px;
                        position: relative;
                        z-index: 1
                    }

                    .foot-grid {
                        display: grid;
                        grid-template-columns: 1.5fr 1fr 1fr 1fr;
                        gap: 50px;
                        margin-bottom: 50px
                    }

                    .foot h3 {
                        font-size: 1.4rem;
                        margin-bottom: 18px;
                        font-weight: 800
                    }

                    .foot h4 {
                        margin-bottom: 18px;
                        font-size: .92rem;
                        font-weight: 700
                    }

                    .foot p,
                    .foot li a {
                        color: rgba(255, 255, 255, .42);
                        font-size: .88rem;
                        transition: .3s
                    }

                    .foot li a:hover {
                        color: rgba(255, 255, 255, .8)
                    }

                    .foot li {
                        margin-bottom: 10px
                    }

                    .foot .socials {
                        display: flex;
                        gap: 10px;
                        margin-top: 20px
                    }

                    .foot .soc {
                        width: 38px;
                        height: 38px;
                        border-radius: 10px;
                        background: rgba(255, 255, 255, .05);
                        border: 1px solid rgba(255, 255, 255, .07);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: rgba(255, 255, 255, .45);
                        transition: .3s;
                        font-size: .9rem
                    }

                    .foot .soc:hover {
                        background: rgba(255, 255, 255, .1);
                        color: #fff
                    }

                    .foot hr {
                        border: 0;
                        border-top: 1px solid rgba(255, 255, 255, .06);
                        margin-bottom: 25px
                    }

                    .foot-bottom {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        flex-wrap: wrap;
                        gap: 10px;
                        color: rgba(255, 255, 255, .3);
                        font-size: .78rem
                    }

                    /* ═══ AI BOT ═══ */
                    .ai-btn {
                        position: fixed;
                        bottom: 28px;
                        right: 28px;
                        width: 60px;
                        height: 60px;
                        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
                        color: #fff;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.3rem;
                        cursor: pointer;
                        box-shadow: 0 8px 30px rgba(255, 111, 97, .35);
                        z-index: 1001;
                        transition: .5s cubic-bezier(.175, .885, .32, 1.275);
                        border: 3px solid rgba(255, 255, 255, .2)
                    }

                    .ai-btn:hover {
                        transform: scale(1.15) rotate(10deg);
                        box-shadow: 0 14px 40px rgba(255, 111, 97, .5)
                    }

                    /* ═══ REVEAL ═══ */
                    .rv {
                        opacity: 0;
                        transform: translateY(30px);
                        transition: all .7s cubic-bezier(.4, 0, .2, 1)
                    }

                    .rv.vis {
                        opacity: 1;
                        transform: translateY(0)
                    }

                    /* ═══ RESPONSIVE — General Page ═══ */
                    @media(max-width:1024px) {
                        .cats-grid,
                        .tour-grid {
                            grid-template-columns: repeat(2, 1fr)
                        }

                        .cta-inner {
                            grid-template-columns: 1fr;
                            gap: 50px
                        }

                        .stats-bar {
                            grid-template-columns: repeat(2, 1fr)
                        }

                        .foot-grid {
                            grid-template-columns: repeat(2, 1fr)
                        }
                    }

                    @media(max-width:768px) {
                        .nav-menu {
                            display: none
                        }

                        .cats-grid {
                            grid-template-columns: 1fr 1fr;
                            gap: 12px
                        }

                        .cat {
                            padding: 22px 16px
                        }

                        .tour-grid {
                            grid-template-columns: 1fr
                        }

                        .feats {
                            grid-template-columns: 1fr
                        }

                        .sh {
                            flex-direction: column;
                            align-items: flex-start;
                            gap: 10px
                        }

                        .sh h2 {
                            font-size: 1.6rem
                        }

                        .cta h2 {
                            font-size: 2rem
                        }

                        .foot-grid {
                            grid-template-columns: 1fr
                        }

                        .stats{margin:40px auto;padding:0 16px}
                        .st{padding:28px 16px}
                        .st .num{font-size:1.8rem}
                        .cats{margin:-40px auto 0;padding:0 16px}
                        .tours{padding:0 16px;margin-bottom:60px}
                        .cta{padding:60px 0}
                        .cta-inner{padding:0 20px}
                        .foot-inner{padding:0 20px}
                    }

                    @media(max-width:480px) {
                        .stats-bar {
                            grid-template-columns: repeat(2, 1fr)
                        }
                        .cats-grid{grid-template-columns:1fr 1fr;gap:10px}
                        .cat .ci{width:48px;height:48px;font-size:1.2rem}
                        .cat .cn{font-size:.88rem}
                        .tc .iw{height:200px}
                        .tc .ct{padding:16px}
                        .cta h2{font-size:1.6rem}
                        .nl-form{flex-direction:column}
                    }
                </style>
            </head>

            <body>
                <jsp:include page="/common/_header.jsp" />

                <!-- ═══ HERO — PREMIUM 2026 ═══ -->
                <section class="hero">
                    <div class="hero-bg"></div>
                    <video class="hero-video" id="heroVideo" autoplay muted loop playsinline
                        poster="${pageContext.request.contextPath}/images/hero-bg.jpg">
                        <source src="${pageContext.request.contextPath}/images/hero-video.mp4" type="video/mp4">
                    </video>
                    <script>(function(){var v=document.getElementById('heroVideo');if(v){v.addEventListener('canplaythrough',function(){v.classList.add('loaded')});setTimeout(function(){if(v)v.classList.add('loaded')},4000)}})();</script>
                    <div class="hero-overlay"></div>

                    <div class="hero-content">
                        <div class="hero-badge" data-i18n="hero.badge">
                            <span class="dot"></span> ⭐ 5,000+ du khách tin tưởng • Đánh giá 4.9/5
                        </div>

                        <h1>Khám Phá <span class="hero-accent">Đà Nẵng</span><br>Trải Nghiệm Du Lịch Tuyệt Vời</h1>
                        <p class="hero-sub" data-i18n="hero.desc">Từ Cầu Vàng Bà Nà Hills đến biển Mỹ Khê — hãy để chúng tôi giúp bạn lên kế hoạch cho chuyến đi hoàn hảo nhất.</p>

                        <!-- Search Panel -->
                        <div class="search-panel">
                            <div class="search-tabs">
                                <a href="${pageContext.request.contextPath}/tour" class="search-tab active"><i class="fas fa-suitcase-rolling"></i> Tour trọn gói</a>
                                <a href="#" class="search-tab"><i class="fas fa-hotel"></i> Khách sạn</a>
                                <a href="#" class="search-tab"><i class="fas fa-plane"></i> Vé máy bay</a>
                                <a href="${pageContext.request.contextPath}/tour" class="search-tab"><i class="fas fa-layer-group"></i> Combo</a>
                            </div>
                            <form action="${pageContext.request.contextPath}/tour" method="get">
                                <div class="search-row">
                                    <div class="search-field">
                                        <div class="search-field-label"><i class="fas fa-map-marker-alt"></i> <span data-i18n="search.where">Bạn muốn đi đâu?</span> <span style="color:#EF4444">*</span></div>
                                        <input type="text" name="search" placeholder="vd: Bà Nà, Hội An, Sơn Trà...">
                                    </div>
                                    <div class="search-field">
                                        <div class="search-field-label"><i class="fas fa-calendar-alt"></i> <span data-i18n="search.date">Ngày khởi hành</span></div>
                                        <input type="text" name="date" placeholder="Chọn ngày đi" onfocus="this.type='date'" onblur="if(!this.value)this.type='text'">
                                    </div>
                                    <div class="search-field">
                                        <div class="search-field-label"><i class="fas fa-wallet"></i> <span data-i18n="search.budget">Ngân sách</span></div>
                                        <select name="priceRange">
                                            <option value="">Chọn mức giá</option>
                                            <option value="0-500000">Dưới 500K</option>
                                            <option value="500000-1000000">500K - 1 triệu</option>
                                            <option value="1000000-3000000">1 - 3 triệu</option>
                                            <option value="3000000-">Trên 3 triệu</option>
                                        </select>
                                    </div>
                                    <div class="search-actions">
                                        <button type="submit" class="search-btn"><i class="fas fa-search"></i> <span data-i18n="search.btn">Tìm kiếm</span></button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- Popular destinations -->
                        <div class="hero-popular">
                            <span class="hero-popular-label">Phổ biến:</span>
                            <a href="${pageContext.request.contextPath}/tour?search=ba+na" class="hero-popular-tag"><i class="fas fa-fire"></i> Bà Nà Hills</a>
                            <a href="${pageContext.request.contextPath}/tour?search=hoi+an" class="hero-popular-tag">🏮 Hội An</a>
                            <a href="${pageContext.request.contextPath}/tour?search=my+khe" class="hero-popular-tag">🏖️ Mỹ Khê</a>
                            <a href="${pageContext.request.contextPath}/tour?search=son+tra" class="hero-popular-tag">🌿 Sơn Trà</a>
                            <a href="${pageContext.request.contextPath}/tour?search=ngu+hanh+son" class="hero-popular-tag">⛰️ Ngũ Hành Sơn</a>
                        </div>

                        <!-- Scroll indicator -->
                        <div class="scroll-hint" onclick="document.querySelector('.map-section').scrollIntoView({behavior:'smooth'})">
                            <span class="scroll-hint-text">Khám phá</span>
                            <div class="scroll-arrow"><i class="fas fa-chevron-down"></i></div>
                        </div>
                    </div>
                </section>

                <!-- ═══ STATS (ABOVE MAP) ═══ -->
                <section class="stats">
                    <div class="stats-bar rv">
                        <div class="st">
                            <div class="num" data-count="100" data-suffix="+">0</div>
                            <div class="lab">Tours Xác Minh</div>
                        </div>
                        <div class="st">
                            <div class="num" data-count="50" data-suffix="+">0</div>
                            <div class="lab">Đối Tác Uy Tín</div>
                        </div>
                        <div class="st">
                            <div class="num" data-count="5000" data-suffix="+" data-format="K">0</div>
                            <div class="lab">Khách Hài Lòng</div>
                        </div>
                        <div class="st">
                            <div class="num" data-count="4.9" data-suffix="★" data-decimal="true">0</div>
                            <div class="lab">Đánh Giá</div>
                        </div>
                    </div>
                </section>

                <!-- ═══ INTERACTIVE MAP - LEAFLET.JS ═══ -->
                <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
                <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
                <style>
                    /* ═══ MAP PREMIUM STYLES ═══ */
                    .map-section{position:relative;max-width:1440px;margin:-40px auto 60px;padding:0 24px;z-index:100}
                    .map-wrapper{background:#fff;border-radius:24px;overflow:hidden;box-shadow:0 20px 60px rgba(27,31,59,.15),0 0 0 1px rgba(255,255,255,.8) inset;border:4px solid #fff;position:relative;display:flex;height:520px}
                    
                    /* Map Container */
                    .map-container{flex:1;position:relative;min-width:0}
                    #leafletMap{width:100%;height:100%;z-index:1}
                    
                    /* Map Controls Overlay */
                    .map-controls{position:absolute;top:16px;left:16px;z-index:1000;display:flex;flex-direction:column;gap:8px}
                    .map-ctrl-btn{display:flex;align-items:center;gap:10px;padding:12px 20px;background:rgba(255,255,255,.95);backdrop-filter:blur(16px);color:#1E293B;border:none;border-radius:14px;font-size:.82rem;font-weight:800;cursor:pointer;box-shadow:0 8px 24px rgba(0,0,0,.12),0 0 0 1px rgba(0,0,0,.04);transition:all .3s;font-family:'Inter',sans-serif;letter-spacing:.2px}
                    .map-ctrl-btn i{font-size:1rem}
                    .map-ctrl-btn:hover{transform:translateY(-2px);box-shadow:0 12px 32px rgba(0,0,0,.18)}
                    .map-ctrl-btn.active{background:linear-gradient(135deg,#2563EB,#3B82F6);color:#fff}
                    .map-ctrl-btn.active i{color:#fff}
                    .map-ctrl-btn:not(.active) i{color:#2563EB}
                    
                    .map-style-toggle{position:absolute;top:16px;right:16px;z-index:1000;display:flex;gap:4px;background:rgba(255,255,255,.92);backdrop-filter:blur(12px);border-radius:12px;padding:4px;box-shadow:0 4px 16px rgba(0,0,0,.1)}
                    .map-style-btn{padding:8px 14px;border:none;border-radius:9px;font-size:.72rem;font-weight:700;cursor:pointer;transition:.3s;font-family:'Inter',sans-serif;background:transparent;color:#64748B}
                    .map-style-btn.active{background:#2563EB;color:#fff;box-shadow:0 2px 8px rgba(37,99,235,.35)}
                    .map-style-btn:hover:not(.active){background:rgba(37,99,235,.08);color:#2563EB}
                    
                    /* Coordinate Badge */
                    .map-coord-badge{position:absolute;bottom:16px;left:16px;z-index:1000;background:rgba(15,23,42,.85);backdrop-filter:blur(12px);color:#CBD5E1;padding:8px 16px;border-radius:10px;font-size:.72rem;font-weight:600;font-family:'JetBrains Mono','Courier New',monospace;letter-spacing:.5px;display:none;gap:12px;align-items:center;box-shadow:0 4px 16px rgba(0,0,0,.2)}
                    .map-coord-badge i{color:#60A5FA;font-size:.68rem}
                    
                    /* Location Info Sidebar */
                    .map-sidebar{width:0;overflow:hidden;transition:width .4s cubic-bezier(.4,0,.2,1);background:linear-gradient(180deg,#F8FAFF 0%,#F1F5FF 100%);border-left:1px solid rgba(37,99,235,.08);position:relative}
                    .map-sidebar.open{width:340px}
                    .map-sidebar-inner{width:340px;height:100%;overflow-y:auto;padding:0}
                    .map-sidebar-inner::-webkit-scrollbar{width:3px}
                    .map-sidebar-inner::-webkit-scrollbar-thumb{background:#CBD5E1;border-radius:3px}
                    
                    /* Sidebar Header */
                    .sidebar-header{background:linear-gradient(135deg,#1E3A5F,#2563EB);color:#fff;padding:20px;position:relative;overflow:hidden}
                    .sidebar-header::before{content:'';position:absolute;top:-30px;right:-30px;width:100px;height:100px;background:rgba(255,255,255,.06);border-radius:50%}
                    .sidebar-header::after{content:'';position:absolute;bottom:-20px;left:-20px;width:80px;height:80px;background:rgba(255,255,255,.04);border-radius:50%}
                    .sidebar-header-top{display:flex;align-items:center;justify-content:space-between;position:relative;z-index:1;margin-bottom:12px}
                    .sidebar-header-top h3{font-size:.92rem;font-weight:800;display:flex;align-items:center;gap:8px}
                    .sidebar-close{background:rgba(255,255,255,.15);border:none;color:rgba(255,255,255,.8);width:28px;height:28px;border-radius:8px;cursor:pointer;font-size:.8rem;transition:.3s;display:flex;align-items:center;justify-content:center}
                    .sidebar-close:hover{background:rgba(255,255,255,.25);color:#fff}
                    
                    .sidebar-location{background:rgba(255,255,255,.1);border-radius:12px;padding:12px;position:relative;z-index:1}
                    .sidebar-address{font-size:.82rem;color:rgba(255,255,255,.9);line-height:1.6;font-weight:500}
                    .sidebar-coords{font-size:.68rem;color:rgba(255,255,255,.5);margin-top:6px;font-family:'JetBrains Mono','Courier New',monospace;letter-spacing:.5px}
                    
                    /* Nearby Suggestions */
                    .sidebar-body{padding:16px 20px}
                    .suggest-title{font-size:.78rem;font-weight:800;color:#475569;text-transform:uppercase;letter-spacing:.8px;margin-bottom:14px;display:flex;align-items:center;gap:8px}
                    .suggest-title i{color:#F59E0B}
                    
                    .suggest-card{background:#fff;border-radius:14px;padding:14px;margin-bottom:10px;border:1px solid #E8EDF5;transition:all .3s;cursor:pointer;position:relative;overflow:hidden}
                    .suggest-card::before{content:'';position:absolute;left:0;top:0;bottom:0;width:3px;border-radius:0 3px 3px 0;transition:background .3s}
                    .suggest-card:nth-child(1)::before{background:#3B82F6}
                    .suggest-card:nth-child(2)::before{background:#10B981}
                    .suggest-card:nth-child(3)::before{background:#F59E0B}
                    .suggest-card:nth-child(4)::before{background:#8B5CF6}
                    .suggest-card:nth-child(5)::before{background:#EF4444}
                    .suggest-card:hover{transform:translateX(4px);box-shadow:0 4px 16px rgba(37,99,235,.1);border-color:#BFDBFE}
                    
                    .suggest-card-header{display:flex;align-items:center;gap:10px;margin-bottom:8px}
                    .suggest-icon{width:36px;height:36px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:1rem;flex-shrink:0}
                    .suggest-card:nth-child(1) .suggest-icon{background:rgba(59,130,246,.1)}
                    .suggest-card:nth-child(2) .suggest-icon{background:rgba(16,185,129,.1)}
                    .suggest-card:nth-child(3) .suggest-icon{background:rgba(245,158,11,.1)}
                    .suggest-card:nth-child(4) .suggest-icon{background:rgba(139,92,246,.1)}
                    .suggest-card:nth-child(5) .suggest-icon{background:rgba(239,68,68,.1)}
                    .suggest-name{font-size:.84rem;font-weight:700;color:#1E293B}
                    .suggest-dist{font-size:.68rem;color:#94A3B8;font-weight:600}
                    .suggest-desc{font-size:.76rem;color:#64748B;line-height:1.5}
                    .suggest-tags{display:flex;gap:4px;margin-top:8px;flex-wrap:wrap}
                    .suggest-tag{padding:3px 8px;border-radius:6px;font-size:.62rem;font-weight:700;background:#F1F5F9;color:#475569;letter-spacing:.3px}
                    
                    /* AI Ask Button */
                    .sidebar-ai-btn{display:flex;align-items:center;justify-content:center;gap:8px;width:100%;padding:14px;background:linear-gradient(135deg,#1E3A5F,#2563EB);color:#fff;border:none;border-radius:14px;font-size:.84rem;font-weight:800;cursor:pointer;transition:all .3s;font-family:'Inter',sans-serif;margin-top:16px;box-shadow:0 6px 20px rgba(37,99,235,.25)}
                    .sidebar-ai-btn:hover{transform:translateY(-2px);box-shadow:0 10px 28px rgba(37,99,235,.35)}
                    .sidebar-ai-btn i{font-size:1rem}
                    
                    /* Loading State */
                    .sidebar-loading{display:flex;flex-direction:column;align-items:center;justify-content:center;padding:40px 20px;gap:12px}
                    .sidebar-loading .loader{width:32px;height:32px;border:3px solid #E8EDF5;border-top-color:#3B82F6;border-radius:50%;animation:spin .8s linear infinite}
                    @keyframes spin{to{transform:rotate(360deg)}}
                    .sidebar-loading p{font-size:.82rem;color:#94A3B8;font-weight:600}
                    
                    /* Hotspot Markers Custom */
                    .leaflet-popup-content-wrapper{border-radius:14px!important;box-shadow:0 8px 30px rgba(0,0,0,.15)!important;border:none!important;padding:0!important}
                    .leaflet-popup-content{margin:0!important;min-width:220px}
                    .leaflet-popup-tip{box-shadow:none!important}
                    .popup-content{padding:16px}
                    .popup-content h4{font-size:.92rem;font-weight:800;color:#1E293B;margin-bottom:4px}
                    .popup-content p{font-size:.78rem;color:#64748B;line-height:1.5;margin-bottom:10px}
                    .popup-btn{display:inline-flex;align-items:center;gap:5px;padding:8px 16px;background:linear-gradient(135deg,#2563EB,#3B82F6);color:#fff;border-radius:10px;font-size:.75rem;font-weight:700;text-decoration:none;transition:.3s}
                    .popup-btn:hover{transform:translateY(-1px);box-shadow:0 4px 12px rgba(37,99,235,.3);color:#fff}
                    
                    /* Mobile responsive */
                    @media(max-width:900px){
                        .map-wrapper{flex-direction:column;height:auto}
                        .map-container{height:360px}
                        #leafletMap{height:360px}
                        .map-sidebar{width:100%!important;border-left:none;border-top:1px solid rgba(37,99,235,.08)}
                        .map-sidebar.open{width:100%!important}
                        .map-sidebar-inner{width:100%}
                    }
                    @media(max-width:768px){
                        .map-section{margin-top:-40px}
                        .map-wrapper{border-radius:16px}
                        .map-container{height:300px}
                        #leafletMap{height:300px}
                    }
                </style>

                <div class="map-section">
                    <div class="map-wrapper rv">
                        <!-- Map Container -->
                        <div class="map-container">
                            <div id="leafletMap"></div>
                            
                            <!-- Controls -->
                            <div class="map-controls">
                                <button class="map-ctrl-btn" id="btnMyLocation" onclick="handleMyLocation()">
                                    <i class="fas fa-crosshairs"></i> Vị Trí Của Tôi
                                </button>
                            </div>
                            
                            <!-- Map Style Toggle -->
                            <div class="map-style-toggle">
                                <button class="map-style-btn active" data-style="streets" onclick="changeMapStyle('streets', this)">Bản đồ</button>
                                <button class="map-style-btn" data-style="satellite" onclick="changeMapStyle('satellite', this)">Vệ tinh</button>
                                <button class="map-style-btn" data-style="dark" onclick="changeMapStyle('dark', this)">Tối</button>
                            </div>
                            
                            <!-- Coordinate Badge -->
                            <div class="map-coord-badge" id="coordBadge">
                                <i class="fas fa-map-pin"></i>
                                <span id="coordText">—</span>
                            </div>
                        </div>
                        
                        <!-- Location Info Sidebar -->
                        <div class="map-sidebar" id="mapSidebar">
                            <div class="map-sidebar-inner" id="sidebarContent">
                                <!-- Content injected by JS -->
                            </div>
                        </div>
                    </div>
                </div>

                <script>
                // ═══ LEAFLET MAP INITIALIZATION ═══
                (function() {
                    const DA_NANG = [16.054, 108.22];
                    let map, currentMarker, currentTileLayer;
                    
                    // Tile layer configs
                    const tileLayers = {
                        streets: {
                            url: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
                            attr: '&copy; <a href="https://carto.com/">CARTO</a> &copy; <a href="https://www.openstreetmap.org/copyright">OSM</a>'
                        },
                        satellite: {
                            url: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                            attr: '&copy; Esri, Maxar, Earthstar'
                        },
                        dark: {
                            url: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
                            attr: '&copy; <a href="https://carto.com/">CARTO</a> &copy; <a href="https://www.openstreetmap.org/copyright">OSM</a>'
                        }
                    };
                    
                    // Custom marker icons
                    function createIcon(color, emoji) {
                        return L.divIcon({
                            className: 'custom-marker',
                            html: '<div style="width:40px;height:40px;background:' + color + ';border-radius:50% 50% 50% 4px;transform:rotate(-45deg);display:flex;align-items:center;justify-content:center;box-shadow:0 4px 16px rgba(0,0,0,.25);border:3px solid #fff"><span style="transform:rotate(45deg);font-size:16px">' + emoji + '</span></div>',
                            iconSize: [40, 40],
                            iconAnchor: [20, 40],
                            popupAnchor: [0, -42]
                        });
                    }
                    
                    function createUserIcon() {
                        return L.divIcon({
                            className: 'custom-marker',
                            html: '<div style="position:relative"><div style="width:18px;height:18px;background:#3B82F6;border-radius:50%;border:3px solid #fff;box-shadow:0 2px 10px rgba(59,130,246,.5)"></div><div style="position:absolute;inset:-8px;border-radius:50%;border:2px solid rgba(59,130,246,.3);animation:pulse2 2s ease infinite"></div></div><style>@keyframes pulse2{0%,100%{transform:scale(1);opacity:1}50%{transform:scale(1.8);opacity:0}}</style>',
                            iconSize: [18, 18],
                            iconAnchor: [9, 9]
                        });
                    }
                    
                    function createPinIcon() {
                        return L.divIcon({
                            className: 'custom-marker',
                            html: '<div style="position:relative;animation:dropIn .4s cubic-bezier(.175,.885,.32,1.275)"><div style="width:44px;height:44px;background:linear-gradient(135deg,#EF4444,#F97316);border-radius:50% 50% 50% 4px;transform:rotate(-45deg);display:flex;align-items:center;justify-content:center;box-shadow:0 6px 20px rgba(239,68,68,.35);border:3px solid #fff"><span style="transform:rotate(45deg);font-size:18px">📍</span></div><div style="position:absolute;bottom:-6px;left:50%;transform:translateX(-50%);width:12px;height:4px;background:rgba(0,0,0,.15);border-radius:50%;filter:blur(2px)"></div></div><style>@keyframes dropIn{0%{transform:translateY(-30px);opacity:0}60%{transform:translateY(4px)}100%{transform:translateY(0);opacity:1}}</style>',
                            iconSize: [44, 44],
                            iconAnchor: [22, 44],
                            popupAnchor: [0, -46]
                        });
                    }
                    
                    // Initialize map
                    map = L.map('leafletMap', {
                        center: DA_NANG,
                        zoom: 13,
                        zoomControl: false,
                        attributionControl: false
                    });
                    
                    // Add zoom control to bottom-right
                    L.control.zoom({ position: 'bottomright' }).addTo(map);
                    
                    // Set initial tile layer
                    currentTileLayer = L.tileLayer(tileLayers.streets.url, {
                        attribution: tileLayers.streets.attr,
                        maxZoom: 19
                    }).addTo(map);
                    
                    // ═══ DA NANG TOURIST HOTSPOTS ═══
                    const hotspots = [
                        { pos: [16.0611, 108.2274], name: 'Cầu Rồng', desc: 'Biểu tượng Đà Nẵng, phun lửa & nước T7-CN', emoji: '🐉', color: '#EF4444', search: 'cau+rong' },
                        { pos: [15.9975, 107.9940], name: 'Bà Nà Hills', desc: 'Làng Pháp trên đỉnh núi, Cầu Vàng nổi tiếng', emoji: '⛰️', color: '#8B5CF6', search: 'ba+na' },
                        { pos: [16.0322, 108.2504], name: 'Biển Mỹ Khê', desc: 'Top 6 bãi biển đẹp nhất hành tinh', emoji: '🏖️', color: '#06B6D4', search: 'my+khe' },
                        { pos: [16.1003, 108.2778], name: 'Bán Đảo Sơn Trà', desc: 'Khu bảo tồn thiên nhiên, Chùa Linh Ứng', emoji: '🌿', color: '#10B981', search: 'son+tra' },
                        { pos: [16.0039, 108.2632], name: 'Ngũ Hành Sơn', desc: 'Marble Mountains, chùa & hang động', emoji: '🏔️', color: '#F59E0B', search: 'ngu+hanh+son' },
                        { pos: [15.8800, 108.3280], name: 'Phố Cổ Hội An', desc: 'Di sản UNESCO, đèn lồng & ẩm thực', emoji: '🏮', color: '#EC4899', search: 'hoi+an' },
                        { pos: [16.0395, 108.2258], name: 'Asia Park', desc: 'Sun World, vòng quay Sun Wheel', emoji: '🎡', color: '#6366F1', search: 'asia+park' },
                        { pos: [16.0719, 108.2271], name: 'Chợ Hàn', desc: 'Chợ truyền thống, đặc sản Đà Nẵng', emoji: '🛍️', color: '#14B8A6', search: '' }
                    ];
                    
                    hotspots.forEach(h => {
                        const marker = L.marker(h.pos, { icon: createIcon(h.color, h.emoji) }).addTo(map);
                        const popupHtml = '<div class="popup-content">'
                            + '<h4>' + h.emoji + ' ' + h.name + '</h4>'
                            + '<p>' + h.desc + '</p>'
                            + '<a href="${pageContext.request.contextPath}/tour?search=' + h.search + '" class="popup-btn"><i class="fas fa-compass"></i> Xem Tour</a>'
                            + '</div>';
                        marker.bindPopup(popupHtml, { closeButton: true, className: 'custom-popup' });
                    });
                    
                    // ═══ CLICK TO PIN LOCATION ═══
                    map.on('click', function(e) {
                        const lat = e.latlng.lat;
                        const lng = e.latlng.lng;
                        
                        placePin(lat, lng);
                        showSidebarLoading();
                        reverseGeocode(lat, lng);
                        
                        // Show coord badge
                        const badge = document.getElementById('coordBadge');
                        document.getElementById('coordText').textContent = lat.toFixed(5) + ', ' + lng.toFixed(5);
                        badge.style.display = 'flex';
                    });
                    
                    function placePin(lat, lng) {
                        if (currentMarker) map.removeLayer(currentMarker);
                        currentMarker = L.marker([lat, lng], { icon: createPinIcon() }).addTo(map);
                        map.flyTo([lat, lng], Math.max(map.getZoom(), 15), { duration: 0.8 });
                    }
                    
                    function showSidebarLoading() {
                        const sidebar = document.getElementById('mapSidebar');
                        sidebar.classList.add('open');
                        document.getElementById('sidebarContent').innerHTML = 
                            '<div class="sidebar-loading"><div class="loader"></div><p>Đang tìm kiếm vị trí...</p></div>';
                    }
                    
                    // ═══ REVERSE GEOCODE ═══
                    function reverseGeocode(lat, lng) {
                        fetch('https://nominatim.openstreetmap.org/reverse?format=json&lat=' + lat + '&lon=' + lng + '&zoom=18&addressdetails=1&accept-language=vi')
                        .then(r => r.json())
                        .then(data => {
                            const address = data.display_name || 'Không xác định được địa chỉ';
                            const addr = data.address || {};
                            const shortAddr = [addr.road, addr.suburb, addr.city || addr.town || addr.county].filter(Boolean).join(', ') || address.split(',').slice(0,3).join(',');
                            
                            renderSidebar(lat, lng, shortAddr, address);
                        })
                        .catch(() => {
                            renderSidebar(lat, lng, 'Tọa độ: ' + lat.toFixed(4) + ', ' + lng.toFixed(4), '');
                        });
                    }
                    
                    // ═══ RENDER SIDEBAR ═══
                    function renderSidebar(lat, lng, shortAddr, fullAddr) {
                        // Find nearest hotspots
                        const nearby = hotspots.map(h => ({
                            ...h,
                            dist: getDistance(lat, lng, h.pos[0], h.pos[1])
                        })).sort((a, b) => a.dist - b.dist).slice(0, 5);
                        
                        let suggestHtml = '';
                        nearby.forEach((h, i) => {
                            const distText = h.dist < 1 ? (h.dist * 1000).toFixed(0) + 'm' : h.dist.toFixed(1) + 'km';
                            const tags = ['Du lịch', 'Đà Nẵng'];
                            if (h.dist < 3) tags.push('Gần đây');
                            if (i === 0) tags.push('Gần nhất');
                            
                            suggestHtml += '<div class="suggest-card" onclick="window.location.href=\'${pageContext.request.contextPath}/tour?search=' + h.search + '\'">'
                                + '<div class="suggest-card-header">'
                                + '<div class="suggest-icon">' + h.emoji + '</div>'
                                + '<div><div class="suggest-name">' + h.name + '</div>'
                                + '<div class="suggest-dist"><i class="fas fa-route" style="margin-right:4px;font-size:.6rem;color:#94A3B8"></i>' + distText + '</div></div>'
                                + '</div>'
                                + '<div class="suggest-desc">' + h.desc + '</div>'
                                + '<div class="suggest-tags">' + tags.map(t => '<span class="suggest-tag">' + t + '</span>').join('') + '</div>'
                                + '</div>';
                        });
                        
                        document.getElementById('sidebarContent').innerHTML = 
                            '<div class="sidebar-header">'
                            + '<div class="sidebar-header-top">'
                            + '<h3><i class="fas fa-map-marker-alt"></i> Vị Trí Đã Chọn</h3>'
                            + '<button class="sidebar-close" onclick="closeSidebar()"><i class="fas fa-times"></i></button>'
                            + '</div>'
                            + '<div class="sidebar-location">'
                            + '<div class="sidebar-address">' + shortAddr + '</div>'
                            + '<div class="sidebar-coords"><i class="fas fa-crosshairs" style="margin-right:4px"></i>' + lat.toFixed(5) + ', ' + lng.toFixed(5) + '</div>'
                            + '</div>'
                            + '</div>'
                            + '<div class="sidebar-body">'
                            + '<div class="suggest-title"><i class="fas fa-star"></i> Gợi ý địa điểm gần đây</div>'
                            + suggestHtml
                            + '<button class="sidebar-ai-btn" onclick="askAI(' + lat + ',' + lng + ')">'
                            + '<i class="fas fa-robot"></i> Hỏi AI gợi ý chi tiết'
                            + '</button>'
                            + '</div>';
                    }
                    
                    // ═══ DISTANCE CALCULATION (Haversine) ═══
                    function getDistance(lat1, lon1, lat2, lon2) {
                        const R = 6371;
                        const dLat = (lat2 - lat1) * Math.PI / 180;
                        const dLon = (lon2 - lon1) * Math.PI / 180;
                        const a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) * Math.sin(dLon/2) * Math.sin(dLon/2);
                        return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
                    }
                    
                    // ═══ CLOSE SIDEBAR ═══
                    window.closeSidebar = function() {
                        document.getElementById('mapSidebar').classList.remove('open');
                        document.getElementById('coordBadge').style.display = 'none';
                        if (currentMarker) { map.removeLayer(currentMarker); currentMarker = null; }
                    };
                    
                    // ═══ ASK AI ═══
                    window.askAI = function(lat, lng) {
                        if (window.EzAiChat && typeof window.EzAiChat.suggestNearby === 'function') {
                            window.EzAiChat.suggestNearby(lat, lng);
                        }
                    };
                    
                    // ═══ CHANGE MAP STYLE ═══
                    window.changeMapStyle = function(style, btn) {
                        document.querySelectorAll('.map-style-btn').forEach(b => b.classList.remove('active'));
                        btn.classList.add('active');
                        
                        if (currentTileLayer) map.removeLayer(currentTileLayer);
                        const config = tileLayers[style];
                        currentTileLayer = L.tileLayer(config.url, {
                            attribution: config.attr,
                            maxZoom: 19
                        }).addTo(map);
                    };
                    
                    // ═══ MY LOCATION ═══
                    window.handleMyLocation = function() {
                        const btn = document.getElementById('btnMyLocation');
                        btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang tìm...';
                        btn.classList.add('active');
                        
                        if (!navigator.geolocation) {
                            alert("Trình duyệt không hỗ trợ định vị!");
                            btn.innerHTML = '<i class="fas fa-crosshairs"></i> Vị Trí Của Tôi';
                            btn.classList.remove('active');
                            return;
                        }
                        
                        navigator.geolocation.getCurrentPosition(
                            (position) => {
                                const lat = position.coords.latitude;
                                const lng = position.coords.longitude;
                                
                                // Remove old marker, add user location marker
                                if (currentMarker) map.removeLayer(currentMarker);
                                currentMarker = L.marker([lat, lng], { icon: createUserIcon() }).addTo(map);
                                map.flyTo([lat, lng], 16, { duration: 1.2 });
                                
                                // Show coord badge
                                document.getElementById('coordText').textContent = lat.toFixed(5) + ', ' + lng.toFixed(5);
                                document.getElementById('coordBadge').style.display = 'flex';
                                
                                // Open sidebar with location info
                                showSidebarLoading();
                                reverseGeocode(lat, lng);
                                
                                // Trigger AI Chatbot
                                if (window.EzAiChat && typeof window.EzAiChat.suggestNearby === 'function') {
                                    window.EzAiChat.suggestNearby(lat, lng);
                                }
                                
                                btn.innerHTML = '<i class="fas fa-check"></i> Đã tìm thấy!';
                                setTimeout(() => {
                                    btn.innerHTML = '<i class="fas fa-crosshairs"></i> Vị Trí Của Tôi';
                                    btn.classList.remove('active');
                                }, 3000);
                            },
                            (error) => {
                                alert("Không thể lấy vị trí. Vui lòng bật định vị GPS!");
                                btn.innerHTML = '<i class="fas fa-crosshairs"></i> Vị Trí Của Tôi';
                                btn.classList.remove('active');
                            },
                            { enableHighAccuracy: true, timeout: 8000, maximumAge: 0 }
                        );
                    };
                    
                    // Invalidate map size after animations
                    setTimeout(() => map.invalidateSize(), 500);
                    
                    // Re-invalidate on sidebar toggle
                    const sidebarObserver = new MutationObserver(() => {
                        setTimeout(() => map.invalidateSize(), 400);
                    });
                    sidebarObserver.observe(document.getElementById('mapSidebar'), { attributes: true, attributeFilter: ['class'] });
                })();
                </script>

                <!-- ═══ TÍNH NĂNG NỔI BẬT — CUTE MARQUEE ═══ -->
                <section class="ft-marquee-section">
                    <div class="ft-marquee-header">
                        <span class="ft-marquee-badge"><i class="fas fa-sparkles"></i> Tại sao chọn chúng tôi?</span>
                        <h2>Tính Năng <span style="color:#FF6F61">Nổi Bật</span></h2>
                        <p>Trải nghiệm đặt tour thông minh, tiện lợi với những tính năng được thiết kế dành riêng cho bạn.</p>
                    </div>
                    <div class="ft-marquee-track-wrapper">
                        <div class="ft-marquee-track">
                            <!-- Card 1 -->
                            <div class="ft-fcard" style="--bg:linear-gradient(135deg,#8B5CF6,#A78BFA)">
                                <div class="ft-fcard-emoji">🤖</div>
                                <h4>AI Chatbot</h4>
                                <p>Trợ lý AI thông minh hỗ trợ bạn 24/7, gợi ý tour phù hợp với sở thích cá nhân.</p>
                                <div class="ft-fcard-icon"><i class="fas fa-chevron-up"></i></div>
                            </div>
                            <!-- Card 2 -->
                            <div class="ft-fcard" style="--bg:linear-gradient(135deg,#10B981,#34D399)">
                                <div class="ft-fcard-emoji">📱</div>
                                <h4>Đặt Tour Online</h4>
                                <p>Đặt tour nhanh chóng chỉ vài bước, thanh toán an toàn với nhiều phương thức.</p>
                                <div class="ft-fcard-icon"><i class="fas fa-chevron-up"></i></div>
                            </div>
                            <!-- Card 3 -->
                            <div class="ft-fcard" style="--bg:linear-gradient(135deg,#EF4444,#F87171)">
                                <div class="ft-fcard-emoji">🗺️</div>
                                <h4>Bản Đồ Thông Minh</h4>
                                <p>Khám phá Đà Nẵng qua bản đồ tương tác, ghim vị trí và nhận gợi ý địa điểm gần.</p>
                                <div class="ft-fcard-icon"><i class="fas fa-chevron-up"></i></div>
                            </div>
                            <!-- Card 4 -->
                            <div class="ft-fcard" style="--bg:linear-gradient(135deg,#F59E0B,#FBBF24)">
                                <div class="ft-fcard-emoji">⚡</div>
                                <h4>So Sánh Tour</h4>
                                <p>So sánh giá, đánh giá và dịch vụ giữa các tour để chọn lựa tốt nhất cho bạn.</p>
                                <div class="ft-fcard-icon"><i class="fas fa-chevron-up"></i></div>
                            </div>
                            <!-- Card 5 -->
                            <div class="ft-fcard" style="--bg:linear-gradient(135deg,#3B82F6,#60A5FA)">
                                <div class="ft-fcard-emoji">🎨</div>
                                <h4>Tour 3D Gallery</h4>
                                <p>Xem trước điểm đến với bộ sưu tập 3D sống động trước khi quyết định đặt tour.</p>
                                <div class="ft-fcard-icon"><i class="fas fa-chevron-up"></i></div>
                            </div>
                            <!-- Card 6 -->
                            <div class="ft-fcard" style="--bg:linear-gradient(135deg,#EC4899,#F472B6)">
                                <div class="ft-fcard-emoji">💳</div>
                                <h4>Thanh Toán Đa Dạng</h4>
                                <p>Hỗ trợ VNPAY, MoMo, ShopeePay, thẻ quốc tế và chuyển khoản ngân hàng.</p>
                                <div class="ft-fcard-icon"><i class="fas fa-chevron-up"></i></div>
                            </div>
                            <!-- Card 7 -->
                            <div class="ft-fcard" style="--bg:linear-gradient(135deg,#06B6D4,#22D3EE)">
                                <div class="ft-fcard-emoji">🌐</div>
                                <h4>Đa Ngôn Ngữ</h4>
                                <p>Hỗ trợ 5 ngôn ngữ: Tiếng Việt, English, 한국어, 日本語, 中文.</p>
                                <div class="ft-fcard-icon"><i class="fas fa-chevron-up"></i></div>
                            </div>
                            <!-- Card 8 -->
                            <div class="ft-fcard" style="--bg:linear-gradient(135deg,#F97316,#FB923C)">
                                <div class="ft-fcard-emoji">📊</div>
                                <h4>Dự Đoán AI</h4>
                                <p>Mạng nơ-ron nhân tạo phân tích xu hướng du lịch, giúp bạn đặt tour đúng thời điểm.</p>
                                <div class="ft-fcard-icon"><i class="fas fa-chevron-up"></i></div>
                            </div>

                            <!-- DUPLICATE for seamless loop -->
                            <div class="ft-fcard" style="--bg:linear-gradient(135deg,#8B5CF6,#A78BFA)">
                                <div class="ft-fcard-emoji">🤖</div>
                                <h4>AI Chatbot</h4>
                                <p>Trợ lý AI thông minh hỗ trợ bạn 24/7, gợi ý tour phù hợp với sở thích cá nhân.</p>
                                <div class="ft-fcard-icon"><i class="fas fa-chevron-up"></i></div>
                            </div>
                            <div class="ft-fcard" style="--bg:linear-gradient(135deg,#10B981,#34D399)">
                                <div class="ft-fcard-emoji">📱</div>
                                <h4>Đặt Tour Online</h4>
                                <p>Đặt tour nhanh chóng chỉ vài bước, thanh toán an toàn với nhiều phương thức.</p>
                                <div class="ft-fcard-icon"><i class="fas fa-chevron-up"></i></div>
                            </div>
                            <div class="ft-fcard" style="--bg:linear-gradient(135deg,#EF4444,#F87171)">
                                <div class="ft-fcard-emoji">🗺️</div>
                                <h4>Bản Đồ Thông Minh</h4>
                                <p>Khám phá Đà Nẵng qua bản đồ tương tác, ghim vị trí và nhận gợi ý địa điểm gần.</p>
                                <div class="ft-fcard-icon"><i class="fas fa-chevron-up"></i></div>
                            </div>
                            <div class="ft-fcard" style="--bg:linear-gradient(135deg,#F59E0B,#FBBF24)">
                                <div class="ft-fcard-emoji">⚡</div>
                                <h4>So Sánh Tour</h4>
                                <p>So sánh giá, đánh giá và dịch vụ giữa các tour để chọn lựa tốt nhất cho bạn.</p>
                                <div class="ft-fcard-icon"><i class="fas fa-chevron-up"></i></div>
                            </div>
                            <div class="ft-fcard" style="--bg:linear-gradient(135deg,#3B82F6,#60A5FA)">
                                <div class="ft-fcard-emoji">🎨</div>
                                <h4>Tour 3D Gallery</h4>
                                <p>Xem trước điểm đến với bộ sưu tập 3D sống động trước khi quyết định đặt tour.</p>
                                <div class="ft-fcard-icon"><i class="fas fa-chevron-up"></i></div>
                            </div>
                            <div class="ft-fcard" style="--bg:linear-gradient(135deg,#EC4899,#F472B6)">
                                <div class="ft-fcard-emoji">💳</div>
                                <h4>Thanh Toán Đa Dạng</h4>
                                <p>Hỗ trợ VNPAY, MoMo, ShopeePay, thẻ quốc tế và chuyển khoản ngân hàng.</p>
                                <div class="ft-fcard-icon"><i class="fas fa-chevron-up"></i></div>
                            </div>
                            <div class="ft-fcard" style="--bg:linear-gradient(135deg,#06B6D4,#22D3EE)">
                                <div class="ft-fcard-emoji">🌐</div>
                                <h4>Đa Ngôn Ngữ</h4>
                                <p>Hỗ trợ 5 ngôn ngữ: Tiếng Việt, English, 한국어, 日本語, 中文.</p>
                                <div class="ft-fcard-icon"><i class="fas fa-chevron-up"></i></div>
                            </div>
                            <div class="ft-fcard" style="--bg:linear-gradient(135deg,#F97316,#FB923C)">
                                <div class="ft-fcard-emoji">📊</div>
                                <h4>Dự Đoán AI</h4>
                                <p>Mạng nơ-ron nhân tạo phân tích xu hướng du lịch, giúp bạn đặt tour đúng thời điểm.</p>
                                <div class="ft-fcard-icon"><i class="fas fa-chevron-up"></i></div>
                            </div>
                        </div>
                    </div>
                </section>

                <style>
                    /* ═══ CUTE FEATURE MARQUEE ═══ */
                    .ft-marquee-section{padding:60px 0 50px;overflow:hidden;position:relative}
                    .ft-marquee-section::before{content:'';position:absolute;top:0;left:0;right:0;height:100%;background:linear-gradient(180deg,rgba(248,250,252,.6) 0%,rgba(255,255,255,0) 30%,rgba(255,255,255,0) 70%,rgba(248,250,252,.6) 100%);pointer-events:none;z-index:1}

                    .ft-marquee-header{text-align:center;max-width:600px;margin:0 auto 36px;padding:0 24px}
                    .ft-marquee-badge{display:inline-flex;align-items:center;gap:6px;font-size:.72rem;font-weight:700;color:#FF6F61;background:rgba(255,111,97,.06);padding:6px 16px;border-radius:999px;margin-bottom:14px;letter-spacing:.5px;text-transform:uppercase}
                    .ft-marquee-header h2{font-family:'Playfair Display',serif;font-size:clamp(1.6rem,3.5vw,2.4rem);font-weight:900;color:#1E293B;margin-bottom:10px;letter-spacing:-.02em}
                    .ft-marquee-header p{color:#64748B;font-size:.9rem;line-height:1.7}

                    .ft-marquee-track-wrapper{position:relative;width:100%}
                    .ft-marquee-track-wrapper::before,.ft-marquee-track-wrapper::after{content:'';position:absolute;top:0;bottom:0;width:80px;z-index:2;pointer-events:none}
                    .ft-marquee-track-wrapper::before{left:0;background:linear-gradient(90deg,#fff,transparent)}
                    .ft-marquee-track-wrapper::after{right:0;background:linear-gradient(270deg,#fff,transparent)}

                    .ft-marquee-track{display:flex;gap:20px;animation:ftMarqueeScroll 40s linear infinite;width:fit-content;padding:10px 0}
                    .ft-marquee-track:hover{animation-play-state:paused}

                    @keyframes ftMarqueeScroll{
                        0%{transform:translateX(0)}
                        100%{transform:translateX(-50%)}
                    }

                    .ft-fcard{flex-shrink:0;width:220px;background:var(--bg);border-radius:22px;padding:28px 22px 22px;color:#fff;position:relative;cursor:default;transition:all .35s cubic-bezier(.4,0,.2,1);box-shadow:0 8px 28px rgba(0,0,0,.12)}
                    .ft-fcard:hover{transform:translateY(-6px) scale(1.03);box-shadow:0 16px 40px rgba(0,0,0,.18)}

                    .ft-fcard-emoji{font-size:2.2rem;margin-bottom:14px;filter:drop-shadow(0 2px 4px rgba(0,0,0,.15));line-height:1}
                    .ft-fcard h4{font-family:'Playfair Display',serif;font-size:1.05rem;font-weight:800;margin-bottom:10px;line-height:1.25;letter-spacing:-.01em}
                    .ft-fcard p{font-size:.76rem;line-height:1.6;color:rgba(255,255,255,.8);margin-bottom:16px}
                    .ft-fcard-icon{width:32px;height:32px;background:rgba(255,255,255,.2);border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:.7rem;color:#fff;transition:all .3s;backdrop-filter:blur(4px)}
                    .ft-fcard:hover .ft-fcard-icon{background:rgba(255,255,255,.35);transform:translateY(-2px)}

                    @media(max-width:768px){
                        .ft-fcard{width:190px;padding:22px 18px 18px;border-radius:18px}
                        .ft-fcard-emoji{font-size:1.8rem;margin-bottom:10px}
                        .ft-fcard h4{font-size:.95rem}
                        .ft-fcard p{font-size:.72rem}
                        .ft-marquee-section{padding:40px 0 30px}
                    }
                </style>

                <!-- ═══ ĐIỂM ĐẾN YÊU THÍCH — STICKY STACKING ═══ -->
                <section class="dest-section" id="destSection">
                    <div class="dest-header">
                        <span class="dest-label"><i class="fas fa-compass"></i> Khám phá</span>
                        <h2>Điểm Đến <span class="dest-hl">Yêu Thích</span></h2>
                        <p>Những địa danh nổi tiếng nhất Đà Nẵng — cuộn để khám phá từng điểm đến tuyệt vời.</p>
                    </div>

                    <div class="ds-wrap">
                        <!-- 1: Bà Nà Hills -->
                        <div class="ds-card" style="--ci:0;--ac:#8B5CF6">
                            <a href="${pageContext.request.contextPath}/tour?search=ba+na" class="ds-inner">
                                <div class="ds-img"><img src="${pageContext.request.contextPath}/images/destinations/ba-na-hills.png" alt="Bà Nà Hills" loading="lazy"></div>
                                <div class="ds-body">
                                    <div class="ds-top">
                                        <span class="ds-num">01</span>
                                        <span class="ds-badge" style="background:linear-gradient(135deg,#8B5CF6,#A78BFA);color:#fff"><i class="fas fa-crown"></i> #1 Đà Nẵng</span>
                                        <span class="ds-rating"><i class="fas fa-star"></i> 4.9</span>
                                    </div>
                                    <h3>Bà Nà Hills</h3>
                                    <p class="ds-loc"><i class="fas fa-map-marker-alt"></i> Hòa Vang, Đà Nẵng · <span class="ds-dist">25km từ trung tâm</span></p>
                                    <p class="ds-desc">Cầu Vàng nổi tiếng thế giới, Làng Pháp trên đỉnh núi 1,487m. Fantasy Park, vườn hoa Le Jardin D'Amour.</p>
                                    <div class="ds-chips">
                                        <span style="--cc:#8B5CF6"><i class="fas fa-camera"></i> Check-in</span>
                                        <span style="--cc:#EC4899"><i class="fas fa-heart"></i> Cáp treo</span>
                                        <span style="--cc:#F59E0B"><i class="fas fa-clock"></i> 1 ngày</span>
                                    </div>
                                    <span class="ds-cta" style="background:linear-gradient(135deg,#8B5CF6,#A78BFA)">Khám phá <i class="fas fa-arrow-right"></i></span>
                                </div>
                            </a>
                        </div>

                        <!-- 2: Cầu Rồng -->
                        <div class="ds-card" style="--ci:1;--ac:#EF4444">
                            <a href="${pageContext.request.contextPath}/tour?search=cau+rong" class="ds-inner">
                                <div class="ds-img"><img src="${pageContext.request.contextPath}/images/destinations/cau-rong.png" alt="Cầu Rồng" loading="lazy"></div>
                                <div class="ds-body">
                                    <div class="ds-top">
                                        <span class="ds-num">02</span>
                                        <span class="ds-badge" style="background:linear-gradient(135deg,#EF4444,#F87171);color:#fff"><i class="fas fa-fire"></i> Hot nhất</span>
                                        <span class="ds-rating"><i class="fas fa-star"></i> 5.0</span>
                                    </div>
                                    <h3>Cầu Rồng</h3>
                                    <p class="ds-loc"><i class="fas fa-map-marker-alt"></i> Trung tâm TP · <span class="ds-dist">Sông Hàn</span></p>
                                    <p class="ds-desc">Biểu tượng Đà Nẵng, phun lửa & nước T7-CN 21h. Cây cầu rồng 666m lung linh sắc màu về đêm.</p>
                                    <div class="ds-chips">
                                        <span style="--cc:#EF4444"><i class="fas fa-fire-alt"></i> Phun lửa</span>
                                        <span style="--cc:#3B82F6"><i class="fas fa-moon"></i> Đêm</span>
                                        <span style="--cc:#10B981"><i class="fas fa-wallet"></i> Miễn phí</span>
                                    </div>
                                    <span class="ds-cta" style="background:linear-gradient(135deg,#EF4444,#F87171)">Khám phá <i class="fas fa-arrow-right"></i></span>
                                </div>
                            </a>
                        </div>

                        <!-- 3: Hội An -->
                        <div class="ds-card" style="--ci:2;--ac:#F59E0B">
                            <a href="${pageContext.request.contextPath}/tour?search=hoi+an" class="ds-inner">
                                <div class="ds-img"><img src="${pageContext.request.contextPath}/images/destinations/hoi-an.png" alt="Hội An" loading="lazy"></div>
                                <div class="ds-body">
                                    <div class="ds-top">
                                        <span class="ds-num">03</span>
                                        <span class="ds-badge" style="background:linear-gradient(135deg,#F59E0B,#FBBF24);color:#78350F"><i class="fas fa-landmark"></i> UNESCO</span>
                                        <span class="ds-rating"><i class="fas fa-star"></i> 4.8</span>
                                    </div>
                                    <h3>Phố Cổ Hội An</h3>
                                    <p class="ds-loc"><i class="fas fa-map-marker-alt"></i> Hội An, Quảng Nam · <span class="ds-dist">30km</span></p>
                                    <p class="ds-desc">Di sản UNESCO, phố đèn lồng lung linh, ẩm thực Cao Lầu - Mì Quảng, kiến trúc cổ trăm năm.</p>
                                    <div class="ds-chips">
                                        <span style="--cc:#F59E0B"><i class="far fa-lightbulb"></i> Đèn lồng</span>
                                        <span style="--cc:#EC4899"><i class="fas fa-utensils"></i> Ẩm thực</span>
                                        <span style="--cc:#10B981"><i class="fas fa-ticket-alt"></i> ~150K</span>
                                    </div>
                                    <span class="ds-cta" style="background:linear-gradient(135deg,#F59E0B,#FBBF24);color:#78350F">Khám phá <i class="fas fa-arrow-right"></i></span>
                                </div>
                            </a>
                        </div>

                        <!-- 4: Biển Mỹ Khê -->
                        <div class="ds-card" style="--ci:3;--ac:#06B6D4">
                            <a href="${pageContext.request.contextPath}/tour?categoryId=1" class="ds-inner">
                                <div class="ds-img"><img src="${pageContext.request.contextPath}/images/destinations/bien-my-khe.png" alt="Biển Mỹ Khê" loading="lazy"></div>
                                <div class="ds-body">
                                    <div class="ds-top">
                                        <span class="ds-num">04</span>
                                        <span class="ds-badge" style="background:linear-gradient(135deg,#06B6D4,#22D3EE);color:#fff"><i class="fas fa-trophy"></i> Top 6 TG</span>
                                        <span class="ds-rating"><i class="fas fa-star"></i> 4.7</span>
                                    </div>
                                    <h3>Biển Mỹ Khê</h3>
                                    <p class="ds-loc"><i class="fas fa-map-marker-alt"></i> Ngũ Hành Sơn · <span class="ds-dist">Forbes Top 6</span></p>
                                    <p class="ds-desc">Bãi biển đẹp nhất hành tinh (Forbes). Cát trắng mịn, nước biển trong xanh, lý tưởng lướt sóng.</p>
                                    <div class="ds-chips">
                                        <span style="--cc:#06B6D4"><i class="fas fa-swimmer"></i> Tắm biển</span>
                                        <span style="--cc:#F59E0B"><i class="fas fa-sun"></i> Bình minh</span>
                                        <span style="--cc:#10B981"><i class="fas fa-wallet"></i> Miễn phí</span>
                                    </div>
                                    <span class="ds-cta" style="background:linear-gradient(135deg,#06B6D4,#22D3EE)">Khám phá <i class="fas fa-arrow-right"></i></span>
                                </div>
                            </a>
                        </div>

                        <!-- 5: Sơn Trà -->
                        <div class="ds-card" style="--ci:4;--ac:#10B981">
                            <a href="${pageContext.request.contextPath}/tour?search=son+tra" class="ds-inner">
                                <div class="ds-img"><img src="${pageContext.request.contextPath}/images/destinations/son-tra.png" alt="Sơn Trà" loading="lazy"></div>
                                <div class="ds-body">
                                    <div class="ds-top">
                                        <span class="ds-num">05</span>
                                        <span class="ds-badge" style="background:linear-gradient(135deg,#10B981,#34D399);color:#fff"><i class="fas fa-leaf"></i> Sinh thái</span>
                                        <span class="ds-rating"><i class="fas fa-star"></i> 4.8</span>
                                    </div>
                                    <h3>Bán Đảo Sơn Trà</h3>
                                    <p class="ds-loc"><i class="fas fa-map-marker-alt"></i> Sơn Trà · <span class="ds-dist">10km từ trung tâm</span></p>
                                    <p class="ds-desc">Khu bảo tồn Voọc chà vá chân nâu. Chùa Linh Ứng, tượng Phật Bà 67m nhìn ra biển Đông.</p>
                                    <div class="ds-chips">
                                        <span style="--cc:#10B981"><i class="fas fa-hiking"></i> Trekking</span>
                                        <span style="--cc:#8B5CF6"><i class="fas fa-pray"></i> Tâm linh</span>
                                        <span style="--cc:#06B6D4"><i class="fas fa-paw"></i> Voọc</span>
                                    </div>
                                    <span class="ds-cta" style="background:linear-gradient(135deg,#10B981,#34D399)">Khám phá <i class="fas fa-arrow-right"></i></span>
                                </div>
                            </a>
                        </div>

                        <!-- 6: Ngũ Hành Sơn -->
                        <div class="ds-card" style="--ci:5;--ac:#F97316">
                            <a href="${pageContext.request.contextPath}/tour?search=ngu+hanh+son" class="ds-inner">
                                <div class="ds-img"><img src="${pageContext.request.contextPath}/images/destinations/ngu-hanh-son.png" alt="Ngũ Hành Sơn" loading="lazy"></div>
                                <div class="ds-body">
                                    <div class="ds-top">
                                        <span class="ds-num">06</span>
                                        <span class="ds-badge" style="background:linear-gradient(135deg,#F97316,#FB923C);color:#fff"><i class="fas fa-mountain"></i> Di tích</span>
                                        <span class="ds-rating"><i class="fas fa-star"></i> 4.6</span>
                                    </div>
                                    <h3>Ngũ Hành Sơn</h3>
                                    <p class="ds-loc"><i class="fas fa-map-marker-alt"></i> Ngũ Hành Sơn · <span class="ds-dist">8km</span></p>
                                    <p class="ds-desc">Marble Mountains — 5 ngọn núi đá hoa cương, chùa cổ, hang động kỳ bí, panorama toàn TP.</p>
                                    <div class="ds-chips">
                                        <span style="--cc:#F97316"><i class="fas fa-monument"></i> Chùa cổ</span>
                                        <span style="--cc:#3B82F6"><i class="fas fa-gem"></i> Đá quý</span>
                                        <span style="--cc:#8B5CF6"><i class="fas fa-cloud-sun"></i> Panorama</span>
                                    </div>
                                    <span class="ds-cta" style="background:linear-gradient(135deg,#F97316,#FB923C)">Khám phá <i class="fas fa-arrow-right"></i></span>
                                </div>
                            </a>
                        </div>
                    </div>
                </section>

                <style>
                    /* ═══ STICKY STACKING DESTINATIONS ═══ */
                    .dest-section{max-width:1440px;margin:0 auto;padding:60px 24px 0}
                    .dest-header{text-align:center;margin-bottom:36px}
                    .dest-label{display:inline-flex;align-items:center;gap:6px;font-size:.72rem;font-weight:700;color:#2563EB;background:rgba(37,99,235,.06);padding:6px 16px;border-radius:999px;margin-bottom:14px;letter-spacing:.5px;text-transform:uppercase}
                    .dest-header h2{font-family:'Playfair Display',serif;font-size:clamp(1.8rem,4vw,2.8rem);font-weight:900;color:#1E293B;margin-bottom:10px;letter-spacing:-.02em}
                    .dest-hl{color:#2563EB}
                    .dest-header p{color:#64748B;font-size:.92rem;max-width:460px;margin:0 auto;line-height:1.7}

                    /* Stacking container */
                    .ds-wrap{position:relative}
                    .ds-card{position:sticky;top:calc(100px + var(--ci) * 20px);margin-bottom:16px;z-index:calc(var(--ci) + 1);transition:transform .4s cubic-bezier(.4,0,.2,1),box-shadow .4s}
                    .ds-card:last-child{margin-bottom:0}

                    /* Card inner layout */
                    .ds-inner{display:grid;grid-template-columns:380px 1fr;height:280px;border-radius:20px;overflow:hidden;background:#fff;box-shadow:0 4px 24px rgba(0,0,0,.07),0 0 0 1px rgba(0,0,0,.04);text-decoration:none;color:inherit;transition:all .35s cubic-bezier(.4,0,.2,1);position:relative}
                    .ds-inner::before{content:'';position:absolute;left:0;top:0;bottom:0;width:4px;background:linear-gradient(180deg,var(--ac),color-mix(in srgb,var(--ac) 60%,white));border-radius:20px 0 0 20px;z-index:2}
                    .ds-inner:hover{box-shadow:0 16px 48px rgba(0,0,0,.12);transform:translateY(-4px)}

                    /* Image side */
                    .ds-img{position:relative;overflow:hidden}
                    .ds-img img{width:100%;height:100%;object-fit:cover;transition:transform .6s cubic-bezier(.4,0,.2,1)}
                    .ds-inner:hover .ds-img img{transform:scale(1.08)}

                    /* Content side */
                    .ds-body{padding:24px 28px;display:flex;flex-direction:column;justify-content:center;position:relative;background:linear-gradient(135deg,#fff 60%,color-mix(in srgb,var(--ac) 4%,white) 100%)}

                    .ds-top{display:flex;align-items:center;gap:10px;margin-bottom:8px}
                    .ds-num{font-family:'Playfair Display',serif;font-size:1.6rem;font-weight:900;color:var(--ac);opacity:.2;line-height:1}
                    .ds-badge{padding:4px 12px;border-radius:999px;font-size:.65rem;font-weight:800;display:flex;align-items:center;gap:4px;letter-spacing:.3px}
                    .ds-rating{display:flex;align-items:center;gap:2px;font-size:.7rem;font-weight:700;color:#F59E0B;margin-left:auto}
                    .ds-rating i{font-size:.62rem}

                    .ds-body h3{font-family:'Playfair Display',serif;font-size:1.4rem;font-weight:900;color:#0F172A;margin-bottom:4px;line-height:1.2}

                    .ds-loc{display:flex;align-items:center;gap:5px;font-size:.76rem;color:#94A3B8;margin-bottom:8px;font-weight:500}
                    .ds-loc i{color:var(--ac);font-size:.68rem}
                    .ds-dist{color:var(--ac);font-weight:700}

                    .ds-desc{color:#64748B;font-size:.84rem;line-height:1.65;margin-bottom:12px;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden}

                    .ds-chips{display:flex;gap:6px;flex-wrap:wrap;margin-bottom:14px}
                    .ds-chips span{display:flex;align-items:center;gap:4px;padding:4px 10px;border-radius:8px;font-size:.68rem;font-weight:700;background:color-mix(in srgb,var(--cc) 8%,white);color:var(--cc);border:1px solid color-mix(in srgb,var(--cc) 15%,white);transition:.25s}
                    .ds-chips span i{font-size:.6rem}
                    .ds-inner:hover .ds-chips span{background:color-mix(in srgb,var(--cc) 12%,white);border-color:color-mix(in srgb,var(--cc) 25%,white)}

                    .ds-cta{display:inline-flex;align-items:center;gap:6px;padding:9px 22px;color:#fff;border-radius:10px;font-weight:700;font-size:.78rem;transition:all .3s;box-shadow:0 3px 12px rgba(0,0,0,.15);width:fit-content}
                    .ds-inner:hover .ds-cta{box-shadow:0 6px 20px rgba(0,0,0,.2);transform:translateX(3px)}
                    .ds-cta i{font-size:.7rem;transition:transform .3s}
                    .ds-inner:hover .ds-cta i{transform:translateX(4px)}

                    /* ═══ Responsive ═══ */
                    @media(max-width:1024px){
                        .ds-inner{grid-template-columns:320px 1fr;height:260px}
                        .ds-body{padding:20px 24px}
                    }
                    @media(max-width:768px){
                        .dest-section{padding:40px 16px 0}
                        .ds-card{top:calc(80px + var(--ci) * 14px);margin-bottom:12px}
                        .ds-inner{grid-template-columns:1fr;height:auto}
                        .ds-img{height:200px}
                        .ds-body{padding:18px 20px}
                        .ds-body h3{font-size:1.2rem}
                        .ds-desc{font-size:.8rem}
                        .ds-chips span{padding:3px 8px;font-size:.62rem}
                    }
                    @media(max-width:480px){
                        .ds-card{top:calc(70px + var(--ci) * 10px)}
                        .ds-img{height:160px}
                        .ds-chips{gap:4px}
                    }
                </style>

                </section>


                <!-- ═══ TRENDING TOURS ═══ -->
                <div class="sh" style="margin-bottom:48px;">
                    <div>
                        <h2>Tours Được Yêu Thích</h2>
                        <p class="sub">Được chọn lọc bởi chuyên gia du lịch Đà Nẵng</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/tour" class="more">Xem tất cả <i
                            class="fas fa-arrow-right"></i></a>
                </div>
                <section class="tours">
                    <c:choose>
                        <c:when test="${not empty listTours}">
                            <div class="tour-grid">
                                <c:forEach items="${listTours}" var="t" varStatus="loop">
                                    <div class="tc rv" style="transition-delay:${loop.index * 0.1}s">
                                        <div class="iw">
                                            <img src="${not empty t.imageUrl ? t.imageUrl : 'https://images.unsplash.com/photo-1559592442-7e182c3c03fb?auto=format&fit=crop&w=600&q=80'}"
                                                alt="${t.tourName}">
                                            <div class="bov">
                                                <c:if test="${not empty t.duration}"><span class="bt bt-d"><i
                                                            class="fas fa-clock"></i> ${t.duration}</span></c:if>
                                                <c:if test="${not empty t.category}"><span
                                                        class="bt bt-a">${t.category.categoryName}</span></c:if>
                                            </div>
                                            <button class="wl" type="button"><i class="far fa-heart"></i></button>
                                        </div>
                                        <div class="ct">
                                            <div class="loc"><i class="fas fa-map-pin"></i> Đà Nẵng, Việt Nam</div>
                                            <h3>${t.tourName}</h3>
                                            <p class="desc">${not empty t.description ? t.description : 'Trải nghiệm du
                                                lịch đẳng cấp với hướng dẫn viên chuyên nghiệp tại Đà Nẵng.'}</p>
                                            <div class="bot">
                                                <div>
                                                    <div class="pl">Từ</div>
                                                    <div class="pr">
                                                        <fmt:formatNumber value="${t.price}" type="number"
                                                            groupingUsed="true" />đ <span>/người</span>
                                                    </div>
                                                </div>
                                                <a href="${pageContext.request.contextPath}/tour?action=view&id=${t.tourId}"
                                                    class="btn-book">Đặt Ngay</a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty">
                                <div class="em">🏝️</div>
                                <h3>Sắp Ra Mắt Tours Mới!</h3>
                                <p>Các tour đang được thêm vào hệ thống. Hãy quay lại sau nhé.</p>
                                <a href="${pageContext.request.contextPath}/tour" class="btn-cta btn-accent"
                                    style="padding:14px 36px;font-size:1rem"><i class="fas fa-compass"></i> Khám Phá</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </section>

                <!-- ═══ CTA — DESTINATION 3D CUBE ═══ -->
                <section class="cta">
                    <div class="cta-inner" style="align-items:center">
                        <!-- LEFT: 3D Cube -->
                        <div class="sc-cube-scene rv" id="scCubeScene">
                            <div class="sc-cube" id="scCube">
                                <div class="sc-cube-face sc-front"><img src="${pageContext.request.contextPath}/images/destinations/cau-vang.png" alt="Cầu Vàng"></div>
                                <div class="sc-cube-face sc-back"><img src="${pageContext.request.contextPath}/images/destinations/cau-rong.png" alt="Cầu Rồng"></div>
                                <div class="sc-cube-face sc-right"><img src="${pageContext.request.contextPath}/images/destinations/hoi-an.png" alt="Hội An"></div>
                                <div class="sc-cube-face sc-left"><img src="${pageContext.request.contextPath}/images/destinations/son-tra.png" alt="Sơn Trà"></div>
                                <div class="sc-cube-face sc-top"><img src="${pageContext.request.contextPath}/images/destinations/ba-na-hills.png" alt="Bà Nà Hills"></div>
                                <div class="sc-cube-face sc-bottom"><img src="${pageContext.request.contextPath}/images/destinations/bien-my-khe.png" alt="Biển Mỹ Khê"></div>
                            </div>
                        </div>

                        <!-- RIGHT: Dynamic Info -->
                        <div class="showcase-info rv" id="showcaseInfo">
                            <div class="showcase-info-counter" id="sCounter">01</div>
                            <div class="showcase-info-loc" id="sLoc"><i class="fas fa-map-marker-alt"></i> <span>Bà Nà Hills</span></div>
                            <h2 class="showcase-info-title" id="sTitle">Cầu Vàng</h2>
                            <p class="showcase-info-desc" id="sDesc">Cây cầu nổi tiếng thế giới nằm trên đỉnh Bà Nà, được nâng đỡ bởi đôi bàn tay khổng lồ. Điểm check-in được yêu thích nhất Đà Nẵng với tầm nhìn 360° ra núi rừng hùng vĩ.</p>
                            <p class="showcase-info-highlight" id="sHighlight">⭐ Đánh giá 4.9/5 · Hơn 2 triệu lượt ghé thăm mỗi năm</p>
                            <div class="showcase-info-tags" id="sTags">
                                <span><i class="fas fa-check"></i> Check-in</span>
                                <span><i class="fas fa-check"></i> 4.9 ★</span>
                                <span><i class="fas fa-check"></i> 2M+ lượt</span>
                                <span><i class="fas fa-check"></i> ~800K VNĐ</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/tour?search=cau+vang" class="showcase-info-btn" id="sBtn">Khám phá ngay <i class="fas fa-arrow-right"></i></a>
                        </div>
                    </div>
                </section>

                <style>
                    /* ═══ 3D CUBE SHOWCASE ═══ */
                    .cta{overflow:hidden}
                    .sc-cube-scene{perspective:900px;width:420px;height:360px;flex-shrink:0;cursor:grab;position:relative;display:flex;align-items:center;justify-content:center;overflow:visible}
                    .sc-cube-scene:active{cursor:grabbing}
                    .sc-cube{width:280px;height:280px;position:relative;transform-style:preserve-3d;animation:scCubeSpin 24s ease-in-out infinite}
                    .sc-cube-face{position:absolute;width:280px;height:280px;border-radius:18px;overflow:hidden;box-shadow:0 12px 40px rgba(0,0,0,.45);border:2px solid rgba(255,255,255,.08);backface-visibility:visible}
                    .sc-cube-face img{width:100%;height:100%;object-fit:cover;transition:transform .6s}
                    .sc-cube-face:hover img{transform:scale(1.06)}
                    .sc-front{transform:rotateY(0deg) translateZ(140px)}
                    .sc-back{transform:rotateY(180deg) translateZ(140px)}
                    .sc-right{transform:rotateY(90deg) translateZ(140px)}
                    .sc-left{transform:rotateY(-90deg) translateZ(140px)}
                    .sc-top{transform:rotateX(90deg) translateZ(140px)}
                    .sc-bottom{transform:rotateX(-90deg) translateZ(140px)}
                    @keyframes scCubeSpin{
                        0%{transform:rotateX(-12deg) rotateY(0deg)}
                        16%{transform:rotateX(-6deg) rotateY(90deg)}
                        33%{transform:rotateX(-12deg) rotateY(180deg)}
                        50%{transform:rotateX(-6deg) rotateY(270deg)}
                        66%{transform:rotateX(-12deg) rotateY(360deg)}
                        80%{transform:rotateX(20deg) rotateY(360deg)}
                        100%{transform:rotateX(-12deg) rotateY(360deg)}
                    }

                    /* ═══ SHOWCASE INFO PANEL ═══ */
                    .showcase-info{display:flex;flex-direction:column;gap:12px;max-width:420px}
                    .showcase-info-counter{font-family:'Playfair Display',serif;font-size:5rem;font-weight:900;color:rgba(255,255,255,.06);line-height:1;letter-spacing:-2px;transition:all .4s}
                    .showcase-info-loc{display:inline-flex;align-items:center;gap:6px;font-size:.75rem;font-weight:700;color:#60A5FA;letter-spacing:.3px}
                    .showcase-info-loc i{font-size:.6rem}
                    .showcase-info-title{font-family:'Playfair Display',serif;font-size:clamp(1.8rem,4vw,3rem);font-weight:900;color:#fff;margin:0;line-height:1.15;letter-spacing:-.01em;transition:all .4s}
                    .showcase-info-desc{font-size:.92rem;color:rgba(255,255,255,.55);line-height:1.8;margin:0;transition:all .4s}
                    .showcase-info-highlight{font-size:.8rem;font-weight:600;color:#FF6F61;margin:4px 0 0;font-style:italic;transition:all .4s}
                    .showcase-info-tags{display:flex;gap:10px;flex-wrap:wrap;margin-top:8px}
                    .showcase-info-tags span{display:inline-flex;align-items:center;gap:5px;font-size:.68rem;font-weight:600;color:rgba(255,255,255,.4);background:rgba(255,255,255,.06);padding:6px 14px;border-radius:8px;border:1px solid rgba(255,255,255,.06);transition:all .3s}
                    .showcase-info-tags span i{font-size:.6rem;color:#FF6F61}
                    .showcase-info-btn{display:inline-flex;align-items:center;gap:8px;padding:14px 28px;background:linear-gradient(135deg,#FF6F61,#FF9F1C);color:#fff;border-radius:12px;font-size:.82rem;font-weight:700;text-decoration:none;transition:all .3s;margin-top:8px;width:fit-content;box-shadow:0 4px 20px rgba(255,111,97,.25)}
                    .showcase-info-btn:hover{transform:translateY(-2px);box-shadow:0 8px 28px rgba(255,111,97,.4)}

                    /* Fade transition */
                    .showcase-info.changing .showcase-info-title,
                    .showcase-info.changing .showcase-info-desc,
                    .showcase-info.changing .showcase-info-highlight,
                    .showcase-info.changing .showcase-info-loc,
                    .showcase-info.changing .showcase-info-tags{opacity:0;transform:translateY(8px)}
                    .showcase-info-title,.showcase-info-desc,.showcase-info-highlight,.showcase-info-loc,.showcase-info-tags{transition:opacity .3s,transform .3s}

                    /* Responsive */
                    @media(max-width:1024px){.sc-cube-scene{width:340px;height:300px}.sc-cube{width:280px;height:280px}.sc-cube-face{width:280px;height:280px}.sc-front{transform:rotateY(0deg) translateZ(140px)}.sc-back{transform:rotateY(180deg) translateZ(140px)}.sc-right{transform:rotateY(90deg) translateZ(140px)}.sc-left{transform:rotateY(-90deg) translateZ(140px)}.sc-top{transform:rotateX(90deg) translateZ(140px)}.sc-bottom{transform:rotateX(-90deg) translateZ(140px)}}
                    @media(max-width:768px){
                        .cta-inner{grid-template-columns:1fr!important;text-align:center;gap:40px!important}
                        .sc-cube-scene{width:280px;height:260px;margin:0 auto}.sc-cube{width:240px;height:240px}.sc-cube-face{width:240px;height:240px}.sc-front{transform:rotateY(0deg) translateZ(120px)}.sc-back{transform:rotateY(180deg) translateZ(120px)}.sc-right{transform:rotateY(90deg) translateZ(120px)}.sc-left{transform:rotateY(-90deg) translateZ(120px)}.sc-top{transform:rotateX(90deg) translateZ(120px)}.sc-bottom{transform:rotateX(-90deg) translateZ(120px)}
                        .showcase-info{align-items:center;text-align:center;order:-1}
                        .showcase-info-tags{justify-content:center}
                    }
                    @media(max-width:480px){.sc-cube-scene{width:220px;height:220px}.sc-cube{width:190px;height:190px}.sc-cube-face{width:190px;height:190px}.sc-front{transform:rotateY(0deg) translateZ(95px)}.sc-back{transform:rotateY(180deg) translateZ(95px)}.sc-right{transform:rotateY(90deg) translateZ(95px)}.sc-left{transform:rotateY(-90deg) translateZ(95px)}.sc-top{transform:rotateX(90deg) translateZ(95px)}.sc-bottom{transform:rotateX(-90deg) translateZ(95px)}}
                </style>

                <script>
                    // 3D Cube Showcase
                    (function(){
                        const scData = [
                            {num:'01',loc:'Bà Nà Hills',title:'Cầu Vàng',desc:'Cây cầu nổi tiếng thế giới nằm trên đỉnh Bà Nà, được nâng đỡ bởi đôi bàn tay khổng lồ. Điểm check-in được yêu thích nhất Đà Nẵng với tầm nhìn 360° ra núi rừng hùng vĩ.',highlight:'⭐ Đánh giá 4.9/5 · Hơn 2 triệu lượt ghé thăm mỗi năm',tags:['Check-in','4.9 ★','2M+ lượt','~800K VNĐ'],link:'cau+vang'},
                            {num:'02',loc:'Đà Nẵng',title:'Cầu Rồng',desc:'Biểu tượng Đà Nẵng dài 666m, phun lửa và phun nước mỗi tối thứ 7 và chủ nhật lúc 21h. Kiến trúc rồng uốn lượn ấn tượng, là cây cầu biểu tượng nhất Việt Nam.',highlight:'🔥 Phun lửa & nước mỗi T7-CN lúc 21:00',tags:['Phun lửa','T7-CN 21h','666m','Miễn phí'],link:'cau+rong'},
                            {num:'03',loc:'Quảng Nam',title:'Hội An',desc:'Phố cổ di sản UNESCO với đèn lồng lung linh mỗi đêm. Ẩm thực đường phố nổi tiếng thế giới và trải nghiệm đi thuyền trên sông Hoài.',highlight:'🏛️ Di sản Văn hóa Thế giới UNESCO từ năm 1999',tags:['UNESCO','Ẩm thực','Đèn lồng','Miễn phí'],link:'hoi+an'},
                            {num:'04',loc:'Bán đảo Sơn Trà',title:'Sơn Trà',desc:'Bán đảo xanh 4.400ha — lá phổi xanh của Đà Nẵng. Nơi sinh sống của voọc chà vá chân nâu quý hiếm.',highlight:'🐒 Nơi duy nhất quan sát Voọc chà vá chân nâu',tags:['Thiên nhiên','Voọc','Trekking','Bãi Bụt'],link:'son+tra'},
                            {num:'05',loc:'Sun World',title:'Bà Nà Hills',desc:'Khu du lịch trên đỉnh núi 1.487m với Làng Pháp cổ kính, Fantasy Park trong nhà lớn nhất Việt Nam và hệ thống cáp treo đạt kỷ lục Guinness.',highlight:'🏔️ Cáp treo dài nhất thế giới · Kỷ lục Guinness',tags:['Cáp treo','Làng Pháp','Fantasy Park','~900K VNĐ'],link:'ba+na'},
                            {num:'06',loc:'Đà Nẵng',title:'Biển Mỹ Khê',desc:'Được Forbes bình chọn Top 6 bãi biển đẹp nhất hành tinh. Cát trắng mịn trải dài 900m, nước biển trong xanh ngọc bích.',highlight:'🏖️ Forbes Top 6 bãi biển đẹp nhất hành tinh',tags:['Forbes Top 6','Lướt sóng','Bình minh','Miễn phí'],link:'my+khe'}
                        ];
                        let scIdx=0,cube=document.getElementById('scCube'),scene=document.getElementById('scCubeScene');
                        if(!cube||!scene)return;

                        // Auto-update info panel synced with cube rotation
                        let scTimer=setInterval(function(){scIdx=(scIdx+1)%scData.length;updateSC(scIdx)},4000);
                        function updateSC(idx){
                            const d=scData[idx],info=document.getElementById('showcaseInfo');
                            info.classList.add('changing');
                            setTimeout(function(){
                                document.getElementById('sCounter').textContent=d.num;
                                document.getElementById('sLoc').innerHTML='<i class="fas fa-map-marker-alt"></i> <span>'+d.loc+'</span>';
                                document.getElementById('sTitle').textContent=d.title;
                                document.getElementById('sDesc').textContent=d.desc;
                                document.getElementById('sHighlight').textContent=d.highlight;
                                document.getElementById('sTags').innerHTML=d.tags.map(function(t){return '<span><i class="fas fa-check"></i> '+t+'</span>'}).join('');
                                document.getElementById('sBtn').href='${pageContext.request.contextPath}/tour?search='+d.link;
                                info.classList.remove('changing');
                            },300);
                        }

                        // Drag to rotate
                        let dragging=false,rx=-12,ry=0,sx,sy;
                        scene.addEventListener('mousedown',function(e){dragging=true;sx=e.clientX;sy=e.clientY;cube.style.animationPlayState='paused';clearInterval(scTimer);e.preventDefault()});
                        document.addEventListener('mousemove',function(e){if(!dragging)return;ry+=(e.clientX-sx)*.4;rx-=(e.clientY-sy)*.4;cube.style.transform='rotateX('+rx+'deg) rotateY('+ry+'deg)';sx=e.clientX;sy=e.clientY});
                        document.addEventListener('mouseup',function(){if(dragging){dragging=false;cube.style.animationPlayState='running';scTimer=setInterval(function(){scIdx=(scIdx+1)%scData.length;updateSC(scIdx)},4000)}});
                        // Touch
                        scene.addEventListener('touchstart',function(e){dragging=true;sx=e.touches[0].clientX;sy=e.touches[0].clientY;cube.style.animationPlayState='paused';clearInterval(scTimer)},{passive:true});
                        document.addEventListener('touchmove',function(e){if(!dragging)return;ry+=(e.touches[0].clientX-sx)*.4;rx-=(e.touches[0].clientY-sy)*.4;cube.style.transform='rotateX('+rx+'deg) rotateY('+ry+'deg)';sx=e.touches[0].clientX;sy=e.touches[0].clientY},{passive:true});
                        document.addEventListener('touchend',function(){if(dragging){dragging=false;cube.style.animationPlayState='running';scTimer=setInterval(function(){scIdx=(scIdx+1)%scData.length;updateSC(scIdx)},4000)}});
                    })();
                </script>


                <!-- ═══ FOOTER ═══ -->
                <jsp:include page="/common/_footer.jsp" />

                <script>
                    // Navbar scroll
                    window.addEventListener('scroll', function () {
                        document.getElementById('mainNav').classList.toggle('scrolled', window.scrollY > 60);
                    });
                    // Scroll reveal with stagger for destinations
                    const obs = new IntersectionObserver(e => { e.forEach(el => { if (el.isIntersecting) el.target.classList.add('vis') }) }, { threshold: .08, rootMargin: '0px 0px -40px 0px' });
                    document.querySelectorAll('.rv').forEach(el => obs.observe(el));
                    // Stagger delay for dest-cards
                    document.querySelectorAll('.dest-card.rv').forEach((card, i) => {
                        card.style.transitionDelay = (i * 0.06) + 's';
                    });
                    // Wishlist - actual API integration
                    document.querySelectorAll('.wl').forEach(b => {
                        b.addEventListener('click', function (e) {
                            e.preventDefault(); e.stopPropagation();
                            const i = this.querySelector('i');
                            const tourId = this.dataset.tourId || this.closest('.tc')?.querySelector('[data-tour-id]')?.dataset.tourId;
                            if (!tourId) {
                                // Fallback visual toggle
                                i.classList.toggle('far'); i.classList.toggle('fas');
                                this.style.color = i.classList.contains('fas') ? '#FF6F61' : '';
                                this.style.transform = 'scale(1.3)'; setTimeout(() => this.style.transform = '', 200);
                                return;
                            }
                            fetch('${pageContext.request.contextPath}/wishlist', {
                                method: 'POST',
                                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                body: 'action=toggle&tourId=' + tourId
                            })
                            .then(r => r.json())
                            .then(data => {
                                if (data.success) {
                                    if (data.added) { i.classList.remove('far'); i.classList.add('fas'); this.style.color = '#FF6F61'; }
                                    else { i.classList.remove('fas'); i.classList.add('far'); this.style.color = ''; }
                                    this.style.transform = 'scale(1.3)'; setTimeout(() => this.style.transform = '', 200);
                                }
                            })
                            .catch(() => {
                                i.classList.toggle('far'); i.classList.toggle('fas');
                                this.style.color = i.classList.contains('fas') ? '#FF6F61' : '';
                                this.style.transform = 'scale(1.3)'; setTimeout(() => this.style.transform = '', 200);
                            });
                        });
                    });

                    // ═══ COUNT UP ANIMATION ═══
                    function animateCountUp(el) {
                        const target = parseFloat(el.dataset.count);
                        const suffix = el.dataset.suffix || '';
                        const isDecimal = el.dataset.decimal === 'true';
                        const isK = el.dataset.format === 'K';
                        const duration = 2000;
                        const startTime = performance.now();

                        function update(currentTime) {
                            const elapsed = currentTime - startTime;
                            const progress = Math.min(elapsed / duration, 1);
                            // easeOutExpo
                            const ease = progress === 1 ? 1 : 1 - Math.pow(2, -10 * progress);
                            const current = ease * target;

                            if (isK) {
                                el.textContent = (current / 1000).toFixed(current >= target ? 0 : 1) + 'K' + suffix;
                            } else if (isDecimal) {
                                el.textContent = current.toFixed(1) + suffix;
                            } else {
                                el.textContent = Math.floor(current) + suffix;
                            }

                            if (progress < 1) {
                                requestAnimationFrame(update);
                            }
                        }
                        requestAnimationFrame(update);
                    }

                    const statsObserver = new IntersectionObserver((entries) => {
                        entries.forEach(entry => {
                            if (entry.isIntersecting) {
                                entry.target.querySelectorAll('.num[data-count]').forEach(el => {
                                    animateCountUp(el);
                                });
                                statsObserver.unobserve(entry.target);
                            }
                        });
                    }, { threshold: 0.3 });

                    document.querySelectorAll('.stats-bar').forEach(el => statsObserver.observe(el));
                </script>
                <script src="${pageContext.request.contextPath}/js/i18n.js"></script>
                <script>if(typeof I18N!=='undefined'){I18N.applyTranslations();}</script>
            </body>

            </html>
