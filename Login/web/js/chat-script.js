/**
 * Finer AI Chat Script
 * AJAX communication voi ChatBotServlet
 */
(function () {
    'use strict';

    // === DOM Elements ===
    const toggle = document.getElementById('finerChatToggle');
    const modal = document.getElementById('finerChatModal');
    const closeBtn = document.getElementById('closeChatBtn');
    const clearBtn = document.getElementById('clearChatBtn');
    const messagesEl = document.getElementById('chatMessages');
    const inputEl = document.getElementById('chatInput');
    const sendBtn = document.getElementById('chatSendBtn');
    const badge = document.getElementById('chatBadge');
    const suggestions = document.getElementById('chatSuggestions');
    const statusEl = document.getElementById('chatStatus');
    const chips = document.querySelectorAll('.fcm-chip');

    // Context path (set tu JSP)
    const ctx = document.querySelector('script[src*="chat-script"]')?.src
        ?.match(/(.+?)\/js\//)?.[1] || '';

    let isOpen = false;
    let isProcessing = false;

    // === Toggle modal ===
    if (toggle) {
        toggle.addEventListener('click', function () {
            isOpen = !isOpen;
            if (isOpen) {
                modal.classList.add('open');
                badge.style.display = 'none';
                inputEl.focus();
                scrollToBottom();
            } else {
                modal.classList.remove('open');
            }
        });
    }

    // === Close ===
    if (closeBtn) {
        closeBtn.addEventListener('click', function () {
            isOpen = false;
            modal.classList.remove('open');
        });
    }

    // === Clear Chat ===
    if (clearBtn) {
        clearBtn.addEventListener('click', function () {
            if (!confirm('Xóa toàn bộ lịch sử chat?')) return;

            fetch(ctx + '/chatbot?action=clear', {
                method: 'POST'
            }).then(r => r.json()).then(data => {
                // Giu lai welcome message, xoa phan con lai
                const welcome = messagesEl.querySelector('.fcm-msg.bot');
                messagesEl.innerHTML = '';
                if (welcome) messagesEl.appendChild(welcome);
                suggestions.style.display = 'flex';
            }).catch(err => console.error('Clear error:', err));
        });
    }

    // === Send message ===
    if (sendBtn) {
        sendBtn.addEventListener('click', sendMessage);
    }

    if (inputEl) {
        inputEl.addEventListener('keydown', function (e) {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                sendMessage();
            }
        });
    }

    // === Quick chips ===
    chips.forEach(chip => {
        chip.addEventListener('click', function () {
            inputEl.value = this.dataset.msg;
            sendMessage();
        });
    });

    // === Core: Gui tin nhan ===
    function sendMessage() {
        const text = inputEl.value.trim();
        if (!text || isProcessing) return;

        // An suggestions sau tin nhan dau
        suggestions.style.display = 'none';

        // Hien tin nhan user
        appendMessage(text, 'user', getCurrentTime());

        // Reset input
        inputEl.value = '';
        inputEl.focus();

        // Show typing
        const typingEl = showTyping();
        isProcessing = true;
        sendBtn.disabled = true;
        statusEl.innerHTML = '<i class="status-dot" style="background:#FFD700"></i> Đang suy nghĩ...';

        // Goi API
        fetch(ctx + '/chatbot', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
            },
            body: 'message=' + encodeURIComponent(text)
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Server error ' + response.status);
            }
            return response.json();
        })
        .then(data => {
            // Xoa typing
            if (typingEl) typingEl.remove();

            if (data.success) {
                appendMessage(data.reply, 'bot', data.botTime || getCurrentTime());
            } else {
                appendMessage('⚠️ ' + (data.error || 'Có lỗi xảy ra'), 'bot', getCurrentTime());
            }
        })
        .catch(err => {
            console.error('Chat error:', err);
            if (typingEl) typingEl.remove();
            appendMessage(
                '❌ Không thể kết nối tới Finer AI. Vui lòng thử lại!',
                'bot',
                getCurrentTime()
            );
        })
        .finally(() => {
            isProcessing = false;
            sendBtn.disabled = false;
            statusEl.innerHTML = '<i class="status-dot"></i> Online';
            inputEl.focus();
        });
    }

    // === Hien thi tin nhan ===
    function appendMessage(text, role, time) {
        const div = document.createElement('div');
        div.className = 'fcm-msg ' + role;

        const avatar = role === 'user' ? '👤' : '💘';

        // Escape HTML de tranh XSS
        const safeText = escapeHtml(text).replace(/\n/g, '<br>');

        div.innerHTML =
            '<div class="fcm-msg-avatar">' + avatar + '</div>' +
            '<div class="fcm-msg-content">' +
                '<div class="fcm-msg-bubble">' + safeText + '</div>' +
                '<span class="fcm-msg-time">' + (time || '') + '</span>' +
            '</div>';

        messagesEl.appendChild(div);
        scrollToBottom();
    }

    // === Typing indicator ===
    function showTyping() {
        const div = document.createElement('div');
        div.className = 'fcm-msg bot';
        div.id = 'typingIndicator';
        div.innerHTML =
            '<div class="fcm-msg-avatar">💘</div>' +
            '<div class="fcm-msg-content">' +
                '<div class="fcm-msg-bubble">' +
                    '<div class="typing-dots"><span></span><span></span><span></span></div>' +
                '</div>' +
            '</div>';
        messagesEl.appendChild(div);
        scrollToBottom();
        return div;
    }

    // === Helpers ===
    function scrollToBottom() {
        requestAnimationFrame(() => {
            messagesEl.scrollTop = messagesEl.scrollHeight;
        });
    }

    function getCurrentTime() {
        const now = new Date();
        return now.getHours().toString().padStart(2, '0') + ':' +
               now.getMinutes().toString().padStart(2, '0');
    }

    function escapeHtml(str) {
        const div = document.createElement('div');
        div.textContent = str;
        return div.innerHTML;
    }

    // === Auto-show badge ===
    setTimeout(function () {
        if (!isOpen && badge) {
            badge.style.display = 'flex';
        }
    }, 3000);

})();
