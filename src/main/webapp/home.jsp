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

                    /* ═══ HERO ═══ */
                    /* ═══ HERO — Đà Nẵng Premium ═══ */
                    .hero{position:relative;min-height:88vh;display:flex;align-items:center;justify-content:center;overflow:hidden;padding-top:100px}
                    .hero-bg{position:absolute;inset:0;background-size:cover;background-position:center 40%;z-index:0}
                    .hero-bg::after{content:'';position:absolute;inset:0;background:inherit;background-size:cover;background-position:center 40%;animation:heroFloat 20s ease-in-out infinite alternate;opacity:.5;z-index:0}
                    @keyframes heroFloat{0%{transform:scale(1) translate(0,0)}100%{transform:scale(1.08) translate(-1%,.5%)}}
                    .hero-overlay{position:absolute;inset:0;background:linear-gradient(175deg,rgba(15,23,42,.25) 0%,rgba(15,23,42,.45) 40%,rgba(15,23,42,.82) 100%);z-index:1}
                    .hero::after{content:'';position:absolute;bottom:0;left:0;right:0;height:120px;background:linear-gradient(transparent,#F7F8FC);z-index:2}

                    .hero-content{position:relative;z-index:3;max-width:840px;margin:0 auto;padding:0 24px;width:100%;text-align:center}

                    /* Badge */
                    .hero-badge{display:inline-flex;align-items:center;gap:8px;padding:7px 20px;background:rgba(255,255,255,.08);backdrop-filter:blur(14px);border:1px solid rgba(255,255,255,.12);border-radius:999px;font-size:.78rem;font-weight:600;color:rgba(255,255,255,.9);margin-bottom:24px;animation:heroFadeUp .6s ease}
                    .hero-badge .dot{width:7px;height:7px;background:#10B981;border-radius:50%;animation:dotPulse 2s ease infinite}
                    @keyframes dotPulse{0%,100%{opacity:1;transform:scale(1)}50%{opacity:.3;transform:scale(1.8)}}

                    /* Title */
                    .hero-content h1{font-family:'Playfair Display',serif;font-size:clamp(1.2rem,3vw,2.2rem);font-weight:900;color:#fff;line-height:1.2;margin-bottom:14px;text-shadow:0 3px 12px rgba(0,0,0,.3);letter-spacing:.03em;animation:heroFadeUp .6s ease .08s both;text-align:center;white-space:nowrap}
                    .hero-content>p.hero-sub{font-size:.98rem;color:rgba(255,255,255,.72);max-width:520px;margin:0 auto 32px;line-height:1.7;animation:heroFadeUp .6s ease .15s both}

                    @keyframes heroFadeUp{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}

                    /* SEARCH PANEL — Glassmorphism */
                    .search-panel{position:relative;background:rgba(255,255,255,.88);backdrop-filter:blur(24px) saturate(180%);-webkit-backdrop-filter:blur(24px) saturate(180%);border-radius:20px;max-width:860px;margin:0 auto;box-shadow:0 20px 60px rgba(0,0,0,.18),0 0 0 1px rgba(255,255,255,.35) inset,0 1px 0 rgba(255,255,255,.6) inset;animation:heroFadeUp .6s ease .22s both;overflow:hidden}
                    .search-panel::before{content:'';position:absolute;top:0;left:0;right:0;height:1px;background:linear-gradient(90deg,transparent 10%,rgba(255,255,255,.9) 50%,transparent 90%);z-index:5}
                    .search-panel::after{content:'';position:absolute;top:0;left:-100%;width:60%;height:100%;background:linear-gradient(90deg,transparent,rgba(255,255,255,.12),transparent);animation:glassShine 6s ease-in-out infinite;z-index:4;pointer-events:none}
                    @keyframes glassShine{0%,100%{left:-100%}50%{left:150%}}

                    .search-row{display:flex;align-items:stretch;position:relative;z-index:5}
                    .search-field{flex:1;padding:18px 22px}
                    .search-field+.search-field{border-left:1px solid rgba(0,0,0,.06)}
                    .search-field-label{display:flex;align-items:center;gap:6px;font-size:.7rem;font-weight:800;color:#4B5563;margin-bottom:6px;letter-spacing:.5px;text-transform:uppercase}
                    .search-field-label i{color:#2563EB;font-size:.68rem}
                    .search-field input,.search-field select{border:none;outline:none;font-size:.88rem;width:100%;background:transparent;color:#111827;font-family:'Inter',sans-serif;font-weight:500}
                    .search-field input::placeholder{color:#9CA3AF;font-weight:400}
                    .search-field select{cursor:pointer;-webkit-appearance:none;appearance:none;color:#6B7280}
                    .search-actions{display:flex;align-items:center;padding:0 14px}
                    .search-btn{position:relative;padding:14px 32px;background:linear-gradient(135deg,#2563EB,#3B82F6,#60A5FA);color:#fff;border:none;border-radius:12px;font-weight:700;font-size:.88rem;cursor:pointer;display:flex;align-items:center;gap:8px;font-family:'Inter',sans-serif;transition:all .3s;white-space:nowrap;box-shadow:0 6px 24px rgba(37,99,235,.35);overflow:hidden}
                    .search-btn::before{content:'';position:absolute;top:0;left:-100%;width:100%;height:100%;background:linear-gradient(90deg,transparent,rgba(255,255,255,.25),transparent);transition:.6s}
                    .search-btn:hover::before{left:100%}
                    .search-btn:hover{transform:translateY(-2px);box-shadow:0 8px 32px rgba(37,99,235,.45)}

                    /* SEARCH TABS */
                    .search-tabs{display:flex;align-items:center;gap:0;border-bottom:1px solid rgba(0,0,0,.06);padding:0 12px;position:relative;z-index:5;background:rgba(255,255,255,.3)}
                    .search-tab{display:flex;align-items:center;gap:7px;padding:14px 20px;font-size:.84rem;font-weight:600;color:#6B7280;border-bottom:2.5px solid transparent;transition:.3s;text-decoration:none;white-space:nowrap}
                    .search-tab:hover{color:#2563EB;background:rgba(37,99,235,.03)}
                    .search-tab.active{color:#2563EB;border-bottom-color:#2563EB;font-weight:700;background:rgba(37,99,235,.04)}
                    .search-tab i{font-size:.8rem}

                    /* QUICK CATEGORIES */
                    .hero-cats{display:flex;justify-content:center;flex-wrap:wrap;gap:10px;margin-top:28px;animation:heroFadeUp .6s ease .35s both}
                    .hero-cat{display:flex;flex-direction:column;align-items:center;gap:6px;padding:12px 16px;background:rgba(255,255,255,.08);backdrop-filter:blur(10px);border:1px solid rgba(255,255,255,.1);border-radius:14px;cursor:pointer;transition:all .3s;text-decoration:none;min-width:80px}
                    .hero-cat:hover{background:rgba(255,255,255,.18);border-color:rgba(255,255,255,.25);transform:translateY(-4px)}
                    .hero-cat-icon{font-size:1.5rem;line-height:1;filter:drop-shadow(0 2px 4px rgba(0,0,0,.15))}
                    .hero-cat-name{font-size:.68rem;font-weight:700;color:rgba(255,255,255,.88);text-align:center;letter-spacing:.2px;line-height:1.2}

                    /* MAP */
                    .map-section{position:relative;background:#F7F8FC;padding:0}
                    .map-wrap{position:relative;height:400px;overflow:hidden}
                    .map-wrap iframe{width:100%;height:100%;border:0;filter:saturate(1.08)}
                    .map-label{position:absolute;top:14px;left:14px;z-index:10;display:flex;align-items:center;gap:7px;padding:9px 16px;background:rgba(255,255,255,.94);backdrop-filter:blur(8px);border-radius:10px;box-shadow:0 4px 14px rgba(0,0,0,.08);font-size:.8rem;font-weight:700;color:#1E293B}
                    .map-label i{color:#2563EB}

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
                        max-width: 1280px;
                        margin: -70px auto 0;
                        padding: 0 30px;
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
                        max-width: 1280px;
                        margin: 70px auto;
                        padding: 0 30px
                    }

                    .stats-bar {
                        display: grid;
                        grid-template-columns: repeat(4, 1fr);
                        background: #1B1F3B;
                        border-radius: 24px;
                        position: relative;
                        overflow: hidden
                    }

                    .stats-bar::before {
                        content: '';
                        position: absolute;
                        inset: 0;
                        background: radial-gradient(circle at 20% 50%, rgba(255, 111, 97, .12), transparent 50%), radial-gradient(circle at 80% 50%, rgba(0, 180, 216, .12), transparent 50%)
                    }

                    .st {
                        padding: 42px 28px;
                        text-align: center;
                        position: relative;
                        border-right: 1px solid rgba(255, 255, 255, .06)
                    }

                    .st:last-child {
                        border-right: none
                    }

                    .st .num {
                        font-size: 2.4rem;
                        font-weight: 800;
                        color: #fff;
                        letter-spacing: -1px
                    }

                    .st .lab {
                        font-size: .88rem;
                        color: rgba(255, 255, 255, .5);
                        margin-top: 6px;
                        font-weight: 500
                    }

                    /* ═══ SECTION HEADER ═══ */
                    .sh {
                        display: flex;
                        justify-content: space-between;
                        align-items: flex-end;
                        margin-bottom: 48px;
                        max-width: 1280px;
                        margin-left: auto;
                        margin-right: auto;
                        padding: 0 30px
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
                        max-width: 1280px;
                        margin: 0 auto 100px;
                        padding: 0 30px
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
                        max-width: 1280px;
                        margin: 0 auto;
                        padding: 0 30px;
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

                    /* ═══ RESPONSIVE ═══ */
                    @media(max-width:1024px) {
                        .hero-right {
                            display: none
                        }

                        .hero-left h1 {
                            font-size: 3rem
                        }

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

                        .hero {
                            min-height: 90vh
                        }

                        .hero-left h1 {
                            font-size: 2.2rem
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
                    }

                    @media(max-width:480px) {
                        .hero-left h1 {
                            font-size: 1.8rem
                        }

                        .search-box {
                            flex-direction: column;
                            border-radius: 16px
                        }

                        .search-box .btn-cta {
                            border-radius: 12px;
                            width: 100%;
                            justify-content: center
                        }

                        .stats-bar {
                            grid-template-columns: 1fr
                        }
                    }
                </style>
            </head>

            <body>
                <jsp:include page="/common/_header.jsp" />

                <!-- ═══ HERO ═══ -->
                <section class="hero">
                    <div class="hero-bg" style="background-image:url('${pageContext.request.contextPath}/images/hero-bg.png')"></div>
                    <div class="hero-overlay"></div>
                <div class="hero-content">
                        <div class="hero-badge" data-i18n="hero.badge"><span class="dot"></span> Hơn 5,000+ du khách tin tưởng</div>
                        <h1 data-i18n="hero.title">EZTRAVEL - TRẢI NGHIỆM DU LỊCH DỄ DÀNG</h1>
                        <p class="hero-sub" data-i18n="hero.desc">Khám phá những điểm đến tuyệt vời, trải nghiệm độc đáo và lên kế hoạch cho chuyến đi hoàn hảo của bạn!</p>

                        <!-- Service Tabs + Search Panel -->
                        <div class="search-panel">
                            <!-- Tab Bar -->
                            <div class="search-tabs">
                                <a href="${pageContext.request.contextPath}/tour" class="search-tab active"><i class="fas fa-suitcase-rolling"></i> Tour trọn gói</a>
                                <a href="#" class="search-tab"><i class="fas fa-hotel"></i> Khách sạn</a>
                                <a href="#" class="search-tab"><i class="fas fa-plane"></i> Vé máy bay</a>
                                <a href="${pageContext.request.contextPath}/tour" class="search-tab"><i class="fas fa-layer-group"></i> Combo</a>
                            </div>
                            <!-- Search Fields -->
                            <form action="${pageContext.request.contextPath}/tour" method="get">
                                <div class="search-row">
                                    <div class="search-field">
                                        <div class="search-field-label"><i class="fas fa-map-marker-alt"></i> <span data-i18n="search.where">Bạn muốn đi đâu?</span> <span style="color:#EF4444">*</span></div>
                                        <input type="text" name="search" placeholder="vd: Bà Nà, Phú Quốc, Đà Nẵng...">
                                    </div>
                                    <div class="search-field">
                                        <div class="search-field-label"><i class="fas fa-calendar-alt"></i> <span data-i18n="search.date">Ngày đi</span></div>
                                        <input type="text" name="date" placeholder="dd/mm/yyyy" onfocus="this.type='date'" onblur="if(!this.value)this.type='text'">
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

                        <!-- Scroll Down Arrow -->
                        <div class="scroll-hint" onclick="document.querySelector('.map-section').scrollIntoView({behavior:'smooth'})">
                            <span style="font-size:.75rem;color:rgba(255,255,255,.6);letter-spacing:.1em;text-transform:uppercase;margin-bottom:8px">Khám phá ngay</span>
                            <i class="fas fa-chevron-down" style="font-size:1.2rem;color:rgba(255,255,255,.7)"></i>
                        </div>
                        <style>
                            .scroll-hint{display:flex;flex-direction:column;align-items:center;cursor:pointer;margin-top:24px;animation:scrollBounce 2s ease-in-out infinite;transition:opacity .3s}
                            .scroll-hint:hover{opacity:.9}
                            .scroll-hint:hover i{transform:translateY(4px)}
                            .scroll-hint i{transition:transform .3s ease}
                            @keyframes scrollBounce{0%,100%{transform:translateY(0)}50%{transform:translateY(8px)}}
                        </style>
                    </div>
                </section>

                <!-- ═══ GOOGLE MAP ═══ -->
                <section class="map-section">
                    <div class="map-wrap">
                        <div class="map-label"><i class="fas fa-map-marker-alt"></i> Vị Trí Của Tôi</div>
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d61349.26893498857!2d108.17!3d16.05!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314219c792252a13%3A0xfc14e3a044436f37!2sDa%20Nang%2C%20Vietnam!5e0!3m2!1svi!2s!4v1709000000000" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                    </div>
                </section>

                <!-- ═══ ĐIỂM ĐẾN YÊU THÍCH ═══ -->
                <section style="max-width:1200px;margin:0 auto;padding:64px 20px 48px">
                    <div style="text-align:center;margin-bottom:40px">
                        <h2 style="font-family:'Playfair Display',serif;font-size:clamp(1.6rem,3.5vw,2.4rem);font-weight:900;color:#1E293B;margin-bottom:8px;letter-spacing:-.02em">ĐIỂM ĐẾN YÊU THÍCH</h2>
                        <div style="width:48px;height:3px;background:linear-gradient(90deg,#2563EB,#60A5FA);margin:0 auto 16px;border-radius:99px"></div>
                        <p style="color:#64748B;font-size:.92rem;max-width:500px;margin:0 auto;line-height:1.7">Hãy chọn một điểm đến du lịch nổi tiếng dưới đây để khám phá các chuyến đi độc quyền tại Đà Nẵng</p>
                    </div>

                    <!-- Masonry Photo Grid -->
                    <div style="display:grid;grid-template-columns:repeat(4,1fr);grid-auto-rows:180px;gap:12px">
                        <!-- Cầu Rồng - Span 2 rows -->
                        <a href="${pageContext.request.contextPath}/tour?search=cau+rong" class="rv" style="grid-row:span 2;position:relative;border-radius:16px;overflow:hidden;display:block;text-decoration:none">
                            <img src="${pageContext.request.contextPath}/images/destinations/cau-rong.png" alt="Cầu Rồng" style="width:100%;height:100%;object-fit:cover;transition:transform .5s ease">
                            <div style="position:absolute;inset:0;background:linear-gradient(0deg,rgba(0,0,0,.55) 0%,transparent 60%);transition:background .3s"></div>
                            <div style="position:absolute;bottom:20px;left:20px;color:#fff">
                                <div style="font-size:1.1rem;font-weight:800;letter-spacing:.5px;text-shadow:0 2px 8px rgba(0,0,0,.3)">CẦU RỒNG</div>
                                <div style="font-size:.72rem;color:rgba(255,255,255,.7);margin-top:2px">Dragon Bridge · Biểu tượng Đà Nẵng</div>
                            </div>
                        </a>

                        <!-- Bà Nà Hills -->
                        <a href="${pageContext.request.contextPath}/tour?search=ba+na" class="rv" style="position:relative;border-radius:16px;overflow:hidden;display:block;text-decoration:none">
                            <img src="${pageContext.request.contextPath}/images/destinations/ba-na-hills.png" alt="Bà Nà Hills" style="width:100%;height:100%;object-fit:cover;transition:transform .5s ease">
                            <div style="position:absolute;inset:0;background:linear-gradient(0deg,rgba(0,0,0,.5) 0%,transparent 60%)"></div>
                            <div style="position:absolute;bottom:14px;left:14px;color:#fff">
                                <div style="font-size:.88rem;font-weight:800;letter-spacing:.5px">BÀ NÀ HILLS</div>
                                <div style="font-size:.65rem;color:rgba(255,255,255,.65);margin-top:1px">Làng Pháp trên đỉnh núi</div>
                            </div>
                        </a>

                        <!-- Cầu Vàng -->
                        <a href="${pageContext.request.contextPath}/tour?search=cau+vang" class="rv" style="position:relative;border-radius:16px;overflow:hidden;display:block;text-decoration:none">
                            <img src="${pageContext.request.contextPath}/images/destinations/cau-vang.png" alt="Cầu Vàng" style="width:100%;height:100%;object-fit:cover;transition:transform .5s ease">
                            <div style="position:absolute;inset:0;background:linear-gradient(0deg,rgba(0,0,0,.5) 0%,transparent 60%)"></div>
                            <div style="position:absolute;bottom:14px;left:14px;color:#fff">
                                <div style="font-size:.88rem;font-weight:800;letter-spacing:.5px">CẦU VÀNG</div>
                                <div style="font-size:.65rem;color:rgba(255,255,255,.65);margin-top:1px">Golden Bridge · Bàn Tay Khổng Lồ</div>
                            </div>
                        </a>

                        <!-- Asia Park -->
                        <a href="${pageContext.request.contextPath}/tour?search=asia+park" class="rv" style="position:relative;border-radius:16px;overflow:hidden;display:block;text-decoration:none">
                            <img src="${pageContext.request.contextPath}/images/destinations/asia-park.png" alt="Asia Park" style="width:100%;height:100%;object-fit:cover;transition:transform .5s ease">
                            <div style="position:absolute;inset:0;background:linear-gradient(0deg,rgba(0,0,0,.5) 0%,transparent 60%)"></div>
                            <div style="position:absolute;bottom:14px;left:14px;color:#fff">
                                <div style="font-size:.88rem;font-weight:800;letter-spacing:.5px">ASIA PARK</div>
                                <div style="font-size:.65rem;color:rgba(255,255,255,.65);margin-top:1px">Sun World · Vòng quay Sun Wheel</div>
                            </div>
                        </a>

                        <!-- Biển Mỹ Khê - Span 2 cols -->
                        <a href="${pageContext.request.contextPath}/tour?categoryId=1" class="rv" style="grid-column:span 2;position:relative;border-radius:16px;overflow:hidden;display:block;text-decoration:none">
                            <img src="${pageContext.request.contextPath}/images/destinations/bien-my-khe.png" alt="Biển Mỹ Khê" style="width:100%;height:100%;object-fit:cover;transition:transform .5s ease">
                            <div style="position:absolute;inset:0;background:linear-gradient(0deg,rgba(0,0,0,.5) 0%,transparent 60%)"></div>
                            <div style="position:absolute;bottom:16px;left:16px;color:#fff">
                                <div style="font-size:1rem;font-weight:800;letter-spacing:.5px">BIỂN MỸ KHÊ</div>
                                <div style="font-size:.7rem;color:rgba(255,255,255,.7);margin-top:2px">Top 6 bãi biển đẹp nhất hành tinh</div>
                            </div>
                        </a>

                        <!-- Hội An -->
                        <a href="${pageContext.request.contextPath}/tour?search=hoi+an" class="rv" style="position:relative;border-radius:16px;overflow:hidden;display:block;text-decoration:none">
                            <img src="${pageContext.request.contextPath}/images/destinations/hoi-an.png" alt="Hội An" style="width:100%;height:100%;object-fit:cover;transition:transform .5s ease">
                            <div style="position:absolute;inset:0;background:linear-gradient(0deg,rgba(0,0,0,.5) 0%,transparent 60%)"></div>
                            <div style="position:absolute;bottom:14px;left:14px;color:#fff">
                                <div style="font-size:.88rem;font-weight:800;letter-spacing:.5px">HỘI AN</div>
                                <div style="font-size:.65rem;color:rgba(255,255,255,.65);margin-top:1px">Phố cổ UNESCO · Đèn lồng</div>
                            </div>
                        </a>

                        <!-- Sơn Trà -->
                        <a href="${pageContext.request.contextPath}/tour?search=son+tra" class="rv" style="position:relative;border-radius:16px;overflow:hidden;display:block;text-decoration:none">
                            <img src="${pageContext.request.contextPath}/images/destinations/son-tra.png" alt="Sơn Trà" style="width:100%;height:100%;object-fit:cover;transition:transform .5s ease">
                            <div style="position:absolute;inset:0;background:linear-gradient(0deg,rgba(0,0,0,.5) 0%,transparent 60%)"></div>
                            <div style="position:absolute;bottom:14px;left:14px;color:#fff">
                                <div style="font-size:.88rem;font-weight:800;letter-spacing:.5px">SƠN TRÀ</div>
                                <div style="font-size:.65rem;color:rgba(255,255,255,.65);margin-top:1px">Bán đảo xanh · Voọc chà vá</div>
                            </div>
                        </a>

                        <!-- Ngũ Hành Sơn -->
                        <a href="${pageContext.request.contextPath}/tour?search=ngu+hanh+son" class="rv" style="position:relative;border-radius:16px;overflow:hidden;display:block;text-decoration:none">
                            <img src="${pageContext.request.contextPath}/images/destinations/ngu-hanh-son.png" alt="Ngũ Hành Sơn" style="width:100%;height:100%;object-fit:cover;transition:transform .5s ease">
                            <div style="position:absolute;inset:0;background:linear-gradient(0deg,rgba(0,0,0,.5) 0%,transparent 60%)"></div>
                            <div style="position:absolute;bottom:14px;left:14px;color:#fff">
                                <div style="font-size:.88rem;font-weight:800;letter-spacing:.5px">NGŨ HÀNH SƠN</div>
                                <div style="font-size:.65rem;color:rgba(255,255,255,.65);margin-top:1px">Marble Mountains · Hang động</div>
                            </div>
                        </a>

                        <!-- Chùa Linh Ứng -->
                        <a href="${pageContext.request.contextPath}/tour?search=linh+ung" class="rv" style="position:relative;border-radius:16px;overflow:hidden;display:block;text-decoration:none">
                            <img src="${pageContext.request.contextPath}/images/destinations/chua-linh-ung.png" alt="Chùa Linh Ứng" style="width:100%;height:100%;object-fit:cover;transition:transform .5s ease">
                            <div style="position:absolute;inset:0;background:linear-gradient(0deg,rgba(0,0,0,.5) 0%,transparent 60%)"></div>
                            <div style="position:absolute;bottom:14px;left:14px;color:#fff">
                                <div style="font-size:.88rem;font-weight:800;letter-spacing:.5px">CHÙA LINH ỨNG</div>
                                <div style="font-size:.65rem;color:rgba(255,255,255,.65);margin-top:1px">Tượng Phật Bà · Linh thiêng</div>
                            </div>
                        </a>

                        <!-- Bãi biển Non Nước -->
                        <a href="${pageContext.request.contextPath}/tour?search=non+nuoc" class="rv" style="position:relative;border-radius:16px;overflow:hidden;display:block;text-decoration:none">
                            <img src="${pageContext.request.contextPath}/images/destinations/non-nuoc.png" alt="Non Nước" style="width:100%;height:100%;object-fit:cover;transition:transform .5s ease">
                            <div style="position:absolute;inset:0;background:linear-gradient(0deg,rgba(0,0,0,.5) 0%,transparent 60%)"></div>
                            <div style="position:absolute;bottom:14px;left:14px;color:#fff">
                                <div style="font-size:.88rem;font-weight:800;letter-spacing:.5px">BÃI BIỂN NON NƯỚC</div>
                                <div style="font-size:.65rem;color:rgba(255,255,255,.65);margin-top:1px">Bãi tắm đẹp · Làng đá mỹ nghệ</div>
                            </div>
                        </a>
                    </div>

                    <!-- Hover effect CSS -->
                    <style>
                        [style*="border-radius:16px"]:hover img{transform:scale(1.08)!important}
                        [style*="border-radius:16px"]:hover div[style*="gradient"]{background:linear-gradient(0deg,rgba(0,0,0,.65) 0%,rgba(0,0,0,.1) 60%)!important}
                        @media(max-width:768px){
                            [style*="grid-template-columns:repeat(4"]{grid-template-columns:repeat(2,1fr)!important;grid-auto-rows:160px!important}
                            [style*="grid-row:span 2"]{grid-row:span 1!important}
                            [style*="grid-column:span 2"]{grid-column:span 2!important}
                        }
                        @media(max-width:480px){
                            [style*="grid-template-columns:repeat(4"]{grid-template-columns:1fr!important;grid-auto-rows:200px!important}
                            [style*="grid-column:span 2"]{grid-column:span 1!important}
                        }
                    </style>
                </section>

                <!-- ═══ STATS ═══ -->
                <section class="stats">
                    <div class="stats-bar rv">
                        <div class="st">
                            <div class="num" style="color:#2563EB">100+</div>
                            <div class="lab">Tours Xác Minh</div>
                        </div>
                        <div class="st">
                            <div class="num" style="color:#0EA5E9">50+</div>
                            <div class="lab">Đối Tác Uy Tín</div>
                        </div>
                        <div class="st">
                            <div class="num" style="color:#10B981">5K+</div>
                            <div class="lab">Khách Hài Lòng</div>
                        </div>
                        <div class="st">
                            <div class="num" style="color:#F59E0B">4.9★</div>
                            <div class="lab">Đánh Giá</div>
                        </div>
                    </div>
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

                <!-- ═══ CTA ═══ -->
                <section class="cta">
                    <div class="cta-inner">
                        <div class="rv">
                            <h2>Tham Gia<br><span class="hl">Da Nang Hub</span></h2>
                            <p>Nhận ưu đãi độc quyền cho Bà Nà Hills, quyền truy cập sớm tour lễ hội và công cụ AI dự
                                báo doanh thu.</p>
                            <div class="nl-form">
                                <input type="email" placeholder="Email của bạn">
                                <button class="btn-cta btn-accent" style="padding:16px 30px">Đăng Ký <i
                                        class="fas fa-arrow-right"></i></button>
                            </div>
                        </div>
                        <div class="feats rv">
                            <div class="feat">
                                <div class="fi">🛡️</div>
                                <h4>Đối Tác Uy Tín</h4>
                                <p>Mọi tour đều được xác minh bởi chuyên gia</p>
                            </div>
                            <div class="feat">
                                <div class="fi">🤖</div>
                                <h4>AI Dự Báo</h4>
                                <p>Công nghệ ML dự báo doanh thu chính xác</p>
                            </div>
                            <div class="feat">
                                <div class="fi">⚡</div>
                                <h4>Đặt Tức Thì</h4>
                                <p>Xác nhận realtime, không chờ đợi</p>
                            </div>
                            <div class="feat">
                                <div class="fi">💳</div>
                                <h4>QR SePay</h4>
                                <p>Thanh toán quét mã siêu nhanh</p>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- ═══ FOOTER ═══ -->
                <jsp:include page="/common/_footer.jsp" />

                <script>
                    // Navbar scroll
                    window.addEventListener('scroll', function () {
                        document.getElementById('mainNav').classList.toggle('scrolled', window.scrollY > 60);
                    });
                    // Scroll reveal
                    const obs = new IntersectionObserver(e => { e.forEach(el => { if (el.isIntersecting) el.target.classList.add('vis') }) }, { threshold: .08, rootMargin: '0px 0px -40px 0px' });
                    document.querySelectorAll('.rv').forEach(el => obs.observe(el));
                    // Wishlist
                    document.querySelectorAll('.wl').forEach(b => {
                        b.addEventListener('click', function (e) {
                            e.preventDefault(); e.stopPropagation();
                            const i = this.querySelector('i');
                            i.classList.toggle('far'); i.classList.toggle('fas');
                            this.style.color = i.classList.contains('fas') ? '#FF6F61' : '';
                            this.style.transform = 'scale(1.3)'; setTimeout(() => this.style.transform = '', 200);
                        });
                    });
                </script>
                <script src="${pageContext.request.contextPath}/js/i18n.js"></script>
                <script>if(typeof I18N!=='undefined'){I18N.applyTranslations();}</script>
            </body>

            </html>