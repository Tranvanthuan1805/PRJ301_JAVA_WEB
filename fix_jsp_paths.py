import os
import re

def update_file(path, replacements):
    try:
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        for pattern, replacement in replacements:
            content = re.sub(pattern, replacement, content)
        
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)
    except Exception as e:
        print(f"Error updating {path}: {e}")

# Mapping old JSP paths to new ones
jsp_replacements = [
    (r'/admin/provider-list.jsp', '/views/provider-management/provider-list.jsp'),
    (r'/admin/price-comparison.jsp', '/views/provider-management/price-comparison.jsp'),
    (r'/admin/customer-list.jsp', '/views/customer-management/customer-list.jsp'),
    (r'/admin/customer-detail.jsp', '/views/customer-management/customer-detail.jsp'),
    (r'/admin/tour-list.jsp', '/views/tour-management/tour-list.jsp'),
    (r'/admin/tour-form.jsp', '/views/tour-management/tour-form.jsp'),
    (r'/customer/cart.jsp', '/views/cart-booking/cart.jsp'),
    (r'/customer/confirmation.jsp', '/views/cart-booking/confirmation.jsp'),
    (r'/admin/order-list.jsp', '/views/order-management/order-list.jsp'),
    (r'/admin/order-detail.jsp', '/views/order-management/order-detail.jsp'),
    (r'/pricing.jsp', '/views/subscription-payment/pricing.jsp'),
    (r'/payment.jsp', '/views/subscription-payment/payment.jsp'),
    (r'/admin/forecast-dashboard.jsp', '/views/ai-forecasting/forecast-dashboard.jsp'),
    (r'/chatbot.jsp', '/views/ai-chatbot/chatbot.jsp'),
]

# Re-package servlets
# Move files first (manually or via script)
# For now, just update the JSP paths in any java file

for root, dirs, files in os.walk('src/main/java/controller'):
    for f in files:
        if f.endswith('.java'):
            update_file(os.path.join(root, f), jsp_replacements)

# Also update common includes if any
for root, dirs, files in os.walk('src/main/webapp'):
    for f in files:
        if f.endswith('.jsp'):
            update_file(os.path.join(root, f), jsp_replacements)

print("JSP paths updated in controllers and JSPs.")
