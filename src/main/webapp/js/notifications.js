/**
 * notifications.js — Notification Bell UI + WebSocket realtime
 * Nhận mọi loại thông báo từ server qua WebSocket /ws/notifications
 */
(function () {
    'use strict';

    // ── Storage key ──────────────────────────────────────────────
    const STORAGE_KEY = 'eztravel_notifications';
    const STORAGE_VERSION = 'v2'; // tăng version để clear cache cũ bị lỗi encoding
    const MAX_ITEMS = 50;

    // Clear data cũ nếu version không khớp
    if (localStorage.getItem('eztravel_notif_ver') !== STORAGE_VERSION) {
        localStorage.removeItem(STORAGE_KEY);
        localStorage.setItem('eztravel_notif_ver', STORAGE_VERSION);
    }

    // ── Helpers ──────────────────────────────────────────────────
    function loadNotifs() {
        try { return JSON.parse(localStorage.getItem(STORAGE_KEY) || '[]'); }
        catch (e) { return []; }
    }

    function saveNotifs(list) {
        localStorage.setItem(STORAGE_KEY, JSON.stringify(list.slice(0, MAX_ITEMS)));
    }

    function timeAgo(ts) {
        const diff = Math.floor((Date.now() - ts) / 1000);
        if (diff < 60) return 'Vừa xong';
        if (diff < 3600) return Math.floor(diff / 60) + ' phút trước';
        if (diff < 86400) return Math.floor(diff / 3600) + ' giờ trước';
        return Math.floor(diff / 86400) + ' ngày trước';
    }

    function iconClass(type) {
        if (type === 'NEW_PROVIDER' || type === 'STATUS_UPDATE') return 'provider';
        if (type === 'NEW_ORDER') return 'order';
        return 'system';
    }

    function iconSymbol(type) {
        if (type === 'NEW_PROVIDER') return '<i class="fas fa-handshake"></i>';
        if (type === 'STATUS_UPDATE') return '<i class="fas fa-check-circle"></i>';
        if (type === 'NEW_ORDER') return '<i class="fas fa-receipt"></i>';
        return '<i class="fas fa-bell"></i>';
    }

    // ── Render ────────────────────────────────────────────────────
    function render() {
        const list = loadNotifs();
        const listEl = document.getElementById('notifList');
        const emptyEl = document.getElementById('notifEmpty');
        const badge = document.getElementById('notifBadge');
        if (!listEl) return;

        const unread = list.filter(n => !n.read).length;

        // Badge
        if (badge) {
            badge.textContent = unread > 99 ? '99+' : unread;
            badge.classList.toggle('show', unread > 0);
        }

        // List
        const items = list.filter(n => n !== null);
        if (items.length === 0) {
            if (emptyEl) emptyEl.style.display = '';
            // Remove old items
            listEl.querySelectorAll('.notif-item').forEach(el => el.remove());
            return;
        }
        if (emptyEl) emptyEl.style.display = 'none';

        // Rebuild list
        listEl.querySelectorAll('.notif-item').forEach(el => el.remove());
        items.forEach((n, idx) => {
            const div = document.createElement('div');
            div.className = 'notif-item' + (n.read ? '' : ' unread');
            div.dataset.idx = idx;
            div.innerHTML =
                '<div class="notif-item-icon ' + iconClass(n.type) + '">' + iconSymbol(n.type) + '</div>' +
                '<div class="notif-item-body">' +
                '<div class="notif-item-title">' + escHtml(n.title) + '</div>' +
                '<div class="notif-item-desc">' + escHtml(n.desc) + '</div>' +
                '<div class="notif-item-time">' + timeAgo(n.ts) + '</div>' +
                '</div>';
            div.addEventListener('click', function () {
                markRead(idx);
                if (n.link) window.location.href = n.link;
            });
            listEl.appendChild(div);
        });
    }

    function escHtml(str) {
        return (str || '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
    }

    function markRead(idx) {
        const list = loadNotifs();
        if (list[idx]) { list[idx].read = true; saveNotifs(list); render(); }
    }

    // ── Push notification ─────────────────────────────────────────
    function push(notif) {
        const list = loadNotifs();
        list.unshift(notif);
        saveNotifs(list);
        render();
        showToast(notif);
    }

    function showToast(notif) {
        const toast = document.createElement('div');
        toast.style.cssText =
            'position:fixed;bottom:24px;right:24px;background:#1E293B;color:#fff;' +
            'padding:14px 20px;border-radius:12px;box-shadow:0 8px 24px rgba(0,0,0,.2);' +
            'z-index:9999;display:flex;align-items:center;gap:12px;max-width:320px;' +
            'animation:slideInRight .3s ease;font-size:.85rem;font-weight:600;';
        toast.innerHTML =
            '<span style="font-size:1.2rem">' + iconSymbol(notif.type) + '</span>' +
            '<span>' + escHtml(notif.title) + '<br><span style="font-weight:400;opacity:.8">' + escHtml(notif.desc) + '</span></span>';
        document.body.appendChild(toast);
        setTimeout(() => { toast.style.opacity = '0'; toast.style.transition = 'opacity .4s'; setTimeout(() => toast.remove(), 400); }, 4000);
    }

    // ── WebSocket ─────────────────────────────────────────────────
    function connectWS() {
        const proto = location.protocol === 'https:' ? 'wss' : 'ws';
        const ctx = document.querySelector('meta[name="ctx"]') ? document.querySelector('meta[name="ctx"]').content : '';
        const url = proto + '://' + location.host + ctx + '/ws/notifications';

        let ws;
        let retryDelay = 3000;

        function connect() {
            try {
                ws = new WebSocket(url);
            } catch (e) { return; }

            ws.onmessage = function (e) {
                try {
                    const data = JSON.parse(e.data);
                    handleEvent(data);
                } catch (err) { /* ignore */ }
            };

            ws.onclose = function () {
                // Reconnect sau vài giây
                setTimeout(connect, retryDelay);
                retryDelay = Math.min(retryDelay * 1.5, 30000);
            };

            ws.onopen = function () {
                retryDelay = 3000; // reset
            };
        }

        connect();
    }

    function handleEvent(data) {
        if (data.type === 'NEW_PROVIDER') {
            push({
                type: 'NEW_PROVIDER',
                title: '🔔 Nhà cung cấp mới đăng ký',
                desc: (data.businessName || 'Một doanh nghiệp') + ' vừa gửi đơn. Đang chờ: ' + data.count,
                link: getCtx() + '/admin/provider-requests',
                ts: Date.now(),
                read: false
            });
        } else if (data.type === 'STATUS_UPDATE') {
            push({
                type: 'STATUS_UPDATE',
                title: '✅ Cập nhật trạng thái NCC',
                desc: 'Còn ' + data.count + ' đơn đang chờ duyệt.',
                link: getCtx() + '/admin/provider-requests',
                ts: Date.now(),
                read: false
            });
        } else if (data.type === 'NEW_ORDER') {
            push({
                type: 'NEW_ORDER',
                title: '🛒 Đơn hàng mới',
                desc: data.message || 'Có đơn hàng mới cần xử lý.',
                link: getCtx() + '/admin/orders',
                ts: Date.now(),
                read: false
            });
        } else {
            // Generic event
            push({
                type: 'SYSTEM',
                title: data.title || '📢 Thông báo hệ thống',
                desc: data.message || '',
                link: data.link || null,
                ts: Date.now(),
                read: false
            });
        }
    }

    function getCtx() {
        const meta = document.querySelector('meta[name="ctx"]');
        return meta ? meta.content : '';
    }

    // ── Public UI API ─────────────────────────────────────────────
    window.NotifUI = {
        toggle: function (e) {
            e.stopPropagation();
            const dd = document.getElementById('notifDropdown');
            if (dd) dd.classList.toggle('open');
        },
        markAll: function () {
            const list = loadNotifs().map(n => Object.assign({}, n, { read: true }));
            saveNotifs(list);
            render();
        }
    };

    // Close dropdown khi click ngoài
    document.addEventListener('click', function (e) {
        const wrapper = document.getElementById('notifWrapper');
        if (wrapper && !wrapper.contains(e.target)) {
            const dd = document.getElementById('notifDropdown');
            if (dd) dd.classList.remove('open');
        }
    });

    // ── Init ──────────────────────────────────────────────────────
    document.addEventListener('DOMContentLoaded', function () {
        render();
        connectWS();
        // Refresh time labels mỗi phút
        setInterval(render, 60000);
    });

    // CSS animation
    const style = document.createElement('style');
    style.textContent = '@keyframes slideInRight{from{transform:translateX(100%);opacity:0}to{transform:translateX(0);opacity:1}}';
    document.head.appendChild(style);

})();
