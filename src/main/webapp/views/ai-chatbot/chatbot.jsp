<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- AI Chatbot Widget - Premium -->
<div id="ai-chatbot-container">
    <!-- Tooltip -->
    <div id="chat-tooltip" class="chat-tooltip">
        <span>💬 Hỏi tôi bất cứ điều gì!</span>
        <button class="tooltip-close" id="tooltip-close">×</button>
    </div>

    <!-- Toggle Button -->
    <button id="chat-toggle" class="chat-toggle-btn" title="Chat với AI">
        <i class="fas fa-robot"></i>
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
                    <strong>EzTravel AI</strong>
                    <small><i class="fas fa-circle" style="color:#06D6A0;font-size:.45rem;margin-right:3px"></i> Online — Hỗ trợ 24/7</small>
                </div>
            </div>
            <div class="chat-header-actions">
                <button id="clear-chat" title="Xóa lịch sử"><i class="fas fa-trash-alt"></i></button>
                <button id="close-chat" title="Đóng"><i class="fas fa-times"></i></button>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions">
            <button class="qa-btn" data-msg="Cho tôi xem top tour phổ biến">🏖️ Tour phổ biến</button>
            <button class="qa-btn" data-msg="Tour nào giá rẻ dưới 500k?">💰 Tour giá rẻ</button>
            <button class="qa-btn" data-msg="Tôi muốn đặt tour">🛒 Đặt tour</button>
            <button class="qa-btn" data-msg="Kiểm tra đơn hàng của tôi">📋 Tra đơn hàng</button>
            <button class="qa-btn" data-msg="Tư vấn tour cho gia đình">👨‍👩‍👧‍👦 Tour gia đình</button>
        </div>

        <!-- Messages Area -->
        <div id="chat-messages" class="chat-messages">
            <div class="msg bot-msg">
                <div class="msg-avatar"><i class="fas fa-brain"></i></div>
                <div class="msg-bubble">
                    Xin chào! 👋 Tôi là <strong>EzTravel AI</strong>.<br><br>
                    Tôi có thể giúp bạn:
                    <ul style="margin:8px 0 0 16px;font-size:.82rem">
                        <li>🏖️ Tư vấn tour phù hợp</li>
                        <li>🛒 <strong>Đặt tour</strong> ngay trong chat</li>
                        <li>💰 So sánh giá tour</li>
                        <li>📋 Tra cứu đơn hàng</li>
                        <li>🎤 Nhắn bằng <strong>giọng nói</strong></li>
                        <li>📸 Gửi ảnh để tìm tour tương tự</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Booking Form (hidden by default) -->
        <div id="booking-form" class="booking-form" style="display:none">
            <div class="bf-header">
                <i class="fas fa-shopping-cart"></i> Đặt Tour Nhanh
                <button id="close-booking" class="bf-close"><i class="fas fa-times"></i></button>
            </div>
            <form id="booking-submit-form">
                <div class="bf-field">
                    <label>Mã Tour (Tour ID)</label>
                    <input type="number" id="bf-tour-id" placeholder="VD: 1, 2, 3..." required>
                </div>
                <div class="bf-row">
                    <div class="bf-field">
                        <label>Ngày đi</label>
                        <input type="date" id="bf-date" required>
                    </div>
                    <div class="bf-field">
                        <label>Số khách</label>
                        <input type="number" id="bf-guests" value="1" min="1" max="20" required>
                    </div>
                </div>
                <div class="bf-field">
                    <label>Ghi chú</label>
                    <input type="text" id="bf-note" placeholder="Yêu cầu đặc biệt (tùy chọn)">
                </div>
                <button type="submit" class="bf-btn"><i class="fas fa-check"></i> Xác Nhận Đặt Tour</button>
            </form>
        </div>

        <!-- Order Status (hidden by default) -->
        <div id="order-status" class="order-status" style="display:none">
            <div class="bf-header">
                <i class="fas fa-receipt"></i> Trạng Thái Đơn Hàng
                <button id="close-order" class="bf-close"><i class="fas fa-times"></i></button>
            </div>
            <div id="order-status-content"></div>
        </div>

        <!-- Input Area -->
        <div class="chat-input-area">
            <form id="chat-form">
                <div class="input-row">
                    <label class="attach-btn" title="Gửi ảnh">
                        <i class="fas fa-image"></i>
                        <input type="file" id="image-input" accept="image/*" style="display:none">
                    </label>
                    <input type="text" id="chat-input" placeholder="Hỏi về tour, giá, đặt vé..." autocomplete="off">
                    <button type="button" id="voice-btn" title="Nhắn bằng giọng nói">
                        <i class="fas fa-microphone"></i>
                    </button>
                    <button type="submit" id="send-btn">
                        <i class="fas fa-paper-plane"></i>
                    </button>
                </div>
                <div class="input-hint">
                    🎤 Voice | 📸 Gửi ảnh | Gõ <code>đặt tour</code> để mở form đặt nhanh
                </div>
            </form>
        </div>
    </div>
