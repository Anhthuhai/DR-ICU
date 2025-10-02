import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class NihssPage extends StatefulWidget {
  const NihssPage({super.key});

  @override
  State<NihssPage> createState() => _NihssPageState();
}

class _NihssPageState extends State<NihssPage> {
  Map<String, int> scores = {
    'consciousness': 0,
    'questions': 0,
    'commands': 0,
    'gaze': 0,
    'visual': 0,
    'facial': 0,
    'leftArm': 0,
    'rightArm': 0,
    'leftLeg': 0,
    'rightLeg': 0,
    'ataxia': 0,
    'sensory': 0,
    'language': 0,
    'dysarthria': 0,
    'extinction': 0,
  };

  int get totalScore => scores.values.fold(0, (sum, score) => sum + score);

  Color get severityColor {
    if (totalScore <= 4) {
      return Colors.green;
    }
    if (totalScore <= 15) {
      return Colors.orange;
    }
    if (totalScore <= 20) {
      return Colors.red;
    }
    return Colors.red.shade800;
  }

  String get severity {
    if (totalScore <= 4) {
      return 'Đột quỵ nhẹ';
    }
    if (totalScore <= 15) {
      return 'Đột quỵ vừa';
    }
    if (totalScore <= 20) {
      return 'Đột quỵ nặng';
    }
    return 'Đột quỵ rất nặng';
  }

  String get prognosis {
    if (totalScore <= 4) {
      return 'Tiên lượng tốt, hồi phục cao';
    }
    if (totalScore <= 15) {
      return 'Tiên lượng khá, cần phục hồi chức năng';
    }
    if (totalScore <= 20) {
      return 'Tiên lượng xấu, phụ thuộc nặng';
    }
    return 'Tiên lượng rất xấu, tử vong cao';
  }

  String get recommendations {
    if (totalScore <= 4) {
      return 'Điều trị nội khoa, phục hồi chức năng sớm';
    }
    if (totalScore <= 15) {
      return 'Cân nhắc can thiệp mạch máu, phục hồi chức năng tích cực';
    }
    if (totalScore <= 20) {
      return 'Can thiệp tích cực nếu trong golden time, ICU monitoring';
    }
    return 'Điều trị hỗ trợ, cân nhắc giới hạn điều trị';
  }

