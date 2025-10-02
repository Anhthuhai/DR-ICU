import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class Abcd2Page extends StatefulWidget {
  const Abcd2Page({super.key});

  @override
  State<Abcd2Page> createState() => _Abcd2PageState();
}

class _Abcd2PageState extends State<Abcd2Page> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bpController = TextEditingController();

  int _clinicalFeatures = 0; // 0: Other, 1: Speech without weakness, 2: Unilateral weakness
  int _duration = 0; // 0: <10min, 1: 10-59min, 2: ≥60min
  bool _diabetes = false;

  int _totalScore = 0;

  @override
  void initState() {
    super.initState();
    _ageController.addListener(_calculateScore);
    _bpController.addListener(_calculateScore);
  }

  void _calculateScore() {
    int score = 0;
    
    // Age ≥60
    final age = int.tryParse(_ageController.text) ?? 0;
    if (age >= 60) {
      score += 1;
    }
    
    // Blood pressure ≥140/90
    final bp = int.tryParse(_bpController.text) ?? 0;
    if (bp >= 140) {
      score += 1;
    }
    
    // Clinical features
    score += _clinicalFeatures;
    
    // Duration
    score += _duration;
    
    // Diabetes
    if (_diabetes) {
      score += 1;
    }

    setState(() {
      _totalScore = score;
    });
  }

  Color get riskColor {
    if (_totalScore <= 3) {
      return Colors.green;
    }
    if (_totalScore <= 5) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String get riskLevel {
    if (_totalScore <= 3) {
      return 'Nguy cơ thấp';
    }
    if (_totalScore <= 5) {
      return 'Nguy cơ trung bình';
    }
    return 'Nguy cơ cao';
  }

  String get strokeRisk2Days {
    if (_totalScore == 0) {
      return '0%';
    }
    if (_totalScore == 1) {
      return '0.4%';
    }
    if (_totalScore == 2) {
      return '1.0%';
    }
    if (_totalScore == 3) {
      return '1.3%';
    }
    if (_totalScore == 4) {
      return '4.1%';
    }
    if (_totalScore == 5) {
      return '5.9%';
    }
    if (_totalScore == 6) {
      return '9.8%';
    }
    return '11.7%';
  }

  String get strokeRisk7Days {
    if (_totalScore == 0) {
      return '0.4%';
    }
    if (_totalScore == 1) {
      return '1.2%';
    }
    if (_totalScore == 2) {
      return '1.2%';
    }
    if (_totalScore == 3) {
      return '3.1%';
    }
    if (_totalScore == 4) {
      return '5.1%';
    }
    if (_totalScore == 5) {
      return '10.5%';
    }
    if (_totalScore == 6) {
      return '13.2%';
    }
    return '17.8%';
  }

  String get strokeRisk90Days {
    if (_totalScore == 0) {
      return '1.2%';
    }
    if (_totalScore == 1) {
      return '3.1%';
    }
    if (_totalScore == 2) {
      return '3.1%';
    }
    if (_totalScore == 3) {
      return '9.8%';
    }
    if (_totalScore == 4) {
      return '11.7%';
    }
    if (_totalScore == 5) {
      return '19.6%';
    }
    if (_totalScore == 6) {
      return '31.4%';
    }
    return '35.5%';
  }

  String get recommendations {
    if (_totalScore <= 3) {
      return 'Có thể xuất viện với theo dõi ngoại trú chặt chẽ, cân nhắc điều tra nguyên nhân';
    }
    if (_totalScore <= 5) {
      return 'Cần nhập viện theo dõi ngắn hạn, điều tra nguyên nhân và điều trị dự phòng';
    }
    return 'Nhập viện khẩn cấp, điều tra toàn diện và điều trị dự phòng tích cực';
  }

  String get urgency {
    if (_totalScore <= 3) {
      return 'Không khẩn cấp - 48-72h';
    }
    if (_totalScore <= 5) {
      return 'Ưu tiên - trong 24h';
    }
    return 'Khẩn cấp - ngay lập tức';
  }

  List<Map<String, dynamic>> get clinicalFeaturesOptions {
    return [
      {
        'value': 0,
        'text': 'Triệu chứng khác',
        'description': 'Không có rối loạn ngôn ngữ hoặc liệt nửa người',
        'points': 0,
      },
      {
        'value': 1,
        'text': 'Rối loạn ngôn ngữ không kèm liệt',
        'description': 'Khó nói, thất ngữ nhưng không liệt vận động',
        'points': 1,
      },
      {
        'value': 2,
        'text': 'Liệt nửa người',
        'description': 'Yếu liệt một bên cơ thể',
        'points': 2,
      },
    ];
  }

  List<Map<String, dynamic>> get durationOptions {
    return [
      {
        'value': 0,
        'text': '< 10 phút',
        'description': 'Triệu chứng kéo dài dưới 10 phút',
        'points': 0,
      },
      {
        'value': 1,
        'text': '10-59 phút',
        'description': 'Triệu chứng kéo dài từ 10 đến 59 phút',
        'points': 1,
      },
      {
        'value': 2,
        'text': '≥ 60 phút',
        'description': 'Triệu chứng kéo dài 60 phút trở lên',
        'points': 2,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ABCD2 Score'),
        backgroundColor: Colors.indigo.shade700,
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
                    'ABCD2 Score',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_totalScore/7',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    riskLevel,
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

            // Clinical Features
            _buildClinicalFeaturesSection(),

            // Duration
            _buildDurationSection(),

            // Diabetes
            _buildDiabetesSection(),

            // Risk Stratification
            _buildRiskStratification(),

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
                    'Đột quỵ 2 ngày',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    strokeRisk2Days,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: riskColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Đột quỵ 7 ngày',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    strokeRisk7Days,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: riskColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Đột quỵ 90 ngày',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    strokeRisk90Days,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
                    Icon(Icons.schedule, color: riskColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Mức độ khẩn cấp:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  urgency,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkGrey,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.medical_services, color: riskColor, size: 20),
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
        border: Border.all(color: Colors.indigo.shade300),
        color: Colors.indigo.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin cơ bản (A)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Tuổi',
                    suffixText: 'năm',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    helperText: '+1 điểm nếu ≥60 tuổi',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _bpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Huyết áp tâm thu',
                    suffixText: 'mmHg',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    helperText: '+1 điểm nếu ≥140mmHg',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClinicalFeaturesSection() {
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
            'Đặc điểm lâm sàng (C)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          ...clinicalFeaturesOptions.map((option) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: RadioListTile<int>(
              title: Text(option['text']),
              subtitle: Text(
                option['description'],
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
              value: option['value'],
              // ignore: deprecated_member_use
              groupValue: _clinicalFeatures,
              // ignore: deprecated_member_use
              onChanged: (value) {
                setState(() {
                  _clinicalFeatures = value!;
                });
                _calculateScore();
              },
              activeColor: Colors.blue.shade600,
              contentPadding: EdgeInsets.zero,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildDurationSection() {
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
            'Thời gian kéo dài (D)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
          ),
          const SizedBox(height: 16),
          ...durationOptions.map((option) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: RadioListTile<int>(
              title: Text(option['text']),
              subtitle: Text(
                option['description'],
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
              value: option['value'],
              // ignore: deprecated_member_use
              groupValue: _duration,
              // ignore: deprecated_member_use
              onChanged: (value) {
                setState(() {
                  _duration = value!;
                });
                _calculateScore();
              },
              activeColor: Colors.orange.shade600,
              contentPadding: EdgeInsets.zero,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildDiabetesSection() {
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
            'Tiểu đường (D)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            title: const Text('Có tiền sử tiểu đường'),
            subtitle: const Text('Đang điều trị hoặc đã được chẩn đoán'),
            value: _diabetes,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _diabetes = value!;
              });
              _calculateScore();
            },
            activeColor: Colors.green.shade600,
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
        border: Border.all(color: Colors.purple.shade300),
        color: Colors.purple.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phân tầng nguy cơ đột quỵ',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('0-3', 'Nguy cơ thấp', '0-3.1%', '1.2-9.8%', Colors.green),
          _buildRiskItem('4-5', 'Nguy cơ trung bình', '4.1-5.9%', '11.7-19.6%', Colors.orange),
          _buildRiskItem('6-7', 'Nguy cơ cao', '9.8-11.7%', '31.4-35.5%', Colors.red),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String risk, String risk2d, String risk90d, Color color) {
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
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '2 ngày: $risk2d, 90 ngày: $risk90d',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
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
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.red.shade600),
              const SizedBox(width: 8),
              Text(
                'Thông tin lâm sàng',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'ABCD2 Score dự đoán nguy cơ đột quỵ sau cơn thiếu máu não thoáng qua (TIA)\n\n'
            'Các thành phần của ABCD2:\n'
            '• A (Age): Tuổi ≥60 (+1 điểm)\n'
            '• B (Blood pressure): HA ≥140/90 (+1 điểm)\n'
            '• C (Clinical features): Triệu chứng lâm sàng (0-2 điểm)\n'
            '• D (Duration): Thời gian kéo dài (0-2 điểm)\n'
            '• D (Diabetes): Tiểu đường (+1 điểm)\n\n'
            'Ứng dụng lâm sàng:\n'
            '• Quyết định nhập viện sau TIA\n'
            '• Mức độ ưu tiên điều tra\n'
            '• Tư vấn nguy cơ cho bệnh nhân\n'
            '• Theo dõi và điều trị dự phòng\n\n'
            'Lưu ý: Kết hợp với đánh giá hình ảnh và nguyên nhân để quyết định điều trị tối ưu',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    _bpController.dispose();
    super.dispose();
  }
}
