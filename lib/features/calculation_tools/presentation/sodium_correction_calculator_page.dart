import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_theme.dart';

class SodiumCorrectionCalculatorPage extends StatefulWidget {
  const SodiumCorrectionCalculatorPage({super.key});

  @override
  State<SodiumCorrectionCalculatorPage> createState() => _SodiumCorrectionCalculatorPageState();
}

class _SodiumCorrectionCalculatorPageState extends State<SodiumCorrectionCalculatorPage> {
  final _weightController = TextEditingController();
  final _currentNaController = TextEditingController();
  final _targetNaController = TextEditingController();
  final _currentGlucoseController = TextEditingController();
  
  String _selectedGender = 'Nam';
  int _selectedAge = 40;
  bool _hasHyperglycemia = false;
  bool _isAcuteHyponatremia = false;
  
  double? _correctedNa;
  double? _totalBodyWater;
  double? _naDeficit;
  
  // Kết quả theo Adrogue-Madias
  double? _nacl09Volume;
  double? _nacl3Volume;
  
  // Kết quả theo phương pháp Deficit (để so sánh)
  double? _nacl09VolumeDeficit;
  double? _nacl3VolumeDeficit;
  
  double? _maxCorrectionRate;
  String _recommendation = '';

  @override
  void dispose() {
    _weightController.dispose();
    _currentNaController.dispose();
    _targetNaController.dispose();
    _currentGlucoseController.dispose();
    super.dispose();
  }

  void _calculateSodiumCorrection() {
    final weight = double.tryParse(_weightController.text);
    final currentNa = double.tryParse(_currentNaController.text);
    final targetNa = double.tryParse(_targetNaController.text);
    final currentGlucose = double.tryParse(_currentGlucoseController.text);

    if (weight == null || currentNa == null || targetNa == null) {
      _showErrorSnackBar('Vui lòng nhập đầy đủ thông tin bắt buộc');
      return;
    }

    if (currentNa >= 135) {
      _showErrorSnackBar('Không có hạ natri máu (Na+ ≥ 135 mmol/L)');
      return;
    }

    if (targetNa > 145) {
      _showErrorSnackBar('Mục tiêu Na+ không nên > 145 mmol/L');
      return;
    }

    setState(() {
      // Tính toán Total Body Water (TBW)
      double tbwFactor;
      if (_selectedGender == 'Nam') {
        tbwFactor = _selectedAge > 60 ? 0.5 : 0.6;
      } else {
        tbwFactor = _selectedAge > 60 ? 0.45 : 0.5;
      }
      _totalBodyWater = weight * tbwFactor;

      // Hiệu chỉnh Na+ nếu có tăng glucose máu
      double correctedCurrentNa = currentNa;
      if (_hasHyperglycemia && currentGlucose != null && currentGlucose > 100) {
        // Công thức Katz: Mỗi 100mg/dL tăng glucose → Na+ giảm 1.6 mmol/L
        correctedCurrentNa = currentNa + (currentGlucose - 100) / 100 * 1.6;
      }
      _correctedNa = correctedCurrentNa;

      double desiredChange = targetNa - correctedCurrentNa;

      // Tính toán theo PHƯƠNG PHÁP DEFICIT (để so sánh)
      _naDeficit = desiredChange * _totalBodyWater!;
      _nacl09VolumeDeficit = _naDeficit! / 154 * 1000; // mL
      _nacl3VolumeDeficit = _naDeficit! / 513 * 1000; // mL
      
      // Tính toán theo công thức ADROGUE-MADIAS (chính thống)
      // Δ Na+ = (Na+ infusion - Na+ serum) / (TBW + 1)
      
      // Tính thay đổi Na+ với 1L NaCl 0.9% (154 mmol/L)
      double deltaNa09 = (154 - correctedCurrentNa) / (_totalBodyWater! + 1);
      _nacl09Volume = (desiredChange / deltaNa09) * 1000; // mL
      
      // Tính thay đổi Na+ với 1L NaCl 3% (513 mmol/L)
      double deltaNa3 = (513 - correctedCurrentNa) / (_totalBodyWater! + 1);
      _nacl3Volume = (desiredChange / deltaNa3) * 1000; // mL

      // Tốc độ hiệu chỉnh tối đa theo ESH/ESC 2018
      if (_isAcuteHyponatremia) {
        _maxCorrectionRate = 10.0; // <10 mmol/L/24h cho hạ natri cấp
      } else {
        if (correctedCurrentNa < 120) {
          _maxCorrectionRate = 10.0; // <10 mmol/L/24h cho Na+ <120
        } else {
          _maxCorrectionRate = 8.0; // <8 mmol/L/24h cho Na+ 120-129
        }
      }

      _generateRecommendation();
    });
  }