  List<Map<String, dynamic>> get nihssItems {
    return [
      {
        'key': 'consciousness',
        'title': '1a. Ý thức',
        'options': [
          {'value': 0, 'text': 'Tỉnh táo'},
          {'value': 1, 'text': 'Lơ mơ nhưng kích thích được'},
          {'value': 2, 'text': 'Hôn mê, cần kích thích liên tục'},
          {'value': 3, 'text': 'Hôn mê sâu'},
        ],
      },
      {
        'key': 'questions',
        'title': '1b. Trả lời câu hỏi (tháng hiện tại, tuổi)',
        'options': [
          {'value': 0, 'text': 'Trả lời đúng cả 2 câu'},
          {'value': 1, 'text': 'Trả lời đúng 1 câu'},
          {'value': 2, 'text': 'Không trả lời đúng câu nào'},
        ],
      },
      {
        'key': 'commands',
        'title': '1c. Thực hiện lệnh (mở/nhắm mắt, nắm/mở bàn tay)',
        'options': [
          {'value': 0, 'text': 'Thực hiện đúng cả 2 lệnh'},
          {'value': 1, 'text': 'Thực hiện đúng 1 lệnh'},
          {'value': 2, 'text': 'Không thực hiện đúng lệnh nào'},
        ],
      },
      {
        'key': 'gaze',
        'title': '2. Vận nhãn (nhìn theo ngón tay)',
        'options': [
          {'value': 0, 'text': 'Bình thường'},
          {'value': 1, 'text': 'Liệt nhìn một phần'},
          {'value': 2, 'text': 'Liệt nhìn hoàn toàn'},
        ],
      },
      {
        'key': 'visual',
        'title': '3. Trường nhìn',
        'options': [
          {'value': 0, 'text': 'Không khiếm khuyết'},
          {'value': 1, 'text': 'Khiếm khuyết 1/4 trường nhìn'},
          {'value': 2, 'text': 'Khiếm khuyết nửa trường nhìn'},
          {'value': 3, 'text': 'Mù hoàn toàn'},
        ],
      },
      {
        'key': 'facial',
        'title': '4. Liệt mặt',
        'options': [
          {'value': 0, 'text': 'Bình thường'},
          {'value': 1, 'text': 'Liệt nhẹ (mất đối xứng nhẹ)'},
          {'value': 2, 'text': 'Liệt vừa (liệt vùng dưới mặt)'},
          {'value': 3, 'text': 'Liệt hoàn toàn'},
        ],
      },
      {
        'key': 'leftArm',
        'title': '5a. Vận động tay trái',
        'options': [
          {'value': 0, 'text': 'Bình thường, giữ 10 giây'},
          {'value': 1, 'text': 'Rơi từ từ trong 10 giây'},
          {'value': 2, 'text': 'Rơi ngay, có cố gắng chống lại trọng lực'},
          {'value': 3, 'text': 'Không chuyển động'},
          {'value': 4, 'text': 'Không đánh giá được (cắt cụt, khớp cứng)'},
        ],
      },
      {
        'key': 'rightArm',
        'title': '5b. Vận động tay phải',
        'options': [
          {'value': 0, 'text': 'Bình thường, giữ 10 giây'},
          {'value': 1, 'text': 'Rơi từ từ trong 10 giây'},
          {'value': 2, 'text': 'Rơi ngay, có cố gắng chống lại trọng lực'},
          {'value': 3, 'text': 'Không chuyển động'},
          {'value': 4, 'text': 'Không đánh giá được (cắt cụt, khớp cứng)'},
        ],
      },
      {
        'key': 'leftLeg',
        'title': '6a. Vận động chân trái',
        'options': [
          {'value': 0, 'text': 'Bình thường, giữ 5 giây'},
          {'value': 1, 'text': 'Rơi từ từ trong 5 giây'},
          {'value': 2, 'text': 'Rơi ngay, có cố gắng chống lại trọng lực'},
          {'value': 3, 'text': 'Không chuyển động'},
          {'value': 4, 'text': 'Không đánh giá được (cắt cụt, khớp cứng)'},
        ],
      },
      {
        'key': 'rightLeg',
        'title': '6b. Vận động chân phải',
        'options': [
          {'value': 0, 'text': 'Bình thường, giữ 5 giây'},
          {'value': 1, 'text': 'Rơi từ từ trong 5 giây'},
          {'value': 2, 'text': 'Rơi ngay, có cố gắng chống lại trọng lực'},
          {'value': 3, 'text': 'Không chuyển động'},
          {'value': 4, 'text': 'Không đánh giá được (cắt cụt, khớp cứng)'},
        ],
      },
      {
        'key': 'ataxia',
        'title': '7. Mất điều hòa chi (finger-nose, heel-shin)',
        'options': [
          {'value': 0, 'text': 'Không có'},
          {'value': 1, 'text': 'Có ở 1 chi'},
          {'value': 2, 'text': 'Có ở 2 chi'},
        ],
      },
      {
        'key': 'sensory',
        'title': '8. Cảm giác',
        'options': [
          {'value': 0, 'text': 'Bình thường'},
          {'value': 1, 'text': 'Giảm cảm giác nhẹ đến vừa'},
          {'value': 2, 'text': 'Mất cảm giác hoàn toàn'},
        ],
      },
      {
        'key': 'language',
        'title': '9. Ngôn ngữ (thất ngôn)',
        'options': [
          {'value': 0, 'text': 'Bình thường'},
          {'value': 1, 'text': 'Thất ngôn nhẹ đến vừa'},
          {'value': 2, 'text': 'Thất ngôn nặng'},
          {'value': 3, 'text': 'Câm hoàn toàn'},
        ],
      },
      {
        'key': 'dysarthria',
        'title': '10. Khó nói (rối loạn phát âm)',
        'options': [
          {'value': 0, 'text': 'Bình thường'},
          {'value': 1, 'text': 'Nhẹ đến vừa'},
          {'value': 2, 'text': 'Nặng (câm hoặc không thể hiểu)'},
        ],
      },
      {
        'key': 'extinction',
        'title': '11. Loại trừ và thiếu chú ý',
        'options': [
          {'value': 0, 'text': 'Bình thường'},
          {'value': 1, 'text': 'Thiếu chú ý hoặc loại trừ một phương thức'},
          {'value': 2, 'text': 'Thiếu chú ý hoàn toàn ở một bên'},
        ],
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NIHSS Score'),
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
                color: severityColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: severityColor.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    'NIHSS Score',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: severityColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$totalScore/42',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: severityColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    severity,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildPrognosisInfo(),
                ],
              ),
            ),

            // Assessment Items
            ...nihssItems.map((item) => _buildAssessmentItem(item)),

            // Reference and Clinical Info
            _buildBottomInfo(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPrognosisInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timeline, color: severityColor),
              const SizedBox(width: 8),
              Text(
                'Tiên lượng:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: severityColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            prognosis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppTheme.darkGrey,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.medical_services, color: severityColor),
              const SizedBox(width: 8),
              Text(
                'Khuyến nghị:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: severityColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            recommendations,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.darkGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentItem(Map<String, dynamic> item) {
    String key = item['key'];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        elevation: 2,
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Text(
            item['title'],
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            'Điểm: ${scores[key]}',
            style: TextStyle(
              color: severityColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          children: [
            Column(
              children: item['options'].map<Widget>((option) {
                return RadioListTile<int>(
                  title: Text(
                    option['text'],
                    style: const TextStyle(fontSize: 14),
                  ),
                  value: option['value'],
                  // ignore: deprecated_member_use
                  groupValue: scores[key],
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    setState(() {
                      scores[key] = value!;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomInfo() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.blue.shade600),
              const SizedBox(width: 8),
              Text(
                'Phân tầng mức độ đột quỵ',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildSeverityItem('0-4 điểm', 'Đột quỵ nhẹ', Colors.green),
          _buildSeverityItem('5-15 điểm', 'Đột quỵ vừa', Colors.orange),
          _buildSeverityItem('16-20 điểm', 'Đột quỵ nặng', Colors.red),
          _buildSeverityItem('21-42 điểm', 'Đột quỵ rất nặng', Colors.red.shade800),
          const SizedBox(height: 12),
          const Text(
            'Lưu ý: NIHSS được đánh giá trong 24h đầu và theo dõi diễn biến. '
            'Điểm số giảm cho thấy cải thiện, tăng cho thấy xấu đi. '
            'Cần kết hợp với đánh giá lâm sàng và hình ảnh học để quyết định điều trị.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildSeverityItem(String range, String severity, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              range,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              severity,
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
