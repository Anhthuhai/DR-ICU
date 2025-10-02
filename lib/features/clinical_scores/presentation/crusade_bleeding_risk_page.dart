import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class CrusadeBleedingRiskPage extends StatefulWidget {
  const CrusadeBleedingRiskPage({super.key});

  @override
  State<CrusadeBleedingRiskPage> createState() => _CrusadeBleedingRiskPageState();
}

class _CrusadeBleedingRiskPageState extends State<CrusadeBleedingRiskPage> {
  final TextEditingController _hematocritController = TextEditingController();
  final TextEditingController _creatinineController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _systolicBpController = TextEditingController();

  String _gender = 'male';
  String _diabetesStatus = 'no';
  String _priorVascularDisease = 'no';

  int _totalScore = 0;

  @override
  void initState() {
    super.initState();
    _hematocritController.addListener(_calculateScore);
    _creatinineController.addListener(_calculateScore);
    _heartRateController.addListener(_calculateScore);
    _systolicBpController.addListener(_calculateScore);
  }

  void _calculateScore() {
    int score = 0;
    
    // Hematocrit
    final hematocrit = double.tryParse(_hematocritController.text) ?? 0;
    if (hematocrit < 31) {
      score += 9;
    } else if (hematocrit <= 33.9) {
      score += 7;
    } else if (hematocrit <= 36.9) {
      score += 3;
    } else if (hematocrit <= 39.9) {
      score += 2;
    }
    // >=40: 0 points
    
    // Creatinine clearance (approximate from creatinine)
    final creatinine = double.tryParse(_creatinineController.text) ?? 0;
    if (creatinine > 2.0) {
      score += 39; // CrCl <15
    } else if (creatinine > 1.5) {
      score += 35; // CrCl 15-30
    } else if (creatinine > 1.2) {
      score += 28; // CrCl 30-60
    } else if (creatinine > 1.0) {
      score += 17; // CrCl 60-90
    } else if (creatinine > 0.9) {
      score += 7; // CrCl 90-120
    }
    // CrCl >120: 0 points
    
    // Heart rate
    final heartRate = int.tryParse(_heartRateController.text) ?? 0;
    if (heartRate >= 121) {
      score += 11;
    } else if (heartRate >= 101) {
      score += 8;
    } else if (heartRate >= 91) {
      score += 6;
    } else if (heartRate >= 81) {
      score += 4;
    } else if (heartRate >= 71) {
      score += 3;
    }
    // <=70: 0 points
    
    // Gender
    if (_gender == 'female') {
      score += 8;
    }
    
    // Signs of congestive heart failure at presentation
    // (approximated by systolic BP <90)
    final systolicBp = int.tryParse(_systolicBpController.text) ?? 0;
    if (systolicBp < 90) {
      score += 7;
    }
    
    // Prior vascular disease
    if (_priorVascularDisease == 'yes') {
      score += 6;
    }
    
    // Diabetes mellitus
    if (_diabetesStatus == 'yes') {
      score += 6;
    }

    setState(() {
      _totalScore = score;
    });
  }

  Color get riskColor {
    if (_totalScore <= 20) {
      return Colors.green;
    }
    if (_totalScore <= 30) {
      return Colors.yellow.shade700;
    }
    if (_totalScore <= 40) {
      return Colors.orange;
    }
    if (_totalScore <= 50) {
      return Colors.red.shade700;
    }
    return Colors.red.shade900;
  }

  String get riskLevel {
    if (_totalScore <= 20) {
      return 'Rất thấp';
    }
    if (_totalScore <= 30) {
      return 'Thấp';
    }
    if (_totalScore <= 40) {
      return 'Trung bình';
    }
    if (_totalScore <= 50) {
      return 'Cao';
    }
    return 'Rất cao';
  }

  String get bleedingRisk {
    if (_totalScore <= 20) {
      return '3.1%';
    }
    if (_totalScore <= 30) {
      return '5.5%';
    }
    if (_totalScore <= 40) {
      return '8.6%';
    }
    if (_totalScore <= 50) {
      return '11.9%';
    }
    return '19.5%';
  }

  String get majorBleedingRisk {
    if (_totalScore <= 20) {
      return 'Rất thấp (<5%)';
    }
    if (_totalScore <= 30) {
      return 'Thấp (5-10%)';
    }
    if (_totalScore <= 40) {
      return 'Trung bình (10-15%)';
    }
    if (_totalScore <= 50) {
      return 'Cao (15-20%)';
    }
    return 'Rất cao (>20%)';
  }

  String get recommendations {
    if (_totalScore <= 20) {
      return 'Có thể sử dụng chiến lược xâm lấn sớm và thuốc chống đông mạnh';
    }
    if (_totalScore <= 30) {
      return 'Cân nhắc lợi ích/nguy cơ của chiến lược xâm lấn và thuốc chống đông';
    }
    if (_totalScore <= 40) {
      return 'Thận trọng với chiến lược xâm lấn, theo dõi chặt chẽ';
    }
    if (_totalScore <= 50) {
      return 'Ưu tiên chiến lược bảo tồn, hạn chế thuốc chống đông mạnh';
    }
    return 'Chiến lược bảo tồn, tránh thuốc chống đông mạnh trừ khi cần thiết';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUSADE Bleeding Risk'),
        backgroundColor: Colors.red.shade800,
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
                    'CRUSADE Score',
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

            // Clinical Approach
            _buildClinicalApproach(),

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
                    'Nguy cơ chảy máu',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    bleedingRisk,
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
                    'Chảy máu nặng',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    majorBleedingRisk,
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
        border: Border.all(color: Colors.blue.shade300),
        color: Colors.blue.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông số lâm sàng',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          // Hematocrit
          TextField(
            controller: _hematocritController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Hematocrit',
              suffixText: '%',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: 'Tỷ lệ thể tích hồng cầu',
            ),
          ),
          const SizedBox(height: 12),
          
