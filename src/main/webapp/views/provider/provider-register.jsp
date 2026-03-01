<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Đăng Ký Nhà Cung Cấp | Da Nang Travel Hub</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                :root {
                    --primary-color: #FF7F5C;
                    --secondary-color: #2C3E50;
                    --light-bg: #F8F9FA;
                    --card-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                    --success-color: #28a745;
                }

                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background-color: var(--light-bg);
                }

                .page-header {
                    background: linear-gradient(135deg, var(--secondary-color) 0%, #34495e 100%);
                    color: white;
                    padding: 60px 0 40px;
                    margin-bottom: 40px;
                    border-radius: 0 0 30px 30px;
                    box-shadow: var(--card-shadow);
                }

                .registration-card {
                    background: white;
                    border-radius: 15px;
                    padding: 40px;
                    box-shadow: var(--card-shadow);
                    margin-bottom: 30px;
                }

                .form-label {
                    font-weight: 600;
                    color: var(--secondary-color);
                    margin-bottom: 8px;
                }

                .form-label .required {
                    color: #dc3545;
                }

                .form-control,
                .form-select {
                    border: 2px solid #dee2e6;
                    border-radius: 10px;
                    padding: 12px 15px;
                    transition: all 0.3s;
                }

                .form-control:focus,
                .form-select:focus {
                    border-color: var(--primary-color);
                    box-shadow: 0 0 0 0.2rem rgba(255, 127, 92, 0.25);
                }

                .form-control.is-invalid {
                    border-color: #dc3545;
                }

                .form-control.is-valid {
                    border-color: var(--success-color);
                }

                .invalid-feedback {
                    display: block;
                    color: #dc3545;
                    font-size: 0.9rem;
                    margin-top: 5px;
                }

                .valid-feedback {
                    display: block;
                    color: var(--success-color);
                    font-size: 0.9rem;
                    margin-top: 5px;
                }

                .input-group-text {
                    background: var(--light-bg);
                    border: 2px solid #dee2e6;
                    border-right: none;
                    color: var(--primary-color);
                }

                .input-group .form-control {
                    border-left: none;
                }

                .input-group:focus-within .input-group-text {
                    border-color: var(--primary-color);
                }

                .btn-submit {
                    background: var(--primary-color);
                    color: white;
                    border: none;
                    padding: 15px 50px;
                    border-radius: 25px;
                    font-weight: 700;
                    font-size: 1.1rem;
                    transition: all 0.3s;
                    width: 100%;
                }

                .btn-submit:hover {
                    background: #ff6a47;
                    transform: scale(1.05);
                    box-shadow: 0 6px 20px rgba(255, 127, 92, 0.4);
                }

                .btn-back {
                    background: var(--secondary-color);
                    color: white;
                    border: none;
                    padding: 12px 30px;
                    border-radius: 25px;
                    font-weight: 600;
                    transition: all 0.3s;
                    text-decoration: none;
                    display: inline-block;
                }

                .btn-back:hover {
                    background: #1a252f;
                    transform: translateY(-2px);
                    box-shadow: 0 4px 15px rgba(44, 62, 80, 0.3);
                    color: white;
                }

                .info-box {
                    background: rgba(255, 127, 92, 0.1);
                    border-left: 4px solid var(--primary-color);
                    padding: 20px;
                    border-radius: 10px;
                    margin-bottom: 30px;
                }

                .info-box h5 {
                    color: var(--secondary-color);
                    font-weight: 700;
                    margin-bottom: 15px;
                }

                .info-box ul {
                    margin-bottom: 0;
                    padding-left: 20px;
                }

                .info-box li {
                    margin-bottom: 8px;
                    color: #495057;
                }

                .section-title {
                    color: var(--secondary-color);
                    font-weight: 700;
                    margin-bottom: 20px;
                    padding-bottom: 10px;
                    border-bottom: 3px solid var(--primary-color);
                }

                .alert-custom {
                    border-radius: 10px;
                    padding: 15px 20px;
                    margin-bottom: 20px;
                }

                @media (max-width: 768px) {
                    .registration-card {
                        padding: 25px;
                    }

                    .btn-submit {
                        padding: 12px 30px;
                    }
                }
            </style>
        </head>

        <body>

            <!-- Include Header -->
            <jsp:include page="/common/_header.jsp" />

            <!-- Page Header -->
            <div class="page-header">
                <div class="container">
                    <h1><i class="fas fa-user-plus"></i> Đăng Ký Làm Nhà Cung Cấp</h1>
                    <p>Trở thành đối tác của chúng tôi và mở rộng kinh doanh du lịch</p>
                </div>
            </div>

            <div class="container mb-5">
                <div class="row">
                    <div class="col-lg-8 mx-auto">

                        <!-- Info Box -->
                        <div class="info-box">
                            <h5><i class="fas fa-info-circle"></i> Lợi ích khi trở thành đối tác</h5>
                            <ul>
                                <li><i class="fas fa-check" style="color: var(--success-color);"></i> Tiếp cận hàng
                                    nghìn khách hàng tiềm năng</li>
                                <li><i class="fas fa-check" style="color: var(--success-color);"></i> Quản lý dịch vụ
                                    và giá cả linh hoạt</li>
                                <li><i class="fas fa-check" style="color: var(--success-color);"></i> Hỗ trợ marketing
                                    và quảng bá miễn phí</li>
                                <li><i class="fas fa-check" style="color: var(--success-color);"></i> Hệ thống thanh
                                    toán an toàn và nhanh chóng</li>
                            </ul>
                        </div>

                        <!-- Error/Success Messages -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-custom">
                                <i class="fas fa-exclamation-circle"></i> ${error}
                            </div>
                        </c:if>

                        <!-- Registration Form -->
                        <div class="registration-card">
                            <h3 class="section-title">
                                <i class="fas fa-file-alt"></i> Thông Tin Đăng Ký
                            </h3>

                            <form action="${pageContext.request.contextPath}/providers" method="post"
                                id="registrationForm" novalidate>
                                <input type="hidden" name="action" value="register">

                                <!-- Business Name -->
                                <div class="mb-4">
                                    <label for="businessName" class="form-label">
                                        Tên Doanh Nghiệp <span class="required">*</span>
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-building"></i>
                                        </span>
                                        <input type="text" class="form-control" id="businessName" name="businessName"
                                            placeholder="Nhập tên doanh nghiệp" required minlength="3" maxlength="200"
                                            value="${param.businessName}">
                                    </div>
                                    <div class="invalid-feedback" id="businessNameError"></div>
                                </div>

                                <!-- Provider Type -->
                                <div class="mb-4">
                                    <label for="providerType" class="form-label">
                                        Loại Dịch Vụ <span class="required">*</span>
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-tags"></i>
                                        </span>
                                        <select class="form-select" id="providerType" name="providerType" required>
                                            <option value="">-- Chọn loại dịch vụ --</option>
                                            <option value="Hotel" ${param.providerType=='Hotel' ? 'selected' : '' }>
                                                Khách sạn</option>
                                            <option value="TourOperator" ${param.providerType=='TourOperator'
                                                ? 'selected' : '' }>Tour</option>
                                            <option value="Transport" ${param.providerType=='Transport' ? 'selected'
                                                : '' }>Vận chuyển
                                            </option>
                                        </select>
                                    </div>
                                    <div class="invalid-feedback" id="providerTypeError"></div>
                                </div>

                                <!-- Business License -->
                                <div class="mb-4">
                                    <label for="businessLicense" class="form-label">
                                        Giấy Phép Kinh Doanh <span class="required">*</span>
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-certificate"></i>
                                        </span>
                                        <input type="text" class="form-control" id="businessLicense"
                                            name="businessLicense" placeholder="Nhập số giấy phép kinh doanh" required
                                            minlength="5" maxlength="50" value="${param.businessLicense}">
                                    </div>
                                    <div class="invalid-feedback" id="businessLicenseError"></div>
                                </div>

                                <!-- Email -->
                                <div class="mb-4">
                                    <label for="email" class="form-label">
                                        Email <span class="required">*</span>
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-envelope"></i>
                                        </span>
                                        <input type="email" class="form-control" id="email" name="email"
                                            placeholder="example@company.com" required value="${param.email}">
                                    </div>
                                    <div class="invalid-feedback" id="emailError"></div>
                                </div>

                                <!-- Phone -->
                                <div class="mb-4">
                                    <label for="phone" class="form-label">
                                        Số Điện Thoại <span class="required">*</span>
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-phone"></i>
                                        </span>
                                        <input type="tel" class="form-control" id="phone" name="phone"
                                            placeholder="0901234567" required pattern="[0-9]{10,11}"
                                            value="${param.phone}">
                                    </div>
                                    <div class="invalid-feedback" id="phoneError"></div>
                                    <small class="text-muted">Nhập 10-11 chữ số</small>
                                </div>

                                <!-- Address -->
                                <div class="mb-4">
                                    <label for="address" class="form-label">
                                        Địa Chỉ <span class="required">*</span>
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-map-marker-alt"></i>
                                        </span>
                                        <input type="text" class="form-control" id="address" name="address"
                                            placeholder="Nhập địa chỉ doanh nghiệp" required minlength="10"
                                            maxlength="500" value="${param.address}">
                                    </div>
                                    <div class="invalid-feedback" id="addressError"></div>
                                </div>

                                <!-- Description -->
                                <div class="mb-4">
                                    <label for="description" class="form-label">
                                        Mô Tả Dịch Vụ
                                    </label>
                                    <textarea class="form-control" id="description" name="description" rows="4"
                                        placeholder="Mô tả ngắn về dịch vụ của bạn (tùy chọn)"
                                        maxlength="1000">${param.description}</textarea>
                                    <small class="text-muted">Tối đa 1000 ký tự</small>
                                </div>

                                <!-- Terms and Conditions -->
                                <div class="mb-4">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="agreeTerms" required>
                                        <label class="form-check-label" for="agreeTerms">
                                            Tôi đồng ý với <a href="#" style="color: var(--primary-color);">Điều khoản
                                                dịch vụ</a> và <a href="#" style="color: var(--primary-color);">Chính
                                                sách bảo mật</a> <span class="required">*</span>
                                        </label>
                                        <div class="invalid-feedback" id="agreeTermsError"></div>
                                    </div>
                                </div>

                                <!-- Submit Button -->
                                <button type="submit" class="btn-submit">
                                    <i class="fas fa-paper-plane"></i> Gửi Đăng Ký
                                </button>
                            </form>
                        </div>

                        <!-- Back Button -->
                        <div class="text-center mt-4">
                            <a href="${pageContext.request.contextPath}/providers" class="btn-back">
                                <i class="fas fa-arrow-left"></i> Quay lại danh sách
                            </a>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Include Footer -->
            <jsp:include page="/common/_footer.jsp" />

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const form = document.getElementById('registrationForm');

                    // Validation rules
                    const validationRules = {
                        businessName: {
                            required: true,
                            minLength: 3,
                            maxLength: 200,
                            message: 'Tên doanh nghiệp phải từ 3-200 ký tự'
                        },
                        providerType: {
                            required: true,
                            message: 'Vui lòng chọn loại dịch vụ'
                        },
                        businessLicense: {
                            required: true,
                            minLength: 5,
                            maxLength: 50,
                            message: 'Giấy phép kinh doanh phải từ 5-50 ký tự'
                        },
                        email: {
                            required: true,
                            pattern: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
                            message: 'Email không hợp lệ'
                        },
                        phone: {
                            required: true,
                            pattern: /^[0-9]{10,11}$/,
                            message: 'Số điện thoại phải có 10-11 chữ số'
                        },
                        address: {
                            required: true,
                            minLength: 10,
                            maxLength: 500,
                            message: 'Địa chỉ phải từ 10-500 ký tự'
                        },
                        agreeTerms: {
                            required: true,
                            message: 'Bạn phải đồng ý với điều khoản dịch vụ'
                        }
                    };

                    // Validate field
                    function validateField(fieldName, value) {
                        const rules = validationRules[fieldName];
                        if (!rules) return true;

                        if (rules.required && !value) {
                            return rules.message;
                        }

                        if (rules.minLength && value.length < rules.minLength) {
                            return rules.message;
                        }

                        if (rules.maxLength && value.length > rules.maxLength) {
                            return rules.message;
                        }

                        if (rules.pattern && !rules.pattern.test(value)) {
                            return rules.message;
                        }

                        return true;
                    }

                    // Show error
                    function showError(fieldName, message) {
                        const field = document.getElementById(fieldName);
                        const errorDiv = document.getElementById(fieldName + 'Error');

                        field.classList.add('is-invalid');
                        field.classList.remove('is-valid');
                        if (errorDiv) {
                            errorDiv.textContent = message;
                        }
                    }

                    // Show success
                    function showSuccess(fieldName) {
                        const field = document.getElementById(fieldName);
                        const errorDiv = document.getElementById(fieldName + 'Error');

                        field.classList.remove('is-invalid');
                        field.classList.add('is-valid');
                        if (errorDiv) {
                            errorDiv.textContent = '';
                        }
                    }

                    // Real-time validation
                    Object.keys(validationRules).forEach(fieldName => {
                        const field = document.getElementById(fieldName);
                        if (!field) return;

                        field.addEventListener('blur', function () {
                            const value = field.type === 'checkbox' ? field.checked : field.value.trim();
                            const result = validateField(fieldName, value);

                            if (result === true) {
                                showSuccess(fieldName);
                            } else {
                                showError(fieldName, result);
                            }
                        });

                        field.addEventListener('input', function () {
                            if (field.classList.contains('is-invalid')) {
                                const value = field.type === 'checkbox' ? field.checked : field.value.trim();
                                const result = validateField(fieldName, value);

                                if (result === true) {
                                    showSuccess(fieldName);
                                }
                            }
                        });
                    });

                    // Form submission
                    form.addEventListener('submit', function (e) {
                        e.preventDefault();
                        let isValid = true;

                        // Validate all fields
                        Object.keys(validationRules).forEach(fieldName => {
                            const field = document.getElementById(fieldName);
                            if (!field) return;

                            const value = field.type === 'checkbox' ? field.checked : field.value.trim();
                            const result = validateField(fieldName, value);

                            if (result === true) {
                                showSuccess(fieldName);
                            } else {
                                showError(fieldName, result);
                                isValid = false;
                            }
                        });

                        if (isValid) {
                            form.submit();
                        } else {
                            // Scroll to first error
                            const firstError = document.querySelector('.is-invalid');
                            if (firstError) {
                                firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                            }
                        }
                    });
                });
            </script>
        </body>

        </html>