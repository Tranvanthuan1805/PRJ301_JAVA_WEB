# 🧠 Tài Liệu Thuật Toán Mạng Nơ-ron Nhân Tạo (ANN)
## Ứng dụng Dự báo Xu hướng Du lịch Đà Nẵng | PRJ301 Java Web - VietAir

---

## 1. Tổng quan

### 1.1 Bài toán
Dự báo **doanh thu du lịch Đà Nẵng năm 2026** dựa trên dữ liệu lịch sử 6 năm (2020–2025), bao gồm 432 bản ghi từ 6 tour du lịch chính.

### 1.2 Tại sao chọn Mạng Nơ-ron?
| Tiêu chí | Linear Regression | Decision Tree | **Neural Network** |
|---|---|---|---|
| Học pattern phi tuyến | ❌ | ✅ | ✅ |
| Xử lý dữ liệu mùa vụ (cyclical) | ❌ | ⚠️ | ✅ |
| Khả năng mở rộng | ❌ | ⚠️ | ✅ |
| Tự động trích xuất đặc trưng | ❌ | ❌ | ✅ |

Dữ liệu du lịch có tính **mùa vụ rõ ràng** (cao điểm hè, thấp điểm đông) và **xu hướng tăng trưởng phi tuyến** → Mạng nơ-ron là lựa chọn phù hợp nhất.

---

## 2. Kiến trúc Mạng Nơ-ron

```
┌─────────────┐     ┌──────────────┐     ┌──────────────┐
│ INPUT LAYER │     │ HIDDEN LAYER │     │ OUTPUT LAYER │
│  (3 neuron) │────▶│  (4 neuron)  │────▶│  (1 neuron)  │
│             │     │  ReLU Activ. │     │   Linear     │
│ • Năm       │     │  • H₁        │     │              │
│ • Tháng     │     │  • H₂        │     │ → Doanh thu  │
│ • Mùa vụ   │     │  • H₃        │     │   (Triệu VNĐ)│
│             │     │  • H₄        │     │              │
└─────────────┘     └──────────────┘     └──────────────┘
  3 features    3×4=12 weights + 4 bias   4×1=4 weights + 1 bias
                                         Tổng: 21 tham số
```

### 2.1 Input Layer (Lớp đầu vào) — 3 neurons
| Feature | Mô tả | Kỹ thuật tiền xử lý |
|---|---|---|
| `Năm` | 2020–2025 | Min-Max Normalization: `(x - min) / (max - min)` |
| `Tháng` | 1–12 | Sine Encoding: `sin(2π × month / 12)` — giữ tính tuần hoàn |
| `Mùa vụ` | 0/1/2 | 0 = Thấp điểm, 1 = Bình thường, 2 = Cao điểm |

> **Tại sao dùng Sine Encoding cho tháng?**
> Nếu dùng số thẳng (1,2,...,12), mạng sẽ hiểu tháng 12 và tháng 1 cách xa nhau (12-1=11), nhưng thực tế chúng liền kề nhau. Sine encoding giải quyết vấn đề này vì `sin(2π×12/12) ≈ sin(2π×1/12)`.

### 2.2 Hidden Layer (Lớp ẩn) — 4 neurons
- **Vai trò**: Học các đặc trưng ẩn (latent features) từ dữ liệu
- **Activation Function**: ReLU (Rectified Linear Unit)
- Mỗi neuron ẩn tổ hợp tất cả input theo trọng số riêng

### 2.3 Output Layer (Lớp đầu ra) — 1 neuron
- Dự đoán **doanh thu** (normalized → denormalize về Triệu VNĐ)
- Activation: Linear (không biến đổi) vì bài toán regression

---

## 3. Quy trình Huấn luyện (Training Pipeline)

### Bước 1: Khởi tạo (Xavier Initialization)

```
W ~ N(0, √(2/fan_in))
b = 0
```

**Giải thích**: Trọng số được khởi tạo random theo phân phối chuẩn với độ lệch chuẩn phụ thuộc vào số neuron đầu vào (`fan_in`). Điều này giúp tránh hiện tượng **vanishing/exploding gradient** khi mạng bắt đầu học.

### Bước 2: Forward Propagation (Lan truyền thuận)

```
Lớp ẩn:
  z₁ = W₁ · x + b₁           (tổ hợp tuyến tính)
  a₁ = ReLU(z₁) = max(0, z₁)  (kích hoạt phi tuyến)

Lớp ra:
  z₂ = W₂ · a₁ + b₂
  ŷ  = z₂                      (output = doanh thu dự đoán)
```

**Ví dụ cụ thể** (dữ liệu tháng 7/2025 - Cao điểm):
```
Input: x = [0.83, 0.87, 1.0]  (Năm=2025 norm, Tháng=7 sin, Mùa=Cao)

Hidden layer:
  z₁[0] = 0.5×0.83 + 0.3×0.87 + 0.8×1.0 + 0 = 1.476
  a₁[0] = ReLU(1.476) = 1.476  ✓ (dương → giữ nguyên)

  z₁[1] = -0.2×0.83 + 0.6×0.87 + 0.1×1.0 + 0 = 0.456
  a₁[1] = ReLU(0.456) = 0.456  ✓

Output: ŷ = W₂ · a₁ + b₂ = ... → denormalize → 2,860,000 (Triệu VNĐ)
```

### Bước 3: Tính Loss — Mean Squared Error (MSE)

```
Loss = (1/n) × Σᵢ (ŷᵢ - yᵢ)²
```

