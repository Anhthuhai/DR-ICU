import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SurgicalApgarScorePage extends StatefulWidget {
  const SurgicalApgarScorePage({super.key});

  @override
  State<SurgicalApgarScorePage> createState() => _SurgicalApgarScorePageState();
}

class _SurgicalApgarScorePageState extends State<SurgicalApgarScorePage> {
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _bloodPressureController = TextEditingController();
  final TextEditingController _bloodLossController = TextEditingController();

  int _heartRateScore = 0;
  int _bloodPressureScore = 0;
  int _bloodLossScore = 0;
  int _totalScore = 0;

  @override
  void initState() {
    super.initState();
    _heartRateController.addListener(_calculateScore);
    _bloodPressureController.addListener(_calculateScore);
    _bloodLossController.addListener(_calculateScore);
  }

  void _calculateScore() {
    final heartRate = int.tryParse(_heartRateController.text) ?? 0;
    final bloodPressure = int.tryParse(_bloodPressureController.text) ?? 0;
    final bloodLoss = int.tryParse(_bloodLossController.text) ?? 0;

    // Heart Rate Score
    if (heartRate >= 56) {
      _heartRateScore = 2;
    } else if (heartRate >= 40) {
      _heartRateScore = 1;
    } else {
      _heartRateScore = 0;
    }

    // Mean Arterial Pressure Score
    if (bloodPressure >= 70) {
      _bloodPressureScore = 2;
    } else if (bloodPressure >= 40) {
      _bloodPressureScore = 1;
    } else {
      _bloodPressureScore = 0;
    }

    // Blood Loss Score (mL/kg)
    if (bloodLoss <= 10) {
      _bloodLossScore = 2;
    } else if (bloodLoss <= 40) {
      _bloodLossScore = 1;
    } else {
      _bloodLossScore = 0;
    }

    setState(() {
      _totalScore = _heartRateScore + _bloodPressureScore + _bloodLossScore;
    });
  }

