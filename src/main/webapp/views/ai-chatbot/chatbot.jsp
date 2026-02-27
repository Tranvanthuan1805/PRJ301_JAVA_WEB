<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- AI Chatbot Widget -->
<div id="ai-chatbot-container">
    <!-- Toggle Button -->
    <button id="chat-toggle" class="chat-toggle-btn" title="Chat với AI">
        <i class="fas fa-robot"></i>
        <div class="pulse-ring"></div>
        <div id="chat-notification" class="chat-notif"></div>
    </button>

    <!-- Chat Window -->
    <div id="chat-window" class="chat-window">
        <!-- Header -->
        <div class="chat-header">
            <div class="chat-header-info">
                <div class="ai-avatar">
                    <i class="fas fa-brain"></i>
                    <span class="online-dot"></span>
                </div>
                <div>
                    <strong>Da Nang Hub AI</strong>
                    <small><i class="fas fa-circle" style="color:#06D6A0;font-size:.45rem;margin-right:3px"></i> Online — Hỗ trợ 24/7</small>
                </div>
            </div>
            <div class="chat-header-actions">
                <button id="clear-chat" title="Xóa lịch sử chat"><i class="fas fa-trash-alt"></i></button>
                <button id="close-chat" title="Đóng"><i class="fas fa-times"></i></button>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions">
            <button class="qa-btn" data-msg="Cho tôi xem top tour phổ biến">🏖️ Tour phổ biến</button>
            <button class="qa-btn" data-msg="Tour nào giá rẻ dưới 500k?">💰 Tour giá rẻ</button>
            <button class="qa-btn" data-msg="Tôi muốn đặt tour">🛒 Đặt tour</button>
            <button class="qa-btn" data-msg="Tư vấn tour cho gia đình 4 người">👨‍👩‍👧‍👦 Tour gia đình</button>
        </div>

        <!-- Messages Area -->
        <div id="chat-messages" class="chat-messages">
            <div class="msg bot-msg">
                <div class="msg-avatar"><i class="fas fa-brain"></i></div>
                <div class="msg-bubble">
                    Xin chào! 👋 Tôi là <strong>Da Nang Hub AI</strong>.<br><br>
                    Tôi có thể giúp bạn:
                    <ul style="margin:8px 0 0 16px;font-size:.82rem">
                        <li>🏖️ Tư vấn tour phù hợp</li>
                        <li>🛒 <strong>Đặt tour</strong> ngay trong chat</li>
                        <li>💰 So sánh giá tour</li>
                        <li>📋 Tra cứu đơn hàng</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Input Area -->
        <div class="chat-input-area">
            <form id="chat-form">
                <div class="input-row">
                    <input type="text" id="chat-input" placeholder="Hỏi về tour, giá, đặt vé..." autocomplete="off">
                    <button type="submit" id="send-btn">
                        <i class="fas fa-paper-plane"></i>
                    </button>
                </div>
                <div class="input-hint">
                    💡 Gõ <code>đặt tour #ID</code> để đặt nhanh
                </div>
            </form>
        </div>
    </div>
</div>

<style>
/* ═══ CHATBOT STYLES ═══ */
#ai-chatbot-container{position:fixed;bottom:28px;right:28px;z-index:9999;font-family:'Plus Jakarta Sans',system-ui,sans-serif}

