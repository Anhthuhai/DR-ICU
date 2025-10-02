import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class PewsScorePage extends StatefulWidget {
  const PewsScorePage({super.key});

  @override
  State<PewsScorePage> createState() => _PewsScorePageState();
}

class _PewsScorePageState extends State<PewsScorePage> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _respiratoryRateController = TextEditingController();
  final TextEditingController _systolicBpController = TextEditingController();

  String _consciousnessLevel = 'alert';
  String _oxygenTherapy = 'room_air';

  int _totalScore = 0;

  @override
  void initState() {
    super.initState();
    _ageController.addListener(_calculateScore);
    _heartRateController.addListener(_calculateScore);
    _respiratoryRateController.addListener(_calculateScore);
    _systolicBpController.addListener(_calculateScore);
  }

  void _calculateScore() {
    int score = 0;
    
    final age = int.tryParse(_ageController.text) ?? 0;
    final heartRate = int.tryParse(_heartRateController.text) ?? 0;
    final respiratoryRate = int.tryParse(_respiratoryRateController.text) ?? 0;
    final systolicBp = int.tryParse(_systolicBpController.text) ?? 0;
    
    // Heart Rate scoring based on age
    if (age > 0 && heartRate > 0) {
      if (age < 1) { // Infant
        if (heartRate < 90 || heartRate > 180) {
          score += 3;
        }
        else if (heartRate < 100 || heartRate > 170) {
   score += 2;
 }
        else if (heartRate < 110 || heartRate > 160) {
   score += 1;
 }
      } else if (age <= 5) { // 1-5 years
        if (heartRate < 80 || heartRate > 140) {
          score += 3;
        }
        else if (heartRate < 90 || heartRate > 130) {
   score += 2;
 }
        else if (heartRate < 100 || heartRate > 120) {
   score += 1;
 }
      } else if (age <= 12) { // 6-12 years
        if (heartRate < 70 || heartRate > 120) {
          score += 3;
        }
        else if (heartRate < 80 || heartRate > 110) {
   score += 2;
 }
        else if (heartRate < 90 || heartRate > 100) {
   score += 1;
 }
      } else { // >12 years
        if (heartRate < 60 || heartRate > 100) {
          score += 3;
        }
        else if (heartRate < 70 || heartRate > 90) {
   score += 2;
 }
        else if (heartRate < 80 || heartRate > 90) {
   score += 1;
 }
      }
    }
    
    // Respiratory Rate scoring based on age
    if (age > 0 && respiratoryRate > 0) {
      if (age < 1) { // Infant
        if (respiratoryRate < 20 || respiratoryRate > 60) {
          score += 3;
        }
        else if (respiratoryRate < 25 || respiratoryRate > 50) {
   score += 2;
 }
        else if (respiratoryRate < 30 || respiratoryRate > 45) {
   score += 1;
 }
      } else if (age <= 5) { // 1-5 years
        if (respiratoryRate < 15 || respiratoryRate > 40) {
          score += 3;
        }
        else if (respiratoryRate < 20 || respiratoryRate > 35) {
   score += 2;
 }
        else if (respiratoryRate < 25 || respiratoryRate > 30) {
   score += 1;
 }
      } else if (age <= 12) { // 6-12 years
        if (respiratoryRate < 12 || respiratoryRate > 30) {
          score += 3;
        }
        else if (respiratoryRate < 15 || respiratoryRate > 25) {
   score += 2;
 }
        else if (respiratoryRate < 18 || respiratoryRate > 22) {
   score += 1;
 }
      } else { // >12 years
        if (respiratoryRate < 10 || respiratoryRate > 25) {
          score += 3;
        }
        else if (respiratoryRate < 12 || respiratoryRate > 22) {
   score += 2;
 }
        else if (respiratoryRate < 15 || respiratoryRate > 20) {
   score += 1;
 }
      }
    }
    
    // Systolic BP scoring based on age
    if (age > 0 && systolicBp > 0) {
      if (age < 1) { // Infant
        if (systolicBp < 70) {
          score += 3;
        }
        else if (systolicBp < 80) {
   score += 2;
 }
        else if (systolicBp < 90) {
   score += 1;
 }
      } else if (age <= 5) { // 1-5 years
        if (systolicBp < 80) {
          score += 3;
        }
        else if (systolicBp < 90) {
   score += 2;
 }
        else if (systolicBp < 100) {
   score += 1;
 }
      } else if (age <= 12) { // 6-12 years
        if (systolicBp < 90) {
          score += 3;
        }
        else if (systolicBp < 100) {
   score += 2;
 }
        else if (systolicBp < 110) {
   score += 1;
 }
      } else { // >12 years
        if (systolicBp < 100) {
          score += 3;
        }
        else if (systolicBp < 110) {
   score += 2;
 }
        else if (systolicBp < 120) {
   score += 1;
 }
      }
    }
    
    // Consciousness level
    switch (_consciousnessLevel) {
      case 'voice':
        score += 1;
        break;
      case 'pain':
        score += 2;
        break;
      case 'unresponsive':
        score += 3;
        break;
    }
    
    // Oxygen therapy
    switch (_oxygenTherapy) {
      case 'nasal_cannula':
        score += 1;
        break;
      case 'face_mask':
        score += 2;
        break;
      case 'high_flow':
        score += 3;
        break;
    }

    setState(() {
      _totalScore = score;
    });
  }

  Color get riskColor {
    if (_totalScore <= 3) {
      return Colors.green;
    }
    if (_totalScore <= 6) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String get riskLevel {
    if (_totalScore <= 3) {
      return 'Thấp';
    }
    if (_totalScore <= 6) {
      return 'Trung bình';
    }
    return 'Cao';
  }

  String get responseLevel {
    if (_totalScore <= 3) {
      return 'Theo dõi thường quy';
    }
    if (_totalScore <= 6) {
      return 'Tăng cường theo dõi';
    }
    return 'Can thiệp tích cực';
  }

  String get frequency {
    if (_totalScore <= 3) {
      return 'Mỗi 4-6 giờ';
    }
    if (_totalScore <= 6) {
      return 'Mỗi 1-2 giờ';
    }
    return 'Liên tục';
  }

  String get recommendations {
    if (_totalScore <= 3) {
      return 'Tiếp tục chăm sóc hiện tại, theo dõi định kỳ';
    }
    if (_totalScore <= 6) {
      return 'Thông báo bác sĩ, tăng cường theo dõi, xem xét chuyển khoa';
    }
    return 'Gọi team cấp cứu nhi khoa ngay lập tức, chuẩn bị chuyển ICU';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PEWS Score'),
        backgroundColor: Colors.pink.shade700,
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
                    'PEWS Score',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_totalScore',
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

            // Response Protocol
            _buildResponseProtocol(),

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
                    'Mức độ đáp ứng',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    responseLevel,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: riskColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Tần suất theo dõi',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    frequency,
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
        border: Border.all(color: Colors.pink.shade300),
        color: Colors.pink.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông số sinh hiệu',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          TextField(
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
              helperText: 'Cần để tính giá trị bình thường theo tuổi',
            ),
          ),
          const SizedBox(height: 12),
          
          TextField(
            controller: _heartRateController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Tần số tim',
              suffixText: 'lần/phút',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: 'Theo dõi bất thường theo tuổi',
            ),
          ),
          const SizedBox(height: 12),
          
          TextField(
            controller: _respiratoryRateController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Tần số thở',
              suffixText: 'lần/phút',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: 'Giá trị bình thường khác theo nhóm tuổi',
            ),
          ),
          const SizedBox(height: 12),
          
          TextField(
            controller: _systolicBpController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Huyết áp tâm thu',
              suffixText: 'mmHg',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: 'Hạ huyết áp là dấu hiệu muộn ở trẻ em',
            ),
          ),
          const SizedBox(height: 16),
          
          Text(
            'Mức độ ý thức',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Column(
            children: [
              RadioListTile<String>(
                title: const Text('Tỉnh táo (Alert)'),
                value: 'alert',
                // ignore: deprecated_member_use
                groupValue: _consciousnessLevel,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _consciousnessLevel = value!;
                  });
                  _calculateScore();
                },
                contentPadding: EdgeInsets.zero,
              ),
              RadioListTile<String>(
                title: const Text('Đáp ứng tiếng gọi (Voice) (+1)'),
                value: 'voice',
                // ignore: deprecated_member_use
                groupValue: _consciousnessLevel,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _consciousnessLevel = value!;
                  });
                  _calculateScore();
                },
                contentPadding: EdgeInsets.zero,
              ),
              RadioListTile<String>(
                title: const Text('Đáp ứng đau (Pain) (+2)'),
                value: 'pain',
                // ignore: deprecated_member_use
                groupValue: _consciousnessLevel,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _consciousnessLevel = value!;
                  });
                  _calculateScore();
                },
                contentPadding: EdgeInsets.zero,
              ),
              RadioListTile<String>(
                title: const Text('Không đáp ứng (Unresponsive) (+3)'),
                value: 'unresponsive',
                // ignore: deprecated_member_use
                groupValue: _consciousnessLevel,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _consciousnessLevel = value!;
                  });
                  _calculateScore();
                },
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          Text(
            'Liệu pháp oxy',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Column(
            children: [
              RadioListTile<String>(
                title: const Text('Không khí phòng'),
                value: 'room_air',
                // ignore: deprecated_member_use
                groupValue: _oxygenTherapy,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _oxygenTherapy = value!;
                  });
                  _calculateScore();
                },
                contentPadding: EdgeInsets.zero,
              ),
              RadioListTile<String>(
                title: const Text('Ống thông mũi (+1)'),
                value: 'nasal_cannula',
                // ignore: deprecated_member_use
                groupValue: _oxygenTherapy,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _oxygenTherapy = value!;
                  });
                  _calculateScore();
                },
                contentPadding: EdgeInsets.zero,
              ),
              RadioListTile<String>(
                title: const Text('Mặt nạ oxy (+2)'),
                value: 'face_mask',
                // ignore: deprecated_member_use
                groupValue: _oxygenTherapy,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _oxygenTherapy = value!;
                  });
                  _calculateScore();
                },
                contentPadding: EdgeInsets.zero,
              ),
              RadioListTile<String>(
                title: const Text('High flow/CPAP (+3)'),
                value: 'high_flow',
                // ignore: deprecated_member_use
                groupValue: _oxygenTherapy,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _oxygenTherapy = value!;
                  });
                  _calculateScore();
                },
                contentPadding: EdgeInsets.zero,
              ),
            ],
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
            'Phân tầng nguy cơ PEWS',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('0-3', 'Nguy cơ thấp', 'Mỗi 4-6h', 'Chăm sóc thường quy', Colors.green),
          _buildRiskItem('4-6', 'Nguy cơ trung bình', 'Mỗi 1-2h', 'Thông báo bác sĩ', Colors.orange),
          _buildRiskItem('≥7', 'Nguy cơ cao', 'Liên tục', 'Team cấp cứu nhi', Colors.red),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String risk, String frequency, String action, Color color) {
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
                  frequency,
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

  Widget _buildResponseProtocol() {
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
            'Quy trình đáp ứng',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildProtocolCard(
            'PEWS 0-3: Chăm sóc thường quy',
            [
              'Theo dõi sinh hiệu 4-6 giờ/lần',
              'Ghi nhận điểm PEWS',
              'Tiếp tục kế hoạch điều trị',
              'Đánh giá lại nếu tình trạng thay đổi',
            ],
            Colors.green,
          ),
          const SizedBox(height: 12),
          _buildProtocolCard(
            'PEWS 4-6: Tăng cường theo dõi',
            [
              'Thông báo bác sĩ trực',
              'Theo dõi sinh hiệu 1-2 giờ/lần',
              'Xem xét nguyên nhân',
              'Cân nhắc chuyển khoa nhi',
            ],
            Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildProtocolCard(
            'PEWS ≥7: Can thiệp tích cực',
            [
              'Gọi team cấp cứu nhi ngay',
              'Theo dõi liên tục',
              'Chuẩn bị chuyển PICU',
              'ABC assessment',
            ],
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildProtocolCard(String title, List<String> items, Color color) {
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
            'PEWS (Pediatric Early Warning Score) là công cụ sàng lọc để nhận diện sớm trẻ em có nguy cơ xấu đi\n\n'
            'Ưu điểm:\n'
            '• Nhận diện sớm trẻ em bệnh nặng\n'
            '• Hướng dẫn mức độ can thiệp\n'
            '• Cải thiện kết quả điều trị\n'
            '• Giảm cardiac arrest ngoài ICU\n\n'
            'Giá trị bình thường theo tuổi:\n'
            '• <1 tuổi: HR 100-170, RR 30-45\n'
            '• 1-5 tuổi: HR 90-130, RR 20-35\n'
            '• 6-12 tuổi: HR 80-110, RR 15-25\n'
            '• >12 tuổi: HR 70-90, RR 12-22\n\n'
            'Đặc điểm sinh lý trẻ em:\n'
            '• Dự trữ tâm phổi hạn chế\n'
            '• Hạ huyết áp là dấu hiệu muộn\n'
            '• Tachycardia và tachypnea là dấu hiệu sớm\n'
            '• Rối loạn ý thức báo hiệu nguy hiểm\n\n'
            'Lưu ý quan trọng:\n'
            '• Điều chỉnh theo độ tuổi\n'
            '• Đánh giá tổng thể lâm sàng\n'
            '• Theo dõi xu hướng thay đổi\n'
            '• Kết hợp với khám thực thể',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heartRateController.dispose();
    _respiratoryRateController.dispose();
    _systolicBpController.dispose();
    super.dispose();
  }
}
