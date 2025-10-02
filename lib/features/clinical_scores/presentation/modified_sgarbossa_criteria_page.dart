import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ModifiedSgarbossaCriteriaPage extends StatefulWidget {
  const ModifiedSgarbossaCriteriaPage({super.key});

  @override
  State<ModifiedSgarbossaCriteriaPage> createState() => _ModifiedSgarbossaCriteriaPageState();
}

class _ModifiedSgarbossaCriteriaPageState extends State<ModifiedSgarbossaCriteriaPage> {
  bool _concordantStElevation = false;
  bool _concordantStDepression = false;
  bool _excessiveDiscordantStElevation = false;

  int _totalScore = 0;

  void _calculateScore() {
    int score = 0;
    
    if (_concordantStElevation) {
      score += 5;
    }
    if (_concordantStDepression) {
      score += 3;
    }
    if (_excessiveDiscordantStElevation) {
      score += 2;
    }

    setState(() {
      _totalScore = score;
    });
  }

  Color get riskColor {
    if (_totalScore == 0) {
      return Colors.green;
    }
    if (_totalScore < 3) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String get interpretation {
    if (_totalScore == 0) {
      return 'Không có tiêu chí dương tính';
    }
    if (_totalScore < 3) {
      return 'Nghi ngờ STEMI';
    }
    return 'Rất khả năng STEMI';
  }

  String get recommendation {
    if (_totalScore == 0) {
      return 'Tiếp tục theo dõi, xem xét các nguyên nhân khác của đau ngực';
    }
    if (_totalScore < 3) {
      return 'Cần đánh giá thêm: Troponin, Echo, theo dõi EKG liên tục';
    }
    return 'STEMI rất khả năng - Cần tái thông mạch vành khẩn cấp (PCI hoặc thrombolysis)';
  }

  String get clinicalAction {
    if (_totalScore == 0) {
      return 'Loại trừ STEMI';
    }
    if (_totalScore < 3) {
      return 'Đánh giá thêm';
    }
    return 'Tái thông mạch khẩn cấp';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modified Sgarbossa\'s Criteria'),
        backgroundColor: Colors.red.shade700,
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
                    'Modified Sgarbossa\'s',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_totalScore điểm',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    interpretation,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  _buildResultInfo(),
                ],
              ),
            ),

            // Criteria Section
            _buildCriteriaSection(),

            // Active Criteria
            if (_totalScore > 0) _buildActiveCriteria(),

            // Interpretation Guide
            _buildInterpretationGuide(),

            // Clinical Information
            _buildClinicalInfo(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildResultInfo() {
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
                    'Hành động',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    clinicalAction,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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
                  recommendation,
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

  Widget _buildCriteriaSection() {
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
            'Tiêu chí Sgarbossa cải tiến',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Đánh giá STEMI trên nền LBBB hoặc nhịp tim máy',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.blue.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            title: const Text('ST elevation đồng hướng (+5)'),
            subtitle: const Text('ST elevation ≥1mm ở lead có QRS dương'),
            value: _concordantStElevation,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _concordantStElevation = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('ST depression đồng hướng (+3)'),
            subtitle: const Text('ST depression ≥1mm ở V1, V2, hoặc V3'),
            value: _concordantStDepression,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _concordantStDepression = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('ST elevation ngược hướng quá mức (+2)'),
            subtitle: const Text('ST elevation ≥1mm và tỷ lệ ST/S ≥0.25'),
            value: _excessiveDiscordantStElevation,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _excessiveDiscordantStElevation = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCriteria() {
    List<Map<String, dynamic>> activeCriteria = [];
    
    if (_concordantStElevation) {
      activeCriteria.add({
        'criterion': 'ST elevation đồng hướng',
        'description': 'ST elevation ≥1mm ở lead có QRS dương',
        'points': 5,
      });
    }
    
    if (_concordantStDepression) {
      activeCriteria.add({
        'criterion': 'ST depression đồng hướng',
        'description': 'ST depression ≥1mm ở V1, V2, hoặc V3',
        'points': 3,
      });
    }
    
    if (_excessiveDiscordantStElevation) {
      activeCriteria.add({
        'criterion': 'ST elevation ngược hướng quá mức',
        'description': 'ST elevation ≥1mm và tỷ lệ ST/S ≥0.25',
        'points': 2,
      });
    }
    
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
            'Tiêu chí dương tính (${activeCriteria.length})',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
          ),
          const SizedBox(height: 12),
          ...activeCriteria.map((criterion) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 24,
                  decoration: BoxDecoration(
                    color: riskColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      '+${criterion['points']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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
                        criterion['criterion'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        criterion['description'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildInterpretationGuide() {
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
            'Hướng dẫn giải thích',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildInterpretationItem('0 điểm', 'Không có tiêu chí', 'Loại trừ STEMI', Colors.green),
          _buildInterpretationItem('1-2 điểm', 'Nghi ngờ STEMI', 'Đánh giá thêm', Colors.orange),
          _buildInterpretationItem('≥3 điểm', 'Rất khả năng STEMI', 'Tái thông mạch khẩn cấp', Colors.red),
        ],
      ),
    );
  }

  Widget _buildInterpretationItem(String score, String interpretation, String action, Color color) {
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
                width: 60,
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
                  interpretation,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  action,
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
            'Modified Sgarbossa\'s Criteria giúp chẩn đoán STEMI khi có LBBB hoặc nhịp tim máy\n\n'
            'Vấn đề lâm sàng:\n'
            '• LBBB che giấu dấu hiệu STEMI trên EKG\n'
            '• Nhịp tim máy gây khó khăn đánh giá ST\n'
            '• Cần tiêu chí đặc biệt để chẩn đoán\n'
            '• Delay chẩn đoán → delay tái thông mạch\n\n'
            'Tiêu chí gốc (Sgarbossa 1996):\n'
            '• ST elevation đồng hướng ≥1mm (+5)\n'
            '• ST depression đồng hướng ≥1mm ở V1-V3 (+3)\n'
            '• ST elevation ngược hướng ≥5mm (+2)\n\n'
            'Cải tiến (Smith 2012):\n'
            '• Thay đổi tiêu chí thứ 3\n'
            '• ST elevation ngược hướng với tỷ lệ ST/S ≥0.25\n'
            '• Tăng độ nhạy từ 52% lên 91%\n'
            '• Độ đặc hiệu vẫn cao 90%\n\n'
            'Cách đo tỷ lệ ST/S:\n'
            '• Đo độ cao ST elevation (mm)\n'
            '• Đo độ sâu sóng S (mm)\n'
            '• Tính tỷ lệ ST/S\n'
            '• Dương tính nếu ≥0.25\n\n'
            'Lưu ý quan trọng:\n'
            '• Chỉ áp dụng khi có LBBB hoặc nhịp tim máy\n'
            '• Kết hợp với triệu chứng lâm sàng\n'
            '• Troponin vẫn cần thiết\n'
            '• Thời gian là vàng trong STEMI',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }
}
