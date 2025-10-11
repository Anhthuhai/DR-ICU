import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HyperglycemicHyperosmolarStateProtocolPage extends StatefulWidget {
  const HyperglycemicHyperosmolarStateProtocolPage({super.key});

  @override
  State<HyperglycemicHyperosmolarStateProtocolPage> createState() => _HyperglycemicHyperosmolarStateProtocolPageState();
}

class _HyperglycemicHyperosmolarStateProtocolPageState extends State<HyperglycemicHyperosmolarStateProtocolPage> {
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _loadBookmarkStatus();
  }

  Future<void> _loadBookmarkStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isBookmarked = prefs.getBool('bookmark_hhs_protocol') ?? false;
    });
  }

  Future<void> _toggleBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    await prefs.setBool('bookmark_hhs_protocol', _isBookmarked);
    
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
          'Cơn Tăng Đường Huyết Tăng Áp Lực Thẩm Thấu',
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
                    Colors.deepOrange.shade400,
                    Colors.deepOrange.shade500,
                  ],
                ),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.science,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'HYPERGLYCEMIC HYPEROSMOLAR STATE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Glucose ≥ 600 mg/dL + Osmolality ≥ 320 mOsm/kg + pH ≥ 7.30',
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
                    title: '🚨 SƠ ĐỒ TIẾP CẬN XỬ TRÍ CẤP CỨU HHS',
                    icon: Icons.account_tree,
                    color: Colors.deepOrange,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.deepOrange.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.deepOrange.shade200, width: 2),
                          ),
                          child: Column(
                            children: [
                              // Step 1: Assessment
                              _buildAlgorithmStep(
                                stepNumber: '1',
                                title: 'CHẨN ĐOÁN HHS',
                                content: 'Glucose ≥600mg/dL + Osmolality ≥320 + pH ≥7.30 + Ketone âm tính',
                                color: Colors.deepOrange,
                                isFirst: true,
                              ),
                              
                              // Decision branch
                              const SizedBox(height: 8),
                              Column(
                                children: [
                                  _buildDecisionBranch(
                                    condition: 'CÓ thay đổi\ntri giác',
                                    outcome: 'HHS NẶNG\n(Cần ICU)',
                                    color: Colors.red,
                                    isEmergency: true,
                                  ),
                                  const SizedBox(height: 12),
                                  _buildDecisionBranch(
                                    condition: 'Tri giác\nbình thường',
                                    outcome: 'HHS VỪA\n(Theo dõi chặt)',
                                    color: Colors.orange,
                                    isEmergency: false,
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 16),
                              
                              // Step 2: Fluid Management
                              _buildAlgorithmStep(
                                stepNumber: '2',
                                title: 'BÙ DỊCH',
                                content: 'NaCl 0.9% 15-20ml/kg/h → 4-14ml/kg/h\nKhi glucose <250: D5 + NaCl 0.45%',
                                color: Colors.blue,
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Step 3: Insulin therapy
                              _buildAlgorithmStep(
                                stepNumber: '3',
                                title: 'INSULIN',
                                content: 'Regular IV: 0.1 đv/kg/h\nMục tiêu: giảm 50-70mg/dL/h',
                                color: Colors.green,
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Step 4: Electrolytes
                              _buildAlgorithmStep(
                                stepNumber: '4',
                                title: 'ĐIỆN GIẢI',
                                content: 'K+: 20-30mEq/L khi K+ <5.2\nPO4, Mg theo chỉ định',
                                color: Colors.purple,
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Step 5: Monitoring
                              _buildAlgorithmStep(
                                stepNumber: '5',
                                title: 'THEO DÕI',
                                content: 'Glucose mỗi 1-2h\nĐiện giải mỗi 2-4h\nTri giác, cân bằng dịch',
                                color: Colors.indigo,
                                isLast: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Diagnostic Criteria
                  _buildProtocolCard(
                    title: '📋 TIÊU CHUẨN CHẨN ĐOÁN HHS',
                    icon: Icons.checklist,
                    color: Colors.purple,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.purple.shade200, width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCriteriaItem('✓', 'Glucose máu ≥ 600 mg/dL (33.3 mmol/L)*', true),
                          _buildCriteriaItem('✓', 'Áp lực thẩm thấu hiệu dụng ≥ 320 mOsm/kg', true),
                          _buildCriteriaItem('✓', 'pH ≥ 7.30', true),
                          _buildCriteriaItem('✓', 'HCO3- ≥ 15 mEq/L', true),
                          _buildCriteriaItem('✓', 'Ketone máu <3.0 mmol/L (ADA 2022)', true),
                          _buildCriteriaItem('✓', 'Thay đổi tri giác (Glasgow Coma Scale <15)', true),
                          _buildCriteriaItem('⚠️', '*SGLT2i: Glucose có thể <600mg/dL (Euglycemic HHS)', false),
                          _buildCriteriaItem('📊', 'PHÂN ĐỘ: Nhẹ (320-330), Vừa (330-350), Nặng (>350)', false),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Laboratory Tests
                  _buildProtocolCard(
                    title: '🧪 XÉT NGHIỆM CẦN THIẾT',
                    icon: Icons.biotech,
                    color: Colors.blue,
                    child: Column(
                      children: [
                        _buildTestCard(
                          'CẤP CỨU',
                          [
                            'Glucose máu tĩnh mạch',
                            'Điện giải đồ (Na+, K+, Cl-, HCO3-)',
                            'Creatinine, BUN',
                            'Khí máu động mạch',
                          ],
                          Colors.red.shade50,
                        ),
                        const SizedBox(height: 12),
                        _buildTestCard(
                          'BỔ SUNG',
                          [
                            'Ketone máu/nước tiểu',
                            'Công thức máu',
                            'CRP, PCT (nếu nghi nhiễm trùng)',
                            'Osmolality huyết thanh',
                          ],
                          Colors.orange.shade50,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Treatment Protocol
                  _buildProtocolCard(
                    title: '💉 ĐIỀU TRỊ THEO GIAI ĐOẠN',
                    icon: Icons.medical_services,
                    color: Colors.green,
                    child: Column(
                      children: [
                        // Fluid management
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            border: Border.all(color: Colors.blue.shade200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.water_drop, color: Colors.blue.shade600),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'BÙ DỊCH',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              _buildTreatmentStep('1', 'NaCl 0.9% 15-20ml/kg trong 1h đầu'),
                              _buildTreatmentStep('2', 'Sau đó 4-14ml/kg/h tùy tình trạng'),
                              _buildTreatmentStep('3', 'Nếu Na+ hiệu chỉnh >145: NaCl 0.45%'),
                              _buildTreatmentStep('4', 'Glucose <250mg/dL: D5 + NaCl 0.45%'),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Insulin therapy
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            border: Border.all(color: Colors.green.shade200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.medication, color: Colors.green.shade600),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'INSULIN THERAPY',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              _buildTreatmentStep('1', 'Insulin Regular IV: 0.1 đơn vị/kg/h'),
                              _buildTreatmentStep('2', 'Mục tiêu: giảm 50-70mg/dL/h'),
                              _buildTreatmentStep('3', 'Glucose <250mg/dL: giảm xuống 0.02-0.05 đv/kg/h'),
                              _buildTreatmentStep('4', 'Chuyển SC khi bệnh nhân ăn được'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Complications
                  _buildProtocolCard(
                    title: '⚠️ BIẾN CHỨNG CẦN THEO DÕI',
                    icon: Icons.warning,
                    color: Colors.red,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red.shade200, width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildComplicationItem('🧠', 'Phù não'),
                          _buildComplicationItem('⚡', 'Hạ kali máu'),
                          _buildComplicationItem('💪', 'Rhabdomyolysis'),
                          _buildComplicationItem('🩸', 'Huyết khối tĩnh mạch'),
                          _buildComplicationItem('🫘', 'Suy thận cấp'),
                          _buildComplicationItem('💓', 'Rối loạn nhịp tim'),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Calculations
                  _buildProtocolCard(
                    title: '🧮 CÔNG THỨC TÍNH TOÁN',
                    icon: Icons.calculate,
                    color: Colors.indigo,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.indigo.shade200, width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCalculationItem(
                            'Áp lực thẩm thấu hiệu dụng:',
                            '2 × [Na+ + K+] + Glucose/18',
                          ),
                          const SizedBox(height: 12),
                          _buildCalculationItem(
                            'Na+ hiệu chỉnh:',
                            'Na+ + 1.6 × (Glucose - 100)/100',
                          ),
                          const SizedBox(height: 12),
                          _buildCalculationItem(
                            'Thiếu hụt nước tự do:',
                            '0.6 × Cân nặng × (Na+/140 - 1)',
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Clinical Discussion
                  _buildProtocolCard(
                    title: '💡 BÀN LUẬN LÂM SÀNG',
                    icon: Icons.school,
                    color: Colors.teal,
                    child: Column(
                      children: [
                        // Discussion 1: Rhabdomyolysis mechanism
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
                                  Icon(Icons.psychology, color: Colors.orange.shade600),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Cơ CHẾ GÂY HUỶ CƠ VÂN TRONG HHS',
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
                              _buildDiscussionPoint('1', 'Tăng áp lực thẩm thấu máu → thoát nước nội bào → tổn thương màng tế bào cơ'),
                              _buildDiscussionPoint('2', 'Giảm perfusion cơ do mất nước nặng và tăng độ nhớt máu'),
                              _buildDiscussionPoint('3', 'Tăng stress oxy hóa và viêm trong môi trường hyperglycemic'),
                              _buildDiscussionPoint('4', 'Rối loạn điện giải (hạ K+, hạ PO4) → rối loạn chức năng cơ'),
                              _buildDiscussionPoint('5', 'Insulin deficiency → giảm uptake glucose của cơ → thiếu năng lượng'),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Discussion 2: VTE mechanism
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.purple.shade50,
                            border: Border.all(color: Colors.purple.shade200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.bloodtype, color: Colors.purple.shade600),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'CƠ CHẾ HUYẾT KHỐI TĨNH MẠCH TRONG HHS',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              _buildDiscussionPoint('1', 'Mất nước nặng → tăng hematocrit và độ nhớt máu (>50%)'),
                              _buildDiscussionPoint('2', 'Hyperglycemia → tăng kích hoạt tiểu cầu và yếu tố đông máu'),
                              _buildDiscussionPoint('3', 'Giảm protein C, protein S và antithrombin III'),
                              _buildDiscussionPoint('4', 'Tăng fibrinogen và von Willebrand factor'),
                              _buildDiscussionPoint('5', 'Stress và viêm → tăng IL-6, TNF-α → thúc đẩy đông máu'),
                              _buildDiscussionPoint('6', 'Bất động lâu và catheter tĩnh mạch → yếu tố cơ học'),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Discussion 3: Hyperglycemia without HHS criteria
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            border: Border.all(color: Colors.green.shade200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.help_outline, color: Colors.green.shade600),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'HYPERGLYCEMIA CHƯA ĐẠT TIÊU CHUẨN HHS',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade50,
                                  border: Border.all(color: Colors.amber.shade200),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ĐỊNH NGHĨA:',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber.shade700,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Glucose 250-600mg/dL + Osmolality <320 mOsm/kg\nhoặc Glucose ≥600mg/dL + Osmolality <320 mOsm/kg',
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              _buildDiscussionPoint('1', 'PHÂN LOẠI: "Severe Hyperglycemia" hoặc "Pre-HHS"'),
                              _buildDiscussionPoint('2', 'Nguy cơ cao tiến triển thành HHS điển hình trong 6-12h'),
                              _buildDiscussionPoint('3', 'Thường có mất nước nhẹ-vừa, ít khi có thay đổi tri giác'),
                              _buildDiscussionPoint('4', 'XỬ TRÍ tương tự HHS nhưng ít cấp cứu hơn:'),
                              Container(
                                margin: const EdgeInsets.only(left: 36),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildSubDiscussionPoint('• Bù dịch: 10-15ml/kg/h thay vì 15-20ml/kg/h'),
                                    _buildSubDiscussionPoint('• Insulin: có thể bắt đầu 0.05-0.1 đv/kg/h'),
                                    _buildSubDiscussionPoint('• Theo dõi glucose mỗi 1-2h'),
                                    _buildSubDiscussionPoint('• Kiểm tra osmolality mỗi 4-6h'),
                                  ],
                                ),
                              ),
                              _buildDiscussionPoint('5', 'TIÊN LƯỢNG: Tốt hơn HHS, ít biến chứng thần kinh'),
                              _buildDiscussionPoint('6', 'LƯU Ý: Điều trị sớm ngăn ngừa tiến triển thành HHS nặng'),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Discussion 4: Insulin dose adjustment
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            border: Border.all(color: Colors.blue.shade200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.tune, color: Colors.blue.shade600),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'HƯỚNG DẪN CHỈNH LIỀU INSULIN THEO GLUCOSE',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              
                              // Target range
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  border: Border.all(color: Colors.green.shade200),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'MỤC TIÊU:',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green.shade700,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      '• Giảm glucose 50-70mg/dL/giờ\n• Glucose mục tiêu: 250-300mg/dL (HHS) hoặc 150-200mg/dL (Pre-HHS)',
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Dose adjustment protocol
                              _buildInsulinAdjustmentTable(),
                              
                              const SizedBox(height: 12),
                              
                              _buildDiscussionPoint('1', 'KHỞI ĐẦU: 0.1 đv/kg/h (regular insulin IV)'),
                              _buildDiscussionPoint('2', 'KIỂM TRA: Glucose mỗi 1h trong 4h đầu, sau đó mỗi 2h'),
                              _buildDiscussionPoint('3', 'CHỈNH LIỀU: Theo bảng hướng dẫn phía trên'),
                              _buildDiscussionPoint('4', 'GLUCOSE <250mg/dL: Thêm D5 + giảm insulin xuống 0.02-0.05 đv/kg/h'),
                              _buildDiscussionPoint('5', 'GLUCOSE <150mg/dL: Dừng insulin tạm thời, kiểm tra lại sau 1h'),
                              _buildDiscussionPoint('6', 'CHUYỂN SC: Khi glucose ổn định và bệnh nhân ăn được'),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Discussion 5: Guidelines updates
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            border: Border.all(color: Colors.indigo.shade200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.update, color: Colors.indigo.shade600),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'CẬP NHẬT GUIDELINES 2022-2025 vs ADA 2009',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              
                              // What's New section
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  border: Border.all(color: Colors.green.shade200),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '🆕 NHỮNG THAY ĐỔI CHÍNH:',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green.shade700,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    _buildUpdateComparison('KETONE', 'ADA 2009: "Âm tính/nhẹ"', 'ADA 2022: "<3.0 mmol/L"'),
                                    _buildUpdateComparison('PHÂN ĐỘ', 'ADA 2009: Không có', 'ADA 2022: Nhẹ/Vừa/Nặng theo Osmolality'),
                                    _buildUpdateComparison('SGLT2i', 'ADA 2009: Không đề cập', 'ADA 2022: Euglycemic HHS (<600mg/dL)'),
                                    _buildUpdateComparison('COVID-19', 'ADA 2009: Không có', 'ADA 2022: COVID-associated HHS'),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 12),
                              
                              _buildDiscussionPoint('1', 'KETONE: Định lượng cụ thể <3.0 mmol/L thay vì "âm tính/nhẹ"'),
                              _buildDiscussionPoint('2', 'SEVERITY GRADING mới: Mild (320-330), Moderate (330-350), Severe (>350)'),
                              _buildDiscussionPoint('3', 'SGLT2i-HHS: Glucose có thể <600mg/dL nhưng vẫn có hyperosmolality'),
                              _buildDiscussionPoint('4', 'ELDERLY: Threshold thấp hơn, can thiệp sớm hơn (>65 tuổi)'),
                              _buildDiscussionPoint('5', 'COVID-19: Nhận biết HHS liên quan COVID-19 (cytokine storm)'),
                              _buildDiscussionPoint('6', 'MONITORING: Continuous glucose monitoring được khuyến khích'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // References
                  _buildProtocolCard(
                    title: '📚 TÀI LIỆU THAM KHẢO',
                    icon: Icons.menu_book,
                    color: Colors.brown,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildReferenceItem(
                          '1.',
                          'American Diabetes Association',
                          'Hyperglycemic Crises in Adults With Diabetes: 2009 Consensus Statement',
                          'Diabetes Care 2009; 32(7): 1335-1343',
                        ),
                        const SizedBox(height: 12),
                        _buildReferenceItem(
                          '2.',
                          'Kitabchi AE, Umpierrez GE, Miles JM, Fisher JN',
                          'Hyperglycemic crises in adult patients with diabetes',
                          'Diabetes Care 2009; 32(7): 1335-1343',
                        ),
                        const SizedBox(height: 12),
                        _buildReferenceItem(
                          '3.',
                          'Pasquel FJ, Umpierrez GE',
                          'Hyperosmolar hyperglycemic state: a historic review of the clinical presentation, diagnosis, and treatment',
                          'Diabetes Care 2014; 37(11): 3124-3131',
                        ),
                        const SizedBox(height: 12),
                        _buildReferenceItem(
                          '4.',
                          'Joint British Diabetes Societies',
                          'The Management of Diabetic Ketoacidosis in Adults, 2nd edition',
                          'September 2013',
                        ),
                        const SizedBox(height: 12),
                        _buildReferenceItem(
                          '5.',
                          'Gosmanov AR, Gosmanova EO, Kitabchi AE',
                          'Hyperglycemic Crises: Diabetic Ketoacidosis and Hyperglycemic Hyperosmolar State',
                          'Endotext [Internet]. South Dartmouth (MA): MDText.com, Inc.; 2018',
                        ),
                        const SizedBox(height: 12),
                        _buildReferenceItem(
                          '6.',
                          'Nyenwe EA, Kitabchi AE',
                          'The evolution of diabetic ketoacidosis: An update of its etiology, pathogenesis and management',
                          'Metabolism 2016; 65(4): 507-521',
                        ),
                        const SizedBox(height: 12),
                        _buildReferenceItem(
                          '7.',
                          'American Diabetes Association Professional Practice Committee',
                          'Diabetes Care in the Hospital: Standards of Care in Diabetes—2022',
                          'Diabetes Care 2022; 45(Suppl. 1): S244–S253',
                        ),
                        const SizedBox(height: 12),
                        _buildReferenceItem(
                          '8.',
                          'Dhatariya KK, Glaser NS, Codner E, Umpierrez GE',
                          'Diabetic ketoacidosis and hyperosmolar hyperglycemic state: An International Society for Pediatric and Adolescent Diabetes clinical practice consensus guideline 2022 update',
                          'Pediatr Diabetes 2022; 23(7): 835-856',
                        ),
                        const SizedBox(height: 12),
                        _buildReferenceItem(
                          '9.',
                          'Handelsman Y, Mechanick JI, Blonde L, et al.',
                          'AACE/ACE Consensus Statement: Management of Hyperglycemic Crises in Adults with Diabetes',
                          'Endocr Pract 2024; 30(1): 1-23',
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline, color: Colors.grey.shade600, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Protocol này được xây dựng dựa trên các guidelines quốc tế và được cập nhật theo evidence-based medicine.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
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
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
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

  Widget _buildAlgorithmStep({
    required String stepNumber,
    required String title,
    required String content,
    required Color color,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Column(
      children: [
        if (!isFirst)
          Container(
            width: 2,
            height: 20,
            color: Colors.grey[300],
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (!isLast)
          Container(
            width: 2,
            height: 20,
            color: Colors.grey[300],
          ),
      ],
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
        border: Border.all(color: color.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              condition,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward, color: color, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              outcome,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCriteriaItem(String bullet, String text, bool isRequired) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bullet,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isRequired ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestCard(String title, List<String> tests, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: backgroundColor.withValues(alpha: 0.3)),
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
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(fontSize: 13)),
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

  Widget _buildTreatmentStep(String stepNumber, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Center(
              child: Text(
                stepNumber,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplicationItem(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculationItem(String title, String formula) {
    return Column(
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
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text(
            formula,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDiscussionPoint(String number, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[400]!, width: 2),
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              content,
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

  Widget _buildSubDiscussionPoint(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        content,
        style: const TextStyle(
          fontSize: 13,
          height: 1.3,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildInsulinAdjustmentTable() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BẢNG CHỈNH LIỀU INSULIN:',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 8),
          _buildAdjustmentRow('Giảm >100mg/dL/h', 'Giảm 50% liều hiện tại', Colors.red.shade50),
          _buildAdjustmentRow('Giảm 70-100mg/dL/h', 'Giữ nguyên liều', Colors.green.shade50),
          _buildAdjustmentRow('Giảm 50-70mg/dL/h', 'Giữ nguyên liều (mục tiêu)', Colors.green.shade50),
          _buildAdjustmentRow('Giảm 30-50mg/dL/h', 'Tăng 25% liều hiện tại', Colors.orange.shade50),
          _buildAdjustmentRow('Giảm <30mg/dL/h', 'Tăng 50% liều hiện tại', Colors.red.shade50),
          _buildAdjustmentRow('Glucose tăng', 'Tăng 100% liều + tìm nguyên nhân', Colors.red.shade100),
        ],
      ),
    );
  }

  Widget _buildAdjustmentRow(String condition, String action, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              condition,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              action,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferenceItem(String number, String authors, String title, String journal) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.brown.shade100,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.brown.shade300),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown.shade700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authors,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      journal,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateComparison(String topic, String oldVersion, String newVersion) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              topic,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_forward, size: 12, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        oldVersion,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.check_circle, size: 12, color: Colors.green.shade600),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        newVersion,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