  Color get riskColor {
    if (_totalScore >= 7) {
      return Colors.green;
    }
    if (_totalScore >= 5) {
      return Colors.yellow.shade700;
    }
    if (_totalScore >= 3) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String get riskLevel {
    if (_totalScore >= 7) {
      return 'Thấp';
    }
    if (_totalScore >= 5) {
      return 'Trung bình thấp';
    }
    if (_totalScore >= 3) {
      return 'Trung bình cao';
    }
    return 'Cao';
  }

  String get complicationRisk {
    if (_totalScore >= 7) {
      return '5.0%';
    }
    if (_totalScore >= 5) {
      return '15.0%';
    }
    if (_totalScore >= 3) {
      return '30.0%';
    }
    return '60.0%';
  }

  String get mortalityRisk {
    if (_totalScore >= 7) {
      return '0.5%';
    }
    if (_totalScore >= 5) {
      return '1.5%';
    }
    if (_totalScore >= 3) {
      return '5.0%';
    }
    return '15.0%';
  }

  String get recommendations {
    if (_totalScore >= 7) {
      return 'Theo dõi tiêu chuẩn, tiên lượng tốt';
    }
    if (_totalScore >= 5) {
      return 'Theo dõi chặt chẽ, dự phòng biến chứng';
    }
    if (_totalScore >= 3) {
      return 'Theo dõi tích cực, chuẩn bị can thiệp';
    }
    return 'Theo dõi đặc biệt, nguy cơ cao biến chứng';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Main AppBar (sticky)
          SliverAppBar(
            pinned: true,
            title: const Text('Surgical Apgar Score'),
            backgroundColor: Colors.teal.shade700,
            foregroundColor: Colors.white,
          ),
          
          // Score Display Header (sticky)
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            backgroundColor: riskColor.withValues(alpha: 0.1),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: riskColor.withValues(alpha: 0.1),
                border: Border(
                  bottom: BorderSide(color: riskColor.withValues(alpha: 0.3)),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Surgical Apgar Score',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: riskColor,
                            ),
                          ),
                          Text(
                            'Nguy cơ $riskLevel',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.darkGrey,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '$_totalScore/6',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: riskColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Risk Info
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: riskColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: riskColor.withValues(alpha: 0.3)),
                  ),
                  child: _buildRiskInfo(),
                ),

                // Input Parameters
                _buildInputSection(),

                // Score Breakdown
                _buildScoreBreakdown(),

                // Risk Stratification
                _buildRiskStratification(),

                // Clinical Guidelines
                _buildClinicalGuidelines(),

                // Clinical Information
                _buildClinicalInfo(),

                // Medical Citation
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildCitationWidget(),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskInfo() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
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
                    'Biến chứng',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    complicationRisk,
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
                    'Tử vong',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    mortalityRisk,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: riskColor,
                    ),
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
        border: Border.all(color: Colors.teal.shade300),
        color: Colors.teal.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông số phẫu thuật',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          TextField(
            controller: _heartRateController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Nhịp tim thấp nhất',
              suffixText: 'lần/phút',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: 'Nhịp tim thấp nhất trong mổ',
            ),
          ),
          const SizedBox(height: 12),
          
          TextField(
            controller: _bloodPressureController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Huyết áp trung bình thấp nhất',
              suffixText: 'mmHg',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: 'MAP thấp nhất trong mổ',
            ),
          ),
          const SizedBox(height: 12),
          
          TextField(
            controller: _bloodLossController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Mất máu ước tính',
              suffixText: 'mL/kg',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: 'Tổng lượng máu mất / cân nặng',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreBreakdown() {
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
            'Chi tiết điểm số',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildParameterScore(
            'Nhịp tim thấp nhất',
            _heartRateScore,
            [
              '≥56 lần/phút: 2 điểm',
              '40-55 lần/phút: 1 điểm',
              '<40 lần/phút: 0 điểm',
            ],
          ),
          const SizedBox(height: 12),
          
          _buildParameterScore(
            'MAP thấp nhất',
            _bloodPressureScore,
            [
              '≥70 mmHg: 2 điểm',
              '40-69 mmHg: 1 điểm',
              '<40 mmHg: 0 điểm',
            ],
          ),
          const SizedBox(height: 12),
          
          _buildParameterScore(
            'Mất máu ước tính',
            _bloodLossScore,
            [
              '≤10 mL/kg: 2 điểm',
              '11-40 mL/kg: 1 điểm',
              '>40 mL/kg: 0 điểm',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildParameterScore(String title, int score, List<String> criteria) {
    Color scoreColor = score == 2 ? Colors.green : 
                      score == 1 ? Colors.orange : Colors.red;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scoreColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: scoreColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: scoreColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: scoreColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$score điểm',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...criteria.map((criterion) => Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              '• $criterion',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
            ),
          )),
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
        border: Border.all(color: Colors.orange.shade300),
        color: Colors.orange.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phân tầng nguy cơ',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('7-6', 'Thấp', '5.0%', '0.5%', 'Theo dõi tiêu chuẩn', Colors.green),
          _buildRiskItem('5-4', 'Trung bình thấp', '15.0%', '1.5%', 'Theo dõi chặt chẽ', Colors.yellow.shade700),
          _buildRiskItem('3-2', 'Trung bình cao', '30.0%', '5.0%', 'Theo dõi tích cực', Colors.orange),
          _buildRiskItem('1-0', 'Cao', '60.0%', '15.0%', 'Theo dõi đặc biệt', Colors.red),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String level, String complication, String mortality, String management, Color color) {
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
                width: 40,
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
                  level,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  complication,
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
          Row(
            children: [
              Container(width: 40),
              Expanded(
                child: Text(
                  'Tử vong: $mortality',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(width: 40),
              Expanded(
                child: Text(
                  management,
                  style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClinicalGuidelines() {
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
            'Hướng dẫn lâm sàng',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildGuidelineCard(
            'Điểm 6-7: Nguy cơ thấp',
            [
              'Theo dõi hậu phẫu tiêu chuẩn',
              'Xuất viện sớm nếu phù hợp',
              'Theo dõi ngoại trú thông thường',
              'Tiên lượng tốt',
            ],
            Colors.green,
          ),
          const SizedBox(height: 12),
          _buildGuidelineCard(
            'Điểm 4-5: Nguy cơ trung bình',
            [
              'Theo dõi chặt chẽ 24-48h',
              'Tầm soát biến chứng sớm',
              'Cân nhắc theo dõi đặc biệt',
              'Tư vấn gia đình về nguy cơ',
            ],
            Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildGuidelineCard(
            'Điểm ≤3: Nguy cơ cao',
            [
              'Theo dõi ICU/HDU',
              'Tầm soát biến chứng tích cực',
              'Hỗ trợ đa cơ quan nếu cần',
              'Tư vấn chi tiết về tiên lượng',
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
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Text(
                'Thông tin lâm sàng',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Surgical Apgar Score đánh giá nguy cơ biến chứng hậu phẫu\n\n'
            'Ba thông số chính:\n'
            '• Nhịp tim thấp nhất trong mổ\n'
            '• Huyết áp trung bình thấp nhất\n'
            '• Lượng máu mất ước tính\n\n'
            'Thời điểm đánh giá:\n'
            '• Kết thúc phẫu thuật\n'
            '• Trước khi chuyển phòng hồi sức\n'
            '• Ghi nhận trong hồ sơ phẫu thuật\n\n'
            'Ứng dụng lâm sàng:\n'
            '• Dự đoán biến chứng sớm\n'
            '• Quyết định mức độ theo dõi\n'
            '• Tư vấn gia đình\n'
            '• Cải thiện chất lượng\n\n'
            'Biến chứng thường gặp:\n'
            '• Nhiễm trùng vết mổ\n'
            '• Rò khâm phẫu\n'
            '• Suy hô hấp\n'
            '• Suy tim\n'
            '• Tắc mạch\n\n'
            'Ưu điểm:\n'
            '• Đơn giản, dễ tính\n'
            '• Có ngay sau mổ\n'
            '• Độ tin cậy cao\n'
            '• Ứng dụng rộng rãi\n\n'
            'Hạn chế:\n'
            '• Không dự đoán biến chứng muộn\n'
            '• Phụ thuộc ghi nhận chính xác\n'
            '• Cần kết hợp đánh giá khác\n'
            '• Thay đổi theo loại phẫu thuật',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _heartRateController.dispose();
    _bloodPressureController.dispose();
    _bloodLossController.dispose();
    super.dispose();
  }

  Widget _buildCitationWidget() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.article, color: Colors.blue.shade700, size: 16),
              const SizedBox(width: 6),
              Text(
                'Tài liệu tham khảo',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Gawande AA, et al. An Apgar score for surgery. J Am Coll Surg. 2007;204(2):201-8.\n\nRegenbogen SE, et al. The intraoperative Surgical Apgar Score predicts postoperative complications in patients undergoing pancreaticoduodenectomy. J Gastrointest Surg. 2008;12(11):2031-9.',
            style: TextStyle(
              fontSize: 11,
              color: Colors.blue.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
