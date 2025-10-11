import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HypertensiveCrisisProtocolPage extends StatefulWidget {
  const HypertensiveCrisisProtocolPage({super.key});

  @override
  State<HypertensiveCrisisProtocolPage> createState() => _HypertensiveCrisisProtocolPageState();
}

class _HypertensiveCrisisProtocolPageState extends State<HypertensiveCrisisProtocolPage> {
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _loadBookmarkStatus();
  }

  Future<void> _loadBookmarkStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isBookmarked = prefs.getBool('bookmark_hypertensive_crisis') ?? false;
    });
  }

  Future<void> _toggleBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    await prefs.setBool('bookmark_hypertensive_crisis', _isBookmarked);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isBookmarked ? 'Đã thêm vào bookmark' : 'Đã xóa khỏi bookmark'),
          duration: const Duration(seconds: 2),
          backgroundColor: _isBookmarked ? Colors.green : Colors.grey,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Cơn Tăng Huyết Áp',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            onPressed: _toggleBookmark,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with vital signs
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.red.shade400,
                    Colors.red.shade500,
                  ],
                ),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'HYPERTENSIVE CRISIS',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Huyết áp ≥ 180/120 mmHg',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Emergency Algorithm
                  _buildProtocolCard(
                    title: '🚨 SƠ ĐỒ TIẾP CẬN XỬ TRÍ CẤP CỨU',
                    icon: Icons.account_tree,
                    color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.red.shade200, width: 2),
                          ),
                          child: Column(
                            children: [
                              // Step 1: Assessment
                              _buildAlgorithmStep(
                                stepNumber: '1',
                                title: 'ĐÁNH GIÁ BAN ĐẦU',
                                content: 'BP ≥ 180/120 mmHg + Triệu chứng?',
                                color: Colors.red,
                                isFirst: true,
                              ),
                              
                              // Decision branch
                              const SizedBox(height: 8),
                              Column(
                                children: [
                                  _buildDecisionBranch(
                                    condition: 'CÓ triệu chứng\ntổn thương cơ quan đích',
                                    outcome: 'HYPERTENSIVE\nEMERGENCY',
                                    color: Colors.red,
                                    isEmergency: true,
                                  ),
                                  const SizedBox(height: 12),
                                  _buildDecisionBranch(
                                    condition: 'KHÔNG có\ntriệu chứng',
                                    outcome: 'HYPERTENSIVE\nURGENCY',
                                    color: Colors.orange,
                                    isEmergency: false,
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 16),
                              
                              // Step 2: Emergency Management
                              _buildAlgorithmStep(
                                stepNumber: '2',
                                title: 'XỬ TRÍ CẤP CỨU',
                                content: 'EMERGENCY: Giảm BP 10-20% trong 1h đầu\nURGENCY: Giảm BP trong 24-48h',
                                color: Colors.blue,
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Step 3: Drug selection
                              _buildAlgorithmStep(
                                stepNumber: '3',
                                title: 'CHỌN THUỐC',
                                content: 'Emergency: IV (Nicardipine, Esmolol)\nUrgency: PO (Amlodipine, Captopril)',
                                color: Colors.green,
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Step 4: Monitoring
                              _buildAlgorithmStep(
                                stepNumber: '4',
                                title: 'THEO DÕI',
                                content: 'BP mỗi 5-15 phút\nTriệu chứng thần kinh\nChức năng cơ quan',
                                color: Colors.purple,
                                isLast: true,
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Quick reference table
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '📋 BẢNG THAM KHẢO NHANH:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Column(
                                children: [
                                  Text(
                                    '🔴 EMERGENCY:\n• Đau ngực\n• Khó thở\n• Đau đầu + buồn nôn\n• Rối loạn thị giác\n• Yếu liệt',
                                    style: TextStyle(fontSize: 12, height: 1.3),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    '🟡 URGENCY:\n• Không triệu chứng\n• Đau đầu nhẹ\n• Chóng mặt\n• Mệt mỏi\n• Lo âu',
                                    style: TextStyle(fontSize: 12, height: 1.3),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Classification
                  _buildProtocolCard(
                    title: '1. PHÂN LOẠI',
                    icon: Icons.category,
                    color: Colors.orange,
                    child: Column(
                      children: [
                        _buildClassificationItem(
                          'Tăng huyết áp khẩn trương\n(Hypertensive Urgency)',
                          'HA ≥ 180/120 mmHg\nKHÔNG có tổn thương cơ quan đích',
                          Colors.orange.shade100,
                          Colors.orange.shade600,
                        ),
                        const SizedBox(height: 12),
                        _buildClassificationItem(
                          'Tăng huyết áp cấp cứu\n(Hypertensive Emergency)',
                          'HA ≥ 180/120 mmHg\nCÓ tổn thương cơ quan đích',
                          Colors.red.shade100,
                          Colors.red.shade600,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Initial Assessment
                  _buildProtocolCard(
                    title: '2. ĐÁNH GIÁ BAN ĐẦU',
                    icon: Icons.assessment,
                    color: Colors.blue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildChecklistItem('Đo huyết áp 2 tay, xác nhận giá trị'),
                        _buildChecklistItem('Tiền sử tăng huyết áp, thuốc đang dùng'),
                        _buildChecklistItem('Triệu chứng thần kinh: đau đầu, nhìn mờ, co giật'),
                        _buildChecklistItem('Triệu chứng tim mạch: đau ngực, khó thở'),
                        _buildChecklistItem('Khám thần kinh, tim phổi, mắt (võng mạc)'),
                        _buildChecklistItem('Cận lâm sàng cấp cứu'),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Paraclinical Tests
                  _buildProtocolCard(
                    title: '3. CẬN LÂM SÀNG',
                    icon: Icons.biotech,
                    color: Colors.purple,
                    child: Column(
                      children: [
                        _buildTestCard(
                          'XÉT NGHIỆM MÁU',
                          [
                            'CTM, CRP',
                            'Glucose, Creatinine, Urea',
                            'Troponin T/I',
                            'D-dimer, PT-INR',
                            'Điện giải đồ (Na+, K+)',
                          ],
                          Colors.purple.shade50,
                        ),
                        const SizedBox(height: 12),
                        _buildTestCard(
                          'HÌNH ẢNH',
                          [
                            'X-quang ngực',
                            'CT não (nếu có triệu chứng thần kinh)',
                            'Siêu âm tim (nếu nghi ngờ suy tim)',
                          ],
                          Colors.blue.shade50,
                        ),
                        const SizedBox(height: 12),
                        _buildTestCard(
                          'KHÁC',
                          [
                            'ECG 12 chuyển đạo',
                            'Nước tiểu tổng quát',
                            'Khám đáy mắt (nếu có điều kiện)',
                          ],
                          Colors.green.shade50,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Treatment Protocol
                  _buildProtocolCard(
                    title: '4. XỬ LÝ ĐIỀU TRỊ',
                    icon: Icons.medical_services,
                    color: Colors.green,
                    child: Column(
                      children: [
                        // Hypertensive Urgency
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            border: Border.all(color: Colors.orange.shade200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.warning_amber, color: Colors.orange.shade600),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'TĂNG HUYẾT ÁP KHẨN TRƯƠNG',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              _buildTreatmentStep('1', 'Nghỉ ngơi trong môi trường yên tĩnh'),
                              _buildTreatmentStep('2', 'Giảm HA 10-20% trong 24-48h đầu'),
                              _buildTreatmentStep('3', 'Thuốc đường uống:\n'
                                  '• Amlodipine 5-10mg\n'
                                  '• Captopril 25mg x 2-3 lần/ngày\n'
                                  '• Nifedipine SR 20mg x 2 lần/ngày'),
                              _buildTreatmentStep('4', 'Theo dõi HA mỗi 30 phút'),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Hypertensive Emergency
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            border: Border.all(color: Colors.red.shade200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.emergency, color: Colors.red.shade600),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'TĂNG HUYẾT ÁP CẤP CỨU',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              _buildTreatmentStep('1', 'Giảm HA 10-20% trong 1h đầu'),
                              _buildTreatmentStep('2', 'Giảm thêm tới 25% trong 2-6h tiếp theo'),
                              _buildTreatmentStep('3', 'Thuốc tiêm tĩnh mạch:\n'
                                  '• Nicardipine 5-15mg/h\n'
                                  '• Esmolol 50-300mcg/kg/min\n'
                                  '• Labetalol 20mg IV, lặp lại mỗi 10 phút'),
                              _buildTreatmentStep('4', 'Theo dõi HA liên tục (monitor)'),
                              _buildTreatmentStep('5', 'Xử lý tổn thương cơ quan đích'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Complications Management
                  _buildProtocolCard(
                    title: '5. XỬ LÝ BIẾN CHỨNG',
                    icon: Icons.healing,
                    color: Colors.teal,
                    child: Column(
                      children: [
                        _buildComplicationCard(
                          'Phù não - Encephalopathy',
                          'Giảm HA 20% trong 1h\nMannitol 0.5-1g/kg IV\nChống co giật',
                          Colors.red.shade100,
                          Icons.psychology,
                        ),
                        const SizedBox(height: 12),
                        _buildComplicationCard(
                          'Phù phổi cấp',
                          'Giảm HA nhanh\nFurosemide 40-80mg IV\nNTG 0.3-0.6mg',
                          Colors.blue.shade100,
                          Icons.air,
                        ),
                        const SizedBox(height: 12),
                        _buildComplicationCard(
                          'Bóc tách động mạch chủ',
                          'Giảm HA mục tiêu <120mmHg\nEsmolol + Nicardipine\nGọi phẫu thuật ngay',
                          Colors.orange.shade100,
                          Icons.warning,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Monitoring
                  _buildProtocolCard(
                    title: '6. THEO DÕI',
                    icon: Icons.monitor_heart,
                    color: Colors.indigo,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMonitoringItem('Huyết áp', 'Mỗi 15 phút (1h đầu) → 30 phút → 1h'),
                        _buildMonitoringItem('Mạch, SpO2', 'Liên tục'),
                        _buildMonitoringItem('Ý thức', 'Glasgow Coma Scale'),
                        _buildMonitoringItem('Nước tiểu', 'Theo dõi bằng catheter'),
                        _buildMonitoringItem('Điện giải', 'Mỗi 6-12h'),
                        _buildMonitoringItem('Thần kinh', 'Triệu chứng thần kinh học'),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Warning Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      border: Border.all(color: Colors.amber.shade300, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.warning, color: Colors.amber.shade700, size: 28),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'LƯU Ý QUAN TRỌNG',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '• KHÔNG giảm huyết áp quá nhanh (tránh thiếu máu não, tim, thận)\n'
                          '• TRÁNH thuốc ngậm dưới lưỡi (Nifedipine ngậm)\n'
                          '• Điều chỉnh thuốc dựa trên đáp ứng lâm sàng\n'
                          '• Chuyển tuyến trên nếu không kiểm soát được',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Discussion and Clinical Debates
                  _buildProtocolCard(
                    title: '7. BÀN LUẬN & TRANH LUẬN LÂM SÀNG (5 câu hỏi)',
                    icon: Icons.question_answer,
                    color: Colors.deepOrange,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDiscussionPoint(
                          'Vấn đề thường gặp',
                          '• Giảm HA quá nhanh: Gây thiếu máu não, đột quỵ thứ phát\n'
                          '• Không phân biệt được Urgency vs Emergency\n'
                          '• Dùng Nifedipine ngậm: Gây hạ HA đột ngột, nguy hiểm\n'
                          '• Không theo dõi chặt chẽ: Bỏ lỡ biến chứng\n'
                          '• Chậm chuyển tuyến: Trì hoãn điều trị chuyên khoa',
                        ),
                        const SizedBox(height: 12),
                        _buildDiscussionPoint(
                          'Khuyến nghị thực hành',
                          '• Luôn đo HA 2 tay, xác nhận kỹ thuật đo\n'
                          '• Đánh giá tổn thương cơ quan đích là ưu tiên\n'
                          '• Mục tiêu giảm HA: từ từ, an toàn\n'
                          '• Theo dõi thần kinh, tim phổi liên tục\n'
                          '• Ghi chép chi tiết để đánh giá đáp ứng',
                        ),
                        const SizedBox(height: 12),
                        _buildDiscussionPoint(
                          'Tranh luận lâm sàng 1',
                          '❓ Tình huống: BN nhập viện HA 240/130, đau đầu, xây xẩm vừa, chưa có dấu thần kinh định vị\n\n'
                          '🤔 Câu hỏi: Có cần hạ HA khẩn bằng thuốc TM trước khi chụp CT?\n\n'
                          '💡 Trả lời:\n'
                          '• KHÔNG nên hạ HA quá nhanh trước CT\n'
                          '• Mức HA này có thể do stress, lo lắng\n'
                          '• Ưu tiên: Đánh giá nhanh → CT não ngay\n'
                          '• Cho thuốc uống nhẹ (Captopril 25mg) nếu cần\n'
                          '• Giảm HA chỉ 10-15% trong 1h đầu\n\n'
                          '📋 Khi CT bình thường:\n'
                          '• Xác định đây là THA khẩn trương\n'
                          '• Điều trị bằng thuốc uống\n'
                          '• Mục tiêu: Giảm HA 10-20% trong 24-48h\n'
                          '• Theo dõi HA mỗi 30 phút\n'
                          '• Tìm nguyên nhân thứ phát nếu có',
                        ),
                        const SizedBox(height: 12),
                        _buildDiscussionPoint(
                          'Tranh luận lâm sàng 2',
                          '❓ Tình huống: Phù phổi cấp do cơn THA cấp cứu\n\n'
                          '🤔 Câu hỏi: Tại sao dùng Nitroglycerin? Có thể thay bằng Nicardipine?\n\n'
                          '🧬 Nitroglycerin - Cơ chế sinh học:\n'
                          '• Giải phóng NO (nitric oxide) trong tế bào cơ trơn\n'
                          '• Kích hoạt guanylate cyclase → tăng cGMP\n'
                          '• Giãn tĩnh mạch >> động mạch (tỷ lệ 10:1)\n'
                          '• Giảm venous return → giảm tiền tải nhanh\n'
                          '• Liều: 0.3-0.6mg ngậm hoặc 10-20mcg/min IV\n'
                          '• Hiệu quả: 2-5 phút\n\n'
                          '🧬 Nicardipine - Cơ chế sinh học:\n'
                          '• Chẹn kênh Ca²⁺ type L ở cơ trơn mạch máu\n'
                          '• Ngăn Ca²⁺ vào tế bào → giảm co cơ trơn\n'
                          '• Giãn động mạch >> tĩnh mạch\n'
                          '• Giảm hậu tải (afterload) → giảm huyết áp\n'
                          '• Có thể tăng tần số tim phản xạ\n\n'
                          '� Tại sao giảm tiền tải trước trong phù phổi?\n'
                          '• Phù phổi = quá tải thể tích + áp lực mao mạch phổi cao\n'
                          '• Tiền tải cao → tăng áp lực nhĩ trái → ứ máu phổi\n'
                          '• Giảm tiền tải → giảm venous return → giảm áp lực mao mạch phổi ngay\n'
                          '• Hậu tải chỉ ảnh hưởng gián tiếp qua cải thiện chức năng tim\n'
                          '• Ưu tiên: Dẫn lưu "bể chứa" phổi trước, sau đó tối ưu bơm tim\n\n'
                          '⚖️ Nicardipine - Khi nào dùng được?\n'
                          '• Sau khi đã kiểm soát ứ phổi bằng Nitroglycerin\n'
                          '• EF tim > 40%, huyết động ổn định\n'
                          '• Để kiểm soát huyết áp dài hạn\n'
                          '• Liều: 5-15mg/h, tăng từ từ',
                        ),
                        const SizedBox(height: 12),
                        _buildDiscussionPoint(
                          'Tranh luận lâm sàng 3',
                          '❓ Nitroglycerin ngậm vs truyền tĩnh mạch - Dạng nào tốt hơn?\n\n'
                          '💊 Nitroglycerin ngậm (0.3-0.6mg):\n'
                          '• Ưu điểm: Có sẵn, dùng nhanh\n'
                          '• Nhược điểm:\n'
                          '  - Hấp thu không đều qua niêm mạc\n'
                          '  - Không kiểm soát được liều\n'
                          '  - Tác dụng kéo dài 30-60 phút\n'
                          '  - Nguy cơ hạ HA quá nhanh, không thể dừng ngay\n'
                          '  - Không phù hợp với BN nôn, ói\n\n'
                          '💉 Nitroglycerin truyền tĩnh mạch (10-20mcg/min):\n'
                          '• Ưu điểm:\n'
                          '  - Kiểm soát chính xác liều lượng\n'
                          '  - Tăng/giảm liều theo đáp ứng\n'
                          '  - Ngưng ngay lập tức nếu hạ HA quá nhanh\n'
                          '  - Hiệu quả ổn định, có thể dự đoán\n'
                          '  - Phù hợp ICU, theo dõi chặt chẽ\n'
                          '• Nhược điểm: Cần pump tiêm, theo dõi monitor\n\n'
                          '🏆 Kết luận: Trong phù phổi cấp, ưu tiên Nitroglycerin IV vì:\n'
                          '• An toàn hơn - có thể kiểm soát\n'
                          '• Hiệu quả hơn - liều chính xác\n'
                          '• Phù hợp với môi trường ICU/CCU',
                        ),
                        const SizedBox(height: 12),
                        _buildDiscussionPoint(
                          'Tranh luận lâm sàng 4',
                          '❓ Phù não do THA cấp cứu - CT scan có loại trừ được không?\n\n'
                          '🧠 Phù não (Hypertensive Encephalopathy):\n'
                          '• Cơ chế: Áp lực tưới máu não quá cao → vỡ hàng rào máu-não\n'
                          '• Phù não lan tỏa, không định vị\n'
                          '• Có thể hồi phục nếu điều trị kịp thời\n\n'
                          '🔍 CT scan có loại trừ được phù não?\n'
                          '• CT thường BÌNH THƯỜNG trong giai đoạn đầu\n'
                          '• Phù não lan tỏa khó phát hiện trên CT\n'
                          '• CT chỉ thấy khi phù não nặng, muộn\n'
                          '• MRI nhạy hơn (FLAIR, DWI) nhưng không cấp cứu\n\n'
                          '🚨 Khi nào nghi phù não?\n'
                          '• HA > 180/120 + triệu chứng thần kinh cấp tính:\n'
                          '  - Đau đầu dữ dội, buồn nôn/nôn\n'
                          '  - Rối loạn ý thức (lú lẫn, li bì)\n'
                          '  - Rối loạn thị giác (nhìn mờ, mù tạm thời)\n'
                          '  - Co giật toàn thể hoặc khu trú\n'
                          '  - Liệt/yếu chi, rối loạn ngôn ngữ\n\n'
                          '⚠️ Chẩn đoán phù não:\n'
                          '• Dựa vào LÂM SÀNG, không dựa vào CT\n'
                          '• CT chỉ để loại trừ chảy máu, nhồi máu\n'
                          '• Nguyên tắc: Có triệu chứng thần kinh + HA cao = nghi phù não\n'
                          '• Điều trị ngay, không chờ CT có phù não\n\n'
                          '💊 Xử lý:\n'
                          '• Giảm HA 20% trong 1h (Nicardipine IV)\n'
                          '• Mannitol 0.5-1g/kg nếu phù não nặng\n'
                          '• Chống co giật (Diazepam, Phenytoin)',
                        ),
                        const SizedBox(height: 12),
                        _buildDiscussionPoint(
                          'Tranh luận lâm sàng 5',
                          '❓ Suy thận cấp trong cơn THA - Cơ chế nào quan trọng nhất?\n\n'
                          '🫘 Cơ chế sinh bệnh suy thận cấp trong THA:\n'
                          '1️⃣ HOẠI TỬ CẤP ỐNG THẬN (ATN):\n'
                          '• Cơ chế chủ yếu: Thiếu máu cục bộ do co mạch thận\n'
                          '• HA tăng đột ngột → co mạch tiểu động mạch cầu thận đến\n'
                          '• Giảm lưu lượng máu thận → thiếu oxy tế bào ống thận\n'
                          '• Hoại tử tế bào ống thận gần và xa\n\n'
                          '2️⃣ VI HUYẾT KHỐI (Microthrombi):\n'
                          '• Tổn thương nội mô mao mạch thận\n'
                          '• Kích hoạt đông máu → huyết khối nhỏ\n'
                          '• Tắc mao mạch cầu thận\n\n'
                          '3️⃣ HOẠI TỬ MẠCH MÁU THẬN:\n'
                          '• Tổn thương trực tiếp thành mạch\n'
                          '• Xuất huyết, hoại tử thành động mạch nhỏ\n'
                          '• Phù nề, viêm quanh mạch\n\n'
                          '🔬 Biểu hiện lâm sàng:\n'
                          '• Triệu chứng SỚM (6-12h):\n'
                          '  - Giảm lượng nước tiểu (<0.5ml/kg/h)\n'
                          '  - Đau vùng thắt lưng hai bên\n'
                          '  - Nước tiểu có máu vi thể\n'
                          '• Triệu chứng MUỘN (24-48h):\n'
                          '  - Thiểu niệu hoặc vô niệu\n'
                          '  - Phù chi dưới, phù phổi\n'
                          '  - Rối loạn ý thức (uremia)\n'
                          '  - Khó thở, tăng JVP\n\n'
                          '🧪 Cận lâm sàng:\n'
                          '• Chức năng thận:\n'
                          '  - Creatinine tăng >1.5 lần baseline\n'
                          '  - Urea tăng nhanh (>20mg/dL/ngày)\n'
                          '  - eGFR giảm >25%\n'
                          '• Nước tiểu:\n'
                          '  - Protein niệu +++ (>3g/24h)\n'
                          '  - Hồng cầu 10-50/HPF\n'
                          '  - Trụ hạt, trụ sáp\n'
                          '  - Tỷ trọng nước tiểu <1.010\n'
                          '• Điện giải:\n'
                          '  - Tăng K+ (>5.5mmol/L)\n'
                          '  - Tăng PO4, giảm Ca++\n'
                          '  - Acid hóa chuyển hóa\n\n'
                          '🚨 Xử lý suy thận cấp trong THA:\n'
                          '1. GIẢM HUYẾT ÁP (MỤC TIÊU CHÍNH):\n'
                          '   • Giảm 20-25% trong 1h đầu\n'
                          '   • Không giảm quá nhanh (<25%)\n'
                          '   • Thuốc chọn: Nicardipine IV 5-15mg/h\n\n'
                          '2. HỖ TRỢ THẬN:\n'
                          '   • Bù dịch cẩn thận (tránh quá tải)\n'
                          '   • Lợi tiểu nếu có phù: Furosemide 40-80mg IV\n'
                          '   • Theo dõi cân bằng nước điện giải\n\n'
                          '3. TRÁNH CÁC YẾU TỐ GÂY HẠI:\n'
                          '   • Tránh ACE-I/ARB trong giai đoạn cấp\n'
                          '   • Tránh thuốc độc thận (NSAIDs, Aminoglycosides)\n'
                          '   • Tránh chất cản quang nếu không cần thiết\n\n'
                          '4. LỌC THẬN KHI CẦN:\n'
                          '   • Chỉ định tuyệt đối:\n'
                          '     - K+ >6.5 mmol/L không đáp ứng điều trị\n'
                          '     - Acid hóa nặng pH <7.1\n'
                          '     - Phù phổi không đáp ứng lợi tiểu\n'
                          '     - Triệu chứng độc tố niệu nặng\n'
                          '   • Phương thức:\n'
                          '     - Ưu tiên CRRT (ổn định huyết động)\n'
                          '     - HD gián đoạn nếu cần nhanh\n'
                          '   • Mục tiêu: Ổn định huyết động, cân bằng điện giải',
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Clinical Cases
                  _buildProtocolCard(
                    title: '8. CA LÂM SÀNG ĐIỂN HÌNH',
                    icon: Icons.local_hospital,
                    color: Colors.brown,
                    child: Column(
                      children: [
                        _buildClinicalCase(
                          'Ca 1: THA Khẩn trương',
                          'Nam 45t, HA 190/110, đau đầu nhẹ, không có triệu chứng thần kinh',
                          'Xử lý: Nghỉ ngơi + Amlodipine 5mg. Theo dõi HA mỗi 30p. Giảm HA từ từ trong 24h.',
                          Colors.orange.shade50,
                        ),
                        const SizedBox(height: 12),
                        _buildClinicalCase(
                          'Ca 2: THA Cấp cứu',
                          'Nữ 60t, HA 210/130, đau đầu dữ dội, nhìn mờ, co giật',
                          'Xử lý: Nicardipine IV 5mg/h. Theo dõi monitor. CT não, xử lý phù não nếu có.',
                          Colors.red.shade50,
                        ),
                        const SizedBox(height: 12),
                        _buildClinicalCase(
                          'Ca 3: Phù phổi cấp',
                          'Nam 55t, HA 200/120, khó thở, ran ẩm 2 phổi',
                          'Xử lý:\n1. Nitroglycerin 10-20mcg/min IV (giảm tiền tải có kiểm soát)\n2. Furosemide 80mg IV (lợi tiểu)\n3. Thở O2, theo dõi SpO2\n4. Sau ổn định: Nicardipine IV để kiểm soát HA\n5. Siêu âm tim đánh giá EF',
                          Colors.blue.shade50,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // References
                  _buildProtocolCard(
                    title: '9. TÀI LIỆU THAM KHẢO',
                    icon: Icons.library_books,
                    color: Colors.blueGrey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildReferenceItem(
                          '1. 2017 ACC/AHA Hypertension Guidelines',
                          'Management of High Blood Pressure in Adults',
                        ),
                        _buildReferenceItem(
                          '2. ESC/ESH 2018 Guidelines',
                          'Arterial Hypertension Management',
                        ),
                        _buildReferenceItem(
                          '3. Hướng dẫn chẩn đoán và điều trị THA',
                          'Bộ Y tế Việt Nam 2018',
                        ),
                        _buildReferenceItem(
                          '4. Critical Care Medicine',
                          'Hypertensive Crisis Management - ICU Protocols',
                        ),
                        _buildReferenceItem(
                          '5. Emergency Medicine Clinics',
                          'Acute Hypertensive Episodes in ED',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProtocolCard({
    required String title,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
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
        children: [
          Container(
            width: double.infinity,
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
                      fontSize: 15,
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

  Widget _buildClassificationItem(String title, String description, Color bgColor, Color textColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: textColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: textColor,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Colors.blue.shade600,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestCard(String title, List<String> tests, Color bgColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...tests.map((test) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    test,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTreatmentStep(String step, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplicationCard(String title, String management, Color bgColor, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade700, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  management,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonitoringItem(String parameter, String frequency) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.indigo.shade400,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  parameter,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  frequency,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscussionPoint(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildClinicalCase(String title, String presentation, String management, Color bgColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Colors.brown.shade600, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Trình bày: $presentation',
            style: const TextStyle(
              fontSize: 13,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            management,
            style: TextStyle(
              fontSize: 13,
              height: 1.3,
              color: Colors.grey.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferenceItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade400,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    height: 1.3,
                  ),
                ),
              ],
            ),
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
      width: double.infinity,
      child: Column(
        children: [
          if (!isFirst)
            Container(
              width: 2,
              height: 16,
              color: Colors.grey.shade400,
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    stepNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        content,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (!isLast)
            Container(
              width: 2,
              height: 16,
              color: Colors.grey.shade400,
            ),
        ],
      ),
    );
  }

  Widget _buildDecisionBranch({
    required String condition,
    required String outcome,
    required Color color,
    required bool isEmergency,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color,
          width: isEmergency ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            condition,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Icon(
            Icons.arrow_downward,
            color: color,
            size: 16,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              outcome,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
