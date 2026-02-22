<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 
    VietAir AI Chatbot Component
    Include this JSP in any page: <%@ include file="/views/ai-chatbot/chatbot.jsp" %>
    Or: <jsp:include page="/views/ai-chatbot/chatbot.jsp" />
--%>

<!-- Chatbot CSS -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/chatbot.css">

<!-- Chatbot Toggle Button -->
<button class="chatbot-toggle" id="chatbotToggle" title="Chat với VietAir AI" aria-label="Mở chatbot">
    <span class="toggle-icon">
        <i class="fas fa-robot" id="toggleIconOpen"></i>
    </span>
    <span class="chatbot-badge" id="chatbotBadge">1</span>
</button>

<!-- Chatbot Window -->
<div class="chatbot-window" id="chatbotWindow">
    <!-- Header -->
    <div class="chatbot-header">
        <div class="chatbot-avatar">
            ✈️
            <span class="chatbot-avatar-status"></span>
        </div>
        <div class="chatbot-header-info">
            <h3>VietAir Assistant</h3>
            <p>
                <span class="status-dot"></span>
                <span id="chatbotStatus">Đang hoạt động</span>
            </p>
        </div>
        <button class="chatbot-close" id="chatbotClose" title="Đóng" aria-label="Đóng chatbot">
            <i class="fas fa-times"></i>
        </button>
    </div>

    <!-- Messages Container -->
    <div class="chatbot-messages" id="chatbotMessages">
        <!-- Welcome Card -->
        <div class="welcome-card">
            <h4>✈️ Xin chào! Tôi là VietAir AI</h4>
            <p>Tôi có thể giúp bạn tìm tour du lịch Đà Nẵng, tư vấn điểm đến, hoặc giải đáp thắc mắc về dịch vụ.</p>
            <div class="welcome-features">
                <div class="welcome-feature" onclick="sendQuickMessage('Gợi ý tour du lịch Đà Nẵng')">
                    <i class="fas fa-compass"></i>
                    <span>Gợi ý tour</span>
                </div>
                <div class="welcome-feature" onclick="sendQuickMessage('Giới thiệu điểm đến Bà Nà Hills')">
                    <i class="fas fa-mountain"></i>
                    <span>Điểm đến hot</span>
                </div>
                <div class="welcome-feature" onclick="sendQuickMessage('Hướng dẫn đặt tour')">
                    <i class="fas fa-book-open"></i>
                    <span>Hướng dẫn</span>
                </div>
                <div class="welcome-feature" onclick="sendQuickMessage('Ẩm thực Đà Nẵng có gì ngon?')">
                    <i class="fas fa-utensils"></i>
                    <span>Ẩm thực</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Suggestions -->
    <div class="chatbot-suggestions" id="chatbotSuggestions">
        <div class="suggestion-chip" onclick="sendQuickMessage('Tour Bà Nà Hills giá bao nhiêu?')">
            <i class="fas fa-tag"></i> Giá tour
        </div>
        <div class="suggestion-chip" onclick="sendQuickMessage('Thời tiết Đà Nẵng hôm nay')">
            <i class="fas fa-cloud-sun"></i> Thời tiết
        </div>
        <div class="suggestion-chip" onclick="sendQuickMessage('Cù Lao Chàm có gì vui?')">
            <i class="fas fa-umbrella-beach"></i> Cù Lao Chàm
        </div>
    </div>

    <!-- Input Area -->
    <div class="chatbot-input-area">
        <div class="chatbot-input-wrapper">
            <textarea 
                class="chatbot-input" 
                id="chatbotInput" 
                placeholder="Hỏi về tour du lịch Đà Nẵng..." 
                rows="1"
                aria-label="Nhập tin nhắn"
            ></textarea>
        </div>
        <button class="chatbot-send" id="chatbotSend" title="Gửi" aria-label="Gửi tin nhắn">
            <i class="fas fa-paper-plane"></i>
        </button>
    </div>

    <!-- Footer -->
    <div class="chatbot-footer">
        Powered by <a href="#" onclick="return false;">VietAir AI</a> ✨
    </div>
</div>