  void _generateRecommendation() {
    String severity = '';
    String urgency = '';
    String fluid = '';
    
    if (_correctedNa! < 120) {
      severity = 'Hạ natri máu nặng';
      urgency = 'CẤP CỨU';
      fluid = 'NaCl 3%';
    } else if (_correctedNa! < 130) {
      severity = 'Hạ natri máu vừa';
      urgency = 'Cần điều trị';
      fluid = 'NaCl 0.9% hoặc 3%';
    } else {
      severity = 'Hạ natri máu nhẹ';
      urgency = 'Theo dõi';
      fluid = 'NaCl 0.9%';
    }

    double percentDifference = ((_nacl3Volume! - _nacl3VolumeDeficit!) / _nacl3VolumeDeficit! * 100).abs();

    _recommendation = '''
📊 ĐÁNH GIÁ: $severity ($urgency)

🎯 MỤC TIÊU ĐIỀU TRỊ (ESH/ESC 2018):
• Tăng Na+ từ ${_correctedNa!.toStringAsFixed(1)} → ${_targetNaController.text} mmol/L
• Tốc độ an toàn: <${_maxCorrectionRate!.toStringAsFixed(1)} mmol/L/24h
${_isAcuteHyponatremia ? '• Có triệu chứng: 1-2 mmol/L/h x 3-4h đầu' : ''}

� SO SÁNH HAI PHƯƠNG PHÁP:
• Adrogue-Madias (NaCl 3%): ${_nacl3Volume!.toStringAsFixed(0)} mL
• Deficit Formula (NaCl 3%): ${_nacl3VolumeDeficit!.toStringAsFixed(0)} mL
• Chênh lệch: ${(_nacl3Volume! - _nacl3VolumeDeficit!).toStringAsFixed(0)} mL (${percentDifference.toStringAsFixed(1)}%)

�💧 CHỌN DUNG DỊCH:
• $fluid được khuyến nghị
${_correctedNa! < 120 ? '• NaCl 3% ưu tiên vì hạ natri nặng' : ''}

🚨 CẢNH BÁO QUAN TRỌNG - Na+ THẤP GIẢ:
• Một số cơ sở XN có thể trả kết quả Na+ thấp giả
• Nguyên nhân: Hyperproteinemia, hyperlipidemia
• NGUY CƠ: Bù theo Adrogue-Madias có thể QUÁ MỨC
• KHUYẾN NGHỊ: 
  ✓ Kiểm tra lại kết quả Na+ trên máy ISE trực tiếp
  ✓ Bắt đầu với 50-70% thể tích Adrogue-Madias
  ✓ Theo dõi Na+ mỗi 2h trong giai đoạn đầu

⚠️ NGUY CƠ OSMOTIC DEMYELINATION:
• Nguy cơ cao: Nghiện rượu, suy dinh dưỡng, bệnh gan
• TUYỆT ĐỐI tránh hiệu chỉnh >18 mmol/L trong 48h
• Ngưng điều trị khi đạt mục tiêu hoặc triệu chứng cải thiện

🔬 THEO DÕI NGHIÊM NGẶT:
• Na+ máu mỗi 2-4h trong 24h đầu (mỗi 1-2h nếu nghi ngờ Na+ thấp giả)
• Triệu chứng thần kinh (ý thức, động kinh)
• Cân bằng nước - điện giải (K+, Mg2+)
• Protein, lipid máu nếu nghi ngờ Na+ thấp giả

� PHƯƠNG PHÁP AN TOÀN:
• Bắt đầu với Deficit Formula nếu nghi ngờ Na+ thấp giả
• Chuyển sang Adrogue-Madias khi xác nhận Na+ thật
• Bù K+ nếu có hypokalemia
• Furosemide nếu nguy cơ quá tải dịch''';
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildInputCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Thông tin bệnh nhân',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(height: 16),
            
            // Cân nặng
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
              decoration: const InputDecoration(
                labelText: 'Cân nặng (kg) *',
                border: OutlineInputBorder(),
                suffixText: 'kg',
              ),
            ),
            const SizedBox(height: 16),
            
