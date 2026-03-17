/**
 * EzTravel i18n - Internationalization Module
 * Supports: vi, en, ko, ja, zh
 */
const I18N = {
    currentLang: 'vi',
    langs: {
        vi: { flag: '🇻🇳', name: 'Tiếng Việt', short: 'VN', currency: 'VND' },
        en: { flag: '🇬🇧', name: 'English', short: 'EN', currency: 'USD' },
        ko: { flag: '🇰🇷', name: '한국어', short: 'KR', currency: 'KRW' },
        ja: { flag: '🇯🇵', name: '日本語', short: 'JP', currency: 'JPY' },
        zh: { flag: '🇨🇳', name: '中文', short: 'CN', currency: 'CNY' }
    },
    translations: {
        // ═══ NAV ═══
        'nav.home':         { vi:'Trang Chủ', en:'Home', ko:'홈', ja:'ホーム', zh:'首页' },
        'nav.explore':      { vi:'Khám Phá', en:'Explore', ko:'탐색', ja:'探索', zh:'探索' },
        'nav.orders':       { vi:'Đơn Hàng', en:'Orders', ko:'주문', ja:'注文', zh:'订单' },
        'nav.history':      { vi:'Lịch Sử', en:'History', ko:'기록', ja:'履歴', zh:'历史' },
        'nav.provider':     { vi:'Nhà Cung Cấp', en:'Providers', ko:'공급업체', ja:'プロバイダー', zh:'供应商' },
        'nav.login':        { vi:'Đăng Nhập', en:'Login', ko:'로그인', ja:'ログイン', zh:'登录' },
        'nav.register':     { vi:'Đăng Ký', en:'Sign Up', ko:'회원가입', ja:'登録', zh:'注册' },
        'nav.logout':       { vi:'Đăng xuất', en:'Logout', ko:'로그아웃', ja:'ログアウト', zh:'退出' },

        // ═══ TOP BAR ═══
        'topbar.phone':     { vi:'0335 111 783', en:'0335 111 783', ko:'0335 111 783', ja:'0335 111 783', zh:'0335 111 783' },
        'topbar.hours':     { vi:'Từ 8:00 - 23:00 hàng ngày', en:'Daily 8:00 AM - 11:00 PM', ko:'매일 8:00 - 23:00', ja:'毎日 8:00〜23:00', zh:'每天 8:00 - 23:00' },
        'search.placeholder': { vi:'Tìm kiếm tour...', en:'Search tours...', ko:'투어 검색...', ja:'ツアー検索...', zh:'搜索旅游...' },

        // ═══ INFO SLIDER ═══
        'info.addr.label':    { vi:'Đại học FPT Đà Nẵng', en:'FPT University Da Nang' },
        'info.addr.value':    { vi:'Khu đô thị FPT City, Ngũ Hành Sơn', en:'FPT City, Ngu Hanh Son District' },
        'info.hours.label':   { vi:'8:00AM - 10:00PM', en:'8:00AM - 10:00PM' },
        'info.hours.value':   { vi:'Thứ Hai đến Chủ Nhật', en:'Monday to Sunday' },
        'info.email.label':   { vi:'Online 24/7', en:'Online 24/7' },
        'info.phone.label':   { vi:'Hotline: 0335 111 783', en:'Hotline: 0335 111 783' },
        'info.phone.value':   { vi:'Miễn phí cuộc gọi tư vấn', en:'Free consultation call' },
        'info.web.label':     { vi:'www.eztravel.site', en:'www.eztravel.site' },
        'info.web.value':     { vi:'Website chính thức', en:'Official website' },
        'info.promo.label':   { vi:'Giảm 20% Tour Hè 2026', en:'20% Off Summer Tours 2026' },
        'info.promo.value':   { vi:'Áp dụng đến 30/06/2026', en:'Valid until 30/06/2026' },
        'info.refund.label':  { vi:'Cam kết hoàn tiền 100%', en:'100% Money Back Guarantee' },
        'info.refund.value':  { vi:'Nếu không hài lòng dịch vụ', en:'If not satisfied with service' },
        'info.cust.label':    { vi:'10,000+ Khách hàng', en:'10,000+ Customers' },
        'info.cust.value':    { vi:'Đánh giá 4.9/5 sao', en:'Rated 4.9/5 stars' },
        'info.tours.label':   { vi:'500+ Tour Đà Nẵng', en:'500+ Da Nang Tours' },
        'info.tours.value':   { vi:'Bà Nà, Hội An, Sơn Trà...', en:'Ba Na, Hoi An, Son Tra...' },

        // ═══ HERO ═══
        'hero.badge':       { vi:'Hơn 5,000+ du khách tin tưởng', en:'Trusted by 5,000+ travelers', ko:'5,000명 이상의 여행자가 신뢰', ja:'5,000人以上の旅行者に信頼', zh:'超过5,000名旅客信赖' },
        'hero.title':       { vi:'EZTRAVEL - TRẢI NGHIỆM DU LỊCH DỄ DÀNG', en:'EZTRAVEL - TRAVEL MADE EASY', ko:'EZTRAVEL - 쉬운 여행 경험', ja:'EZTRAVEL - 簡単な旅行体験', zh:'EZTRAVEL - 轻松旅行体验' },
        'hero.desc':        { vi:'Khám phá những điểm đến tuyệt vời, trải nghiệm độc đáo và lên kế hoạch cho chuyến đi hoàn hảo của bạn!', en:'Discover amazing destinations, unique experiences and plan your perfect trip!', ko:'멋진 여행지를 발견하고, 독특한 경험과 완벽한 여행을 계획하세요!', ja:'素晴らしい目的地を発見し、ユニークな体験と完璧な旅を計画しましょう！', zh:'发现精彩目的地，独特体验，规划您的完美旅程！' },

        // ═══ SEARCH ═══
        'search.tab.all':       { vi:'Tour Trọn Gói', en:'All Tours', ko:'전체 투어', ja:'全ツアー', zh:'全部旅游' },
        'search.tab.beach':     { vi:'Biển & Đảo', en:'Beach & Island', ko:'해변 & 섬', ja:'ビーチ＆島', zh:'海滩 & 岛屿' },
        'search.tab.mountain':  { vi:'Núi & Trekking', en:'Mountain & Trek', ko:'산 & 트레킹', ja:'山＆トレッキング', zh:'山 & 徒步' },
        'search.tab.food':      { vi:'Ẩm Thực', en:'Cuisine', ko:'음식', ja:'グルメ', zh:'美食' },
        'search.tab.culture':   { vi:'Văn Hóa', en:'Culture', ko:'문화', ja:'文化', zh:'文化' },
        'search.tab.combo':     { vi:'Combo', en:'Combo', ko:'콤보', ja:'コンボ', zh:'组合' },
        'search.where':         { vi:'Bạn muốn đi đâu?', en:'Where do you want to go?', ko:'어디로 가고 싶으세요?', ja:'どこに行きたいですか？', zh:'您想去哪里？' },
        'search.where.ph':      { vi:'ví dụ: Bà Nà, Hội An, Sơn Trà, Mỹ Khê...', en:'e.g: Ba Na, Hoi An, Son Tra, My Khe...', ko:'예: 바나, 호이안, 선짜, 미케...', ja:'例：バナ、ホイアン、ソンチャ、ミーケー...', zh:'例：巴拿山、会安、山茶、美溪...' },
        'search.date':          { vi:'Ngày đi', en:'Departure', ko:'출발일', ja:'出発日', zh:'出发日' },
        'search.budget':        { vi:'Ngân sách', en:'Budget', ko:'예산', ja:'予算', zh:'预算' },
        'search.budget.select': { vi:'Chọn mức giá', en:'Select price', ko:'가격 선택', ja:'価格を選択', zh:'选择价格' },
        'search.budget.1':      { vi:'Dưới 500k', en:'Under $25', ko:'₩30,000 이하', ja:'¥3,000以下', zh:'¥150以下' },
        'search.budget.2':      { vi:'500k - 1 triệu', en:'$25 - $50', ko:'₩30,000 - ₩60,000', ja:'¥3,000 - ¥6,000', zh:'¥150 - ¥300' },
        'search.budget.3':      { vi:'1 - 3 triệu', en:'$50 - $150', ko:'₩60,000 - ₩180,000', ja:'¥6,000 - ¥18,000', zh:'¥300 - ¥900' },
        'search.budget.4':      { vi:'Trên 3 triệu', en:'Over $150', ko:'₩180,000 이상', ja:'¥18,000以上', zh:'¥900以上' },
        'search.btn':           { vi:'Tìm kiếm', en:'Search', ko:'검색', ja:'検索', zh:'搜索' },

        // ═══ SECTIONS ═══
        'section.cat.badge':    { vi:'DANH MỤC DU LỊCH', en:'TRAVEL CATEGORIES', ko:'여행 카테고리', ja:'旅行カテゴリー', zh:'旅游分类' },
        'section.cat.title':    { vi:'Khám Phá Theo Thể Loại', en:'Explore By Category', ko:'카테고리별 탐색', ja:'カテゴリーで探索', zh:'按类别探索' },
        'cat.beach':            { vi:'Biển & Đảo', en:'Beach & Island', ko:'해변 & 섬', ja:'ビーチ＆島', zh:'海滩 & 岛屿' },
        'cat.mountain':         { vi:'Núi & Trekking', en:'Mountain & Trek', ko:'산 & 트레킹', ja:'山＆トレッキング', zh:'山 & 徒步' },
        'cat.food':             { vi:'Ẩm Thực', en:'Cuisine', ko:'음식', ja:'グルメ', zh:'美食' },
        'cat.culture':          { vi:'Văn Hóa', en:'Culture', ko:'문화', ja:'文化', zh:'文化' },

        // ═══ DEST ═══
        'section.dest.badge':   { vi:'ĐIỂM ĐẾN NỔI BẬT', en:'TOP DESTINATIONS', ko:'인기 여행지', ja:'人気スポット', zh:'热门目的地' },
        'section.dest.title':   { vi:'Đà Nẵng & Lân Cận', en:'Da Nang & Nearby', ko:'다낭 & 근처', ja:'ダナン＆近郊', zh:'岘港 & 周边' },
        'dest.view':            { vi:'tour', en:'tours', ko:'투어', ja:'ツアー', zh:'旅游线路' },

        // ═══ STATS ═══
        'stat.tours':           { vi:'Tours Hoạt Động', en:'Active Tours', ko:'진행 중인 투어', ja:'アクティブツアー', zh:'活跃旅游' },
        'stat.customers':       { vi:'Khách Hàng', en:'Customers', ko:'고객', ja:'お客様', zh:'客户' },
        'stat.rating':          { vi:'Đánh Giá', en:'Rating', ko:'평점', ja:'評価', zh:'评分' },
        'stat.destinations':    { vi:'Điểm Đến', en:'Destinations', ko:'여행지', ja:'目的地', zh:'目的地' },

        // ═══ TOURS ═══
        'section.tour.badge':   { vi:'ĐANG THỊNH HÀNH', en:'TRENDING', ko:'인기', ja:'トレンド', zh:'热门' },
        'section.tour.title':   { vi:'Tours Được Yêu Thích', en:'Most Loved Tours', ko:'인기 투어', ja:'人気ツアー', zh:'最受欢迎' },
        'section.tour.sub':     { vi:'Được chọn lọc bởi chuyên gia du lịch Đà Nẵng.', en:'Curated by Da Nang travel experts.', ko:'다낭 여행 전문가가 엄선했습니다.', ja:'ダナン旅行の専門家が厳選。', zh:'由岘港旅游专家精选。' },
        'tour.viewall':         { vi:'Xem tất cả', en:'View all', ko:'전체 보기', ja:'すべて見る', zh:'查看全部' },
        'tour.from':            { vi:'Từ', en:'From', ko:'부터', ja:'から', zh:'起' },
        'tour.person':          { vi:'/người', en:'/person', ko:'/인', ja:'/人', zh:'/人' },
        'tour.book':            { vi:'Đặt Ngay', en:'Book Now', ko:'지금 예약', ja:'今すぐ予約', zh:'立即预订' },
        'tour.location':        { vi:'Đà Nẵng, Việt Nam', en:'Da Nang, Vietnam', ko:'다낭, 베트남', ja:'ダナン、ベトナム', zh:'岘港，越南' },
        'tour.empty.title':     { vi:'Sắp Ra Mắt Tours Mới!', en:'New Tours Coming Soon!', ko:'새로운 투어 곧 출시!', ja:'新ツアーまもなく！', zh:'新旅游即将推出！' },
        'tour.empty.desc':      { vi:'Các tour đang được thêm vào hệ thống. Hãy quay lại sau nhé.', en:'Tours are being added. Please check back later.', ko:'투어가 추가되고 있습니다. 나중에 다시 확인해 주세요.', ja:'ツアーを追加中です。後ほどご確認ください。', zh:'旅游线路正在添加中，请稍后再来。' },
        'tour.empty.btn':       { vi:'Khám Phá', en:'Explore', ko:'탐색', ja:'探索', zh:'探索' },

        // ═══ CTA ═══
        'cta.badge':            { vi:'HƠN 5,000 KHÁCH ĐÃ TIN TƯỞNG', en:'TRUSTED BY 5,000+ TRAVELERS', ko:'5,000명 이상의 여행자가 신뢰', ja:'5,000人以上に信頼', zh:'超过5,000名旅客信赖' },
        'cta.title1':           { vi:'Trải Nghiệm', en:'Experience', ko:'경험하세요', ja:'体験する', zh:'体验' },
        'cta.title2':           { vi:'Đà Nẵng', en:'Da Nang', ko:'다낭', ja:'ダナン', zh:'岘港' },
        'cta.title3':           { vi:'Hoàn Hảo', en:'Perfectly', ko:'완벽하게', ja:'完璧に', zh:'完美' },
        'cta.desc':             { vi:'Đăng ký ngay để nhận ưu đãi độc quyền Bà Nà Hills, truy cập sớm tour lễ hội và công cụ AI dự báo doanh thu thông minh.', en:'Sign up now for exclusive Ba Na Hills offers, early access to festival tours and smart AI revenue forecasting tools.', ko:'바나힐 독점 혜택, 축제 투어 사전 접근 및 스마트 AI 수익 예측 도구를 받으세요.', ja:'バナヒルズの限定オファー、フェスティバルツアーへの早期アクセス、スマートAI収益予測ツールを入手。', zh:'立即注册获取巴拿山独家优惠、节日旅游早期访问和智能AI收入预测工具。' },
        'cta.email.ph':         { vi:'Nhập email để nhận ưu đãi...', en:'Enter email for offers...', ko:'이메일을 입력하세요...', ja:'メールアドレスを入力...', zh:'输入邮箱获取优惠...' },
        'cta.signup':           { vi:'Đăng Ký', en:'Sign Up', ko:'가입', ja:'登録', zh:'注册' },
        'cta.trust.1':          { vi:'Miễn phí 100%', en:'100% Free', ko:'100% 무료', ja:'100%無料', zh:'100%免费' },
        'cta.trust.2':          { vi:'Không spam', en:'No spam', ko:'스팸 없음', ja:'スパムなし', zh:'无垃圾邮件' },
        'cta.trust.3':          { vi:'Hủy bất cứ lúc nào', en:'Cancel anytime', ko:'언제든 취소', ja:'いつでもキャンセル', zh:'随时取消' },
        'cta.feat1.title':      { vi:'Đối Tác Uy Tín', en:'Trusted Partners', ko:'신뢰할 수 있는 파트너', ja:'信頼のパートナー', zh:'值得信赖的合作伙伴' },
        'cta.feat1.desc':       { vi:'100% tour được xác minh bởi đội ngũ chuyên gia địa phương Đà Nẵng', en:'100% tours verified by local Da Nang expert team', ko:'100% 현지 다낭 전문가 팀이 검증한 투어', ja:'100%ダナンの地元専門家チームが検証', zh:'100%由岘港当地专家团队验证' },
        'cta.feat2.title':      { vi:'AI Thông Minh', en:'Smart AI', ko:'스마트 AI', ja:'スマートAI', zh:'智能AI' },
        'cta.feat2.desc':       { vi:'Chatbot AI hỗ trợ 24/7, dự báo giá tour & gợi ý cá nhân hóa', en:'AI chatbot 24/7, tour price forecast & personalized suggestions', ko:'AI 챗봇 24/7, 투어 가격 예측 및 맞춤 추천', ja:'AIチャットボット24/7、ツアー価格予測＆パーソナライズ提案', zh:'AI聊天机器人24/7，旅游价格预测和个性化建议' },
        'cta.feat3.title':      { vi:'Đặt Tức Thì', en:'Instant Booking', ko:'즉시 예약', ja:'即時予約', zh:'即时预订' },
        'cta.feat3.desc':       { vi:'Xác nhận realtime qua hệ thống — không cần chờ đợi phản hồi', en:'Realtime confirmation — no waiting for response', ko:'실시간 확인 — 응답을 기다릴 필요 없음', ja:'リアルタイム確認 — 返答を待つ必要なし', zh:'实时确认 — 无需等待回复' },
        'cta.feat4.title':      { vi:'QR SePay', en:'QR SePay', ko:'QR SePay', ja:'QR SePay', zh:'QR SePay' },
        'cta.feat4.desc':       { vi:'Thanh toán quét QR siêu nhanh, hỗ trợ VISA, MoMo, VNPay', en:'Ultra-fast QR payment, supports VISA, MoMo, VNPay', ko:'초고속 QR 결제, VISA, MoMo, VNPay 지원', ja:'超高速QR決済、VISA、MoMo、VNPay対応', zh:'超快QR支付，支持VISA、MoMo、VNPay' },

        // ═══ FOOTER ═══
        'footer.dest':          { vi:'Điểm Đến Đà Nẵng', en:'Da Nang Destinations', ko:'다낭 여행지', ja:'ダナン目的地', zh:'岘港目的地' },
        'footer.tours':         { vi:'Dòng Tour', en:'Tour Types', ko:'투어 유형', ja:'ツアータイプ', zh:'旅游类型' },
        'footer.booking':       { vi:'Tra Cứu Booking', en:'Booking Search', ko:'예약 검색', ja:'予約検索', zh:'预订查询' },
        'footer.info':          { vi:'Thông Tin', en:'Information', ko:'정보', ja:'情報', zh:'信息' },
        'footer.account':       { vi:'Tài Khoản', en:'Account', ko:'계정', ja:'アカウント', zh:'账户' },
        'footer.payment':       { vi:'Chấp Nhận Thanh Toán', en:'Payment Methods', ko:'결제 수단', ja:'お支払い方法', zh:'付款方式' },
        'footer.cert':          { vi:'Chứng Nhận', en:'Certifications', ko:'인증', ja:'認証', zh:'认证' },
        'footer.copyright':     { vi:'© 2026 eztravel — PRJ301 FPT University', en:'© 2026 eztravel — PRJ301 FPT University', ko:'© 2026 eztravel — PRJ301 FPT University', ja:'© 2026 eztravel — PRJ301 FPT University', zh:'© 2026 eztravel — PRJ301 FPT University' },
        'footer.made':          { vi:'Made with ❤️ in Đà Nẵng', en:'Made with ❤️ in Da Nang', ko:'다낭에서 ❤️로 제작', ja:'ダナンで❤️を込めて制作', zh:'在岘港用 ❤️ 制作' },

        // ═══ CONTACT FORM ═══
        'contact.title':        { vi:'Bạn cần tư vấn tour?', en:'Need tour consultation?' },
        'contact.subtitle':     { vi:'Tiếp cận với dịch vụ du lịch đáng tin cậy nhất Đà Nẵng..', en:'Connect with the most trusted travel service in Da Nang..' },
        'contact.name.label':   { vi:'Tên người gửi', en:'Your name' },
        'contact.name.ph':      { vi:'Họ và tên *', en:'Full name *' },
        'contact.email.label':  { vi:'Địa chỉ email', en:'Email address' },
        'contact.service.label':{ vi:'Loại tour yêu cầu', en:'Tour type requested' },
        'contact.opt.beach':    { vi:'Tour Biển & Đảo', en:'Beach & Island Tour' },
        'contact.opt.mountain': { vi:'Tour Núi & Trekking', en:'Mountain & Trekking Tour' },
        'contact.opt.culture':  { vi:'Tour Văn Hóa & Lịch Sử', en:'Culture & History Tour' },
        'contact.opt.food':     { vi:'Tour Ẩm Thực', en:'Cuisine Tour' },
        'contact.opt.combo':    { vi:'Combo Trọn Gói', en:'All-Inclusive Combo' },
        'contact.opt.custom':   { vi:'Yêu cầu riêng', en:'Custom Request' },
        'contact.desc.label':   { vi:'Mô Tả', en:'Description' },
        'contact.desc.ph':      { vi:'Hãy mô tả những gì bạn cần.', en:'Describe what you need.' },
        'contact.submit':       { vi:'Gửi', en:'Submit' },
        'contact.reach':        { vi:'TIẾP CẬN NGAY', en:'REACH OUT NOW' },
        'contact.reach.desc':   { vi:'Bắt đầu hợp tác với chúng tôi trong khi tìm ra giải pháp tốt nhất dựa trên nhu cầu của bạn.', en:'Start working with us to find the best solution based on your needs.' },
        'contact.map':          { vi:'Xem trên bản đồ Google', en:'View on Google Maps' },

        // ═══ MISSION ═══
        'mission.title':        { vi:'Sứ Mệnh & Tầm Nhìn', en:'Mission & Vision' },
        'mission.desc':         { vi:'Tập trung tối ưu trải nghiệm du lịch cho thế hệ 2k10 đến 2k, eztravel xây dựng hệ sinh thái du lịch toàn diện từ đặt tour, khám phá điểm đến đến thanh toán thông minh. Mục tiêu của chúng tôi là trở thành trợ lý AI đồng hành cùng mọi chuyến đi.', en:'Focused on optimizing travel for generations 2k10 to 2k, eztravel builds a comprehensive tourism ecosystem from booking tours, discovering destinations to smart payments. Our goal is to become an AI assistant for every journey.' },
        'mission.eff':          { vi:'Hiệu quả', en:'Efficiency' },
        'mission.eff.desc':     { vi:'Đặt tour nhanh chóng, thanh toán an toàn, xác nhận tức thì với công nghệ hiện đại.', en:'Quick booking, secure payment, instant confirmation with modern technology.' },
        'mission.core':         { vi:'Bản chất', en:'Authenticity' },
        'mission.core.desc':    { vi:'Mang đến trải nghiệm du lịch chân thực, kết nối văn hóa địa phương Đà Nẵng.', en:'Delivering authentic travel experiences, connecting with local Da Nang culture.' },
    },

    t: function(key) {
        var entry = this.translations[key];
        if (!entry) return key;
        return entry[this.currentLang] || entry['vi'] || key;
    },

    init: function() {
        var saved = localStorage.getItem('eztravel_lang');
        if (saved && this.langs[saved]) {
            this.currentLang = saved;
        }
        this.applyTranslations();
        this.renderLangSelector();
    },

    setLang: function(lang) {
        if (!this.langs[lang]) return;
        this.currentLang = lang;
        localStorage.setItem('eztravel_lang', lang);
        this.applyTranslations();
        this.renderLangSelector();
        // Close dropdown
        document.querySelectorAll('.lang-dropdown').forEach(function(d) { d.style.display = 'none'; });
    },

    applyTranslations: function() {
        var self = this;
        document.querySelectorAll('[data-i18n]').forEach(function(el) {
            var key = el.getAttribute('data-i18n');
            var text = self.t(key);
            if (el.tagName === 'INPUT' && el.type !== 'hidden') {
                el.placeholder = text;
            } else if (el.tagName === 'OPTION') {
                el.textContent = text;
            } else {
                // Preserve child elements (icons etc)
                var icons = el.querySelectorAll('i, span.dot, svg');
                if (icons.length > 0 && el.children.length > 0) {
                    // Find text nodes and replace
                    var nodes = el.childNodes;
                    var replaced = false;
                    for (var i = 0; i < nodes.length; i++) {
                        if (nodes[i].nodeType === 3 && nodes[i].textContent.trim()) {
                            nodes[i].textContent = ' ' + text + ' ';
                            replaced = true;
                            break;
                        }
                    }
                    if (!replaced) {
                        // Append text after last icon
                        el.appendChild(document.createTextNode(' ' + text));
                    }
                } else {
                    el.textContent = text;
                }
            }
        });
        // Update html lang
        document.documentElement.lang = this.currentLang;
    },

    renderLangSelector: function() {
        var self = this;
        // Update flag buttons active state
        document.querySelectorAll('.lang-flag-btn').forEach(function(btn) {
            var title = btn.getAttribute('title');
            var isVi = title && title.indexOf('Vi') !== -1;
            var isEn = title && title === 'English';
            if ((isVi && self.currentLang === 'vi') || (isEn && self.currentLang === 'en')) {
                btn.classList.add('active');
            } else {
                btn.classList.remove('active');
            }
        });
        // Also update any old lang-selector containers (backward compat)
        document.querySelectorAll('.lang-selector').forEach(function(container) {
            var current = self.langs[self.currentLang];
            if (!current) return;
            container.innerHTML = 
                '<div class="lang-current" onclick="this.nextElementSibling.style.display=this.nextElementSibling.style.display===\'block\'?\'none\':\'block\'">' +
                    current.flag + ' <span>' + current.short + '</span> <i class="fas fa-chevron-down" style="font-size:.5rem;opacity:.6"></i>' +
                '</div>' +
                '<div class="lang-dropdown">' +
                    ['vi','en'].map(function(code) {
                        var l = self.langs[code];
                        var active = code === self.currentLang ? ' lang-active' : '';
                        return '<div class="lang-option' + active + '" onclick="I18N.setLang(\'' + code + '\')">' +
                            l.flag + ' ' + l.name + 
                            (code === self.currentLang ? ' <i class="fas fa-check" style="margin-left:auto;font-size:.6rem;color:#2563EB"></i>' : '') +
                        '</div>';
                    }).join('') +
                '</div>';
        });
    }
};

// Close dropdown on outside click
document.addEventListener('click', function(e) {
    if (!e.target.closest('.lang-selector')) {
        document.querySelectorAll('.lang-dropdown').forEach(function(d) { d.style.display = 'none'; });
    }
});

// Init on DOM ready
document.addEventListener('DOMContentLoaded', function() { I18N.init(); });
