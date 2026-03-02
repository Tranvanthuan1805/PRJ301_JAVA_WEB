<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- 
    Finer AI Chatbot Modal
    Include trong trang chinh: <jsp:include page="/views/ai-chatbot/chatbot-modal.jsp" />
--%>

<!-- Chatbot Toggle Button -->
<button class="finer-chat-toggle" id="finerChatToggle" title="Chat với Finer AI">
    <span class="chat-icon">💬</span>
    <span class="chat-pulse"></span>
    <span class="chat-badge" id="chatBadge">1</span>
</button>

<!-- Chatbot Modal -->
<div class="finer-chat-modal" id="finerChatModal">
    <!-- Header -->
    <div class="fcm-header">
        <div class="fcm-header-left">
            <div class="fcm-avatar">💘</div>
            <div class="fcm-info">
                <h4>Finer AI</h4>
                <span class="fcm-status" id="chatStatus">
                    <i class="status-dot"></i> Online
                </span>
            </div>
        </div>
        <div class="fcm-header-right">
            <button class="fcm-btn" id="clearChatBtn" title="Xóa lịch sử">
                <i class="fas fa-trash-alt"></i>
            </button>
            <button class="fcm-btn" id="closeChatBtn" title="Đóng">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </div>

    <!-- Messages -->
    <div class="fcm-messages" id="chatMessages">
        <!-- Welcome message -->
        <div class="fcm-msg bot">
            <div class="fcm-msg-avatar">💘</div>
            <div class="fcm-msg-content">
                <div class="fcm-msg-bubble">
                    Xin chào bạn! 💕 Mình là <b>Finer AI</b> — trợ lý hẹn hò thông minh nhất vũ trụ! 🚀
                    <br><br>
                    Mình có thể giúp bạn:
                    <br>• 💝 Tư vấn tìm người yêu
                    <br>• ✍️ Viết bio profile ấn tượng
                    <br>• 💬 Gợi ý tin nhắn mở đầu
                    <br>• 🎯 Match-making tips
                    <br><br>
                    Hỏi mình bất cứ gì nhé! 😄
                </div>
                <span class="fcm-msg-time">Bây giờ</span>
            </div>
        </div>

        <!-- Lich su chat tu session -->
        <c:if test="${not empty chatHistory}">
            <c:forEach var="msg" items="${chatHistory}">
                <div class="fcm-msg ${msg.role == 'user' ? 'user' : 'bot'}">
                    <div class="fcm-msg-avatar">
                        ${msg.role == 'user' ? '👤' : '💘'}
                    </div>
                    <div class="fcm-msg-content">
                        <div class="fcm-msg-bubble">
                            <c:out value="${msg.content}" />
                        </div>
                        <span class="fcm-msg-time">${msg.formattedTime}</span>
                    </div>
                </div>
            </c:forEach>
        </c:if>
    </div>

    <!-- Quick Suggestions -->
    <div class="fcm-suggestions" id="chatSuggestions">
        <button class="fcm-chip" data-msg="Viết bio hẹn hò cho mình">✍️ Viết bio</button>
        <button class="fcm-chip" data-msg="Gợi ý tin nhắn mở đầu hay">💬 Mở đầu chat</button>
        <button class="fcm-chip" data-msg="Làm sao để nhiều match hơn?">🎯 Tips match</button>
        <button class="fcm-chip" data-msg="Tư vấn date đầu tiên">💕 Date đầu</button>
    </div>

    <!-- Input -->
    <div class="fcm-input-area">
        <div class="fcm-input-row">
            <input type="text" 
                   id="chatInput" 
                   class="fcm-input" 
                   placeholder="Hỏi Finer AI về hẹn hò..." 
                   autocomplete="off"
                   maxlength="500">
            <button id="chatSendBtn" class="fcm-send" title="Gửi">
                <i class="fas fa-paper-plane"></i>
            </button>
        </div>
        <div class="fcm-powered">
            ⚡ Powered by Finer AI
        </div>
    </div>
</div>

