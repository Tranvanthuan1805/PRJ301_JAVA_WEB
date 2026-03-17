const { Document, Packer, Paragraph, TextRun, HeadingLevel, Table, TableRow, TableCell, WidthType, AlignmentType, ShadingType } = require("docx");
const fs = require("fs");

async function main() {
    const doc = new Document({
        sections: [{
            children: [
                new Paragraph({
                    alignment: AlignmentType.CENTER,
                    children: [
                        new TextRun({
                            text: "BẢNG MÔ TẢ CHI TIẾT CÔNG VIỆC DỰ ÁN",
                            bold: true,
                            size: 32,
                            font: "Times New Roman",
                        }),
                    ],
                    spacing: { after: 400 },
                }),
                new Paragraph({
                    alignment: AlignmentType.CENTER,
                    children: [
                        new TextRun({
                            text: "Dự án: DaNang Travel Hub (EZTravel) — Nhóm 1",
                            italics: true,
                            size: 24,
                            font: "Times New Roman",
                        }),
                    ],
                    spacing: { after: 600 },
                }),
                new Table({
                    width: {
                        size: 100,
                        type: WidthType.PERCENTAGE,
                    },
                    rows: [
                        new TableRow({
                            children: [
                                new TableCell({
                                    width: { size: 10, type: WidthType.PERCENTAGE },
                                    shading: { fill: "1E3A5F" },
                                    children: [new Paragraph({ alignment: AlignmentType.CENTER, children: [new TextRun({ text: "STT", bold: true, color: "FFFFFF", font: "Times New Roman" })] })],
                                }),
                                new TableCell({
                                    width: { size: 40, type: WidthType.PERCENTAGE },
                                    shading: { fill: "1E3A5F" },
                                    children: [new Paragraph({ alignment: AlignmentType.CENTER, children: [new TextRun({ text: "Hạng Mục Công Việc", bold: true, color: "FFFFFF", font: "Times New Roman" })] })],
                                }),
                                new TableCell({
                                    width: { size: 50, type: WidthType.PERCENTAGE },
                                    shading: { fill: "1E3A5F" },
                                    children: [new Paragraph({ alignment: AlignmentType.CENTER, children: [new TextRun({ text: "Mô Tả Chi Tiết / Kết Quả", bold: true, color: "FFFFFF", font: "Times New Roman" })] })],
                                }),
                            ],
                        }),
                        ...[
                            ["1", "Quản lý nhà cung cấp", "Quản lý thông tin, loại dịch vụ (vận chuyển, khách sạn...), trạng thái hợp tác."],
                            ["2", "So sánh giá nhà cung cấp", "Theo dõi và so sánh mức giá dịch vụ giữa các đối tác để tối ưu chi phí."],
                            ["3", "Quản lý khách hàng", "Quản lý hồ sơ cá nhân, thông tin liên lạc và tài khoản người dùng."],
                            ["4", "Theo dõi lịch sử tương tác", "Lưu trữ lịch sử tìm kiếm, lịch sử đặt tour, hủy tour và hành vi user."],
                            ["5", "Quản lý Tour du lịch", "Cập nhật thông tin tour, lịch trình chi tiết, giá cả và quản lý số chỗ trống."],
                            ["6", "Giỏ hàng & Lưu trữ phiên", "Triển khai Session / Database Persistence để duy trì giỏ hàng ổn định."],
                            ["7", "Xử lý Đặt tour", "Cập nhật trạng thái real-time, xử lý quy trình đặt tour và phân tích giỏ hàng bỏ quên."],
                            ["8", "Quản lý Đơn hàng (OMS)", "Quy trình xử lý đơn từ Chờ xác nhận → Hoàn thành/Hủy, ghi nhận doanh thu."],
                            ["9", "Gói dịch vụ & Thanh toán", "Tích hợp cổng thanh toán (Sepay) và quản lý các gói dịch vụ."],
                            ["10", "Xử lý Dữ liệu & Dự báo AI", "Dự báo doanh thu đa tầng, phân tích mùa vụ du lịch và gợi ý ra quyết định kinh doanh."],
                            ["11", "Chatbot AI Tư vấn", "Hỗ trợ khách hàng ra quyết định, phân tích & tóm tắt báo cáo, kiểm tra quyền."],
                            ["12", "Admin Dashboard", "Xây dựng Template quản trị hiện đại, trực quan hóa dữ liệu."],
                            ["13", "Nâng cấp giao diện", "Chuyển đổi Hero section sang Video, thiết kế Footer Rubic 3D độc đáo."],
                            ["14", "Responsive Mobile", "Triển khai giao diện tương thích hoàn toàn trên các thiết bị di động."],
                            ["15", "Planning Dashboard AI", "Hệ thống thống kê câu hỏi của khách hàng và phân tích hành vi người dùng bằng AI."],
                            ["16", "Hệ thống Feedback", "Triển khai tính năng đánh giá và phản hồi cho khách hàng sau khi tham gia tour."],
                            ["17", "So sánh giá Tour", "Xây dựng danh mục cho phép khách hàng so sánh giá giữa các tour khác nhau."],
                            ["18", "Hệ thống Coupon", "Xây dựng mục quản lý và áp dụng mã giảm giá (Coupon) cho khách hàng."],
                            ["19", "Xác thực người dùng", "Phát triển tính năng đăng nhập Google OAuth và hệ thống Quên mật khẩu."],
                            ["20", "Brand Identity Footer", "Cập nhật Footer với Logo chính thức của EzTravel."],
                            ["21", "Nâng cấp Bảo mật (HTTPS)", "Chuyển đổi sang HTTPS để hỗ trợ Map API và Voice AI Recognition."],
                            ["22", "Triển khai Production", "Cấu hình CI/CD, Docker, Server, Domain, SSL cho môi trường thực tế."],
                            ["23", "Thiết kế UI/UX & Backend", "Xây dựng giao diện người dùng hiện đại, responsive và tích hợp API backend."],
                        ].map(([stt, item, desc]) => new TableRow({
                            children: [
                                new TableCell({ children: [new Paragraph({ alignment: AlignmentType.CENTER, children: [new TextRun({ text: stt, font: "Times New Roman" })] })] }),
                                new TableCell({ children: [new Paragraph({ children: [new TextRun({ text: item, bold: true, font: "Times New Roman" })] })] }),
                                new TableCell({ children: [new Paragraph({ children: [new TextRun({ text: desc, font: "Times New Roman" })] })] }),
                            ],
                        })),
                    ],
                }),
                new Paragraph({
                    alignment: AlignmentType.RIGHT,
                    children: [
                        new TextRun({
                            text: "\nNgày lập: 17 tháng 03 năm 2026",
                            size: 22,
                            font: "Times New Roman",
                        }),
                    ],
                    spacing: { before: 400 },
                }),
            ],
        }],
    });

    const buffer = await Packer.toBuffer(doc);
    fs.writeFileSync("Bang_Mo_Ta_Cong_Viec_Chi_Tiet.docx", buffer);
    console.log("File created successfully.");
}

main();
