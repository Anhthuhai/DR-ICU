import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class RaceScalePage extends StatefulWidget {
  const RaceScalePage({super.key});

  @override
  State<RaceScalePage> createState() => _RaceScalePageState();
}

class _RaceScalePageState extends State<RaceScalePage> {
  String _facialPalsy = '0';
  String _armMotor = '0';
  String _legMotor = '0';
  String _headEyeDeviation = '0';
  String _hemianeglect = '0';
  String _aphasia = '0';

  int _totalScore = 0;

  void _calculateScore() {
    int score = 0;
    
    score += int.parse(_facialPalsy);
    score += int.parse(_armMotor);
    score += int.parse(_legMotor);
    score += int.parse(_headEyeDeviation);
    score += int.parse(_hemianeglect);
    score += int.parse(_aphasia);

    setState(() {
      _totalScore = score;
    });
  }

  Color get riskColor {
    if (_totalScore < 5) {
      return Colors.green;
    }
    return Colors.red;
  }

  String get lvoLikelihood {
    if (_totalScore < 5) {
      return 'Thấp';
    }
    return 'Cao';
  }

  String get lvoProbability {
    if (_totalScore < 5) {
      return '< 10%';
    }
    return '≥ 85%';
  }

  String get recommendations {
    if (_totalScore < 5) {
      return 'Tiếp tục đánh giá đột quỵ thường quy, xem xét các nguyên nhân khác';
    }
    return 'Khả năng cao LVO - Cần chuyển tức thì đến trung tâm có EVT (endovascular therapy)';
  }

  String get timeTarget {
    if (_totalScore < 5) {
      return 'Thời gian tiêu chuẩn';
    }
    return 'Door-to-groin < 90 phút';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RACE Scale'),
        backgroundColor: Colors.purple.shade700,
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
                    'RACE Scale',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_totalScore/9',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'LVO likelihood: $lvoLikelihood',
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

            // Assessment Items
            _buildAssessmentSection(),

            // Risk Stratification
            _buildRiskStratification(),

            // Emergency Protocol
            if (_totalScore >= 5) _buildEmergencyProtocol(),

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
                    'Xác suất LVO',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    lvoProbability,
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
                    'Mục tiêu thời gian',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    timeTarget,
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

  Widget _buildAssessmentSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.shade300),
        color: Colors.purple.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Đánh giá RACE Scale',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Rapid Arterial oCclusion Evaluation',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.purple.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          
          // Facial Palsy
          _buildAssessmentItem(
            'Liệt mặt',
            'Yêu cầu bệnh nhân cười hoặc nhe răng',
            _facialPalsy,
            [
              {'value': '0', 'text': 'Không có'},
              {'value': '1', 'text': 'Liệt mặt nhẹ'},
              {'value': '2', 'text': 'Liệt mặt nặng'},
            ],
            (value) {
              setState(() {
                _facialPalsy = value;
              });
              _calculateScore();
            },
          ),
          
          // Arm Motor
          _buildAssessmentItem(
            'Vận động tay',
            'Giơ tay lên 90° trong 10 giây',
            _armMotor,
            [
              {'value': '0', 'text': 'Bình thường'},
              {'value': '1', 'text': 'Rơi nhẹ'},
              {'value': '2', 'text': 'Rơi nhanh hoặc không giơ được'},
            ],
            (value) {
              setState(() {
                _armMotor = value;
              });
              _calculateScore();
            },
          ),
          
          // Leg Motor
          _buildAssessmentItem(
            'Vận động chân',
            'Giơ chân lên 30° trong 5 giây',
            _legMotor,
            [
              {'value': '0', 'text': 'Bình thường'},
              {'value': '1', 'text': 'Rơi nhẹ'},
              {'value': '2', 'text': 'Rơi nhanh hoặc không giơ được'},
            ],
            (value) {
              setState(() {
                _legMotor = value;
              });
              _calculateScore();
            },
          ),
          
          // Head and Eye Deviation
          _buildAssessmentItem(
            'Lệch đầu và mắt',
            'Quan sát hướng nhìn và xoay đầu',
            _headEyeDeviation,
            [
              {'value': '0', 'text': 'Không có'},
              {'value': '1', 'text': 'Có lệch'},
            ],
            (value) {
              setState(() {
                _headEyeDeviation = value;
              });
              _calculateScore();
            },
          ),
          
          // Hemianeglect
          _buildAssessmentItem(
            'Hội chứng bỏ qua',
            'Đánh giá sự chú ý đến không gian bên trái',
            _hemianeglect,
            [
              {'value': '0', 'text': 'Bình thường'},
              {'value': '1', 'text': 'Có bỏ qua một bên'},
            ],
            (value) {
              setState(() {
                _hemianeglect = value;
              });
              _calculateScore();
            },
          ),
          