<!-- Chatbot JavaScript -->
<script>
(function() {
    'use strict';

    // ═══ DOM Elements ═══
    const toggle = document.getElementById('chatbotToggle');
    const window_ = document.getElementById('chatbotWindow');
    const closeBtn = document.getElementById('chatbotClose');
    const messages = document.getElementById('chatbotMessages');
    const input = document.getElementById('chatbotInput');
    const sendBtn = document.getElementById('chatbotSend');
    const badge = document.getElementById('chatbotBadge');
    const suggestions = document.getElementById('chatbotSuggestions');
    const statusText = document.getElementById('chatbotStatus');
    const toggleIconOpen = document.getElementById('toggleIconOpen');

    let isOpen = false;
    let isProcessing = false;

    // ═══ Context path for API calls ═══
    const contextPath = '<%= request.getContextPath() %>';

    // ═══ Toggle Chat Window ═══
    toggle.addEventListener('click', function() {
        isOpen = !isOpen;
        if (isOpen) {
            window_.classList.add('open');
            toggle.classList.add('active');
            toggleIconOpen.className = 'fas fa-times';
            badge.style.display = 'none';
            input.focus();
        } else {
            window_.classList.remove('open');
            toggle.classList.remove('active');
            toggleIconOpen.className = 'fas fa-robot';
        }
    });

    closeBtn.addEventListener('click', function() {
        isOpen = false;
        window_.classList.remove('open');
        toggle.classList.remove('active');
        toggleIconOpen.className = 'fas fa-robot';
    });

    // ═══ Send Message ═══
    sendBtn.addEventListener('click', sendMessage);

    input.addEventListener('keydown', function(e) {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            sendMessage();
        }
    });

    // Auto-resize textarea
    input.addEventListener('input', function() {
        this.style.height = 'auto';
        this.style.height = Math.min(this.scrollHeight, 100) + 'px';
    });

    function sendMessage() {
        const text = input.value.trim();
        if (!text || isProcessing) return;

        // Hide suggestions after first message
        suggestions.style.display = 'none';

        // Add user message
        addMessage(text, 'user');

        // Clear input
        input.value = '';
        input.style.height = 'auto';

        // Show typing indicator
        showTyping();

        // Disable send button
        isProcessing = true;
        sendBtn.disabled = true;
        statusText.textContent = 'Đang suy nghĩ...';

        // Call API
        fetch(contextPath + '/chat', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8'
            },
            body: JSON.stringify({ message: text })
        })
        .then(response => {
            if (!response.ok) throw new Error('Network response was not ok');
            return response.json();
        })
        .then(data => {
            hideTyping();
            addMessage(data.response || 'Xin lỗi, tôi không thể xử lý yêu cầu này.', 'bot');
            statusText.textContent = 'Đang hoạt động';
        })
        .catch(error => {
            console.error('Chat error:', error);
            hideTyping();
            addMessage('⚠️ Xin lỗi, có lỗi xảy ra. Vui lòng thử lại sau.', 'bot');
            statusText.textContent = 'Đang hoạt động';
        })
        .finally(() => {
            isProcessing = false;
            sendBtn.disabled = false;
            input.focus();
        });
    }

    // ═══ Quick message from suggestions ═══
    window.sendQuickMessage = function(text) {
        input.value = text;
        sendMessage();
    };

    // ═══ Add Message to Chat ═══
    function addMessage(text, type) {
        const now = new Date();
        const timeStr = now.getHours().toString().padStart(2, '0') + ':' +
                        now.getMinutes().toString().padStart(2, '0');

        const messageDiv = document.createElement('div');
        messageDiv.className = 'chat-message ' + type;

        const avatarEmoji = type === 'bot' ? '✈️' : '👤';
        
        // Format text: convert \n to <br> and handle markdown-like bold
        let formattedText = text
            .replace(/\n/g, '<br>')
            .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
            .replace(/\*(.*?)\*/g, '<em>$1</em>');

        messageDiv.innerHTML = 
            '<div class="msg-avatar">' + avatarEmoji + '</div>' +
            '<div class="msg-content">' +
                '<div class="msg-bubble">' + formattedText + '</div>' +
                '<span class="msg-time">' + timeStr + '</span>' +
            '</div>';

        messages.appendChild(messageDiv);
        scrollToBottom();
    }

    // ═══ Typing Indicator ═══
    function showTyping() {
        const typing = document.createElement('div');
        typing.className = 'typing-indicator';
        typing.id = 'typingIndicator';
        typing.innerHTML =
            '<div class="typing-avatar">✈️</div>' +
            '<div class="typing-bubble">' +
                '<div class="typing-dot"></div>' +
                '<div class="typing-dot"></div>' +
                '<div class="typing-dot"></div>' +
            '</div>';
        messages.appendChild(typing);
        scrollToBottom();
    }

    function hideTyping() {
        const typing = document.getElementById('typingIndicator');
        if (typing) typing.remove();
    }

    // ═══ Scroll to bottom ═══
    function scrollToBottom() {
        requestAnimationFrame(() => {
            messages.scrollTop = messages.scrollHeight;
        });
    }

    // ═══ Auto-show badge after delay ═══
    setTimeout(function() {
        if (!isOpen) {
            badge.style.display = 'flex';
        }
    }, 3000);

})();
</script>
