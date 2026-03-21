/**
 * provider-realtime.js
 * SSE client cho trang admin - nhận thông báo realtime khi có NCC đăng ký mới.
 * Nhúng vào trang admin có contextPath được định nghĩa trước.
 */
(function () {
    const ctx = window._contextPath || '';
    const evtSource = new EventSource(ctx + '/provider/events');

    evtSource.addEventListener('new-provider', function (e) {
        try {
            const data = JSON.parse(e.data);
            showProviderToast(data.businessName, data.providerType, data.registeredAt);
            incrementPendingBadge();
        } catch (err) {
            console.error('SSE parse error', err);
        }
    });

    evtSource.onerror = function () {
        // EventSource tự reconnect - không cần xử lý thêm
    };

    function showProviderToast(businessName, providerType, registeredAt) {
        const time = registeredAt ? registeredAt.replace('T', ' ').substring(0, 16) : '';
        const toast = document.createElement('div');
        toast.className = 'provider-toast';
        toast.innerHTML =
            '<div class="provider-toast-icon"><i class="fas fa-store"></i></div>' +
            '<div class="provider-toast-body">' +
            '  <strong>Nhà cung cấp mới đăng ký!</strong>' +
            '  <div>' + escHtml(businessName) + ' &mdash; <em>' + escHtml(providerType) + '</em></div>' +
            '  <small>' + time + '</small>' +
            '</div>' +
            '<button class="provider-toast-close" onclick="this.parentElement.remove()">&times;</button>';

        document.body.appendChild(toast);
        // Trigger animation
        requestAnimationFrame(function () { toast.classList.add('show'); });
        // Tự đóng sau 8 giây
        setTimeout(function () {
            toast.classList.remove('show');
            setTimeout(function () { toast.remove(); }, 400);
        }, 8000);
    }

    function incrementPendingBadge() {
        const badge = document.getElementById('provider-pending-badge');
        if (badge) {
            const current = parseInt(badge.textContent, 10) || 0;
            badge.textContent = current + 1;
            badge.style.display = 'inline-block';
        }
    }

    function escHtml(str) {
        return String(str)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;');
    }
})();