<style>
/* ============================== */
/*  FINER AI CHATBOT — PURE CSS  */
/* ============================== */
.finer-chat-toggle {
    position: fixed;
    bottom: 28px;
    right: 28px;
    z-index: 10000;
    width: 64px;
    height: 64px;
    border-radius: 50%;
    background: linear-gradient(135deg, #FF416C, #FF4B2B);
    border: none;
    cursor: pointer;
    box-shadow: 0 8px 32px rgba(255, 65, 108, 0.4);
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}
.finer-chat-toggle:hover {
    transform: scale(1.1);
    box-shadow: 0 12px 40px rgba(255, 65, 108, 0.5);
}
.finer-chat-toggle .chat-icon { font-size: 1.6rem; }
.chat-pulse {
    position: absolute;
    inset: -4px;
    border-radius: 50%;
    border: 2px solid rgba(255, 65, 108, 0.5);
    animation: finerPulse 2s ease-out infinite;
}
@keyframes finerPulse {
    0% { transform: scale(1); opacity: 1; }
    100% { transform: scale(1.4); opacity: 0; }
}
.chat-badge {
    position: absolute;
    top: -2px;
    right: -2px;
    width: 20px;
    height: 20px;
    background: #FFD700;
    color: #333;
    font-size: 0.7rem;
    font-weight: 800;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 2px solid #fff;
}

/* Modal */
.finer-chat-modal {
    position: fixed;
    bottom: 100px;
    right: 28px;
    z-index: 10001;
    width: 400px;
    max-height: 600px;
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15), 0 0 0 1px rgba(0, 0, 0, 0.05);
    display: none;
    flex-direction: column;
    overflow: hidden;
    animation: fcmOpen 0.3s ease;
    font-family: 'Inter', 'Segoe UI', system-ui, sans-serif;
}
.finer-chat-modal.open { display: flex; }
@keyframes fcmOpen {
    from { opacity: 0; transform: translateY(20px) scale(0.95); }
    to { opacity: 1; transform: translateY(0) scale(1); }
}