</div>

<style>
/* ═══ CHATBOT PREMIUM ═══ */
#ai-chatbot-container{position:fixed;bottom:28px;right:28px;z-index:9999;font-family:'Inter',system-ui,sans-serif}

/* Tooltip */
.chat-tooltip{position:absolute;bottom:72px;right:0;background:#fff;color:#1B1F3B;padding:10px 16px;border-radius:12px;box-shadow:0 8px 30px rgba(0,0,0,.15);font-size:.82rem;font-weight:600;white-space:nowrap;display:flex;align-items:center;gap:10px;animation:tooltipIn .5s ease .5s both}
.chat-tooltip::after{content:'';position:absolute;bottom:-6px;right:24px;width:12px;height:12px;background:#fff;transform:rotate(45deg);box-shadow:2px 2px 4px rgba(0,0,0,.06)}
.tooltip-close{background:none;border:none;color:#94A3B8;font-size:1rem;cursor:pointer;padding:0 0 0 4px}
@keyframes tooltipIn{from{opacity:0;transform:translateY(8px)}to{opacity:1;transform:translateY(0)}}

/* Toggle Button */
.chat-toggle-btn{width:62px;height:62px;border-radius:50%;background:linear-gradient(135deg,#1E40AF,#3B82F6);color:#fff;border:none;cursor:pointer;box-shadow:0 8px 30px rgba(37,99,235,.35);display:flex;align-items:center;justify-content:center;transition:.4s cubic-bezier(.175,.885,.32,1.275);position:relative;font-size:1.5rem}
.chat-toggle-btn:hover{transform:scale(1.1);box-shadow:0 12px 40px rgba(37,99,235,.45)}
.chat-notif{position:absolute;top:0;right:0;width:16px;height:16px;background:#EF4444;border:3px solid #fff;border-radius:50%;display:none;animation:bounce .5s ease}
@keyframes bounce{0%,100%{transform:scale(1)}50%{transform:scale(1.3)}}

/* Chat Window - BIGGER */
.chat-window{position:absolute;bottom:80px;right:0;width:380px;height:520px;background:#fff;border-radius:24px;box-shadow:0 25px 80px rgba(27,31,59,.2),0 0 0 1px rgba(27,31,59,.06);display:none;flex-direction:column;overflow:hidden;animation:chatOpen .3s ease}
@keyframes chatOpen{from{opacity:0;transform:translateY(15px) scale(.95)}to{opacity:1;transform:translateY(0) scale(1)}}

/* Header */
.chat-header{background:linear-gradient(135deg,#1E3A5F,#2563EB);color:#fff;padding:18px 20px;display:flex;align-items:center;justify-content:space-between}
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
.user-msg .msg-avatar{background:linear-gradient(135deg,#3B82F6,#60A5FA);color:#fff}

.msg-bubble{padding:12px 16px;border-radius:16px;font-size:.84rem;line-height:1.6;word-wrap:break-word}
.bot-msg .msg-bubble{background:#fff;color:#1B1F3B;border:1px solid #E8EAF0;border-top-left-radius:4px;box-shadow:0 1px 4px rgba(27,31,59,.04)}
.user-msg .msg-bubble{background:linear-gradient(135deg,#3B82F6,#60A5FA);color:#fff;border-top-right-radius:4px}

.msg-bubble strong{font-weight:700}
.msg-bubble code{background:rgba(59,130,246,.1);color:#3B82F6;padding:2px 6px;border-radius:4px;font-size:.78rem}
.msg-bubble ul{margin:6px 0;padding-left:18px}
.msg-bubble ul li{margin-bottom:4px}
.msg-bubble a{color:#3B82F6;font-weight:700;text-decoration:underline}
.msg-bubble img{max-width:100%;border-radius:10px;margin-top:8px}

/* Typing */
.typing-indicator{display:flex;gap:4px;padding:12px 16px}
.typing-indicator span{width:7px;height:7px;background:#A0A5C3;border-radius:50%;animation:typingDot 1.4s infinite}
.typing-indicator span:nth-child(2){animation-delay:.2s}
.typing-indicator span:nth-child(3){animation-delay:.4s}
@keyframes typingDot{0%,60%,100%{transform:translateY(0);opacity:.4}30%{transform:translateY(-8px);opacity:1}}

/* Input */
.chat-input-area{padding:12px 16px;background:#fff;border-top:1px solid #F0F1F5}
.input-row{display:flex;gap:6px;align-items:center}
.attach-btn{width:38px;height:38px;border-radius:10px;background:#F7F8FC;border:1px solid #E8EAF0;display:flex;align-items:center;justify-content:center;cursor:pointer;color:#94A3B8;transition:.3s;flex-shrink:0;font-size:.85rem}
.attach-btn:hover{background:#EEF2FF;color:#3B82F6;border-color:#3B82F6}
#chat-input{flex:1;padding:10px 14px;border:2px solid #E8EAF0;border-radius:12px;font-size:.85rem;outline:none;font-family:inherit;transition:.3s;background:#F7F8FC;color:#1B1F3B}
#chat-input:focus{border-color:#3B82F6;box-shadow:0 0 0 3px rgba(59,130,246,.08);background:#fff}
#chat-input::placeholder{color:#A0A5C3}
#voice-btn{width:38px;height:38px;border-radius:10px;background:#F7F8FC;border:1px solid #E8EAF0;color:#94A3B8;cursor:pointer;transition:.3s;font-size:.85rem;flex-shrink:0;display:flex;align-items:center;justify-content:center}
#voice-btn:hover{background:#EEF2FF;color:#3B82F6;border-color:#3B82F6}
#voice-btn.recording{background:#FEE2E2;color:#EF4444;border-color:#EF4444;animation:pulse-rec 1s ease infinite}
@keyframes pulse-rec{0%,100%{box-shadow:0 0 0 0 rgba(239,68,68,.3)}50%{box-shadow:0 0 0 8px rgba(239,68,68,0)}}
#send-btn{width:38px;height:38px;border-radius:10px;background:linear-gradient(135deg,#3B82F6,#60A5FA);color:#fff;border:none;cursor:pointer;display:flex;align-items:center;justify-content:center;transition:.3s;font-size:.85rem;flex-shrink:0}
#send-btn:hover{transform:scale(1.05);box-shadow:0 4px 12px rgba(59,130,246,.3)}
#send-btn:disabled{opacity:.5;cursor:not-allowed;transform:none}
.input-hint{font-size:.65rem;color:#A0A5C3;margin-top:6px;text-align:center}
.input-hint code{background:rgba(59,130,246,.08);color:#3B82F6;padding:1px 5px;border-radius:3px;font-size:.63rem}

/* Booking Form */
.booking-form,.order-status{background:#fff;border-top:1px solid #F0F1F5;padding:16px;animation:slideUp .3s ease}
@keyframes slideUp{from{opacity:0;transform:translateY(10px)}to{opacity:1;transform:translateY(0)}}
.bf-header{font-size:.88rem;font-weight:800;color:#1B1F3B;margin-bottom:14px;display:flex;align-items:center;gap:8px}
.bf-header i{color:#3B82F6}
.bf-close{margin-left:auto;background:none;border:none;color:#94A3B8;cursor:pointer;font-size:.9rem}
.bf-field{margin-bottom:10px}
.bf-field label{font-size:.72rem;font-weight:700;color:#64748B;display:block;margin-bottom:4px;text-transform:uppercase;letter-spacing:.3px}
.bf-field input{width:100%;padding:9px 12px;border:1.5px solid #E8EAF0;border-radius:10px;font-size:.82rem;font-family:inherit;outline:none;color:#1B1F3B;transition:.3s;background:#F7F8FC}
.bf-field input:focus{border-color:#3B82F6;box-shadow:0 0 0 3px rgba(59,130,246,.08);background:#fff}
.bf-row{display:grid;grid-template-columns:1fr 1fr;gap:10px}
.bf-btn{width:100%;padding:11px;border:none;border-radius:12px;background:linear-gradient(135deg,#3B82F6,#60A5FA);color:#fff;font-weight:800;font-size:.85rem;cursor:pointer;transition:.3s;font-family:inherit;display:flex;align-items:center;justify-content:center;gap:6px;margin-top:4px}
.bf-btn:hover{transform:translateY(-1px);box-shadow:0 6px 20px rgba(59,130,246,.3)}

/* Order Status */
.os-card{background:#F7F8FC;border-radius:12px;padding:14px;margin-bottom:10px;border:1px solid #E8EAF0}
.os-card h4{font-size:.82rem;color:#1B1F3B;margin-bottom:6px}
.os-card p{font-size:.75rem;color:#64748B;margin:3px 0}
.os-badge{display:inline-block;padding:3px 10px;border-radius:999px;font-size:.68rem;font-weight:800}
.os-pending{background:#FEF3C7;color:#D97706}
.os-confirmed{background:#D1FAE5;color:#059669}
.os-paid{background:#DBEAFE;color:#2563EB}
.os-btn{display:inline-flex;align-items:center;gap:4px;padding:7px 14px;border-radius:8px;background:#3B82F6;color:#fff;font-size:.75rem;font-weight:700;border:none;cursor:pointer;margin-top:8px}

/* Mobile */
@media(max-width:500px){
    .chat-window{width:calc(100vw - 16px);right:-20px;bottom:75px;height:calc(100vh - 100px);border-radius:20px}
    .chat-tooltip{display:none!important}
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
    const voiceBtn = document.getElementById('voice-btn');
    const imageInput = document.getElementById('image-input');
    const qaBtns = document.querySelectorAll('.qa-btn');
    const tooltip = document.getElementById('chat-tooltip');
    const tooltipClose = document.getElementById('tooltip-close');
    const contextPath = '${pageContext.request.contextPath}';

    // Toggle chat
    toggleBtn.addEventListener('click', () => {
        const open = chatWindow.style.display === 'flex';
        chatWindow.style.display = open ? 'none' : 'flex';
        if (!open) {
            chatInput.focus();
            document.getElementById('chat-notification').style.display = 'none';
            if (tooltip) tooltip.style.display = 'none';
        }
    });

    closeBtn.addEventListener('click', () => chatWindow.style.display = 'none');
    if (tooltipClose) tooltipClose.addEventListener('click', () => tooltip.style.display = 'none');

    // Clear chat
    clearBtn.addEventListener('click', () => {
        chatMessages.innerHTML = '';
        addBotMessage('🔄 Đã xóa lịch sử. Tôi có thể giúp gì cho bạn?');
    });

    // Quick actions
    qaBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            chatInput.value = btn.dataset.msg;
            chatForm.dispatchEvent(new Event('submit'));
        });
    });

    // === IMAGE UPLOAD ===
    imageInput.addEventListener('change', (e) => {
        const file = e.target.files[0];
        if (!file) return;

        // Preview
        const reader = new FileReader();
        reader.onload = (ev) => {
            const div = document.createElement('div');
            div.className = 'msg user-msg';
            div.innerHTML = '<div class="msg-avatar"><i class="fas fa-user"></i></div>'
                + '<div class="msg-bubble"><img src="' + ev.target.result + '" alt="Ảnh"><br><small>📸 Gửi ảnh</small></div>';
            chatMessages.appendChild(div);
            scrollBottom();

            // Bot response
            setTimeout(() => {
                addBotMessage('📸 Tôi thấy ảnh rất đẹp! Dựa trên ảnh này, tôi gợi ý các tour liên quan:<br><br>'
                    + '🏖️ <a href="' + contextPath + '/tour">Tour tham quan Đà Nẵng</a><br>'
                    + '🌉 <a href="' + contextPath + '/tour?categoryId=3">Tour Bà Nà Hills</a><br>'
                    + '🏮 <a href="' + contextPath + '/tour?categoryId=2">Tour Phố cổ Hội An</a><br><br>'
                    + 'Bạn muốn đặt tour nào? Gõ <code>đặt tour</code> để bắt đầu!');
            }, 1000);
        };
        reader.readAsDataURL(file);
        imageInput.value = '';
    });

    // === VOICE INPUT ===
    let recognition = null;
    let isRecording = false;

    if ('webkitSpeechRecognition' in window || 'SpeechRecognition' in window) {
        const SR = window.SpeechRecognition || window.webkitSpeechRecognition;
        recognition = new SR();
        recognition.lang = 'vi-VN';
        recognition.interimResults = false;
        recognition.continuous = false;

        recognition.onresult = (event) => {
            const text = event.results[0][0].transcript;
            chatInput.value = text;
            chatInput.focus();
        };

        recognition.onend = () => {
            isRecording = false;
            voiceBtn.classList.remove('recording');
            voiceBtn.innerHTML = '<i class="fas fa-microphone"></i>';
        };

        recognition.onerror = () => {
            isRecording = false;
            voiceBtn.classList.remove('recording');
            voiceBtn.innerHTML = '<i class="fas fa-microphone"></i>';
            addBotMessage('⚠️ Không nhận được giọng nói. Vui lòng thử lại.');
        };
    }

    voiceBtn.addEventListener('click', () => {
        if (!recognition) {
            addBotMessage('⚠️ Trình duyệt không hỗ trợ giọng nói. Vui lòng dùng Chrome.');
            return;
        }
        if (isRecording) {
            recognition.stop();
        } else {
            isRecording = true;
            voiceBtn.classList.add('recording');
            voiceBtn.innerHTML = '<i class="fas fa-stop"></i>';
            recognition.start();
        }
    });

    // === BOOKING FORM ===
    const bookingForm = document.getElementById('booking-form');
    const closeBooking = document.getElementById('close-booking');
    const bookingSubmit = document.getElementById('booking-submit-form');

    closeBooking.addEventListener('click', () => bookingForm.style.display = 'none');

    function showBookingForm() {
        bookingForm.style.display = 'block';
        document.getElementById('bf-date').valueAsDate = new Date(Date.now() + 86400000);
    }

    bookingSubmit.addEventListener('submit', (e) => {
        e.preventDefault();
        const tourId = document.getElementById('bf-tour-id').value;
        const date = document.getElementById('bf-date').value;
        const guests = document.getElementById('bf-guests').value;
        const note = document.getElementById('bf-note').value;

        bookingForm.style.display = 'none';

        addBotMessage('✅ <strong>Đang xử lý đặt tour...</strong><br><br>'
            + '📋 Tour ID: <code>#' + tourId + '</code><br>'
            + '📅 Ngày: ' + date + '<br>'
            + '👥 Số khách: ' + guests + '<br>'
            + (note ? '📝 Ghi chú: ' + note + '<br>' : '')
            + '<br>⏳ Đang tạo đơn hàng...');

        // Simulate booking
        setTimeout(() => {
            const orderId = Math.floor(Math.random() * 9000) + 1000;
            addBotMessage('🎉 <strong>Đặt tour thành công!</strong><br><br>'
                + '📋 Mã đơn: <code>#' + orderId + '</code><br>'
                + '💰 Trạng thái: <span style="color:#D97706;font-weight:700">Chờ thanh toán</span><br><br>'
                + '<a href="' + contextPath + '/my-orders" style="display:inline-flex;align-items:center;gap:4px;padding:8px 16px;background:#3B82F6;color:#fff;border-radius:8px;font-weight:700;font-size:.8rem;text-decoration:none"><i class="fas fa-credit-card"></i> Thanh Toán Ngay</a>'
                + '&nbsp;&nbsp;'
                + '<a href="' + contextPath + '/my-orders" style="display:inline-flex;align-items:center;gap:4px;padding:8px 16px;background:#F1F5F9;color:#475569;border-radius:8px;font-weight:700;font-size:.8rem;text-decoration:none"><i class="fas fa-receipt"></i> Xem Đơn Hàng</a>');
            showBookingSuccess();
        }, 1500);
    });

    // === ORDER STATUS ===
    const orderStatus = document.getElementById('order-status');
    const closeOrder = document.getElementById('close-order');
    closeOrder.addEventListener('click', () => orderStatus.style.display = 'none');

    // === SEND MESSAGE ===
    chatForm.addEventListener('submit', async (e) => {
        e.preventDefault();
        const msg = chatInput.value.trim();
        if (!msg) return;

        addUserMessage(msg);
        chatInput.value = '';
        sendBtn.disabled = true;

        // Check for booking intent
        if (msg.toLowerCase().includes('đặt tour') || msg.toLowerCase().includes('book tour') || msg.toLowerCase().includes('dat tour')) {
            setTimeout(() => {
                addBotMessage('🛒 Bạn muốn đặt tour! Tôi đã mở form đặt tour nhanh cho bạn. Hãy điền thông tin bên dưới 👇');
                showBookingForm();
                sendBtn.disabled = false;
            }, 500);
            return;
        }

        // Check for order status intent
        if (msg.toLowerCase().includes('đơn hàng') || msg.toLowerCase().includes('tra cứu') || msg.toLowerCase().includes('trạng thái')) {
            setTimeout(() => {
                addBotMessage('📋 Bạn muốn kiểm tra đơn hàng? <a href="' + contextPath + '/my-orders" style="font-weight:700">Xem tất cả đơn hàng tại đây</a>');
                sendBtn.disabled = false;
            }, 500);
            return;
        }

        const typingEl = showTyping();

        try {
            const res = await fetch(contextPath + '/ai/chat', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                body: 'message=' + encodeURIComponent(msg)
            });

            if (!res.ok && res.status === 404) {
                typingEl.remove();
                addBotMessage('⚠️ Chatbot API chưa sẵn sàng. Vui lòng thử lại sau.');
                sendBtn.disabled = false;
                return;
            }

            let data;
            const text = await res.text();
            try { data = JSON.parse(text); } catch (pe) {
                typingEl.remove();
                addBotMessage('⚠️ Server phản hồi không hợp lệ. Vui lòng thử lại.');
                sendBtn.disabled = false;
                return;
            }
            typingEl.remove();

            if (data.response) {
                addBotMessage(formatMarkdown(data.response));
                if (data.action === 'booked') showBookingSuccess();
            } else if (data.error) {
                addBotMessage('⚠️ ' + data.error);
            }
        } catch (err) {
            typingEl.remove();
            addBotMessage('❌ Không thể kết nối server. Vui lòng thử lại.');
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

    function escapeHtml(text) { const d = document.createElement('div'); d.textContent = text; return d.innerHTML; }
    function scrollBottom() { setTimeout(() => chatMessages.scrollTop = chatMessages.scrollHeight, 50); }

    function showBookingSuccess() {
        const colors = ['#3B82F6', '#06D6A0', '#FFB703', '#00B4D8', '#8B5CF6'];
        for (let i = 0; i < 30; i++) {
            const c = document.createElement('div');
            c.style.cssText = 'position:fixed;width:8px;height:8px;border-radius:50%;pointer-events:none;z-index:99999;'
                + 'background:' + colors[i % colors.length] + ';top:50%;left:' + (30 + Math.random() * 40) + '%;'
                + 'animation:confetti ' + (1 + Math.random()) + 's ease-out forwards;animation-delay:' + (Math.random() * 0.3) + 's';
            document.body.appendChild(c);
            setTimeout(() => c.remove(), 2000);
        }
        if (!document.getElementById('confetti-css')) {
            const s = document.createElement('style');
            s.id = 'confetti-css';
            s.textContent = '@keyframes confetti{0%{transform:translateY(0) rotate(0);opacity:1}100%{transform:translateY(-300px) translateX(' + (Math.random()*100-50) + 'px) rotate(720deg);opacity:0}}';
            document.head.appendChild(s);
        }
    }

    chatInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); chatForm.dispatchEvent(new Event('submit')); }
    });

    // Expose Global API for Map Integration
    window.EzAiChat = {
        sendMessage: function(msg) {
            chatInput.value = msg;
            chatForm.dispatchEvent(new Event('submit'));
            if (chatWindow.style.display !== 'flex') {
                toggleBtn.click();
            }
        },
        suggestNearby: function(lat, lng) {
            if (chatWindow.style.display !== 'flex') {
                toggleBtn.click();
            }
            addBotMessage('📍 Tôi đã nhận được vị trí của bạn! Đang tìm kiếm các điểm du lịch gần đây...');
            const msg = `Tôi đang ở tọa độ ${lat}, ${lng}. Hãy gợi ý cho tôi 3 địa điểm du lịch hoặc quán ăn nổi tiếng gần đây nhất tại Đà Nẵng và lý do nên đến đó.`;
            setTimeout(() => {
                this.sendMessage(msg);
            }, 1000);
        }
    };

    // Show notification after 3s
    setTimeout(() => {
        if (chatWindow.style.display !== 'flex') {
            document.getElementById('chat-notification').style.display = 'block';
        }
    }, 3000);
})();
</script>
