<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${tour != null ? 'Sửa' : 'Thêm'} Tour - VietAir</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">   
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        .form-wrapper {
            width: 100%;
            max-width: 720px;
            background: white;
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            animation: slideUp 0.5s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 32px;
            text-align: center;
            color: white;
        }

        .form-header i {
            font-size: 48px;
            margin-bottom: 12px;
            display: block;
        }

        .form-header h2 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .form-header p {
            font-size: 14px;
            opacity: 0.9;
        }

        .form-body {
            padding: 40px;
        }

        .alert {
            padding: 16px 20px;
            border-radius: 12px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            background: #fee;
            color: #c33;
            border: 1px solid #fcc;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-row.full {
            grid-template-columns: 1fr;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-label {
            font-size: 14px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .required {
            color: #e74c3c;
        }

        .form-control {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e0e6ed;
            border-radius: 12px;
            font-size: 15px;
            font-family: 'Inter', sans-serif;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        .form-control::placeholder {
            color: #a0aec0;
        }

        textarea.form-control {
            resize: vertical;
            min-height: 120px;
            font-family: 'Inter', sans-serif;
        }

        .form-control:read-only {
            background: #e9ecef;
            cursor: not-allowed;
        }

        .help-text {
            font-size: 13px;
            color: #718096;
            margin-top: 6px;
        }

        .form-actions {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            margin-top: 32px;
        }

        .btn {
            padding: 16px 32px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.3s ease;
            text-decoration: none;
            font-family: 'Inter', sans-serif;
        }

        .btn-cancel {
            background: #e2e8f0;
            color: #4a5568;
        }

        .btn-cancel:hover {
            background: #cbd5e0;
            transform: translateY(-2px);
        }

        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.5);
        }

        .occupancy-badge {
            display: inline-block;
            padding: 6px 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            margin-top: 6px;
        }

        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }

            .form-actions {
                grid-template-columns: 1fr;
            }

            .form-body {
                padding: 24px;
            }
        }
    </style>
</head>
<body>
    <div class="form-wrapper">
        <div class="form-header">
            <i class="fas fa-${tour != null ? 'edit' : 'plus-circle'}"></i>
            <h2>${tour != null ? 'Sửa' : 'Thêm'} Tour Du lịch</h2>
            <p>Điền thông tin tin tour vào form bên dưới</p>
        </div>

        <div class="form-body">
            <c:if test="${not empty error}">
                <div class="alert">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>${error}</span>
                </div>
            </c:if>

            <form action="tour" method="post">
                <input type="hidden" name="action" value="${tour != null ? 'update' : 'create'}">
                <c:if test="${tour != null}">
                    <input type="hidden" name="id" value="${tour.id}">
                    <input type="hidden" name="currentCapacity" value="${tour.currentCapacity}">
                </c:if>

                <div class="form-row full">
                    <div class="form-group">
                        <label class="form-label">
                            Tên Tour <span class="required">*</span>
                        </label>
                        <input type="text" class="form-control" name="name"
                               value="${tour != null ? tour.name : ''}"
                               placeholder="VD: Tour Đà Nẵng 3N2Đ" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">
                            Điểm đến <span class="required">*</span>
                        </label>
                        <input type="text" class="form-control" name="destination"
                               value="${tour != null ? tour.destination : ''}"
                               placeholder="VD: Đà Nẵng" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            Giá (VNĐ) <span class="required">*</span>
                        </label>
                        <input type="number" class="form-control" name="price"
                               value="${tour != null ? tour.price : ''}"
                               placeholder="VD: 2500000" min="0" step="1000" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">
                            Ngày bắt đầu <span class="required">*</span>
                        </label>
                        <input type="date" class="form-control" name="startDate"
                               value="${tour != null ? tour.startDate : ''}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            Ngày kết thúc <span class="required">*</span>
                        </label>
                        <input type="date" class="form-control" name="endDate"
                               value="${tour != null ? tour.endDate : ''}" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">
                            Sức chứa tối đa <span class="required">*</span>
                        </label>
                        <input type="number" class="form-control" name="maxCapacity"
                               value="${tour != null ? tour.maxCapacity : ''}"
                               placeholder="VD: 30" min="1" required>
                    </div>

                    <c:if test="${tour != null}">
                        <div class="form-group">
                            <label class="form-label">Đã đặt</label>
                            <input type="text" class="form-control"
                                   value="${tour.currentCapacity} người" readonly>
                            <span class="occupancy-badge">
                                <i class="fas fa-chart-pie"></i> Occupancy: ${tour.occupancyRate}%
                            </span>
                        </div>
                    </c:if>
                </div>

                <div class="form-row full">
                    <div class="form-group">
                        <label class="form-label">Mô tả</label>
                        <textarea class="form-control" name="description"
                                  placeholder="Mô tả chi tiết về tour...">${tour != null ? tour.description : ''}</textarea>
                    </div>
                </div>

                <div class="form-actions">
                    <a href="tour?action=list" class="btn btn-cancel">
                        <i class="fas fa-times"></i>
                        <span>Hủy</span>
                    </a>
                    <button type="submit" class="btn btn-submit">
                        <i class="fas fa-${tour != null ? 'save' : 'plus'}"></i>
                        <span>${tour != null ? 'Cập nhật' : 'Tạo mới'}</span>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Validate dates
        document.querySelector('form').addEventListener('submit', function(e) {
            const startDate = new Date(document.querySelector('[name="startDate"]').value);
            const endDate = new Date(document.querySelector('[name="endDate"]').value);

            if (endDate < startDate) {
                e.preventDefault();
                alert('Ngày kết thúc phải sau ngày bắt đầu!');
            }
        });

        // Auto-format price input
        const priceInput = document.querySelector('[name="price"]');
        if (priceInput) {
            priceInput.addEventListener('blur', function() {
                if (this.value) {
                    this.value = Math.round(this.value / 1000) * 1000;
                }
            });
        }
    </script>
</body>
</html>
