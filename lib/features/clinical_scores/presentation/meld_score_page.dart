import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../core/theme/app_theme.dart';

class MeldScorePage extends StatefulWidget {
  const MeldScorePage({super.key});

  @override
  State<MeldScorePage> createState() => _MeldScorePageState();
}

class _MeldScorePageState extends State<MeldScorePage> {
  final TextEditingController _creatinineController = TextEditingController();
  final TextEditingController _bilirubinController = TextEditingController();
  final TextEditingController _inrController = TextEditingController();

  bool _dialysis = false;

  double _meldScore = 0.0;

  @override
  void initState() {
    super.initState();
    _creatinineController.addListener(_calculateScore);
    _bilirubinController.addListener(_calculateScore);
    _inrController.addListener(_calculateScore);
  }

  void _calculateScore() {
    final creatinine = double.tryParse(_creatinineController.text) ?? 0;
    final bilirubin = double.tryParse(_bilirubinController.text) ?? 0;
    final inr = double.tryParse(_inrController.text) ?? 0;

    if (creatinine > 0 && bilirubin > 0 && inr > 0) {
      // MELD = 3.78 × ln(serum bilirubin mg/dL) + 11.2 × ln(INR) + 9.57 × ln(serum creatinine mg/dL) + 6.43
      
      double adjustedCreatinine = creatinine;
      
      // If dialysis, creatinine is set to 4.0
      if (_dialysis) {
        adjustedCreatinine = 4.0;
      } else {
        // Maximum creatinine value is 4.0
        adjustedCreatinine = math.min(creatinine, 4.0);
      }
      
      // Minimum values
      adjustedCreatinine = math.max(adjustedCreatinine, 1.0);
      final adjustedBilirubin = math.max(bilirubin, 1.0);
      final adjustedInr = math.max(inr, 1.0);

      double score = 3.78 * math.log(adjustedBilirubin) + 
                     11.2 * math.log(adjustedInr) + 
                     9.57 * math.log(adjustedCreatinine) + 
                     6.43;

      // Round to nearest integer
      score = (score * 10).round() / 10;
      
      // Minimum MELD score is 6
      score = math.max(score, 6.0);
      
      // Maximum MELD score is 40
      score = math.min(score, 40.0);

      setState(() {
        _meldScore = score;
      });
    } else {
      setState(() {
        _meldScore = 0.0;
      });
    }
  }

  Color get riskColor {
    if (_meldScore < 10) {
      return Colors.green;
    }
    if (_meldScore < 15) {
      return Colors.yellow.shade700;
    }
    if (_meldScore < 20) {
      return Colors.orange;
    }
    if (_meldScore < 25) {
      return Colors.red.shade600;
    }
    return Colors.red.shade900;
  }

  String get riskLevel {
    if (_meldScore < 10) {
      return 'Thấp';
    }
    if (_meldScore < 15) {
      return 'Trung bình thấp';
    }
    if (_meldScore < 20) {
      return 'Trung bình';
    }
    if (_meldScore < 25) {
      return 'Cao';
    }
    return 'Rất cao';
  }

  String get mortalityRisk3Month {
    if (_meldScore < 10) {
      return '1.9%';
    }
    if (_meldScore < 15) {
      return '6.0%';
    }
    if (_meldScore < 20) {
      return '19.6%';
    }
    if (_meldScore < 25) {
      return '76.0%';
    }
    return '>90%';
  }

  String get transplantPriority {
    if (_meldScore < 15) {
      return 'Ưu tiên thấp';
    }
    if (_meldScore < 25) {
      return 'Ưu tiên trung bình';
    }
    return 'Ưu tiên cao';
  }

