<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="ai-chatbot-container" style="position: fixed; bottom: 30px; right: 30px; z-index: 1000; font-family: 'Inter', sans-serif;">
    <!-- Chat Toggle Button -->
    <button id="chat-toggle" style="width: 60px; height: 60px; border-radius: 50%; background: var(--primary); color: white; border: none; cursor: pointer; box-shadow: 0 10px 25px rgba(10, 35, 81, 0.3); display: flex; align-items: center; justify-content: center; transition: 0.3s; position: relative;">
        <i class="fas fa-robot" style="font-size: 1.5rem;"></i>
        <div id="chat-notification" style="position: absolute; top: 0; right: 0; width: 15px; height: 15px; background: #FF6B6B; border: 2px solid white; border-radius: 50%; display: none;"></div>
    </button>

    <!-- Chat Window (hidden by default) -->
    <div id="chat-window" class="card" style="position: absolute; bottom: 80px; right: 0; width: 380px; height: 500px; display: none; flex-direction: column; padding: 0; overflow: hidden; border: 1px solid rgba(0,0,0,0.1); box-shadow: 0 15px 40px rgba(0,0,0,0.15);">
        <!-- Chat Header -->
        <div style="background: var(--primary); color: white; padding: 20px; display: flex; align-items: center; gap: 12px;">
            <div style="width: 40px; height: 40px; background: rgba(255,255,255,0.1); border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                <i class="fas fa-brain"></i>
            </div>
            <div>
                <strong style="display: block; font-size: 0.9rem;">Da Nang Hub AI</strong>
                <small style="opacity: 0.8; font-size: 0.75rem;">Business Intelligence Assistant</small>
            </div>
            <button id="close-chat" style="margin-left: auto; background: none; border: none; color: white; cursor: pointer; opacity: 0.6;"><i class="fas fa-times"></i></button>
        </div>

        <!-- Chat Messages Area -->
        <div id="chat-messages" style="flex: 1; overflow-y: auto; padding: 20px; background: #f8f9fa; display: flex; flex-direction: column; gap: 15px;">
            <div class="bot-msg" style="align-self: flex-start; max-width: 80%; background: white; padding: 12px 16px; border-radius: 15px 15px 15px 0; border: 1px solid #eee; font-size: 0.85rem; line-height: 1.5;">
                Hello! I'm your AI business assistant. How can I help you optimize your Da Nang travel experiences today?
            </div>
        </div>

        <!-- Chat Input Area -->
        <div style="padding: 15px; background: white; border-top: 1px solid #eee;">
            <form id="chat-form" style="display: flex; gap: 10px;">
                <input type="text" id="chat-input" placeholder="Ask about revenue, recommendations..." style="flex: 1; padding: 10px 15px; border: 1px solid #ddd; border-radius: 25px; font-size: 0.85rem; outline: none;">
                <button type="submit" style="width: 38px; height: 38px; border-radius: 50%; background: var(--primary); color: white; border: none; cursor: pointer; display: flex; align-items: center; justify-content: center;">
                    <i class="fas fa-paper-plane" style="font-size: 0.9rem;"></i>
                </button>
            </form>
        </div>
    </div>
</div>

<script>
    (function() {
        const toggleBtn = document.getElementById('chat-toggle');
        const chatWindow = document.getElementById('chat-window');
        const closeBtn = document.getElementById('close-chat');
        const chatForm = document.getElementById('chat-form');
        const chatInput = document.getElementById('chat-input');
        const chatMessages = document.getElementById('chat-messages');

        toggleBtn.addEventListener('click', () => {
            const isVisible = chatWindow.style.display === 'flex';
            chatWindow.style.display = isVisible ? 'none' : 'flex';
            if (!isVisible) {
                chatInput.focus();
                document.getElementById('chat-notification').style.display = 'none';
            }
        });

        closeBtn.addEventListener('click', () => {
            chatWindow.style.display = 'none';
        });

        chatForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const msg = chatInput.value.trim();
            if (!msg) return;

            // Add User Message
            addMessage(msg, 'user');
            chatInput.value = '';

            // Loading state
            const loadingId = 'loading-' + Date.now();
            addMessage('<i class="fas fa-spinner fa-spin"></i> Analyzing your business data...', 'bot', loadingId);

            try {
                const response = await fetch('${pageContext.request.contextPath}/ai/chat', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'message=' + encodeURIComponent(msg)
                });

                const data = await response.json();
                document.getElementById(loadingId).remove();

                if (response.status === 403) {
                    addMessage('<strong>Upgrade Required:</strong> ' + data.message + ' <br><br><a href="${pageContext.request.contextPath}/views/subscription-payment/pricing.jsp" style="color: var(--primary); font-weight: 700;">View Pricing</a>', 'bot');
                } else {
                    addMessage(data.response, 'bot');
                }
            } catch (error) {
                document.getElementById(loadingId).remove();
                addMessage('Sorry, I encountered an error. Please try again later.', 'bot');
            }
        });

        function addMessage(content, type, id = null) {
            const msgDiv = document.createElement('div');
            msgDiv.style.alignSelf = type === 'user' ? 'flex-end' : 'flex-start';
            msgDiv.style.maxWidth = '85%';
            msgDiv.style.padding = '12px 16px';
            msgDiv.style.borderRadius = type === 'user' ? '15px 15px 0 15px' : '15px 15px 15px 0';
            msgDiv.style.fontSize = '0.85rem';
            msgDiv.style.lineHeight = '1.5';
            
            if (id) msgDiv.id = id;

            if (type === 'user') {
                msgDiv.style.background = 'var(--primary)';
                msgDiv.style.color = 'white';
            } else {
                msgDiv.style.background = 'white';
                msgDiv.style.color = '#333';
                msgDiv.style.border = '1px solid #eee';
            }

            msgDiv.innerHTML = content;
            chatMessages.appendChild(msgDiv);
            chatMessages.scrollTop = chatMessages.scrollHeight;
        }
    })();
</script>