          // Aphasia
          _buildAssessmentItem(
            'Mất ngôn ngữ',
            'Đánh giá khả năng nói và hiểu',
            _aphasia,
            [
              {'value': '0', 'text': 'Bình thường'},
              {'value': '1', 'text': 'Mất ngôn ngữ nhẹ'},
              {'value': '2', 'text': 'Mất ngôn ngữ nặng'},
            ],
            (value) {
              setState(() {
                _aphasia = value;
              });
              _calculateScore();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentItem(
    String title,
    String instruction,
    String currentValue,
    List<Map<String, String>> options,
    Function(String) onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            instruction,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          ...options.map((option) => RadioListTile<String>(
            title: Text(option['text']!),
            value: option['value']!,
            // ignore: deprecated_member_use
            groupValue: currentValue,
            // ignore: deprecated_member_use
            onChanged: (value) => onChanged(value!),
            contentPadding: EdgeInsets.zero,
            dense: true,
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
        border: Border.all(color: Colors.blue.shade300),
        color: Colors.blue.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phân tầng nguy cơ LVO',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('0-4', 'Thấp', '< 10%', 'Đột quỵ thường quy', Colors.green),
          _buildRiskItem('≥5', 'Cao', '≥ 85%', 'Chuyển EVT center', Colors.red),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String risk, String probability, String action, Color color) {
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
                  risk,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  probability,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color,
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

  Widget _buildEmergencyProtocol() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade300),
        color: Colors.red.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: Colors.red.shade700),
              const SizedBox(width: 8),
              Text(
                'Protocol LVO khẩn cấp',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildProtocolItem('1. Kích hoạt stroke code', 'Thông báo team đột quỵ ngay lập tức', Icons.phone),
          _buildProtocolItem('2. CT/CTA khẩn cấp', 'Chụp CT và CTA trong 20 phút', Icons.scanner),
          _buildProtocolItem('3. Chuyển EVT center', 'Liên hệ trung tâm can thiệp mạch máu não', Icons.local_hospital),
          _buildProtocolItem('4. IV tPA (nếu đủ điều kiện)', 'Thrombolysis tĩnh mạch trước khi chuyển', Icons.medication),
          _buildProtocolItem('5. Door-to-groin <90 phút', 'Mục tiêu từ vào viện đến EVT', Icons.timer),
        ],
      ),
    );
  }

  Widget _buildProtocolItem(String title, String description, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.red.shade600, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  description,
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
            'RACE Scale nhận diện nhanh Large Vessel Occlusion (LVO) stroke\n\n'
            'Mục đích:\n'
            '• Sàng lọc bệnh nhân cần EVT (endovascular therapy)\n'
            '• Tối ưu hóa thời gian "time is brain"\n'
            '• Quyết định chuyển viện\n'
            '• Cải thiện kết quả điều trị\n\n'
            'LVO là gì:\n'
            '• Tắc mạch máu não lớn (ICA, M1, M2, basilar)\n'
            '• Chiếm 24-46% đột quỵ thiếu máu não cấp\n'
            '• Tiên lượng xấu nếu không can thiệp\n'
            '• Đáp ứng tốt với EVT trong 24 giờ\n\n'
            'Ưu điểm RACE:\n'
            '• Đơn giản, nhanh chóng\n'
            '• Độ nhạy 85%, độ đặc hiệu 68%\n'
            '• Có thể thực hiện ngoài viện\n'
            '• Giúp triage hiệu quả\n\n'
            'Cách thực hiện:\n'
            '• Đánh giá 6 thành phần\n'
            '• Tổng điểm 0-9\n'
            '• ≥5 điểm: khả năng cao LVO\n'
            '• Cần kết hợp với NIHSS\n\n'
            'Lưu ý quan trọng:\n'
            '• Không thay thế đánh giá neurologic đầy đủ\n'
            '• Cần imaging xác nhận LVO\n'
            '• Time window quan trọng cho EVT\n'
            '• Kết hợp với IV tPA nếu phù hợp',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
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
            'Pérez de la Ossa N, et al. Design and validation of a prehospital stroke scale to predict large arterial occlusion: the rapid arterial occlusion evaluation (RACE) scale. Stroke. 2014;45(1):87-91.\n\nCarrera D, et al. Validation of computer-assisted RACE scale for prehospital use. Stroke. 2018;49(5):1255-7.',
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
