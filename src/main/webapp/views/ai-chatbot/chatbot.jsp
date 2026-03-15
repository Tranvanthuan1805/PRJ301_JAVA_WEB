<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- Reuse tours from request scope (set by servlet) to avoid duplicate DB query --%>
<script>
    window.__CHAT_TOURS__ = [
        <c:forEach items="${listTours}" var="t" varStatus="s">
        {"tourId":${t.tourId},"tourName":"<c:out value='${t.tourName}' escapeXml='true'/>","price":${t.price},"destination":"<c:out value='${t.destination}' escapeXml='true'/>","maxPeople":${t.maxPeople}}<c:if test="${!s.last}">,</c:if>
        </c:forEach>
    ];
</script>

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
                <div id="bf-loading" style="text-align:center;padding:20px;display:none">
                    <i class="fas fa-spinner fa-spin"></i> Đang tải danh sách tour...
                </div>
                <div class="bf-field">
                    <label>Chọn Tour</label>
                    <select id="bf-tour-id" class="bf-select" required>
                        <option value="">-- Chọn tour bạn muốn đặt --</option>
                    </select>
                </div>
                <div id="bf-tour-info" style="display:none;background:#F0F7FF;border-radius:10px;padding:10px;margin-bottom:10px;font-size:.8rem;border:1px solid #DBEAFE">
                    <strong id="bf-tour-name"></strong><br>
                    <span style="color:#3B82F6;font-weight:700" id="bf-tour-price"></span>
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
.bf-field input,.bf-select{width:100%;padding:9px 12px;border:1.5px solid #E8EAF0;border-radius:10px;font-size:.82rem;font-family:inherit;outline:none;color:#1B1F3B;transition:.3s;background:#F7F8FC;box-sizing:border-box}
.bf-field input:focus,.bf-select:focus{border-color:#3B82F6;box-shadow:0 0 0 3px rgba(59,130,246,.08);background:#fff}
.bf-row{display:grid;grid-template-columns:1fr 1fr;gap:10px}
.bf-btn{width:100%;padding:11px;border:none;border-radius:12px;background:linear-gradient(135deg,#3B82F6,#60A5FA);color:#fff;font-weight:800;font-size:.85rem;cursor:pointer;transition:.3s;font-family:inherit;display:flex;align-items:center;justify-content:center;gap:6px;margin-top:4px}
.bf-btn:hover{transform:translateY(-1px);box-shadow:0 6px 20px rgba(59,130,246,.3)}
.bf-btn:disabled{opacity:.5;cursor:not-allowed;transform:none}

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

    // === VOICE INPUT (works on both HTTP and HTTPS) ===
    let recognition = null;
    let isRecording = false;

    // Always try to initialize SpeechRecognition regardless of protocol
    // The browser itself will decide if it's allowed
    if ('webkitSpeechRecognition' in window || 'SpeechRecognition' in window) {
        try {
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

            recognition.onerror = (event) => {
                isRecording = false;
                voiceBtn.classList.remove('recording');
                voiceBtn.innerHTML = '<i class="fas fa-microphone"></i>';
                if (event.error === 'not-allowed') {
                    addBotMessage('🔒 Trình duyệt chặn microphone trên HTTP.<br><br>'
                        + '<strong>Cách khắc phục:</strong><br>'
                        + '• <strong>Chrome:</strong> Nhập <code>chrome://flags/#unsafely-treat-insecure-origin-as-secure</code> → thêm URL của bạn<br>'
                        + '• <strong>Edge:</strong> Vào Settings → Site permissions → Microphone<br>'
                        + '• Hoặc deploy trên <strong>HTTPS</strong><br><br>'
                        + '💡 Bạn vẫn có thể gõ tin nhắn bình thường! 😊');
                } else if (event.error === 'network') {
                    addBotMessage('⚠️ Lỗi mạng khi nhận dạng giọng nói. Kiểm tra kết nối internet.');
                } else {
                    addBotMessage('⚠️ Không nhận được giọng nói. Vui lòng thử lại.');
                }
            };
        } catch (e) {
            recognition = null;
        }
    }

    voiceBtn.addEventListener('click', () => {
        if (!recognition) {
            addBotMessage('⚠️ Trình duyệt không hỗ trợ giọng nói.<br><br>'
                + '💡 Dùng <strong>Chrome</strong> hoặc <strong>Edge</strong> phiên bản mới nhất.<br>'
                + '💡 Bạn vẫn có thể gõ tin nhắn bình thường! 😊');
            return;
        }
        if (isRecording) {
            recognition.stop();
        } else {
            isRecording = true;
            voiceBtn.classList.add('recording');
            voiceBtn.innerHTML = '<i class="fas fa-stop"></i>';
            try {
                recognition.start();
            } catch (e) {
                isRecording = false;
                voiceBtn.classList.remove('recording');
                voiceBtn.innerHTML = '<i class="fas fa-microphone"></i>';
                addBotMessage('⚠️ Không thể bật mic. Thử tải lại trang hoặc dùng Chrome.');
            }
        }
    });

    // === BOOKING FORM ===
    const bookingForm = document.getElementById('booking-form');
    const closeBooking = document.getElementById('close-booking');
    const bookingSubmit = document.getElementById('booking-submit-form');
    const tourSelect = document.getElementById('bf-tour-id');
    let toursCache = [];

    closeBooking.addEventListener('click', () => bookingForm.style.display = 'none');

    // Show tour info when selected
    tourSelect.addEventListener('change', () => {
        const tourInfo = document.getElementById('bf-tour-info');
        const selected = toursCache.find(t => t.tourId == tourSelect.value);
        if (selected) {
            document.getElementById('bf-tour-name').textContent = selected.tourName;
            document.getElementById('bf-tour-price').textContent = new Intl.NumberFormat('vi-VN').format(selected.price) + 'đ/người';
            tourInfo.style.display = 'block';
        } else {
            tourInfo.style.display = 'none';
        }
    });

    function showBookingForm() {
        bookingForm.style.display = 'block';
        document.getElementById('bf-date').valueAsDate = new Date(Date.now() + 86400000);
        
        // Load tours from embedded data (no API needed)
        const tours = window.__CHAT_TOURS__ || [];
        toursCache = tours;
        tourSelect.innerHTML = '<option value="">-- Chọn tour bạn muốn đặt --</option>';
        tours.forEach(t => {
            const opt = document.createElement('option');
            opt.value = t.tourId;
            opt.textContent = t.tourName + ' (' + new Intl.NumberFormat('vi-VN').format(t.price) + 'đ)';
            tourSelect.appendChild(opt);
        });
        document.getElementById('bf-loading').style.display = 'none';
    }

    bookingSubmit.addEventListener('submit', (e) => {
        e.preventDefault();
        const tourId = tourSelect.value;
        const guests = document.getElementById('bf-guests').value;
        const selected = toursCache.find(t => t.tourId == tourId);
        
        if (!tourId || !selected) {
            addBotMessage('⚠️ Vui lòng chọn tour từ danh sách.');
            return;
        }

        bookingForm.style.display = 'none';
        const tourName = selected.tourName;
        const totalPrice = new Intl.NumberFormat('vi-VN').format(selected.price * guests);

        addBotMessage('✅ <strong>Đang xử lý đặt tour...</strong><br><br>'
            + '📋 Tour: <strong>' + escapeHtml(tourName) + '</strong><br>'
            + '👥 Số khách: ' + guests + '<br>'
            + '💰 Tổng tiền: <strong>' + totalPrice + 'đ</strong><br><br>'
            + '⏳ Đang tạo đơn hàng...');

        // Call real booking API
        const formData = new URLSearchParams();
        formData.append('action', 'book');
        formData.append('tourId', tourId);
        formData.append('numberOfPeople', guests);

        fetch(contextPath + '/booking', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData.toString(),
            redirect: 'follow'
        })
        .then(r => {
            const finalUrl = r.url || '';
            const isLoginRedirect = finalUrl.includes('login.jsp') || finalUrl.includes('/login');
            const isTourRedirect = finalUrl.includes('/tour');
            
            if (r.ok && !isLoginRedirect && !isTourRedirect) {
                // Success: servlet forwarded to payment-checkout.jsp (HTTP 200)
                addBotMessage('🎉 <strong>Đặt tour thành công!</strong><br><br>'
                    + '🏖️ Tour: <strong>' + escapeHtml(tourName) + '</strong><br>'
                    + '👥 Số khách: ' + guests + '<br>'
                    + '💰 Tổng tiền: <strong>' + totalPrice + 'đ</strong><br>'
                    + '📋 Trạng thái: <span style="color:#D97706;font-weight:700">Chờ thanh toán</span><br><br>'
                    + '<a href="' + contextPath + '/my-orders" style="display:inline-flex;align-items:center;gap:4px;padding:8px 16px;background:#3B82F6;color:#fff;border-radius:8px;font-weight:700;font-size:.8rem;text-decoration:none"><i class="fas fa-credit-card"></i> Thanh Toán Ngay</a>'
                    + '&nbsp;&nbsp;'
                    + '<a href="' + contextPath + '/my-orders" style="display:inline-flex;align-items:center;gap:4px;padding:8px 16px;background:#F1F5F9;color:#475569;border-radius:8px;font-weight:700;font-size:.8rem;text-decoration:none"><i class="fas fa-receipt"></i> Xem Đơn Hàng</a>');
                showBookingSuccess();
            } else if (isLoginRedirect) {
                // User not logged in - servlet redirected to login
                addBotMessage('⚠️ Bạn cần <a href="' + contextPath + '/login.jsp" style="color:#3B82F6;font-weight:700">đăng nhập</a> trước khi đặt tour.<br><br>'
                    + '<a href="' + contextPath + '/login.jsp" style="display:inline-flex;align-items:center;gap:4px;padding:8px 16px;background:#3B82F6;color:#fff;border-radius:8px;font-weight:700;font-size:.8rem;text-decoration:none"><i class="fas fa-sign-in-alt"></i> Đăng Nhập Ngay</a>');
            } else {
                // Other error (tour not found, invalid data, etc.)
                addBotMessage('⚠️ Không thể đặt tour. Vui lòng thử lại hoặc <a href="' + contextPath + '/login.jsp">đăng nhập</a>.');
            }
        })
        .catch(err => {
            addBotMessage('❌ Lỗi kết nối. Vui lòng thử lại.');
        });
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

        // Log question to DB for analytics
        fetch(contextPath + '/chatlog', {
            method: 'POST',
            headers: {'Content-Type':'application/x-www-form-urlencoded'},
            body: 'question=' + encodeURIComponent(msg)
        }).catch(function(){});

        // Track special intents (but still send ALL to AI)
        const lowerMsg = msg.toLowerCase();
        const isBookingIntent = lowerMsg.includes('đặt tour') || lowerMsg.includes('book tour') || lowerMsg.includes('dat tour');
        const isOrderIntent = lowerMsg.includes('đơn hàng') || lowerMsg.includes('tra cứu') || lowerMsg.includes('trạng thái đơn');

        const typingEl = showTyping();

        try {
            const res = await fetch(contextPath + '/ai/chat', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                body: 'message=' + encodeURIComponent(msg)
            });

            let data;
            const text = await res.text();
            try { data = JSON.parse(text); } catch (pe) {
                typingEl.remove();
                showFallbackResponse(msg);
                sendBtn.disabled = false;
                return;
            }
            typingEl.remove();

            if (data.response) {
                // Check if response contains error indicator
                const respText = data.response;
                if (respText.includes('tam thoi khong kha dung') || respText.includes('Loi he thong') || respText.includes('loi 4')) {
                    showFallbackResponse(msg);
                } else {
                    addBotMessage(formatMarkdown(respText));
                    if (data.action === 'booked') showBookingSuccess();
                }
            } else if (data.error) {
                showFallbackResponse(msg);
            }

            // Show extra UI for special intents (after AI response)
            if (isBookingIntent) {
                setTimeout(() => { showBookingForm(); }, 300);
            }
            if (isOrderIntent) {
                setTimeout(() => {
                    addBotMessage('📋 <a href="' + contextPath + '/my-orders" style="font-weight:700;color:#3B82F6">👉 Xem tất cả đơn hàng tại đây</a>');
                }, 300);
            }
        } catch (err) {
            typingEl.remove();
            showFallbackResponse(msg);
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

    // ═══ SMART FALLBACK when AI API is unavailable ═══
    function showFallbackResponse(userMsg) {
        const lowerMsg = userMsg.toLowerCase();
        let reply = '';
        
        if (lowerMsg.includes('xin chào') || lowerMsg.includes('hello') || lowerMsg.match(/^hi\b/) || lowerMsg.includes('chào')) {
            reply = '👋 Xin chào bạn! Tôi là <strong>EzTravel AI</strong>.<br><br>'
                + '🏖️ Tư vấn tour & địa điểm<br>💰 So sánh giá tour<br>'
                + '🍜 Gợi ý ẩm thực & khách sạn<br>🌤️ Thông tin thời tiết<br><br>'
                + 'Hãy hỏi tôi bất cứ điều gì! 😊';
        } else if (lowerMsg.includes('cảm ơn') || lowerMsg.includes('thank') || lowerMsg.includes('tks')) {
            reply = '😊 Không có chi! Rất vui được giúp bạn!<br>Nếu cần gì thêm, cứ hỏi nhé! 💬';
        } else if (lowerMsg.includes('giá') || lowerMsg.includes('bao nhiêu') || lowerMsg.includes('rẻ') || lowerMsg.includes('500')) {
            reply = '💰 <strong>Giá tour tham khảo:</strong><br>'
                + '🏖️ Mỹ Khê: từ <strong>350k</strong> · ⛰️ Bà Nà: từ <strong>750k</strong><br>'
                + '🏮 Hội An: từ <strong>450k</strong> · 🌿 Sơn Trà: từ <strong>500k</strong><br><br>'
                + '👉 <a href="' + contextPath + '/tour" style="color:#3B82F6;font-weight:700">Xem chi tiết →</a>';
        } else if (lowerMsg.includes('phổ biến') || lowerMsg.includes('hot') || lowerMsg.includes('top') || lowerMsg.includes('nổi')) {
            reply = '🌟 <strong>Top tour:</strong><br>'
                + '1. ⛰️ Bà Nà Hills ⭐4.9<br>2. 🏖️ Mỹ Khê ⭐4.8<br>'
                + '3. 🏮 Hội An ⭐4.9<br>4. 🐉 City Tour ⭐4.7<br><br>'
                + '👉 <a href="' + contextPath + '/tour" style="color:#3B82F6;font-weight:700">Xem tất cả →</a>';
        } else if (lowerMsg.includes('thời tiết') || lowerMsg.includes('mùa') || lowerMsg.includes('tháng') || lowerMsg.includes('khi nào')) {
            reply = '🌤️ <strong>Thời tiết Đà Nẵng:</strong><br><br>'
                + '☀️ <strong>Mùa khô (3-8):</strong> Nắng đẹp, 25-35°C, lý tưởng tắm biển<br>'
                + '🌧️ <strong>Mùa mưa (9-2):</strong> Mưa nhiều, 20-28°C<br>'
                + '✅ <strong>Tháng đẹp nhất:</strong> 3, 4, 5, 6<br><br>'
                + '💡 Đặt tour mùa khô để có trải nghiệm tốt nhất!';
        } else if (lowerMsg.includes('ăn') || lowerMsg.includes('món') || lowerMsg.includes('ẩm thực') || lowerMsg.includes('quán') || lowerMsg.includes('nhà hàng')) {
            reply = '🍜 <strong>Ẩm thực Đà Nẵng nổi tiếng:</strong><br><br>'
                + '• <strong>Mì Quảng</strong> — Món đặc trưng số 1<br>'
                + '• <strong>Bún chả cá</strong> — Hương vị biển<br>'
                + '• <strong>Bánh tráng cuốn thịt heo</strong><br>'
                + '• <strong>Bánh xèo</strong> — Giòn rụm<br>'
                + '• <strong>Hải sản tươi</strong> — Bãi biển Mỹ Khê<br><br>'
                + '📍 Chợ Hàn & Chợ Cồn là thiên đường ẩm thực!';
        } else if (lowerMsg.includes('khách sạn') || lowerMsg.includes('ở đâu') || lowerMsg.includes('lưu trú') || lowerMsg.includes('homestay')) {
            reply = '🏨 <strong>Gợi ý lưu trú:</strong><br><br>'
                + '⭐ <strong>5 sao:</strong> InterContinental, Hyatt (~3-5tr/đêm)<br>'
                + '⭐ <strong>4 sao:</strong> Novotel, Grand Tourane (~1-2tr/đêm)<br>'
                + '🏡 <strong>Homestay:</strong> 200-500k/đêm<br><br>'
                + '💡 Khu <strong>Mỹ Khê</strong> và <strong>Sơn Trà</strong> lý tưởng nhất!';
        } else if (lowerMsg.includes('di chuyển') || lowerMsg.includes('xe') || lowerMsg.includes('máy bay') || lowerMsg.includes('sân bay') || lowerMsg.includes('taxi')) {
            reply = '🚗 <strong>Di chuyển tại Đà Nẵng:</strong><br><br>'
                + '✈️ Sân bay quốc tế — cách trung tâm 3km<br>'
                + '🛵 Thuê xe máy: 100-150k/ngày<br>'
                + '🚕 Grab/taxi: tiện lợi, giá hợp lý<br>'
                + '🚌 Bus du lịch: 5k-10k/lượt<br><br>'
                + '💡 Nên thuê xe máy để tự do khám phá!';
        } else if (lowerMsg.includes('gia đình') || lowerMsg.includes('trẻ em') || lowerMsg.includes('con nhỏ')) {
            reply = '👨‍👩‍👧‍👦 <strong>Tour gia đình:</strong><br>'
                + '🎡 Asia Park · ⛰️ Bà Nà Hills · 🏖️ Mỹ Khê<br><br>'
                + '💡 Ưu đãi trẻ em dưới 6 tuổi!';
        } else if (lowerMsg.includes('đặt tour') || lowerMsg.includes('book')) {
            reply = '🛒 Tôi đã mở form đặt tour cho bạn 👇';
        } else if (lowerMsg.includes('đơn hàng') || lowerMsg.includes('tra cứu')) {
            reply = '📋 <a href="' + contextPath + '/my-orders" style="font-weight:700;color:#3B82F6">Xem đơn hàng tại đây →</a>';
        } else if (lowerMsg.includes('tọa độ') || lowerMsg.includes('gần') || lowerMsg.includes('vị trí') || lowerMsg.includes('bản đồ')) {
            reply = '📍 <strong>Địa điểm nổi bật:</strong><br>'
                + '🐉 Cầu Rồng · 🏖️ Mỹ Khê · ⛰️ Bà Nà · 🏮 Hội An<br><br>'
                + '💡 Xem <strong>bản đồ</strong> trên trang chủ!';
        } else {
            reply = '🤖 Xin lỗi, hệ thống AI đang bận. Thử lại sau vài giây nhé!<br><br>'
                + '<div style="background:#F8FAFF;padding:12px;border-radius:10px;margin:8px 0">'
                + '💬 Thử hỏi: <em>thời tiết, ẩm thực, khách sạn, di chuyển...</em><br>'
                + '🏖️ <a href="' + contextPath + '/tour" style="color:#3B82F6;font-weight:700">Xem Tours</a> · '
                + '🛒 Gõ <code>đặt tour</code></div>'
                + '⏳ AI sẽ sớm khôi phục!';
        }
        
        addBotMessage(reply);
    }

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
            
            // ═══ OFFLINE SMART SUGGESTIONS (no API needed) ═══
            const hotspots = [
                { name: 'Cầu Rồng', lat: 16.0611, lng: 108.2274, desc: 'Biểu tượng Đà Nẵng - phun lửa & nước vào T7, CN lúc 21h', emoji: '🐉', tags: 'Kiến trúc, Check-in' },
                { name: 'Bà Nà Hills', lat: 15.9975, lng: 107.9940, desc: 'Cầu Vàng nổi tiếng thế giới, Làng Pháp trên đỉnh núi', emoji: '⛰️', tags: 'Thiên nhiên, Giải trí' },
                { name: 'Biển Mỹ Khê', lat: 16.0322, lng: 108.2504, desc: 'Top 6 bãi biển đẹp nhất hành tinh (Forbes)', emoji: '🏖️', tags: 'Biển, Tắm biển' },
                { name: 'Bán Đảo Sơn Trà', lat: 16.1003, lng: 108.2778, desc: 'Khu bảo tồn thiên nhiên, Chùa Linh Ứng 67m', emoji: '🌿', tags: 'Tâm linh, Trekking' },
                { name: 'Ngũ Hành Sơn', lat: 16.0039, lng: 108.2632, desc: 'Marble Mountains - chùa cổ & hang động kỳ bí', emoji: '🏔️', tags: 'Di tích, Leo núi' },
                { name: 'Phố Cổ Hội An', lat: 15.8800, lng: 108.3280, desc: 'Di sản UNESCO, phố đèn lồng & ẩm thực đặc sắc', emoji: '🏮', tags: 'UNESCO, Ẩm thực' },
                { name: 'Asia Park', lat: 16.0395, lng: 108.2258, desc: 'Sun World - vòng quay Sun Wheel cao 115m', emoji: '🎡', tags: 'Vui chơi, Gia đình' },
                { name: 'Chợ Hàn', lat: 16.0719, lng: 108.2271, desc: 'Chợ truyền thống - đặc sản Đà Nẵng, quà lưu niệm', emoji: '🛍️', tags: 'Mua sắm, Ẩm thực' },
                { name: 'Chợ Cồn', lat: 16.0692, lng: 108.2137, desc: 'Chợ lớn nhất Đà Nẵng, ẩm thực đường phố', emoji: '🍜', tags: 'Ẩm thực, Mua sắm' },
                { name: 'Cầu Tình Yêu', lat: 16.0603, lng: 108.2270, desc: 'Cầu khóa tình yêu bên sông Hàn, đẹp nhất về đêm', emoji: '💕', tags: 'Lãng mạn, Check-in' }
            ];
            
            // Calculate distances using Haversine
            function calcDist(lat1, lon1, lat2, lon2) {
                const R = 6371;
                const dLat = (lat2 - lat1) * Math.PI / 180;
                const dLon = (lon2 - lon1) * Math.PI / 180;
                const a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(lat1*Math.PI/180) * Math.cos(lat2*Math.PI/180) * Math.sin(dLon/2) * Math.sin(dLon/2);
                return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
            }
            
            const nearby = hotspots.map(h => ({
                ...h,
                dist: calcDist(lat, lng, h.lat, h.lng)
            })).sort((a, b) => a.dist - b.dist).slice(0, 5);
            
            // Build instant response (no API needed)
            let response = '📍 <strong>Vị trí của bạn:</strong> ' + lat.toFixed(4) + ', ' + lng.toFixed(4) + '<br><br>';
            response += '🌟 <strong>Top 5 địa điểm gần bạn nhất:</strong><br><br>';
            
            nearby.forEach((h, i) => {
                const distText = h.dist < 1 ? (h.dist * 1000).toFixed(0) + 'm' : h.dist.toFixed(1) + 'km';
                response += '<div style="background:#F8FAFF;border-radius:10px;padding:10px 12px;margin-bottom:8px;border-left:3px solid #3B82F6">';
                response += '<strong>' + h.emoji + ' ' + (i+1) + '. ' + h.name + '</strong>';
                response += ' <span style="color:#3B82F6;font-size:.75rem;font-weight:700">(' + distText + ')</span><br>';
                response += '<span style="font-size:.8rem;color:#64748B">' + h.desc + '</span><br>';
                response += '<span style="font-size:.68rem;color:#94A3B8">🏷️ ' + h.tags + '</span>';
                response += '</div>';
            });
            
            response += '<br>💡 <strong>Mẹo:</strong> Nhấn vào bản đồ để khám phá thêm! Hoặc gõ tên điểm đến để tìm tour.';
            response += '<br><br><a href="' + contextPath + '/tour" style="display:inline-flex;align-items:center;gap:5px;padding:8px 16px;background:#3B82F6;color:#fff;border-radius:10px;font-weight:700;font-size:.8rem;text-decoration:none"><i class="fas fa-compass"></i> Xem tất cả Tours</a>';
            
            addBotMessage(response);
            
            // Optionally try AI for more detailed suggestions (non-blocking, truly silent)
            const aiMsg = 'Tôi đang ở tọa độ ' + lat.toFixed(4) + ', ' + lng.toFixed(4) + '. Hãy gợi ý cho tôi 3 địa điểm du lịch hoặc quán ăn nổi tiếng gần đây nhất tại Đà Nẵng và lý do nên đến đó.';
            
            fetch(contextPath + '/ai/chat', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                body: 'message=' + encodeURIComponent(aiMsg)
            }).then(r => {
                if (r.ok) return r.text();
                throw new Error('API error');
            }).then(text => {
                try {
                    const data = JSON.parse(text);
                    if (data.response && !data.response.includes('tam thoi') && !data.response.includes('loi ') && !data.response.includes('Loi he thong')) {
                        addBotMessage('🤖 <strong>AI gợi ý thêm:</strong><br><br>' + formatMarkdown(data.response));
                    }
                } catch(e) {}
            }).catch(() => {
                // Silently fail - offline suggestions already shown
            });
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