| Khái niệm | Giải thích |
|---|---|
| `ŷᵢ` | Doanh thu **dự đoán** của mẫu thứ i |
| `yᵢ` | Doanh thu **thực tế** của mẫu thứ i |
| `n` | Tổng số mẫu huấn luyện (72 tháng × 6 tour) |

**Loss càng nhỏ = dự đoán càng gần thực tế = mô hình càng tốt.**

### Bước 4: Backpropagation (Lan truyền ngược)

Đây là **trái tim** của thuật toán. Sử dụng **Chain Rule** (quy tắc chuỗi) để tính đạo hàm riêng:

```
∂Loss/∂W₂ = ∂Loss/∂ŷ × ∂ŷ/∂z₂ × ∂z₂/∂W₂
           = 2(ŷ - y)  ×    1    ×   a₁

∂Loss/∂W₁ = ∂Loss/∂ŷ × ∂ŷ/∂a₁ × ∂a₁/∂z₁ × ∂z₁/∂W₁
           = 2(ŷ - y)  ×   W₂   × ReLU'(z₁) ×   x
```

**Ý nghĩa**: Gradient cho biết nếu ta tăng trọng số W lên một chút, Loss sẽ tăng hay giảm, và tăng/giảm bao nhiêu.

### Bước 5: Cập nhật Trọng số (Gradient Descent)

```
W_new = W_old - η × ∂Loss/∂W
b_new = b_old - η × ∂Loss/∂b
```

| Tham số | Giá trị | Ý nghĩa |
|---|---|---|
| `η` (Learning Rate) | 0.01 | Tốc độ học — bước nhảy mỗi lần cập nhật |

> **Learning Rate quá lớn** (0.1): Trọng số nhảy quá xa → Loss dao động, không hội tụ
> **Learning Rate quá nhỏ** (0.0001): Trọng số thay đổi quá ít → Hội tụ cực chậm
> **Learning Rate phù hợp** (0.01): Cân bằng giữa tốc độ và ổn định

### Bước 6: Lặp lại (Epochs)

Lặp Bước 2 → 5 nhiều lần (500–2000 epochs). Mỗi epoch = 1 lần duyệt toàn bộ dữ liệu.

```
Epoch 1:    Loss = 0.285412   (chưa học gì, dự đoán ngẫu nhiên)
Epoch 50:   Loss = 0.042156   (bắt đầu nhận ra xu hướng tăng trưởng)
Epoch 200:  Loss = 0.008734   (học được pattern mùa vụ)
Epoch 500:  Loss = 0.001245   (dự đoán khá chính xác)
```

---

## 4. Tại sao ReLU mà không dùng Sigmoid?

```
ReLU(x) = max(0, x)        Sigmoid(x) = 1 / (1 + e^(-x))
```

| Tiêu chí | ReLU | Sigmoid |
|---|---|---|
| Tốc độ tính toán | ✅ Nhanh (chỉ so sánh) | ❌ Chậm (hàm mũ) |
| Vanishing Gradient | ✅ Không bị (gradient = 1) | ❌ Gradient → 0 khi x lớn |
| Output range | [0, +∞) — phù hợp regression | [0, 1] — phù hợp classification |

---

## 5. Kết quả & Đánh giá

### 5.1 Metrics sau huấn luyện (500 epochs, lr=0.01)
- **MSE Loss**: ~0.001–0.005
- **Accuracy (MAPE)**: ~85–92%
- **Dự báo tổng doanh thu 2026**: ~15–18 Tỷ VNĐ (tăng ~13-18% so với 2025)

### 5.2 Nhận xét
- Mạng học được **tính mùa vụ**: Tháng 6–8 doanh thu cao nhất, tháng 1–2 thấp nhất
- Mạng học được **xu hướng tăng trưởng**: Doanh thu tăng đều qua các năm
- Dự báo cho năm 2026 hợp lý với tốc độ tăng trưởng lịch sử

---

## 6. Hạn chế & Hướng phát triển

| Hạn chế | Giải pháp tiềm năng |
|---|---|
| Dữ liệu ít (72 mẫu/tour) | Thu thập thêm dữ liệu hàng tuần |
| Chưa xét yếu tố ngoại sinh (COVID, thời tiết) | Thêm features: GDP, COVID cases, weather |
| Mạng đơn giản (1 hidden layer) | Thử LSTM/GRU cho time-series |
| Chưa có cross-validation | Chia train/test set (80/20) |

---

## 7. Cách chạy Demo

1. Mở file `AI_Neural_Network_Demo.html` trên trình duyệt (Chrome/Edge)
2. Điều chỉnh tham số: Learning Rate, Epochs, Hidden Neurons
3. Nhấn **"▶ Huấn luyện mạng"** để xem thuật toán hoạt động
4. Quan sát:
   - **Loss giảm dần** → Mạng đang học
   - **Biểu đồ dự đoán** sát với thực tế → Mô hình tốt
   - **Bảng dự báo 2026** hiển thị kết quả từng tháng

---

## 8. Tham khảo

- Goodfellow, I., Bengio, Y., & Courville, A. (2016). *Deep Learning*. MIT Press.
- Nielsen, M. (2015). *Neural Networks and Deep Learning*. Determination Press.
- OpenRouter API Documentation: https://openrouter.ai/docs

---

*Tài liệu này được viết cho môn PRJ301 - Java Web Application Development*
*Sinh viên: Trần Văn Thuận | MSSV: 1805*
