import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class TimiUaNstemiPage extends StatefulWidget {
  const TimiUaNstemiPage({super.key});

  @override
  State<TimiUaNstemiPage> createState() => _TimiUaNstemiPageState();
}

class _TimiUaNstemiPageState extends State<TimiUaNstemiPage> {
  final TextEditingController _ageController = TextEditingController();

  bool _cad = false; // ≥3 CAD risk factors
  bool _knownCad = false; // Known CAD (stenosis ≥50%)
  bool _aspirinUse = false; // Aspirin use in prior 7 days
  bool _severeAngina = false; // ≥2 anginal events in 24h
  bool _stChanges = false; // ST changes ≥0.5mm
  bool _elevatedMarkers = false; // Elevated cardiac markers

  int _totalScore = 0;

  @override
  void initState() {
    super.initState();
    _ageController.addListener(_calculateScore);
  }

  void _calculateScore() {
    int score = 0;
    
    // Age ≥65
    final age = int.tryParse(_ageController.text) ?? 0;
    if (age >= 65) {
      score += 1;
    }
    
    // ≥3 CAD risk factors
    if (_cad) {
      score += 1;
    }
    
    // Known CAD (stenosis ≥50%)
    if (_knownCad) {
      score += 1;
    }
    
    // Aspirin use in prior 7 days
    if (_aspirinUse) {
      score += 1;
    }
    
    // ≥2 severe anginal events in 24h
    if (_severeAngina) {
      score += 1;
    }
    
    // ST changes ≥0.5mm
    if (_stChanges) {
      score += 1;
    }
    
    // Elevated cardiac markers
    if (_elevatedMarkers) {
      score += 1;
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
    return 'Nguy cơ cao';
  }

  String get eventRisk14Days {
    if (_totalScore == 0) {
      return '4.7%';
    }
    if (_totalScore == 1) {
      return '8.3%';
    }
    if (_totalScore == 2) {
      return '16.6%';
    }
    if (_totalScore == 3) {
      return '24.2%';
    }
    if (_totalScore == 4) {
      return '29.4%';
    }
    if (_totalScore == 5) {
      return '38.7%';
    }
    if (_totalScore == 6) {
      return '40.9%';
    }
    return '41.0%';
  }

  String get mortalityRisk {
    if (_totalScore <= 2) {
      return '3.4%';
    }
    if (_totalScore <= 4) {
      return '9.4%';
    }
    return '19.9%';
  }

  String get recommendations {
    if (_totalScore <= 2) {
      return 'Điều trị nội khoa, theo dõi ngoại trú có thể xem xét';
    }
    if (_totalScore <= 4) {
      return 'Nhập viện theo dõi, cân nhắc can thiệp sớm trong 24-48h';
    }
    return 'Can thiệp mạch vành sớm trong 24h, điều trị tích cực';
  }

  String get managementStrategy {
    if (_totalScore <= 2) {
      return 'Chiến lược bảo tồn';
    }
    if (_totalScore <= 4) {
      return 'Chiến lược can thiệp chọn lọc';
    }
    return 'Chiến lược can thiệp sớm';
  }

  List<Map<String, dynamic>> get riskFactors {
    return [
      {
        'factor': 'Tuổi ≥65',
        'description': 'Yếu tố nguy cơ tuổi tác',
        'active': (int.tryParse(_ageController.text) ?? 0) >= 65,
      },
      {
        'factor': '≥3 yếu tố nguy cơ CAD',
        'description': 'Gia đình, THA, ĐTĐ, hút thuốc, cholesterol cao',
        'active': _cad,
      },
      {
        'factor': 'CAD đã biết (hẹp ≥50%)',
        'description': 'Tiền sử can thiệp hoặc hình ảnh chứng minh',
        'active': _knownCad,
      },
      {
        'factor': 'Dùng Aspirin 7 ngày gần đây',
        'description': 'Sử dụng aspirin trước khi nhập viện',
        'active': _aspirinUse,
      },
      {
        'factor': '≥2 cơn đau ngực nặng/24h',
        'description': 'Đau thắt ngực tăng dần hoặc lặp lại',
        'active': _severeAngina,
      },
      {
        'factor': 'Chênh ST ≥0.5mm',
        'description': 'Thay đổi ST segment trên ECG',
        'active': _stChanges,
      },
      {
        'factor': 'Tăng enzyme tim',
        'description': 'Troponin hoặc CK-MB tăng',
        'active': _elevatedMarkers,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TIMI Score - UA/NSTEMI'),
        backgroundColor: Colors.orange.shade700,
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
                    'TIMI Score - UA/NSTEMI',
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

            // Risk Factors
            _buildRiskFactorsSection(),

            // Active Risk Factors
            _buildActiveFactors(),

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
                    'Biến cố 14 ngày',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    eventRisk14Days,
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
                Text(
                  'Chiến lược điều trị:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: riskColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  managementStrategy,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkGrey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Khuyến nghị:',
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
        border: Border.all(color: Colors.orange.shade300),
        color: Colors.orange.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin bệnh nhân',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
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
              helperText: 'Điểm nếu ≥65 tuổi',
            ),
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
            title: const Text('≥3 yếu tố nguy cơ CAD'),
            subtitle: const Text('Gia đình, THA, ĐTĐ, hút thuốc, cholesterol cao'),
            value: _cad,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _cad = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('CAD đã biết (hẹp ≥50%)'),
            subtitle: const Text('Tiền sử can thiệp hoặc hình ảnh chứng minh'),
            value: _knownCad,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _knownCad = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Dùng Aspirin 7 ngày gần đây'),
            subtitle: const Text('Sử dụng aspirin trước khi nhập viện'),
            value: _aspirinUse,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _aspirinUse = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('≥2 cơn đau ngực nặng trong 24h'),
            subtitle: const Text('Đau thắt ngực tăng dần hoặc lặp lại'),
            value: _severeAngina,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _severeAngina = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Chênh ST ≥0.5mm'),
            subtitle: const Text('Thay đổi ST segment trên ECG'),
            value: _stChanges,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _stChanges = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Tăng enzyme tim'),
            subtitle: const Text('Troponin hoặc CK-MB tăng'),
            value: _elevatedMarkers,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _elevatedMarkers = value!;
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
        border: Border.all(color: Colors.green.shade300),
        color: Colors.green.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Yếu tố nguy cơ hiện tại (${activeFactors.length})',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 12),
          ...activeFactors.map((factor) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: riskColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '+1',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
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
                        factor['factor'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        factor['description'],
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
            'Phân tầng nguy cơ biến cố tim mạch',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('0-2', 'Nguy cơ thấp', '4.7-16.6%', 'Bảo tồn', Colors.green),
          _buildRiskItem('3-4', 'Nguy cơ trung bình', '24.2-29.4%', 'Can thiệp chọn lọc', Colors.orange),
          _buildRiskItem('5-7', 'Nguy cơ cao', '38.7-41.0%', 'Can thiệp sớm', Colors.red),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String risk, String eventRate, String strategy, Color color) {
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
                  eventRate,
                  style: TextStyle(color: Colors.grey.shade700),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            strategy,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: color,
              fontWeight: FontWeight.w500,
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
        color: Colors.indigo.shade50,
        border: Border.all(color: Colors.indigo.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.indigo.shade600),
              const SizedBox(width: 8),
              Text(
                'Thông tin lâm sàng',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'TIMI Score for UA/NSTEMI đánh giá nguy cơ biến cố tim mạch trong 14 ngày\n\n'
            'Biến cố bao gồm:\n'
            '• Tử vong tim mạch\n'
            '• Nhồi máu cơ tim mới\n'
            '• Cần can thiệp mạch vành cấp cứu\n\n'
            'Ứng dụng lâm sàng:\n'
            '• Phân tầng nguy cơ và lựa chọn chiến lược\n'
            '• Quyết định thời điểm can thiệp\n'
            '• Tư vấn tiên lượng\n'
            '• Đánh giá chỉ định xuất viện sớm\n\n'
            'Lưu ý:\n'
            '• Áp dụng cho UA/NSTEMI, không phải STEMI\n'
            '• Kết hợp với Troponin để tăng độ chính xác\n'
            '• Can thiệp sớm có lợi ích ở nhóm nguy cơ cao',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }
}