            // Giới tính và tuổi
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Giới tính'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: _selectedGender,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: ['Nam', 'Nữ'].map((gender) {
                          return DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tuổi'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<int>(
                        initialValue: _selectedAge,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: List.generate(80, (index) => 20 + index).map((age) {
                          return DropdownMenuItem(
                            value: age,
                            child: Text('$age tuổi'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedAge = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Na+ hiện tại
            TextField(
              controller: _currentNaController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
              decoration: const InputDecoration(
                labelText: 'Na+ hiện tại (mmol/L) *',
                border: OutlineInputBorder(),
                suffixText: 'mmol/L',
                helperText: 'Bình thường: 135-145 mmol/L',
              ),
            ),
            const SizedBox(height: 16),
            
            // Na+ mục tiêu
            TextField(
              controller: _targetNaController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
              decoration: const InputDecoration(
                labelText: 'Na+ mục tiêu (mmol/L) *',
                border: OutlineInputBorder(),
                suffixText: 'mmol/L',
                helperText: 'Không nên > 145 mmol/L',
              ),
            ),
            const SizedBox(height: 16),
            
            // Tăng glucose máu
            CheckboxListTile(
              title: const Text('Có tăng glucose máu'),
              value: _hasHyperglycemia,
              onChanged: (value) {
                setState(() {
                  _hasHyperglycemia = value!;
                });
              },
            ),
            
            if (_hasHyperglycemia) ...[
              const SizedBox(height: 8),
              TextField(
                controller: _currentGlucoseController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                decoration: const InputDecoration(
                  labelText: 'Glucose máu hiện tại (mg/dL)',
                  border: OutlineInputBorder(),
                  suffixText: 'mg/dL',
                ),
              ),
            ],
            
            const SizedBox(height: 16),
            
            // Thời gian khởi phát
            CheckboxListTile(
              title: const Text('Hạ natri cấp tính (<48h)'),
              value: _isAcuteHyponatremia,
              onChanged: (value) {
                setState(() {
                  _isAcuteHyponatremia = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    if (_totalBodyWater == null) return const SizedBox.shrink();

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kết quả tính toán',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildResultRow('Total Body Water (TBW)', '${_totalBodyWater!.toStringAsFixed(1)} L'),
            
            if (_hasHyperglycemia && _correctedNa != null)
              _buildResultRow('Na+ hiệu chỉnh theo glucose', '${_correctedNa!.toStringAsFixed(1)} mmol/L'),
            
            _buildResultRow('Na+ deficit', '${_naDeficit!.toStringAsFixed(1)} mmol'),
            
            const Divider(),
            Row(
              children: [
                const Icon(Icons.science, color: AppTheme.primaryBlue, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Phương pháp Adrogue-Madias (Khuyến nghị):',
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            _buildResultRow('NaCl 0.9% (Δ Na+ = ${((154 - _correctedNa!) / (_totalBodyWater! + 1)).toStringAsFixed(1)} mmol/L/L)', '${_nacl09Volume!.toStringAsFixed(0)} mL'),
            _buildResultRow('NaCl 3% (Δ Na+ = ${((513 - _correctedNa!) / (_totalBodyWater! + 1)).toStringAsFixed(1)} mmol/L/L)', '${_nacl3Volume!.toStringAsFixed(0)} mL'),
            
            const SizedBox(height: 12),
            
            const Divider(),
            Row(
              children: [
                const Icon(Icons.compare_arrows, color: Colors.orange, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Phương pháp Deficit (So sánh):',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            _buildResultRow('NaCl 0.9% (Deficit formula)', '${_nacl09VolumeDeficit!.toStringAsFixed(0)} mL'),
            _buildResultRow('NaCl 3% (Deficit formula)', '${_nacl3VolumeDeficit!.toStringAsFixed(0)} mL'),
            
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.warning_amber, color: Colors.orange, size: 16),
                      const SizedBox(width: 6),
                      const Text(
                        'CHÊNH LỆCH QUAN TRỌNG:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'NaCl 0.9%: ${(_nacl09Volume! - _nacl09VolumeDeficit!).toStringAsFixed(0)} mL khác biệt\n'
                    'NaCl 3%: ${(_nacl3Volume! - _nacl3VolumeDeficit!).toStringAsFixed(0)} mL khác biệt\n\n'
                    'Adrogue-Madias thường cho kết quả cao hơn do tính đến pha loãng.',
                    style: TextStyle(fontSize: 11, color: Colors.amber.shade800),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(
                'Adrogue-Madias: Δ Na+ = (Na+ dung dịch - Na+ huyết thanh) / (TBW + 1L)\n'
                'Deficit: Thể tích = Na+ deficit / nồng độ Na+ × 1000 mL',
                style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
              ),
            ),
            
            const Divider(),
            _buildResultRow('Tốc độ hiệu chỉnh tối đa', '${_maxCorrectionRate!.toStringAsFixed(1)} mmol/L/24h'),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(label),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlue,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard() {
    if (_recommendation.isEmpty) return const SizedBox.shrink();

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Khuyến nghị điều trị',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Text(
                _recommendation,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormulaCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Công thức tính toán',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(height: 16),
            _buildFormulaSection(
              'Total Body Water (TBW)',
              'Nam > 60 tuổi: Cân nặng × 0.5\n'
              'Nam ≤ 60 tuổi: Cân nặng × 0.6\n'
              'Nữ > 60 tuổi: Cân nặng × 0.45\n'
              'Nữ ≤ 60 tuổi: Cân nặng × 0.5\n\n'
              '📖 Tham khảo: Watson PE, Watson ID, Batt RD, 1980',
            ),
            _buildFormulaSection(
              'Hiệu chỉnh Na+ theo glucose',
              'Na+ hiệu chỉnh = Na+ đo + (Glucose - 100) / 100 × 1.6\n\n'
              '⚠️ Chỉ áp dụng khi glucose > 100 mg/dL\n'
              'Công thức Katz & Ma (1999): Mỗi 100 mg/dL tăng glucose\n'
              '→ Na+ giảm giả tạo 1.6 mmol/L\n\n'
              '📖 Tham khảo: Katz MA, 1973; Hillier et al., 1999',
            ),
            _buildFormulaSection(
              'Công thức Adrogue-Madias (CHÍNH THỐNG)',
              'Δ Na+ = (Na+ dung dịch - Na+ huyết thanh) / (TBW + 1)\n\n'
              'VÍ DỤ:\n'
              '• Na+ huyết thanh = 120 mmol/L, TBW = 40L\n'
              '• NaCl 3% (513 mmol/L): Δ = (513-120)/(40+1) = 9.6 mmol/L\n'
              '• NaCl 0.9% (154 mmol/L): Δ = (154-120)/(40+1) = 0.8 mmol/L\n\n'
              'Thể tích cần = Tăng mong muốn / Δ Na+ × 1000 mL\n\n'
              '⚠️ LƯU Ý: Công thức này tính chính xác hơn vì:\n'
              '• Tính đến sự pha loãng của dung dịch infusion\n'
              '• Tính đến thể tích dung dịch thêm vào\n'
              '• Phù hợp với thực tế lâm sàng\n\n'
              '📖 Tham khảo: Adrogue & Madias, NEJM 2000',
            ),
            _buildFormulaSection(
              'So sánh: Deficit vs Adrogue-Madias',
              'CÔNG THỨC DEFICIT (KHÔNG CHÍNH XÁC):\n'
              '• Na+ deficit = (Mục tiêu - Hiện tại) × TBW\n'
              '• Thể tích = Deficit / Nồng độ × 1000\n'
              '• SAI LẦM: Không tính pha loãng\n\n'
              'CÔNG THỨC ADROGUE-MADIAS (CHÍNH XÁC):\n'
              '• Δ Na+ = (Na+ dung dịch - Na+ máu) / (TBW + 1)\n'
              '• Thể tích = Tăng mong muốn / Δ Na+ × 1000\n'
              '• ĐÚNG: Tính cả pha loãng do dung dịch\n\n'
              'KẾT QUẢ: Adrogue-Madias cho thể tích CHÍNH XÁC hơn!',
            ),
            _buildFormulaSection(
              'Thể tích dung dịch',
              'NaCl 0.9% (Normal Saline): 154 mmol Na+/L\n'
              'NaCl 3% (Hypertonic Saline): 513 mmol Na+/L\n\n'
              'Thể tích = Na+ deficit / nồng độ Na+ × 1000 (mL)\n\n'
              '📖 Tham khảo: Composition of IV fluids, USP',
            ),
            _buildFormulaSection(
              'Tốc độ hiệu chỉnh an toàn (ESH/ESC 2018)',
              'Hạ natri cấp (<48h):\n'
              '• Có triệu chứng: 1-2 mmol/L/h x 3-4h đầu\n'
              '• Sau đó: <10 mmol/L/24h, <18 mmol/L/48h\n\n'
              'Hạ natri mạn (>48h):\n'
              '• Na+ <120 mmol/L: <10 mmol/L/24h\n'
              '• Na+ 120-129 mmol/L: <8 mmol/L/24h\n\n'
              '⚠️ NGUY CƠ: Osmotic Demyelination Syndrome\n'
              'Yếu tố nguy cơ cao: Nghiện rượu, suy dinh dưỡng,\n'
              'bệnh gan, hypokalemia\n\n'
              '📖 Tham khảo: ESH/ESC Guidelines 2018; Spasovski et al., 2014',
            ),
            _buildFormulaSection(
              'CẢNH BÁO: Na+ thấp giả (Pseudohyponatremia)',
              'NGUYÊN NHÂN Na+ thấp giả:\n'
              '• Hyperproteinemia (protein >100 g/L)\n'
              '• Hyperlipidemia (triglyceride >15 mmol/L)\n'
              '• Hyperglycemia nghiêm trọng (>55 mmol/L)\n\n'
              'PHƯƠNG PHÁP PHÁT HIỆN:\n'
              '• Đo Na+ bằng ISE trực tiếp (Direct ISE)\n'
              '• Tính osmolality: 2×(Na+ + K+) + glucose + urea\n'
              '• So sánh với osmolality đo trực tiếp\n\n'
              'CHIẾN LƯỢC AN TOÀN:\n'
              '• Nghi ngờ nếu: Protein cao, lipid cao, đái tháo đường\n'
              '• Bắt đầu với 50-70% thể tích Adrogue-Madias\n'
              '• Theo dõi Na+ mỗi 1-2h trong giai đoạn đầu\n'
              '• Kiểm tra lại bằng máy ISE trực tiếp\n\n'
              '🚨 NGUY CƠ: Bù quá mức → Hypernatremia → ODS\n\n'
              '📖 Tham khảo: Dimeski G, Clin Biochem 2012',
            ),
            _buildReferencesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormulaSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Text(
              content,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferencesSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tài liệu tham khảo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text(
                '1. Adrogue HJ, Madias NE. Hyponatremia. N Engl J Med. 2000;342(21):1581-1589.\n\n'
                '2. Spasovski G, Vanholder R, Allolio B, et al. Clinical practice guideline on diagnosis and treatment of hyponatraemia. Eur J Endocrinol. 2014;170(3):G1-47.\n\n'
                '3. Katz MA. Hyperglycemia-induced hyponatremia--calculation of expected serum sodium depression. N Engl J Med. 1973;289(16):843-844.\n\n'
                '4. Hillier TA, Abbott RD, Barrett EJ. Hyponatremia: evaluating the correction factor for hyperglycemia. Am J Med. 1999;106(4):399-403.\n\n'
                '5. Watson PE, Watson ID, Batt RD. Total body water volumes for adult males and females estimated from simple anthropometric measurements. Am J Clin Nutr. 1980;33(1):27-39.\n\n'
                '6. ESH/ESC Guidelines for the management of arterial hypertension. Eur Heart J. 2018;39(33):3021-3104.\n\n'
                '7. Verbalis JG, Goldsmith SR, Greenberg A, et al. Diagnosis, evaluation, and treatment of hyponatremia: expert panel recommendations. Am J Med. 2013;126(10 Suppl 1):S1-42.\n\n'
                '8. Sterns RH, Hix JK, Silver S. Management of hyponatremia in the ICU. Chest. 2013;144(2):672-679.',
                style: TextStyle(fontSize: 12, height: 1.4),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade300),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: Colors.orange,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'LƯU Ý QUAN TRỌNG:\n'
                      '• Công thức chỉ là ước tính ban đầu\n'
                      '• Cần theo dõi Na+ mỗi 2-4h và điều chỉnh\n'
                      '• Nguy cơ Osmotic Demyelination nếu hiệu chỉnh quá nhanh\n'
                      '• Luôn tuân thủ hướng dẫn lâm sàng địa phương',
                      style: TextStyle(fontSize: 12, height: 1.4),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Tính bù Natri máu'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInputCard(),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _calculateSodiumCorrection,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Tính toán bù Natri',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildResultCard(),
            const SizedBox(height: 16),
            _buildRecommendationCard(),
            const SizedBox(height: 16),
            _buildFormulaCard(),
            const SizedBox(height: 16),
            _buildReferencesSection(),
          ],
        ),
      ),
    );
  }
}
