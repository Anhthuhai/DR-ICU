import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ImproveBleedingRiskPage extends StatefulWidget {
  const ImproveBleedingRiskPage({super.key});

  @override
  State<ImproveBleedingRiskPage> createState() => _ImproveBleedingRiskPageState();
}

class _ImproveBleedingRiskPageState extends State<ImproveBleedingRiskPage> {
  final TextEditingController _ageController = TextEditingController();

  bool _female = false;
  bool _cancer = false;
  bool _dialysis = false;
  bool _liverDisease = false;
  bool _icuStay = false;
  bool _icu48h = false;
  bool _anticoagulants = false;

  int _totalScore = 0;

  @override
  void initState() {
    super.initState();
    _ageController.addListener(_calculateScore);
  }

  void _calculateScore() {
    int score = 0;
    
    // Age
    final age = int.tryParse(_ageController.text) ?? 0;
    if (age >= 40) {
      score += 1;
    }
    
    // Female gender
    if (_female) {
      score += 1;
    }
    
    // Cancer
    if (_cancer) {
      score += 2;
    }
    
    // Dialysis
    if (_dialysis) {
      score += 2;
    }
    
    // Liver disease
    if (_liverDisease) {
      score += 2;
    }
    
    // ICU stay
    if (_icuStay) {
      score += 2;
    }
    
    // ICU stay >48h
    if (_icu48h) {
      score += 1;
    }
    
    // Anticoagulants
    if (_anticoagulants) {
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
    if (_totalScore <= 6) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String get riskLevel {
    if (_totalScore <= 2) {
      return 'Nguy cơ thấp';
    }
    if (_totalScore <= 6) {
      return 'Nguy cơ trung bình';
    }
    return 'Nguy cơ cao';
  }

  String get bleedingRisk {
    if (_totalScore <= 2) {
      return '0.4%';
    }
    if (_totalScore <= 6) {
      return '1.1%';
    }
    return '4.1%';
  }

  String get majorBleedingRisk {
    if (_totalScore <= 2) {
      return '< 1%';
    }
    if (_totalScore <= 6) {
      return '1-3%';
    }
    return '> 3%';
  }

  String get recommendations {
    if (_totalScore <= 2) {
      return 'Có thể sử dụng thuốc chống đông phòng ngừa tiêu chuẩn';
    }
    if (_totalScore <= 6) {
      return 'Cần cân nhắc lợi ích/nguy cơ, theo dõi chặt chẽ khi dùng thuốc chống đông';
    }
    return 'Thận trọng với thuốc chống đông, cân nhắc các biện pháp cơ học phòng tắc mạch';
  }

  String get prophylaxisStrategy {
    if (_totalScore <= 2) {
      return 'Prophylaxis tiêu chuẩn';
    }
    if (_totalScore <= 6) {
      return 'Prophylaxis cẩn thận, giảm liều';
    }
    return 'Cân nhắc prophylaxis cơ học';
  }

  List<Map<String, dynamic>> get riskFactors {
    return [
      {
        'factor': 'Tuổi ≥40',
        'description': 'Tuổi từ 40 trở lên',
        'points': 1,
        'active': (int.tryParse(_ageController.text) ?? 0) >= 40,
      },
      {
        'factor': 'Nữ giới',
        'description': 'Giới tính nữ',
        'points': 1,
        'active': _female,
      },
      {
        'factor': 'Ung thư',
        'description': 'Ung thư hiện tại hoặc tiền sử',
        'points': 2,
        'active': _cancer,
      },
      {
        'factor': 'Chạy thận',
        'description': 'Chạy thận nhân tạo',
        'points': 2,
        'active': _dialysis,
      },
      {
        'factor': 'Bệnh gan',
        'description': 'Bệnh gan mạn tính',
        'points': 2,
        'active': _liverDisease,
      },
      {
        'factor': 'Nằm ICU',
        'description': 'Đang điều trị tại ICU',
        'points': 2,
        'active': _icuStay,
      },
      {
        'factor': 'ICU >48h',
        'description': 'Nằm ICU quá 48 giờ',
        'points': 1,
        'active': _icu48h,
      },
      {
        'factor': 'Thuốc chống đông',
        'description': 'Đang dùng thuốc chống đông',
        'points': 1,
        'active': _anticoagulants,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMPROVE Bleeding Risk'),
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
                    'IMPROVE Bleeding Risk',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_totalScore/12',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
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
            if (_totalScore > 0) _buildActiveFactors(),

            // Risk Stratification
            _buildRiskStratification(),

            // Clinical Information
            _buildClinicalInfo(),

            // Medical Citation
            Container(
              margin: const EdgeInsets.all(16),
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
                    'Hostler DC, Marx ES, Moores LK, et al. Validation of the International Medical Prevention Registry on Venous Thromboembolism bleeding risk score. Chest. 2016;149(2):372-9.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ],
              ),
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
                    Icon(Icons.medical_services, color: riskColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Chiến lược prophylaxis:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  prophylaxisStrategy,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkGrey,
                  ),
                ),
                const SizedBox(height: 12),
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
        border: Border.all(color: Colors.red.shade300),
        color: Colors.red.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin bệnh nhân',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
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
              helperText: '+1 điểm nếu ≥40 tuổi',
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
            'Yếu tố nguy cơ chảy máu',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            title: const Text('Nữ giới (+1)'),
            subtitle: const Text('Giới tính nữ'),
            value: _female,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _female = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Ung thư (+2)'),
            subtitle: const Text('Ung thư hiện tại hoặc tiền sử'),
            value: _cancer,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _cancer = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Chạy thận (+2)'),
            subtitle: const Text('Chạy thận nhân tạo'),
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
          
          CheckboxListTile(
            title: const Text('Bệnh gan (+2)'),
            subtitle: const Text('Bệnh gan mạn tính'),
            value: _liverDisease,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _liverDisease = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Nằm ICU (+2)'),
            subtitle: const Text('Đang điều trị tại ICU'),
            value: _icuStay,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _icuStay = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('ICU >48h (+1)'),
            subtitle: const Text('Nằm ICU quá 48 giờ'),
            value: _icu48h,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _icu48h = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Thuốc chống đông (+1)'),
            subtitle: const Text('Đang dùng thuốc chống đông'),
            value: _anticoagulants,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _anticoagulants = value!;
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
          ...activeFactors.map((factor) => Container(
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
        border: Border.all(color: Colors.green.shade300),
        color: Colors.green.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phân tầng nguy cơ chảy máu',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('0-2', 'Nguy cơ thấp', '0.4%', 'Prophylaxis tiêu chuẩn', Colors.green),
          _buildRiskItem('3-6', 'Nguy cơ trung bình', '1.1%', 'Prophylaxis cẩn thận', Colors.orange),
          _buildRiskItem('7-12', 'Nguy cơ cao', '4.1%', 'Cân nhắc prophylaxis cơ học', Colors.red),
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
            'IMPROVE Bleeding Risk Score đánh giá nguy cơ chảy máu khi prophylaxis tắc mạch\n\n'
            'Ứng dụng lâm sàng:\n'
            '• Quyết định loại prophylaxis tắc mạch\n'
            '• Cân nhắc lợi ích/nguy cơ thuốc chống đông\n'
            '• Lựa chọn giữa prophylaxis dược lý vs cơ học\n'
            '• Theo dõi chặt chẽ bệnh nhân nguy cơ cao\n\n'
            'Prophylaxis cơ học bao gồm:\n'
            '• Tất áp lực\n'
            '• Nén khí gián đoạn\n'
            '• Vận động sớm\n'
            '• Nâng chân\n\n'
            'Lưu ý quan trọng:\n'
            '• Cân bằng nguy cơ chảy máu vs tắc mạch\n'
            '• Đánh giá lại khi tình trạng thay đổi\n'
            '• Kết hợp với các yếu tố lâm sàng khác\n'
            '• Theo dõi các dấu hiệu chảy máu',
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