  String get recommendations {
    if (_meldScore < 10) {
      return 'Theo dõi định kỳ, quản lý biến chứng xơ gan';
    }
    if (_meldScore < 15) {
      return 'Đánh giá ghép gan, tầm soát biến chứng';
    }
    if (_meldScore < 20) {
      return 'Đưa vào danh sách chờ ghép gan';
    }
    if (_meldScore < 25) {
      return 'Ưu tiên cao ghép gan, theo dõi chặt chẽ';
    }
    return 'Cần ghép gan khẩn cấp, xem xét ICU';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MELD Score'),
        backgroundColor: Colors.brown.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Score Display
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: riskColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: riskColor.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    'MELD Score',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _meldScore > 0 ? _meldScore.toStringAsFixed(1) : '0',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nguy cơ $riskLevel',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildRiskInfo(),
                ],
              ),
            ),

            // Input Parameters
            _buildInputSection(),

            // Risk Stratification
            _buildRiskStratification(),

            // Transplant Guidelines
            _buildTransplantGuidelines(),

            // Clinical Information
            _buildClinicalInfo(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'Tử vong 3 tháng',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    mortalityRisk3Month,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: riskColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Ưu tiên ghép gan',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    transplantPriority,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: riskColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: riskColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: riskColor.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.assignment, color: riskColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Khuyến nghị:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  recommendations,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.darkGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.brown.shade300),
        color: Colors.brown.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông số MELD',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.brown.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          TextField(
            controller: _creatinineController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Creatinine',
              suffixText: 'mg/dL',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: 'Tối đa 4.0 mg/dL, tối thiểu 1.0 mg/dL',
            ),
          ),
          const SizedBox(height: 12),
          
          TextField(
            controller: _bilirubinController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Bilirubin',
              suffixText: 'mg/dL',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: 'Bilirubin toàn phần, tối thiểu 1.0 mg/dL',
            ),
          ),
          const SizedBox(height: 12),
          
          TextField(
            controller: _inrController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'INR',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: 'International Normalized Ratio, tối thiểu 1.0',
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            title: const Text('Chạy thận'),
            subtitle: const Text('Đã chạy thận ít nhất 2 lần trong tuần qua hoặc CVVHD 24h'),
            value: _dialysis,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _dialysis = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildRiskStratification() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade300),
        color: Colors.blue.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phân tầng nguy cơ MELD',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('<10', 'Thấp', '1.9%', 'Theo dõi định kỳ', Colors.green),
          _buildRiskItem('10-14', 'Trung bình thấp', '6.0%', 'Đánh giá ghép gan', Colors.yellow.shade700),
          _buildRiskItem('15-19', 'Trung bình', '19.6%', 'Danh sách chờ', Colors.orange),
          _buildRiskItem('20-24', 'Cao', '76.0%', 'Ưu tiên cao', Colors.red.shade600),
          _buildRiskItem('≥25', 'Rất cao', '>90%', 'Ghép khẩn cấp', Colors.red.shade900),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String risk, String mortality, String action, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                child: Text(
                  score,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  risk,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  mortality,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            action,
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransplantGuidelines() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade300),
        color: Colors.green.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hướng dẫn ghép gan',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildGuidelineCard(
            'MELD <15: Theo dõi',
            [
              'Khám định kỳ 6 tháng',
              'Siêu âm gan 6 tháng',
              'AFP mỗi 6 tháng',
              'Tầm soát biến chứng',
            ],
            Colors.green,
          ),
          const SizedBox(height: 12),
          _buildGuidelineCard(
            'MELD 15-24: Danh sách chờ',
            [
              'Đưa vào danh sách chờ ghép',
              'Đánh giá toàn diện',
              'Theo dõi 3 tháng',
              'Tầm soát ung thư gan',
            ],
            Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildGuidelineCard(
            'MELD ≥25: Ưu tiên cao',
            [
              'Ưu tiên cao ghép gan',
              'Theo dõi hàng tuần',
              'Cân nhắc ghép sống',
              'Hỗ trợ tích cực',
            ],
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildGuidelineCard(String title, List<String> items, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.medical_services, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(left: 28, bottom: 4),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildClinicalInfo() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.teal.shade50,
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.teal.shade600),
              const SizedBox(width: 8),
              Text(
                'Thông tin lâm sàng',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'MELD Score đánh giá mức độ nặng bệnh gan giai đoạn cuối\n\n'
            'Công thức MELD:\n'
            '3.78 × ln(bilirubin) + 11.2 × ln(INR) + 9.57 × ln(creatinine) + 6.43\n\n'
            'Các điều chỉnh:\n'
            '• Creatinine: tối thiểu 1.0, tối đa 4.0 mg/dL\n'
            '• Nếu chạy thận: creatinine = 4.0 mg/dL\n'
            '• Bilirubin và INR: tối thiểu 1.0\n'
            '• Điểm MELD: tối thiểu 6, tối đa 40\n\n'
            'Ứng dụng lâm sàng:\n'
            '• Ưu tiên ghép gan theo UNOS\n'
            '• Dự đoán tử vong ngắn hạn\n'
            '• Quyết định can thiệp\n'
            '• Theo dõi tiến triển bệnh\n\n'
            'MELD-Na (cải tiến):\n'
            '• Bổ sung natri huyết thanh\n'
            '• Cải thiện độ chính xác\n'
            '• Sử dụng rộng rãi hiện nay\n\n'
            'Ngoại lệ ưu tiên:\n'
            '• Ung thư gan (HCC)\n'
            '• Bệnh gan fulminant\n'
            '• Các bệnh hiếm gặp\n'
            '• Tình trạng đặc biệt\n\n'
            'Hạn chế:\n'
            '• Không bao gồm biến chứng\n'
            '• Thay đổi theo thời gian\n'
            '• Cần đánh giá tổng thể\n'
            '• Không dự đoán chức năng sau ghép',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _creatinineController.dispose();
    _bilirubinController.dispose();
    _inrController.dispose();
    super.dispose();
  }
}
