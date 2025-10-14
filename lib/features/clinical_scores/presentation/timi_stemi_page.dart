import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class TimiStemiPage extends StatefulWidget {
  const TimiStemiPage({super.key});

  @override
  State<TimiStemiPage> createState() => _TimiStemiPageState();
}

class _TimiStemiPageState extends State<TimiStemiPage> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _systolicBPController = TextEditingController();

  bool _diabetes = false;
  bool _hypertension = false;
  bool _angina = false;
  bool _anteriorMI = false;
  bool _timeToTreatment = false; // >4 hours

  int _totalScore = 0;

  @override
  void initState() {
    super.initState();
    _ageController.addListener(_calculateScore);
    _weightController.addListener(_calculateScore);
    _heartRateController.addListener(_calculateScore);
    _systolicBPController.addListener(_calculateScore);
  }

  void _calculateScore() {
    int score = 0;
    
    // Age
    final age = int.tryParse(_ageController.text) ?? 0;
    if (age >= 75) {
      score += 3;
    }
    else if (age >= 65) {
   score += 2;
 }
    
    // Weight < 67kg
    final weight = double.tryParse(_weightController.text) ?? 0;
    if (weight > 0 && weight < 67) {
      score += 1;
    }
    
    // Anterior MI or LBBB
    if (_anteriorMI) {
      score += 1;
    }
    
    // Time to treatment > 4 hours
    if (_timeToTreatment) {
      score += 1;
    }
    
    // Diabetes/Hypertension/Angina
    if (_diabetes || _hypertension || _angina) {
      score += 1;
    }
    
    // Heart rate >= 100
    final hr = int.tryParse(_heartRateController.text) ?? 0;
    if (hr >= 100) {
      score += 2;
    }
    
    // Systolic BP < 100
    final sbp = int.tryParse(_systolicBPController.text) ?? 0;
    if (sbp > 0 && sbp < 100) {
      score += 3;
    }

    setState(() {
      _totalScore = score;
    });
  }

  Color get riskColor {
    if (_totalScore <= 2) {
      return Colors.green;
    }
    if (_totalScore <= 4) {
      return Colors.yellow.shade700;
    }
    if (_totalScore <= 8) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String get riskLevel {
    if (_totalScore <= 2) {
      return 'Nguy cơ thấp';
    }
    if (_totalScore <= 4) {
      return 'Nguy cơ trung bình';
    }
    if (_totalScore <= 8) {
      return 'Nguy cơ cao';
    }
    return 'Nguy cơ rất cao';
  }

  String get mortalityRisk {
    if (_totalScore == 0) {
      return '0.8%';
    }
    if (_totalScore == 1) {
      return '1.6%';
    }
    if (_totalScore == 2) {
      return '2.2%';
    }
    if (_totalScore == 3) {
      return '4.4%';
    }
    if (_totalScore == 4) {
      return '7.3%';
    }
    if (_totalScore == 5) {
      return '12.4%';
    }
    if (_totalScore == 6) {
      return '16.1%';
    }
    if (_totalScore == 7) {
      return '23.4%';
    }
    if (_totalScore == 8) {
      return '26.8%';
    }
    return '>30%';
  }

  String get recommendations {
    if (_totalScore <= 2) {
      return 'PCI sớm trong 12h, điều trị theo hướng dẫn chuẩn';
    }
    if (_totalScore <= 4) {
      return 'PCI cấp cứu, theo dõi chặt chẽ biến chứng';
    }
    if (_totalScore <= 8) {
      return 'PCI ngay lập tức, hỗ trợ tuần hoàn, ICU monitoring';
    }
    return 'Can thiệp cấp cứu tối đa, cân nhắc hỗ trợ cơ học tuần hoàn';
  }

  List<Map<String, dynamic>> get riskFactors {
    return [
      {
        'factor': 'Tuổi 65-74',
        'points': 2,
        'active': (int.tryParse(_ageController.text) ?? 0) >= 65 && (int.tryParse(_ageController.text) ?? 0) < 75,
      },
      {
        'factor': 'Tuổi ≥75',
        'points': 3,
        'active': (int.tryParse(_ageController.text) ?? 0) >= 75,
      },
      {
        'factor': 'Cân nặng <67kg',
        'points': 1,
        'active': (double.tryParse(_weightController.text) ?? 0) > 0 && (double.tryParse(_weightController.text) ?? 0) < 67,
      },
      {
        'factor': 'ĐTĐ/THA/Đau thắt ngực',
        'points': 1,
        'active': _diabetes || _hypertension || _angina,
      },
      {
        'factor': 'Nhồi máu thành trước/LBBB',
        'points': 1,
        'active': _anteriorMI,
      },
      {
        'factor': 'Thời gian điều trị >4h',
        'points': 1,
        'active': _timeToTreatment,
      },
      {
        'factor': 'Nhịp tim ≥100',
        'points': 2,
        'active': (int.tryParse(_heartRateController.text) ?? 0) >= 100,
      },
      {
        'factor': 'Huyết áp tâm thu <100',
        'points': 3,
        'active': (int.tryParse(_systolicBPController.text) ?? 0) > 0 && (int.tryParse(_systolicBPController.text) ?? 0) < 100,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TIMI Score - STEMI'),
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
                    'TIMI Score - STEMI',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_totalScore/14',
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

            // Risk Factors
            _buildRiskFactorsSection(),

            // Active Risk Factors
            _buildActiveFactors(),

            // Risk Stratification
            _buildRiskStratification(),

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Tỷ lệ tử vong 30 ngày',
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
                      fontSize: 24,
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
                Text(
                  'Khuyến nghị điều trị:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: riskColor,
                  ),
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
        border: Border.all(color: Colors.red.shade300),
        color: Colors.red.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông số bệnh nhân',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
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
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Cân nặng',
                    suffixText: 'kg',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _heartRateController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Nhịp tim',
                    suffixText: 'lần/phút',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _systolicBPController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Huyết áp tâm thu',
                    suffixText: 'mmHg',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRiskFactorsSection() {
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
            'Yếu tố nguy cơ',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            title: const Text('Tiểu đường'),
            value: _diabetes,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _diabetes = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Tăng huyết áp'),
            value: _hypertension,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _hypertension = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Tiền sử đau thắt ngực'),
            value: _angina,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _angina = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Nhồi máu thành trước hoặc LBBB'),
            value: _anteriorMI,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _anteriorMI = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Thời gian từ khởi phát đến điều trị >4 giờ'),
            value: _timeToTreatment,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _timeToTreatment = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildActiveFactors() {
    List<Map<String, dynamic>> activeFactors = riskFactors.where((factor) => factor['active']).toList();
    
    if (activeFactors.isEmpty) {
      return const SizedBox.shrink();
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
            'Yếu tố nguy cơ hiện tại (${activeFactors.length})',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
          ),
          const SizedBox(height: 12),
          ...activeFactors.map((factor) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 20,
                  decoration: BoxDecoration(
                    color: riskColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      '+${factor['points']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  factor['factor'],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
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
        border: Border.all(color: Colors.green.shade300),
        color: Colors.green.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phân tầng nguy cơ tử vong 30 ngày',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('0-2', 'Nguy cơ thấp', '0.8-2.2%', Colors.green),
          _buildRiskItem('3-4', 'Nguy cơ trung bình', '4.4-7.3%', Colors.yellow.shade700),
          _buildRiskItem('5-8', 'Nguy cơ cao', '12.4-26.8%', Colors.orange),
          _buildRiskItem('>8', 'Nguy cơ rất cao', '>30%', Colors.red),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String risk, String mortality, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
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
              style: TextStyle(color: Colors.grey.shade700),
              textAlign: TextAlign.right,
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
        color: Colors.purple.shade50,
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.purple.shade600),
              const SizedBox(width: 8),
              Text(
                'Thông tin lâm sàng',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.purple.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'TIMI Score for STEMI đánh giá nguy cơ tử vong 30 ngày sau nhồi máu cơ tim cấp có chênh ST\n\n'
            'Ứng dụng lâm sàng:\n'
            '• Phân tầng nguy cơ và tiên lượng\n'
            '• Hỗ trợ quyết định điều trị\n'
            '• Tư vấn bệnh nhân và gia đình\n'
            '• Đánh giá hiệu quả can thiệp\n\n'
            'Lưu ý quan trọng:\n'
            '• Áp dụng cho STEMI, không phải NSTEMI/UA\n'
            '• Cần kết hợp với đánh giá lâm sàng\n'
            '• PCI sớm là mục tiêu vàng cho STEMI\n'
            '• Thời gian "door-to-balloon" <90 phút',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heartRateController.dispose();
    _systolicBPController.dispose();
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
            'Morrow DA, et al. TIMI risk score for ST-elevation myocardial infarction: A convenient, bedside, clinical score for risk assessment at presentation. Circulation. 2000;102(17):2031-7.\n\nWiviott SD, et al. Percutaneous coronary intervention patients with ST-elevation myocardial infarction in the TIMI trials. Am Heart J. 2004;148(6):1020-5.',
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
