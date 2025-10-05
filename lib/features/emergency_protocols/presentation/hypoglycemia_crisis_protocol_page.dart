import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_theme.dart';

class HypoglycemiaCrisisProtocolPage extends StatefulWidget {
  const HypoglycemiaCrisisProtocolPage({super.key});

  @override
  State<HypoglycemiaCrisisProtocolPage> createState() => _HypoglycemiaCrisisProtocolPageState();
}

class _HypoglycemiaCrisisProtocolPageState extends State<HypoglycemiaCrisisProtocolPage> {
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _loadBookmarkStatus();
  }

  Future<void> _loadBookmarkStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isBookmarked = prefs.getBool('bookmark_hypoglycemia_crisis') ?? false;
    });
  }

  Future<void> _toggleBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    await prefs.setBool('bookmark_hypoglycemia_crisis', _isBookmarked);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isBookmarked ? 'Đã thêm vào bookmark' : 'Đã xóa khỏi bookmark'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildProtocolCard({
    required String title,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildKeyPoint(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: const Border(
          left: BorderSide(
            width: 4,
            color: Colors.blue,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscussionPoint(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.orange.shade700, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.orange.shade800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClinicalCase(String title, String scenario, String management, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tình huống: $scenario',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            'Xử lý: $management',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyApproachAlgorithm() {
    return _buildProtocolCard(
      title: 'SƠ ĐỒ TIẾP CẬN XỬ TRÍ CẤP CỨU CƠN HẠ ĐƯỜNG HUYẾT',
      icon: Icons.medical_services,
      color: Colors.red,
      child: Column(
        children: [
          // Bước 1: Đánh giá ban đầu
          _buildAlgorithmStep(
            stepNumber: '1',
            title: 'ĐÁNH GIÁ BAN ĐẦU',
            content: '• ABC (Airway, Breathing, Circulation)\n'
                     '• Glucose máu ngay lập tức\n'
                     '• Đánh giá mức độ ý thức (GCS)\n'
                     '• Tiền sử thuốc hạ đường huyết',
            color: Colors.red,
            isFirst: true,
          ),
          _buildDecisionArrow(),
          
          // Bước 2: Phân loại mức độ
          _buildDecisionBranch(
            condition: 'Mức độ ý thức?',
            leftPath: _buildAlgorithmStep(
              stepNumber: '2A',
              title: 'BN TỈNH TÁO',
              content: '• Glucose máu 54-69mg/dL\n'
                       '• Tự xử lý được\n'
                       '• Có thể nuốt an toàn',
              color: Colors.orange,
            ),
            rightPath: _buildAlgorithmStep(
              stepNumber: '2B', 
              title: 'BN HÔN MÊ/LÚ LẪN',
              content: '• Glucose máu <54mg/dL\n'
                       '• GCS <13 hoặc co giật\n'
                       '• Không thể nuốt an toàn',
              color: Colors.red,
            ),
            leftLabel: 'Tỉnh táo',
            rightLabel: 'Hôn mê/Lú lẫn',
          ),
          _buildDecisionArrow(),
          
          // Bước 3: Điều trị cụ thể
          _buildDecisionBranch(
            condition: 'Phương pháp điều trị',
            leftPath: _buildAlgorithmStep(
              stepNumber: '3A',
              title: 'ĐIỀU TRỊ ĐƯỜNG UỐNG',
              content: '• Glucose 15-20g (3-4 viên kẹo)\n'
                       '• Nước ngọt 150-200ml\n'
                       '• Kiểm tra lại sau 15 phút\n'
                       '• Lặp lại nếu glucose <70mg/dL',
              color: Colors.green,
            ),
            rightPath: _buildAlgorithmStep(
              stepNumber: '3B',
              title: 'ĐIỀU TRỊ ĐƯỜNG TĨNH MẠCH',
              content: '• Glucose 50% 50ml IV ngay\n'
                       '• Hoặc Glucose 10% 250ml\n'
                       '• Glucagon 1mg IM nếu không có IV\n'
                       '• Theo dõi mỗi 15 phút',
              color: Colors.red,
            ),
            leftLabel: 'Đường uống',
            rightLabel: 'Đường tĩnh mạch',
          ),
          _buildDecisionArrow(),
          
          // Bước 4: Theo dõi và phòng ngừa
          _buildAlgorithmStep(
            stepNumber: '4',
            title: 'THEO DÕI & PHÒNG NGỪA',
            content: '• Duy trì glucose 100-180mg/dL\n'
                     '• Cho ăn khi ý thức tỉnh\n'
                     '• Điều chỉnh thuốc hạ đường huyết\n'
                     '• Giáo dục bệnh nhân',
            color: Colors.blue,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAlgorithmStep({
    required String stepNumber,
    required String title,
    required String content,
    required Color color,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: isFirst || isLast ? 8 : 4,
        horizontal: 8,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  stepNumber,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecisionBranch({
    required String condition,
    required Widget leftPath,
    required Widget rightPath,
    required String leftLabel,
    required String rightLabel,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.amber.shade100,
            border: Border.all(color: Colors.amber, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            condition,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      leftLabel,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  leftPath,
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      rightLabel,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.red.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  rightPath,
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDecisionArrow() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Icon(
        Icons.keyboard_arrow_down,
        size: 30,
        color: Colors.grey[600],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Cơn Hạ Đường Huyết'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: _isBookmarked ? Colors.yellow[700] : Colors.white,
            ),
            onPressed: _toggleBookmark,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emergency Approach Algorithm
            _buildEmergencyApproachAlgorithm(),

            // Definition & Classification
            _buildProtocolCard(
              title: '1. ĐỊNH NGHĨA & PHÂN LOẠI',
              icon: Icons.info,
              color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildKeyPoint(
                    'Định nghĩa cơn hạ đường huyết (ADA 2024)',
                    'Glucose máu <70mg/dL (3.9mmol/L) = Ngưỡng cảnh báo\n'
                    'Glucose máu <54mg/dL (3.0mmol/L) = Có ý nghĩa lâm sàng\n'
                    'Hạ đường huyết nặng = <54mg/dL + hôn mê/co giật',
                  ),
                  _buildKeyPoint(
                    'Phân loại theo mức độ (ADA 2024)',
                    'Mức 1 (54-69mg/dL): Alert value\n'
                    '• Có triệu chứng nhẹ (đổ mồ hôi, run, đói)\n'
                    '• Bệnh nhân tự xử lý được\n'
                    '• Glucose đường uống 15-20g\n\n'
                    'Mức 2 (<54mg/dL): Clinically important\n'
                    '• Triệu chứng rõ rệt (lú lẫn, yếu liệt)\n'
                    '• Cần hỗ trợ từ người khác\n'
                    '• IV glucose nếu không uống được\n\n'
                    'Mức 3 (<54mg/dL + hôn mê): Severe hypoglycemia\n'
                    '• Hôn mê, co giật, không tỉnh táo\n'
                    '• Cần cấp cứu ngay lập tức\n'
                    '• IV glucose 50% hoặc Glucagon IM',
                  ),
                  _buildKeyPoint(
                    'Phân loại theo nguyên nhân (WHO 2023)',
                    '🔴 DO THUỐC (Drug-induced):\n'
                    '• Insulin: Quá liều, sai thời điểm tiêm\n'
                    '• Sulfonylurea: Glibenclamide, Gliclazide\n'
                    '• Meglitinide: Repaglinide, Nateglinide\n'
                    '• Thuốc khác: Quinoline, Salicylate, Ethanol\n\n'
                    '🟠 BỆNH LÝ NỘI KHOA (Medical causes):\n'
                    '• Suy thận mạn: Giảm gluconeogenesis\n'
                    '• Suy gan: Giảm dự trữ glycogen\n'
                    '• Suy tuyến thượng thận: Thiếu cortisol\n'
                    '• Suy tuyến yên: Thiếu GH, ACTH\n'
                    '• Sepsis: Tăng tiêu thụ glucose\n\n'
                    '🟡 U TIẾT INSULIN (Tumor-related):\n'
                    '• Insulinoma: U tế bào beta\n'
                    '• U không phải tế bào đảo: IGF-2\n'
                    '• Hội chứng tự miễn: Kháng thể insulin\n\n'
                    '🟢 NGUYÊN NHÂN KHÁC (Other causes):\n'
                    '• Nhịn ăn kéo dài: >72h\n'
                    '• Gắng sức quá mức: Marathon, thể thao\n'
                    '• Thai kỳ: Tăng cầu glucose của thai nhi\n'
                    '• Trẻ em: Ketotic hypoglycemia',
                  ),
                ],
              ),
            ),

            // Clinical Manifestations
            _buildProtocolCard(
              title: '2. BIỂU HIỆN LÂM SÀNG',
              icon: Icons.medical_services,
              color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildKeyPoint(
                    'Triệu chứng adrenergic (sớm)',
                    '• Đổ mồ hôi, run, hồi hộp\n'
                    '• Đói, buồn nôn\n'
                    '• Mạch nhanh, huyết áp tăng nhẹ\n'
                    '• Lo lắng, bồn chồn',
                  ),
                  _buildKeyPoint(
                    'Triệu chứng neuroglycopenic (muộn)',
                    '• Đau đầu, chóng mặt\n'
                    '• Lú lẫn, thay đổi hành vi\n'
                    '• Khó tập trung, nói lắp\n'
                    '• Yếu liệt, rối loạn thị giác',
                  ),
                  _buildKeyPoint(
                    'Triệu chứng nặng',
                    '• Co giật toàn thân\n'
                    '• Hôn mê sâu (GCS <8)\n'
                    '• Tổn thương não không hồi phục\n'
                    '• Ngừng tuần hoàn nếu kéo dài',
                  ),
                ],
              ),
            ),

            // Diagnosis & Investigation
            _buildProtocolCard(
              title: '3. CHẨN ĐOÁN & XÉT NGHIỆM',
              icon: Icons.biotech,
              color: Colors.purple,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildKeyPoint(
                    'Tam chứng Whipple',
                    '1. Triệu chứng lâm sàng phù hợp\n'
                    '2. Glucose máu thấp (<70mg/dL)\n'
                    '3. Cải thiện sau bổ sung glucose',
                  ),
                  _buildKeyPoint(
                    'Xét nghiệm tại chỗ',
                    '• Glucose máu mao mạch (fingerstick)\n'
                    '• Ketone niệu/máu (nếu có)\n'
                    '• Ý thức (GCS)\n'
                    '• Dấu hiệu thần kinh định vị',
                  ),
                  _buildKeyPoint(
                    'Xét nghiệm bổ sung',
                    '• Glucose tĩnh mạch xác nhận\n'
                    '• Điện giải, chức năng thận gan\n'
                    '• C-peptide, insulin (nếu nghi ngờ)\n'
                    '• Cortisol, hormone tăng trưởng',
                  ),
                  _buildKeyPoint(
                    'Chẩn đoán phân biệt nguyên nhân',
                    '🔍 TIỀN SỬ VÀ KHÁM:\n'
                    '• Thuốc đang dùng: Insulin, Sulfonylurea\n'
                    '• Thời gian xuất hiện: Sau ăn vs nhịn ăn\n'
                    '• Triệu chứng kèm theo: Sốt, đau bụng\n'
                    '• Tiền sử: Phẫu thuật dạ dày, bệnh gan\n\n'
                    '🧪 XÉT NGHIỆM PHÂN BIỆT:\n'
                    '• Insulin/C-peptide cao: Insulinoma\n'
                    '• Insulin cao, C-peptide thấp: Tiêm insulin ngoại sinh\n'
                    '• Kháng thể insulin: Hội chứng tự miễn\n'
                    '• Cortisol thấp: Suy thượng thận\n'
                    '• Chức năng gan/thận bất thường',
                  ),
                ],
              ),
            ),

            // Emergency Management
            _buildProtocolCard(
              title: '4. XỬ LÝ CẤP CỨU',
              icon: Icons.emergency,
              color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildKeyPoint(
                    'ABC + Glucose',
                    '• Đường thở: Kiểm tra, hút đờm nếu có\n'
                    '• Thở: Oxy nếu cần, thông khí nếu hôn mê\n'
                    '• Tuần hoàn: Đo huyết áp, mạch\n'
                    '• Glucose ngay lập tức',
                  ),
                  _buildKeyPoint(
                    'Điều trị glucose',
                    'Có ý thức:\n'
                    '• Glucose 15-20g đường/kẹo\n'
                    '• Kiểm tra lại sau 15 phút\n'
                    '• Lặp lại nếu chưa cải thiện\n\n'
                    'Hôn mê/không hợp tác:\n'
                    '• IV glucose 50% 50ml (25g)\n'
                    '• Hoặc glucose 10% 250ml nhanh\n'
                    '• Glucagon 1mg IM nếu không có IV',
                  ),
                  _buildKeyPoint(
                    'Theo dõi sau cấp cứu',
                    '• Glucose mỗi 15-30 phút\n'
                    '• Duy trì glucose 100-180mg/dL\n'
                    '• Cho ăn sau khi ý thức tỉnh\n'
                    '• Điều chỉnh thuốc hạ đường huyết',
                  ),
                ],
              ),
            ),

            // Medication Management
            _buildProtocolCard(
              title: '5. QUẢN LÝ THUỐC',
              icon: Icons.medication,
              color: Colors.green,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildKeyPoint(
                    'Insulin',
                    '• Giảm/ngừng insulin tác dụng nhanh\n'
                    '• Điều chỉnh insulin nền nếu cần\n'
                    '• Kiểm tra kỹ thuật tiêm\n'
                    '• Đảm bảo phối hợp với bữa ăn',
                  ),
                  _buildKeyPoint(
                    'Sulfonylurea',
                    '• Gliclazide: Tác dụng 12-24h\n'
                    '• Glibenclamide: Tác dụng 24h\n'
                    '• Cần theo dõi lâu hơn\n'
                    '• Có thể cần glucose liên tục',
                  ),
                  _buildKeyPoint(
                    'Thuốc khác',
                    '• Metformin: Hiếm gây hạ đường huyết\n'
                    '• DPP4-i, GLP1-RA: An toàn\n'
                    '• SGLT2-i: Nguy cơ ketoacidosis\n'
                    '• Kiểm tra tương tác thuốc',
                  ),
                ],
              ),
            ),

            // Prevention
            _buildProtocolCard(
              title: '6. PHÒNG NGỪA',
              icon: Icons.shield,
              color: Colors.orange,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildKeyPoint(
                    'Giáo dục bệnh nhân',
                    '• Nhận biết triệu chứng sớm\n'
                    '• Tự theo dõi đường huyết\n'
                    '• Cách xử lý cơn hạ đường huyết\n'
                    '• Khi nào cần đến viện',
                  ),
                  _buildKeyPoint(
                    'Quản lý sinh hoạt',
                    '• Ăn đúng giờ, đủ lượng\n'
                    '• Tập thể dục có kế hoạch\n'
                    '• Tránh uống rượu đói\n'
                    '• Điều chỉnh thuốc khi ốm',
                  ),
                  _buildKeyPoint(
                    'Sai lầm thường gặp',
                    '• Quá liều insulin, không ăn sau tiêm\n'
                    '• Uống sulfonylurea khi không ăn\n'
                    '• Tập thể dục quá mức\n'
                    '• Không theo dõi đường huyết',
                  ),
                ],
              ),
            ),

            // Clinical Discussions
            _buildProtocolCard(
              title: '7. BÀN LUẬN & TRANH LUẬN LÂM SÀNG (6 câu hỏi)',
              icon: Icons.forum,
              color: Colors.deepPurple,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Các câu hỏi tranh luận dựa trên tình huống lâm sàng thực tế:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDiscussionPoint(
                    'Tranh luận lâm sàng 1',
                    '❓ Tình huống: BN đái tháo đường type 1, 25 tuổi, hôn mê sâu với glucose 25mg/dL, không có đường truyền\n\n'
                    '🤔 Câu hỏi: Glucagon 1mg IM hay cố gắng đặt đường truyền trước?\n\n'
                    '💡 Trả lời:\n'
                    '• TIÊM GLUCAGON NGAY, đồng thời cố đặt IV\n'
                    '• Glucagon tác dụng sau 5-15 phút\n'
                    '• Không trì hoãn vì đặt IV khó\n'
                    '• Cơ chế: Kích thích giải phóng glucose từ gan\n'
                    '• Hiệu quả: Tăng glucose 50-100mg/dL\n\n'
                    '📋 Sau khi tiêm Glucagon:\n'
                    '• Đặt BN nghiêng để tránh hít\n'
                    '• Tiếp tục cố gắng đặt IV\n'
                    '• Glucose IV ngay khi có đường truyền\n'
                    '• Theo dõi đường huyết mỗi 15 phút\n'
                    '• Cho ăn khi tỉnh táo hoàn toàn',
                  ),
                  const SizedBox(height: 12),
                  _buildDiscussionPoint(
                    'Tranh luận lâm sàng 2',
                    '❓ Tình huống: Bà cụ 80 tuổi, uống Glibenclamide, hạ đường huyết lần thứ 3 trong tuần\n\n'
                    '🤔 Câu hỏi: Tại sao sulfonylurea ở người già nguy hiểm? Cách xử lý?\n\n'
                    '🧬 Tại sao Glibenclamide nguy hiểm ở người già?\n'
                    '• Thải trừ chậm qua thận (GFR giảm)\n'
                    '• Tác dụng kéo dài 24-36h\n'
                    '• Ăn uống không đều ở người già\n'
                    '• Tương tác với nhiều thuốc khác\n'
                    '• Nhận biết triệu chứng kém\n\n'
                    '🚨 Tại sao hạ đường huyết lặp lại?\n'
                    '• Thuốc còn tồn dư trong máu\n'
                    '• Không điều chỉnh liều sau lần đầu\n'
                    '• Chức năng thận giảm (không đánh giá)\n'
                    '• Chế độ ăn không phù hợp\n\n'
                    '📋 Xử lý:\n'
                    '1. Điều trị cơn cấp: Glucose IV\n'
                    '2. NGỪNG Glibenclamide hoàn toàn\n'
                    '3. Theo dõi glucose 48-72h\n'
                    '4. Chuyển sang Metformin hoặc DPP4-i\n'
                    '5. Giáo dục về chế độ ăn',
                  ),
                  const SizedBox(height: 12),
                  _buildDiscussionPoint(
                    'Tranh luận lâm sàng 3',
                    '❓ Tình huống: Bệnh nhân insulin, glucose 45mg/dL, vẫn tỉnh táo nhưng lú lẫn nhẹ\n\n'
                    '🤔 Câu hỏi: Glucose đường uống hay đường tĩnh mạch?\n\n'
                    '⚖️ So sánh glucose đường uống vs IV:\n\n'
                    '🍯 GLUCOSE ĐƯỜNG UỐNG:\n'
                    '• Ưu điểm:\n'
                    '  - Không cần đặt IV\n'
                    '  - An toàn hơn (khó quá liều)\n'
                    '  - Tăng glucose từ từ, ổn định\n'
                    '  - Kích thích tiết insulin sinh lý\n'
                    '• Nhược điểm:\n'
                    '  - Chậm hơn (15-30 phút)\n'
                    '  - Cần bệnh nhân hợp tác\n'
                    '  - Không dùng được nếu buồn nôn\n\n'
                    '💉 GLUCOSE IV:\n'
                    '• Ưu điểm:\n'
                    '  - Tác dụng nhanh (2-5 phút)\n'
                    '  - Không cần hợp tác\n'
                    '  - Kiểm soát liều chính xác\n'
                    '• Nhược điểm:\n'
                    '  - Cần đặt IV\n'
                    '  - Nguy cơ tăng glucose quá nhanh\n'
                    '  - Glucose có thể giảm lại nhanh\n\n'
                    '📋 Quyết định:\n'
                    '• BN tỉnh táo, không nôn → Glucose đường uống\n'
                    '• 15-20g glucose (3-4 viên kẹo)\n'
                    '• Kiểm tra lại sau 15 phút\n'
                    '• Sẵn sàng IV nếu không cải thiện',
                  ),
                  const SizedBox(height: 12),
                  _buildDiscussionPoint(
                    'Tranh luận lâm sàng 4',
                    '❓ Tình huống: Bệnh nhân sau phẫu thuật, ăn kém, glucose dao động 50-200mg/dL\n\n'
                    '🤔 Câu hỏi: Nguyên nhân và cách ổn định đường huyết?\n\n'
                    '🔍 Phân tích nguyên nhân glucose không ổn định:\n'
                    '1️⃣ YẾU TỐ STRESS PHẪU THUẬT:\n'
                    '• Cortisol tăng → kháng insulin\n'
                    '• Adrenaline → phân giải glycogen\n'
                    '• Cytokines viêm → rối loạn chuyển hóa\n'
                    '• Đau → kích thích sympathetic\n\n'
                    '2️⃣ YẾU TỐ DINH DƯỠNG:\n'
                    '• Ăn kém, không đều\n'
                    '• Buồn nôn sau mổ\n'
                    '• Tương tác thuốc giảm đau\n'
                    '• Rối loạn tiêu hóa\n\n'
                    '3️⃣ YẾU TỐ THUỐC:\n'
                    '• Corticoid liều cao\n'
                    '• Insulin liều cố định\n'
                    '• Không điều chỉnh theo ăn uống\n\n'
                    '📋 Chiến lược ổn định:\n'
                    '• Chuyển sang insulin sliding scale\n'
                    '• Theo dõi glucose 4-6h\n'
                    '• Đảm bảo dinh dưỡng ổn định\n'
                    '• Giảm dần corticoid khi có thể\n'
                    '• Điều trị đau hiệu quả',
                  ),
                  const SizedBox(height: 12),
                  _buildDiscussionPoint(
                    'Tranh luận lâm sàng 5',
                    '❓ Tại sao thuốc hạ đường huyết có nguy cơ gây hạ đường huyết khác nhau?\n\n'
                    '🤔 Câu hỏi: Metformin không gây hạ đường huyết, Sulfonylurea rất nguy hiểm, còn DPP4-i thì sao?\n\n'
                    '🧬 PHÂN TÍCH CƠ CHẾ TÁC DỤNG:\n\n'
                    '💊 METFORMIN - NGUY CƠ THẤP:\n'
                    '• Cơ chế: Giảm sản xuất glucose từ gan\n'
                    '• Không kích thích tiết insulin\n'
                    '• Chỉ hoạt động khi glucose cao\n'
                    '• Không gây hạ đường huyết đơn độc\n'
                    '• An toàn ngay cả khi nhịn ăn\n\n'
                    '💊 SULFONYLUREA - NGUY CƠ CAO:\n'
                    '• Cơ chế: Kích thích tế bào beta tiết insulin\n'
                    '• Hoạt động độc lập với glucose\n'
                    '• Tiết insulin ngay cả khi glucose thấp\n'
                    '• Tác dụng kéo dài 12-24h\n'
                    '• Glibenclamide nguy hiểm nhất\n'
                    '• Gliclazide, Glimepiride ít hơn\n\n'
                    '💊 INSULIN - NGUY CƠ RẤT CAO:\n'
                    '• Cơ chế: Trực tiếp hạ glucose\n'
                    '• Không có cơ chế tự điều chỉnh\n'
                    '• Tác dụng mạnh và nhanh\n'
                    '• Dễ quá liều nếu không ăn\n\n'
                    '💊 DPP4-INHIBITOR - NGUY CƠ THẤP:\n'
                    '• Cơ chế: Tăng GLP-1 nội sinh\n'
                    '• Chỉ kích thích insulin khi glucose cao\n'
                    '• Glucose-dependent insulin secretion\n'
                    '• Tự động "tắt" khi glucose bình thường\n'
                    '• Sitagliptin, Linagliptin, Vildagliptin\n\n'
                    '💊 GLP1-RECEPTOR AGONIST - NGUY CƠ THẤP:\n'
                    '• Cơ chế: Bắt chước hormone GLP-1\n'
                    '• Glucose-dependent insulin secretion\n'
                    '• Chậm trống dạ dày → giảm hấp thu glucose\n'
                    '• Liraglutide, Semaglutide\n\n'
                    '💊 SGLT2-INHIBITOR - NGUY CƠ THẤP:\n'
                    '• Cơ chế: Đào thải glucose qua nước tiểu\n'
                    '• Không ảnh hưởng insulin\n'
                    '• Insulin-independent mechanism\n'
                    '• Dapagliflozin, Empagliflozin\n'
                    '• Nguy cơ: Ketoacidosis, không phải hạ đường huyết\n\n'
                    '📊 XẾP HẠNG NGUY CƠ HẠ ĐƯỜNG HUYẾT:\n'
                    '🔴 NGUY CƠ CAO: Insulin, Sulfonylurea\n'
                    '🟡 NGUY CƠ TRUNG BÌNH: Meglitinide (Repaglinide)\n'
                    '🟢 NGUY CƠ THẤP: Metformin, DPP4-i, GLP1-RA, SGLT2-i\n\n'
                    '🔬 TẠI SAO CÓ SỰ KHÁC BIỆT?\n'
                    '• Glucose-dependent vs Independent action\n'
                    '• Có/không có cơ chế feedback\n'
                    '• Thời gian tác dụng\n'
                    '• Phụ thuộc chức năng tế bào beta\n\n'
                    '📋 Ý NGHĨA LÂM SÀNG:\n'
                    '• Người già: Ưu tiên DPP4-i, tránh Sulfonylurea\n'
                    '• Bệnh nhân hay quên ăn: Tránh Insulin, Sulfonylurea\n'
                    '• Suy thận: Tránh Metformin, cẩn thận Sulfonylurea\n'
                    '• Phối hợp thuốc: Insulin + Metformin an toàn hơn Insulin + Sulfonylurea',
                  ),
                  const SizedBox(height: 12),
                  _buildDiscussionPoint(
                    'Tranh luận lâm sàng 6',
                    '❓ Tình huống: Sau truyền glucose cấp cứu, đường huyết lên quá cao 350mg/dL, xử trí thế nào?\n\n'
                    '🤔 Câu hỏi: Có cần insulin ngay? Có nguy cơ biến chứng gì? Làm sao tránh "yo-yo glucose"?\n\n'
                    '⚠️ TÌNH HUỐNG THƯỜNG GẶP:\n'
                    '• BN hôn mê glucose 25mg/dL\n'
                    '• Truyền Glucose 50% 100ml (50g glucose)\n'
                    '• Sau 30 phút: Tỉnh táo, glucose 350mg/dL\n'
                    '• Bác sĩ trẻ hoảng sợ, muốn tiêm insulin ngay\n\n'
                    '🧠 PHÂN TÍCH SINH LÝ BỆNH:\n'
                    '1️⃣ TẠI SAO GLUCOSE TĂNG QUÁ CAO?\n'
                    '• Cơ chế counter-regulation bị kích thích\n'
                    '• Glucagon, cortisol, adrenaline tăng cao\n'
                    '• Insulin nội sinh vẫn bị ức chế\n'
                    '• Glucose ngoại sinh chưa được chuyển hóa\n'
                    '• Stress response sau hạ đường huyết nặng\n\n'
                    '2️⃣ CƠ CHẾ "SOMOGYI EFFECT":\n'
                    '• Hạ đường huyết → Kích thích hormone đối kháng\n'
                    '• Glucagon ++ → Phân giải glycogen gan\n'
                    '• Cortisol ++ → Gluconeogenesis tăng\n'
                    '• Adrenaline ++ → Giải phóng glucose\n'
                    '• Kết quả: Hyperglycemia phản ứng\n\n'
                    '📋 XỬ TRÍ ĐÚNG CÁCH:\n'
                    '🚫 KHÔNG NÊN LÀM:\n'
                    '• KHÔNG tiêm insulin ngay lập tức\n'
                    '• KHÔNG hoảng sợ vì glucose cao\n'
                    '• KHÔNG dùng insulin sliding scale aggressive\n'
                    '• KHÔNG bỏ qua nguyên nhân hạ đường huyết\n\n'
                    '✅ NÊN LÀM:\n'
                    '1. QUAN SÁT VÀ THEO DÕI:\n'
                    '   • Theo dõi glucose mỗi 1-2h\n'
                    '   • Đánh giá tình trạng tri giác\n'
                    '   • Kiểm tra ketone niệu/máu\n'
                    '   • Theo dõi dấu hiệu mất nước\n\n'
                    '2. ĐIỀU CHỈNH TỪ TỪ:\n'
                    '   • Chờ 2-4h trước khi can thiệp\n'
                    '   • Glucose thường tự giảm xuống\n'
                    '   • Nếu >400mg/dL sau 4h mới cân nhắc insulin\n'
                    '   • Bắt đầu insulin liều thấp 0.05-0.1 unit/kg/h\n\n'
                    '3. XỬ LÝ NGUYÊN NHÂN GỐC:\n'
                    '   • Ngừng/giảm thuốc gây hạ đường huyết\n'
                    '   • Điều chỉnh chế độ ăn\n'
                    '   • Tìm nguyên nhân hạ đường huyết\n'
                    '   • Giáo dục bệnh nhân\n\n'
                    '⚠️ BIẾN CHỨNG CÓ THỂ XẢY RA:\n'
                    '🔴 DO TĂNG ĐƯỜNG HUYẾT CAO:\n'
                    '• Mất nước, điện giải rối loạn\n'
                    '• Ketoacidosis (nếu có thiếu insulin)\n'
                    '• Hôn mê tăng thẩm thấu (hiếm)\n'
                    '• Nhiễm trùng cơ hội\n\n'
                    '🔴 DO XỬ TRÍ SAI:\n'
                    '• "Yo-yo glucose": Hạ → Cao → Hạ\n'
                    '• Hạ đường huyết tái phát nặng hơn\n'
                    '• Tổn thương não do dao động glucose\n'
                    '• Rối loạn điện giải nghiêm trọng\n\n'
                    '💡 NGUYÊN TẮC "SOFT LANDING":\n'
                    '• Mục tiêu glucose 150-250mg/dL trong 24h đầu\n'
                    '• Giảm glucose từ từ 50-100mg/dL/h\n'
                    '• Tránh dao động glucose mạnh\n'
                    '• Ưu tiên ổn định hơn là glucose hoàn hảo\n\n'
                    '📊 THEO DÕI VÀ ĐÁNH GIÁ:\n'
                    '• Glucose mỗi 1-2h trong 12h đầu\n'
                    '• Ketone nếu glucose >300mg/dL\n'
                    '• Điện giải, creatinine\n'
                    '• Tri giác, dấu hiệu thần kinh\n'
                    '• Cân bằng nước - điện giải',
                  ),
                ],
              ),
            ),

            // Clinical Cases
            _buildProtocolCard(
              title: '8. CA LÂM SÀNG ĐIỂN HÌNH',
              icon: Icons.local_hospital,
              color: Colors.brown,
              child: Column(
                children: [
                  _buildClinicalCase(
                    'Ca 1: Hạ đường huyết nhẹ',
                    'Nam 45t, đái tháo đường type 2, uống Metformin + Gliclazide. Đói, đổ mồ hôi, glucose 55mg/dL',
                    'Cho uống 4 viên kẹo (20g glucose). Kiểm tra lại sau 15 phút: 85mg/dL. Cho ăn nhẹ và theo dõi.',
                    Colors.green.shade50,
                  ),
                  const SizedBox(height: 12),
                  _buildClinicalCase(
                    'Ca 2: Hạ đường huyết nặng',
                    'Nữ 30t, đái tháo đường type 1, hôn mê tại nhà, glucose 28mg/dL',
                    'Glucagon 1mg IM ngay. Đặt IV → Glucose 50% 50ml. Tỉnh sau 10 phút. Glucose duy trì 100-150mg/dL.',
                    Colors.red.shade50,
                  ),
                  const SizedBox(height: 12),
                  _buildClinicalCase(
                    'Ca 3: Hạ đường huyết do thuốc',
                    'Ông 75t, uống Glibenclamide, nhập viện lần 2 vì hạ đường huyết',
                    'Ngừng Glibenclamide. Theo dõi 72h. Chuyển sang Sitagliptin. Giáo dục chế độ ăn.',
                    Colors.orange.shade50,
                  ),
                ],
              ),
            ),

            // References
            _buildProtocolCard(
              title: '9. TÀI LIỆU THAM KHẢO',
              icon: Icons.library_books,
              color: Colors.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '• ADA Standards of Medical Care in Diabetes 2024\n'
                    '• Endocrine Society Clinical Practice Guidelines\n'
                    '• ESC Guidelines on Diabetes and CVD 2023\n'
                    '• Bộ Y Tế - Hướng dẫn chẩn đoán và điều trị Đái tháo đường\n'
                    '• Diabetes Care Journal - Hypoglycemia Management\n'
                    '• EASD Position Statement on Hypoglycemia',
                    style: TextStyle(fontSize: 14, height: 1.6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