          // Creatinine
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
              helperText: 'Nồng độ creatinine huyết thanh',
            ),
          ),
          const SizedBox(height: 12),
          
          // Heart Rate
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
              helperText: 'Tần số tim lúc nhập viện',
            ),
          ),
          const SizedBox(height: 12),
          
          // Systolic BP
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
              helperText: 'Để đánh giá dấu hiệu suy tim',
            ),
          ),
          const SizedBox(height: 16),
          
          // Gender
          Text(
            'Giới tính',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Nam'),
                  value: 'male',
                  // ignore: deprecated_member_use
                  groupValue: _gender,
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                    _calculateScore();
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Nữ (+8)'),
                  value: 'female',
                  // ignore: deprecated_member_use
                  groupValue: _gender,
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                    _calculateScore();
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          
          // Diabetes
          Text(
            'Đái tháo đường',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Không'),
                  value: 'no',
                  // ignore: deprecated_member_use
                  groupValue: _diabetesStatus,
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    setState(() {
                      _diabetesStatus = value!;
                    });
                    _calculateScore();
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Có (+6)'),
                  value: 'yes',
                  // ignore: deprecated_member_use
                  groupValue: _diabetesStatus,
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    setState(() {
                      _diabetesStatus = value!;
                    });
                    _calculateScore();
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          
          // Prior vascular disease
          Text(
            'Tiền sử bệnh mạch máu',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Không'),
                  value: 'no',
                  // ignore: deprecated_member_use
                  groupValue: _priorVascularDisease,
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    setState(() {
                      _priorVascularDisease = value!;
                    });
                    _calculateScore();
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Có (+6)'),
                  value: 'yes',
                  // ignore: deprecated_member_use
                  groupValue: _priorVascularDisease,
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    setState(() {
                      _priorVascularDisease = value!;
                    });
                    _calculateScore();
                  },
                  contentPadding: EdgeInsets.zero,
                ),
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
        border: Border.all(color: Colors.green.shade300),
        color: Colors.green.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phân tầng nguy cơ CRUSADE',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('≤20', 'Rất thấp', '3.1%', 'Xâm lấn tích cực', Colors.green),
          _buildRiskItem('21-30', 'Thấp', '5.5%', 'Cân nhắc xâm lấn', Colors.yellow.shade700),
          _buildRiskItem('31-40', 'Trung bình', '8.6%', 'Thận trọng', Colors.orange),
          _buildRiskItem('41-50', 'Cao', '11.9%', 'Ưu tiên bảo tồn', Colors.red.shade700),
          _buildRiskItem('>50', 'Rất cao', '19.5%', 'Bảo tồn', Colors.red.shade900),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String risk, String bleedingRate, String strategy, Color color) {
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
                  bleedingRate,
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
            strategy,
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

  Widget _buildClinicalApproach() {
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
            'Chiến lược điều trị',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildStrategyCard(
            'Chiến lược xâm lấn (Nguy cơ thấp)',
            [
              'Can thiệp mạch vành sớm',
              'GPIIb/IIIa inhibitor',
              'Dual antiplatelet therapy',
              'Anticoagulation đầy đủ',
            ],
            Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildStrategyCard(
            'Chiến lược bảo tồn (Nguy cơ cao)',
            [
              'Điều trị nội khoa tối ưu',
              'Tránh GPIIb/IIIa inhibitor',
              'Cân nhắc aspirin đơn độc',
              'Heparin liều thấp',
            ],
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildStrategyCard(String title, List<String> items, Color color) {
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
            'CRUSADE Score đánh giá nguy cơ chảy máu trong hội chứng mạch vành cấp\n\n'
            'Ứng dụng lâm sàng:\n'
            '• Lựa chọn chiến lược xâm lấn vs bảo tồn\n'
            '• Quyết định sử dụng GPIIb/IIIa inhibitor\n'
            '• Cân nhắc dual antiplatelet therapy\n'
            '• Tối ưu hóa liều thuốc chống đông\n\n'
            'Các yếu tố chính:\n'
            '• Hematocrit: phản ánh thiếu máu\n'
            '• Creatinine: chức năng thận\n'
            '• Tần số tim: mức độ bệnh nặng\n'
            '• Giới tính nữ: nguy cơ cao hơn\n'
            '• Đái tháo đường: biến chứng mạch máu\n'
            '• Tiền sử mạch máu: nguy cơ cao\n\n'
            'Lưu ý quan trọng:\n'
            '• Không loại trừ điều trị khi điểm cao\n'
            '• Cân bằng nguy cơ ischemia vs chảy máu\n'
            '• Có thể điều chỉnh liều thuốc\n'
            '• Theo dõi chặt chẽ bệnh nhân nguy cơ cao\n'
            '• Tái đánh giá khi tình trạng thay đổi',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _hematocritController.dispose();
    _creatinineController.dispose();
    _heartRateController.dispose();
    _systolicBpController.dispose();
    super.dispose();
  }
}