/* Toggle Button */
.chat-toggle-btn{width:62px;height:62px;border-radius:50%;background:linear-gradient(135deg,#1B1F3B,#2D3561);color:#fff;border:none;cursor:pointer;box-shadow:0 8px 30px rgba(27,31,59,.35);display:flex;align-items:center;justify-content:center;transition:.4s cubic-bezier(.175,.885,.32,1.275);position:relative;font-size:1.5rem}
.chat-toggle-btn:hover{transform:scale(1.1);box-shadow:0 12px 40px rgba(27,31,59,.45)}
.pulse-ring{position:absolute;inset:-4px;border-radius:50%;border:2px solid rgba(255,111,97,.4);animation:pulse 2s ease-out infinite}
@keyframes pulse{0%{transform:scale(1);opacity:1}100%{transform:scale(1.5);opacity:0}}
.chat-notif{position:absolute;top:0;right:0;width:16px;height:16px;background:#FF6F61;border:3px solid #fff;border-radius:50%;display:none;animation:bounce .5s ease}
@keyframes bounce{0%,100%{transform:scale(1)}50%{transform:scale(1.3)}}

/* Chat Window */
.chat-window{position:absolute;bottom:80px;right:0;width:400px;height:580px;background:#fff;border-radius:24px;box-shadow:0 25px 80px rgba(27,31,59,.2),0 0 0 1px rgba(27,31,59,.06);display:none;flex-direction:column;overflow:hidden;animation:chatOpen .3s ease}
@keyframes chatOpen{from{opacity:0;transform:translateY(15px) scale(.95)}to{opacity:1;transform:translateY(0) scale(1)}}

/* Header */
.chat-header{background:linear-gradient(135deg,#1B1F3B,#2D3561);color:#fff;padding:18px 20px;display:flex;align-items:center;justify-content:space-between}
.chat-header-info{display:flex;align-items:center;gap:12px}
.ai-avatar{width:42px;height:42px;border-radius:14px;background:rgba(255,255,255,.1);display:flex;align-items:center;justify-content:center;font-size:1.1rem;position:relative}
.online-dot{position:absolute;bottom:-1px;right:-1px;width:10px;height:10px;background:#06D6A0;border:2px solid #1B1F3B;border-radius:50%}
.chat-header-info strong{display:block;font-size:.92rem}
.chat-header-info small{font-size:.7rem;opacity:.7}
.chat-header-actions{display:flex;gap:6px}
.chat-header-actions button{background:rgba(255,255,255,.1);border:none;color:rgba(255,255,255,.6);width:32px;height:32px;border-radius:10px;cursor:pointer;transition:.3s;font-size:.8rem}
.chat-header-actions button:hover{background:rgba(255,255,255,.2);color:#fff}

/* Quick Actions */
.quick-actions{display:flex;gap:6px;padding:12px 16px;overflow-x:auto;border-bottom:1px solid #F0F1F5;background:#FAFBFF}
.quick-actions::-webkit-scrollbar{display:none}
.qa-btn{white-space:nowrap;padding:7px 14px;border-radius:999px;border:1px solid #E8EAF0;background:#fff;color:#4A4E6F;font-size:.72rem;font-weight:700;cursor:pointer;transition:.3s;font-family:inherit;flex-shrink:0}
.qa-btn:hover{background:#1B1F3B;color:#fff;border-color:#1B1F3B}

/* Messages */
.chat-messages{flex:1;overflow-y:auto;padding:16px;display:flex;flex-direction:column;gap:14px;background:#F7F8FC;scroll-behavior:smooth}
.chat-messages::-webkit-scrollbar{width:4px}
.chat-messages::-webkit-scrollbar-thumb{background:#E8EAF0;border-radius:4px}

.msg{display:flex;gap:8px;max-width:88%;animation:msgIn .3s ease}
@keyframes msgIn{from{opacity:0;transform:translateY(8px)}to{opacity:1;transform:translateY(0)}}
.msg.user-msg{align-self:flex-end;flex-direction:row-reverse}
.msg-avatar{width:30px;height:30px;border-radius:10px;display:flex;align-items:center;justify-content:center;flex-shrink:0;font-size:.7rem}
.bot-msg .msg-avatar{background:linear-gradient(135deg,#1B1F3B,#2D3561);color:#fff}
.user-msg .msg-avatar{background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff}

.msg-bubble{padding:12px 16px;border-radius:16px;font-size:.84rem;line-height:1.6;word-wrap:break-word}
.bot-msg .msg-bubble{background:#fff;color:#1B1F3B;border:1px solid #E8EAF0;border-top-left-radius:4px;box-shadow:0 1px 4px rgba(27,31,59,.04)}
.user-msg .msg-bubble{background:linear-gradient(135deg,#1B1F3B,#2D3561);color:#fff;border-top-right-radius:4px}

.msg-bubble strong{font-weight:700}
.msg-bubble code{background:rgba(255,111,97,.1);color:#FF6F61;padding:2px 6px;border-radius:4px;font-size:.78rem;font-family:'Plus Jakarta Sans',monospace}
.msg-bubble ul{margin:6px 0;padding-left:18px}
.msg-bubble ul li{margin-bottom:4px}
.msg-bubble a{color:#FF6F61;font-weight:700;text-decoration:underline}

/* Typing */
.typing-indicator{display:flex;gap:4px;padding:12px 16px}
.typing-indicator span{width:7px;height:7px;background:#A0A5C3;border-radius:50%;animation:typingDot 1.4s infinite}
.typing-indicator span:nth-child(2){animation-delay:.2s}
.typing-indicator span:nth-child(3){animation-delay:.4s}
@keyframes typingDot{0%,60%,100%{transform:translateY(0);opacity:.4}30%{transform:translateY(-8px);opacity:1}}

/* Input */
.chat-input-area{padding:14px 16px;background:#fff;border-top:1px solid #F0F1F5}
.input-row{display:flex;gap:8px}
#chat-input{flex:1;padding:12px 16px;border:2px solid #E8EAF0;border-radius:14px;font-size:.88rem;outline:none;font-family:inherit;transition:.3s;background:#F7F8FC;color:#1B1F3B}
#chat-input:focus{border-color:#FF6F61;box-shadow:0 0 0 3px rgba(255,111,97,.08);background:#fff}
#chat-input::placeholder{color:#A0A5C3}
#send-btn{width:44px;height:44px;border-radius:14px;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;border:none;cursor:pointer;display:flex;align-items:center;justify-content:center;transition:.3s;font-size:.9rem;flex-shrink:0}
#send-btn:hover{transform:scale(1.05);box-shadow:0 4px 12px rgba(255,111,97,.3)}
#send-btn:disabled{opacity:.5;cursor:not-allowed;transform:none}
.input-hint{font-size:.68rem;color:#A0A5C3;margin-top:8px;text-align:center}
.input-hint code{background:rgba(255,111,97,.08);color:#FF6F61;padding:1px 5px;border-radius:3px;font-size:.66rem}

/* Mobile */
@media(max-width:500px){
    .chat-window{width:calc(100vw - 20px);right:-18px;bottom:75px;height:calc(100vh - 120px);border-radius:20px}
}
</style>

<script>
(function() {
    const toggleBtn = document.getElementById('chat-toggle');
    const chatWindow = document.getElementById('chat-window');
    const closeBtn = document.getElementById('close-chat');
    const clearBtn = document.getElementById('clear-chat');
    const chatForm = document.getElementById('chat-form');
    const chatInput = document.getElementById('chat-input');
    const chatMessages = document.getElementById('chat-messages');
    const sendBtn = document.getElementById('send-btn');
    const qaBtns = document.querySelectorAll('.qa-btn');
    const contextPath = '${pageContext.request.contextPath}';

    // Toggle chat
    toggleBtn.addEventListener('click', () => {
        const open = chatWindow.style.display === 'flex';
        chatWindow.style.display = open ? 'none' : 'flex';
        if (!open) {
            chatInput.focus();
            document.getElementById('chat-notification').style.display = 'none';
        }
    });

    closeBtn.addEventListener('click', () => chatWindow.style.display = 'none');

    // Clear chat
    clearBtn.addEventListener('click', () => {
        chatMessages.innerHTML = '';
        addBotMessage('🔄 Lịch sử chat đã được xóa. Tôi có thể giúp gì cho bạn?');
    });

    // Quick actions
    qaBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            chatInput.value = btn.dataset.msg;
            chatForm.dispatchEvent(new Event('submit'));
        });
    });

    // Send message
    chatForm.addEventListener('submit', async (e) => {
        e.preventDefault();
        const msg = chatInput.value.trim();
        if (!msg) return;

        addUserMessage(msg);
        chatInput.value = '';
        sendBtn.disabled = true;

        // Show typing
        const typingEl = showTyping();

        try {
            const res = await fetch(contextPath + '/ai/chat', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                body: 'message=' + encodeURIComponent(msg)
            });

            if (!res.ok && res.status === 404) {
                typingEl.remove();
                addBotMessage('⚠️ Chatbot servlet chưa được deploy. Hãy build lại project trong NetBeans (Clean and Build → Run).');
                sendBtn.disabled = false;
                return;
            }

            let data;
            const text = await res.text();
            try {
                data = JSON.parse(text);
            } catch (parseErr) {
                typingEl.remove();
                addBotMessage('⚠️ Server trả về response không hợp lệ (status ' + res.status + '). Hãy build lại project.');
                console.error('Response text:', text);
                sendBtn.disabled = false;
                return;
            }
            typingEl.remove();

            if (data.response) {
                addBotMessage(formatMarkdown(data.response));

                if (data.action === 'booked') {
                    showBookingSuccess();
                }
            } else if (data.error) {
                addBotMessage('⚠️ ' + data.error);
            }
        } catch (err) {
            typingEl.remove();
            addBotMessage('❌ Không thể kết nối tới server. Kiểm tra:\n• Server đang chạy?\n• Đã build lại project?');
            console.error('Chat error:', err);
        }

        sendBtn.disabled = false;
        chatInput.focus();
    });

    function addUserMessage(text) {
        const div = document.createElement('div');
        div.className = 'msg user-msg';
        div.innerHTML = '<div class="msg-avatar"><i class="fas fa-user"></i></div>'
            + '<div class="msg-bubble">' + escapeHtml(text) + '</div>';
        chatMessages.appendChild(div);
        scrollBottom();
    }

    function addBotMessage(html) {
        const div = document.createElement('div');
        div.className = 'msg bot-msg';
        div.innerHTML = '<div class="msg-avatar"><i class="fas fa-brain"></i></div>'
            + '<div class="msg-bubble">' + html + '</div>';
        chatMessages.appendChild(div);
        scrollBottom();
    }

    function showTyping() {
        const div = document.createElement('div');
        div.className = 'msg bot-msg typing-msg';
        div.innerHTML = '<div class="msg-avatar"><i class="fas fa-brain"></i></div>'
            + '<div class="msg-bubble"><div class="typing-indicator"><span></span><span></span><span></span></div></div>';
        chatMessages.appendChild(div);
        scrollBottom();
        return div;
    }

    function formatMarkdown(text) {
        if (!text) return '';
        return text
            .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
            .replace(/\*(.*?)\*/g, '<em>$1</em>')
            .replace(/`(.*?)`/g, '<code>$1</code>')
            .replace(/\[([^\]]+)\]\(([^)]+)\)/g, '<a href="$2" target="_blank">$1</a>')
            .replace(/\n/g, '<br>')
            .replace(/^- (.+)/gm, '• $1');
    }

    function escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    function scrollBottom() {
        setTimeout(() => chatMessages.scrollTop = chatMessages.scrollHeight, 50);
    }

    function showBookingSuccess() {
        // Mini confetti effect
        const colors = ['#FF6F61', '#06D6A0', '#FFB703', '#00B4D8', '#FF9A8B'];
        for (let i = 0; i < 30; i++) {
            const conf = document.createElement('div');
            conf.style.cssText = 'position:fixed;width:8px;height:8px;border-radius:50%;pointer-events:none;z-index:99999;'
                + 'background:' + colors[i % colors.length] + ';'
                + 'top:50%;left:' + (30 + Math.random() * 40) + '%;'
                + 'animation:confetti ' + (1 + Math.random()) + 's ease-out forwards;'
                + 'animation-delay:' + (Math.random() * 0.3) + 's';
            document.body.appendChild(conf);
            setTimeout(() => conf.remove(), 2000);
        }

        // Add confetti keyframes if not exists
        if (!document.getElementById('confetti-css')) {
            const style = document.createElement('style');
            style.id = 'confetti-css';
            style.textContent = '@keyframes confetti{0%{transform:translateY(0) rotate(0);opacity:1}100%{transform:translateY(-300px) translateX(' + (Math.random()*100-50) + 'px) rotate(720deg);opacity:0}}';
            document.head.appendChild(style);
        }
    }

    // Enter to send
    chatInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            chatForm.dispatchEvent(new Event('submit'));
        }
    });

    // Show notification after 3 seconds
    setTimeout(() => {
        if (chatWindow.style.display !== 'flex') {
            document.getElementById('chat-notification').style.display = 'block';
        }
    }, 3000);
})();
</script>