/* Header */
.fcm-header {
    background: linear-gradient(135deg, #FF416C, #FF4B2B);
    color: #fff;
    padding: 16px 18px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-shrink: 0;
}
.fcm-header-left { display: flex; align-items: center; gap: 12px; }
.fcm-avatar {
    width: 42px;
    height: 42px;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.15);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.3rem;
}
.fcm-info h4 { margin: 0; font-size: 0.95rem; font-weight: 700; }
.fcm-status { font-size: 0.72rem; opacity: 0.85; }
.status-dot {
    display: inline-block;
    width: 7px;
    height: 7px;
    background: #4ADE80;
    border-radius: 50%;
    margin-right: 4px;
    vertical-align: middle;
}
.fcm-header-right { display: flex; gap: 6px; }
.fcm-btn {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    border: none;
    background: rgba(255, 255, 255, 0.15);
    color: rgba(255, 255, 255, 0.8);
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: 0.2s;
    font-size: 0.8rem;
}
.fcm-btn:hover { background: rgba(255, 255, 255, 0.25); color: #fff; }

/* Messages */
.fcm-messages {
    flex: 1;
    overflow-y: auto;
    padding: 16px;
    display: flex;
    flex-direction: column;
    gap: 14px;
    background: #F8F9FC;
    max-height: 360px;
    min-height: 200px;
    scroll-behavior: smooth;
}
.fcm-messages::-webkit-scrollbar { width: 4px; }
.fcm-messages::-webkit-scrollbar-thumb { background: #D1D5DB; border-radius: 4px; }

.fcm-msg {
    display: flex;
    gap: 8px;
    max-width: 85%;
    animation: fcmMsgIn 0.3s ease;
}
.fcm-msg.user { align-self: flex-end; flex-direction: row-reverse; }
.fcm-msg.bot { align-self: flex-start; }
@keyframes fcmMsgIn {
    from { opacity: 0; transform: translateY(8px); }
    to { opacity: 1; transform: translateY(0); }
}

.fcm-msg-avatar {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    font-size: 0.85rem;
    background: #F3F4F6;
}
.fcm-msg.user .fcm-msg-avatar { background: linear-gradient(135deg, #FF416C, #FF4B2B); }

.fcm-msg-content { display: flex; flex-direction: column; gap: 4px; }
.fcm-msg-bubble {
    padding: 10px 14px;
    border-radius: 16px;
    font-size: 0.86rem;
    line-height: 1.55;
    word-wrap: break-word;
}
.fcm-msg.bot .fcm-msg-bubble {
    background: #fff;
    color: #1F2937;
    border: 1px solid #E5E7EB;
    border-top-left-radius: 4px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.04);
}
.fcm-msg.user .fcm-msg-bubble {
    background: linear-gradient(135deg, #FF416C, #FF4B2B);
    color: #fff;
    border-top-right-radius: 4px;
}
.fcm-msg-time {
    font-size: 0.65rem;
    color: #9CA3AF;
    padding: 0 4px;
}
.fcm-msg.user .fcm-msg-time { text-align: right; }

/* Typing indicator */
.typing-dots { display: flex; gap: 4px; padding: 10px 14px; }
.typing-dots span {
    width: 7px; height: 7px;
    background: #9CA3AF;
    border-radius: 50%;
    animation: typingBounce 1.4s infinite;
}
.typing-dots span:nth-child(2) { animation-delay: 0.2s; }
.typing-dots span:nth-child(3) { animation-delay: 0.4s; }
@keyframes typingBounce {
    0%, 60%, 100% { transform: translateY(0); opacity: 0.4; }
    30% { transform: translateY(-8px); opacity: 1; }
}

/* Suggestions */
.fcm-suggestions {
    display: flex;
    gap: 6px;
    padding: 8px 16px;
    overflow-x: auto;
    background: #fff;
    border-top: 1px solid #F3F4F6;
    flex-shrink: 0;
}
.fcm-suggestions::-webkit-scrollbar { display: none; }
.fcm-chip {
    white-space: nowrap;
    padding: 6px 12px;
    border-radius: 999px;
    border: 1px solid #E5E7EB;
    background: #fff;
    color: #374151;
    font-size: 0.72rem;
    font-weight: 600;
    cursor: pointer;
    transition: 0.2s;
    flex-shrink: 0;
    font-family: inherit;
}
.fcm-chip:hover {
    background: linear-gradient(135deg, #FF416C, #FF4B2B);
    color: #fff;
    border-color: transparent;
}

/* Input */
.fcm-input-area {
    padding: 12px 16px;
    background: #fff;
    border-top: 1px solid #F3F4F6;
    flex-shrink: 0;
}
.fcm-input-row { display: flex; gap: 8px; }
.fcm-input {
    flex: 1;
    padding: 10px 14px;
    border: 2px solid #E5E7EB;
    border-radius: 12px;
    font-size: 0.88rem;
    outline: none;
    font-family: inherit;
    transition: 0.2s;
    background: #F9FAFB;
    color: #1F2937;
}
.fcm-input:focus {
    border-color: #FF416C;
    box-shadow: 0 0 0 3px rgba(255, 65, 108, 0.08);
    background: #fff;
}
.fcm-input::placeholder { color: #9CA3AF; }
.fcm-send {
    width: 42px;
    height: 42px;
    border-radius: 12px;
    background: linear-gradient(135deg, #FF416C, #FF4B2B);
    color: #fff;
    border: none;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: 0.2s;
    font-size: 0.9rem;
    flex-shrink: 0;
}
.fcm-send:hover { transform: scale(1.05); box-shadow: 0 4px 12px rgba(255, 65, 108, 0.3); }
.fcm-send:disabled { opacity: 0.5; cursor: not-allowed; transform: none; }
.fcm-powered {
    font-size: 0.65rem;
    color: #9CA3AF;
    text-align: center;
    margin-top: 6px;
}

/* Booking Form Styles */
.fcm-form-bubble {
    width: 100%;
    background: #fff !important;
    border: 1px solid #FF416C !important;
}
.fcm-booking-form h6 {
    color: #FF416C;
    font-weight: 700;
}
.fcm-form-group {
    margin-bottom: 10px;
}
.fcm-form-group label {
    display: block;
    font-size: 0.75rem;
    color: #4B5563;
    margin-bottom: 3px;
    font-weight: 500;
}
.fcm-form-input {
    width: 100%;
    padding: 8px 10px;
    border: 1px solid #D1D5DB;
    border-radius: 8px;
    font-size: 0.8rem;
    outline: none;
}
.fcm-form-input:focus {
    border-color: #FF416C;
}
.fcm-submit-btn {
    width: 100%;
    padding: 10px;
    background: linear-gradient(135deg, #FF416C, #FF4B2B);
    color: #fff;
    border: none;
    border-radius: 8px;
    font-size: 0.85rem;
    font-weight: 700;
    cursor: pointer;
    margin-top: 5px;
    transition: 0.2s;
}
.fcm-submit-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(255, 65, 108, 0.3);
}

/* Mobile */
@media (max-width: 480px) {
    .finer-chat-modal {
        width: calc(100vw - 16px);
        right: 8px;
        bottom: 96px;
        max-height: calc(100vh - 120px);
    }
}
</style>

<!-- Load JS -->
<script src="<%= request.getContextPath() %>/js/chat-script.js"></script>
