import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class DaptScorePage extends StatefulWidget {
  const DaptScorePage({super.key});

  @override
  State<DaptScorePage> createState() => _DaptScorePageState();
}

class _DaptScorePageState extends State<DaptScorePage> {
  final TextEditingController _ageController = TextEditingController();
  
  bool _cigaretteSmoking = false;
  bool _diabetesMellitus = false;
  bool _myocardialInfarction = false;
  bool _stentType = false; // false = BMS/DES, true = BMS
  bool _stentDiameter = false; // false = ≥3mm, true = <3mm
  bool _congestiveHeartFailure = false;
  final bool _leftVentricular = false; // LVEF <30%
  bool _saphenousVeinGraft = false;

  int _daptScore = 0;

  @override
  void initState() {
    super.initState();
    _ageController.addListener(_calculateScore);
  }

  void _calculateScore() {
    final age = int.tryParse(_ageController.text) ?? 0;
    
    int score = 0;
    
    // Age
    if (age >= 75) {
      score -= 2;
    } else if (age >= 65) {
      score -= 1;
    }
    
    // Risk factors for ischemic events (increase score)
    if (_cigaretteSmoking) {
      score += 1;
    }
    if (_diabetesMellitus) {
      score += 1;
    }
    if (_myocardialInfarction) {
      score += 1;
    }
    if (_stentType) score += 1; // BMS
    if (_stentDiameter) score += 1; // <3mm
    if (_congestiveHeartFailure) {
      score += 2;
    }
    if (_leftVentricular) score += 1; // LVEF <30%
    if (_saphenousVeinGraft) {
      score += 1;
    }

    setState(() {
      _daptScore = score;
    });
  }

  Color get recommendationColor {
    if (_daptScore >= 2) {
      return Colors.green;
    }
    return Colors.red;
  }

  String get recommendation {
    if (_daptScore >= 2) {
      return 'Tiếp tục DAPT';
    }
    return 'Ngừng DAPT';
  }

  String get reasoning {
    if (_daptScore >= 2) {
      return 'Lợi ích giảm nguy cơ thiếu máu cục bộ > Nguy cơ chảy máu';
    } else {
      return 'Nguy cơ chảy máu > Lợi ích giảm thiếu máu cục bộ';
    }
  }

  String get ischemicBenefit {
    if (_daptScore >= 2) {
      return 'Giảm 41% nguy cơ MACE';
    }
    return 'Giảm 7% nguy cơ MACE';
  }

  String get bleedingRisk {
    if (_daptScore >= 2) {
      return 'Tăng 31% nguy cơ chảy máu nặng';
    }
    return 'Tăng 61% nguy cơ chảy máu nặng';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DAPT Score'),
        backgroundColor: Colors.cyan.shade700,
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
                color: recommendationColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: recommendationColor.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    'DAPT Score',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: recommendationColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_daptScore',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: recommendationColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    recommendation,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildRecommendationInfo(),
                ],
              ),
            ),

            // Input Parameters
            _buildPatientFactors(),
            _buildClinicalFactors(),

            // Risk-Benefit Analysis
            _buildRiskBenefitAnalysis(),

            // Clinical Guidelines
            _buildClinicalGuidelines(),

            // Clinical Information
            _buildClinicalInfo(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationInfo() {
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
                    'Lợi ích thiếu máu',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    ischemicBenefit,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
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
                      fontSize: 12,
                      color: Colors.red,
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
              color: recommendationColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: recommendationColor.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.psychology, color: recommendationColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Cơ sở:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: recommendationColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  reasoning,
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

  Widget _buildPatientFactors() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.cyan.shade300),
        color: Colors.cyan.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Yếu tố bệnh nhân',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade700,
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
              helperText: '≥75 tuổi: -2 điểm, 65-74 tuổi: -1 điểm',
            ),
          ),
          const SizedBox(height: 16),
          
          _buildRiskFactorCheckbox(
            'Hút thuốc lá',
            'Hiện tại hoặc trong vòng 1 năm',
            _cigaretteSmoking,
            (value) {
              setState(() {
                _cigaretteSmoking = value!;
              });
              _calculateScore();
            },
            '+1 điểm',
          ),
          
          _buildRiskFactorCheckbox(
            'Đái tháo đường',
            'Dùng thuốc điều trị',
            _diabetesMellitus,
            (value) {
              setState(() {
                _diabetesMellitus = value!;
              });
              _calculateScore();
            },
            '+1 điểm',
          ),
        ],
      ),
    );
  }

  Widget _buildClinicalFactors() {
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
            'Yếu tố lâm sàng & can thiệp',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildRiskFactorCheckbox(
            'Nhồi máu cơ tim trước PCI',
            'MI tại nhập viện hoặc trước đó',
            _myocardialInfarction,
            (value) {
              setState(() {
                _myocardialInfarction = value!;
              });
              _calculateScore();
            },
            '+1 điểm',
          ),
          
          _buildRiskFactorCheckbox(
            'Suy tim hoặc LVEF <30%',
            'Suy tim lâm sàng hoặc phân suất tống máu <30%',
            _congestiveHeartFailure,
            (value) {
              setState(() {
                _congestiveHeartFailure = value!;
              });
              _calculateScore();
            },
            '+2 điểm',
          ),
          
          _buildRiskFactorCheckbox(
            'Can thiệp tĩnh mạch ghép',
            'PCI trên saphenous vein graft',
            _saphenousVeinGraft,
            (value) {
              setState(() {
                _saphenousVeinGraft = value!;
              });
              _calculateScore();
            },
            '+1 điểm',
          ),
          
          const SizedBox(height: 16),
          
          Text(
            'Đặc điểm stent',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 8),
          
          _buildRiskFactorCheckbox(
            'Stent kim loại trần (BMS)',
            'So với drug-eluting stent',
            _stentType,
            (value) {
              setState(() {
                _stentType = value!;
              });
              _calculateScore();
            },
            '+1 điểm',
          ),
          
          _buildRiskFactorCheckbox(
            'Đường kính stent <3mm',
            'Stent nhỏ có nguy cơ cao hơn',
            _stentDiameter,
            (value) {
              setState(() {
                _stentDiameter = value!;
              });
              _calculateScore();
            },
            '+1 điểm',
          ),
        ],
      ),
    );
  }

  Widget _buildRiskFactorCheckbox(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool?> onChanged,
    String points,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: value ? Colors.blue.withValues(alpha: 0.1) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: value ? Colors.blue.withValues(alpha: 0.3) : Colors.grey.shade300,
        ),
      ),
      child: CheckboxListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: value ? FontWeight.w600 : FontWeight.normal,
            color: value ? Colors.blue.shade700 : Colors.grey.shade700,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
            if (value) ...[
              const SizedBox(height: 4),
              Text(
                points,
                style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
        value: value,
        // ignore: deprecated_member_use
        onChanged: onChanged,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }

  Widget _buildRiskBenefitAnalysis() {
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
            'Phân tích lợi ích - nguy cơ',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildAnalysisCard(
            'DAPT Score ≥2: Tiếp tục DAPT',
            [
              'Giảm 41% nguy cơ MACE',
              'Giảm 43% nguy cơ nhồi máu cơ tim',
              'Giảm 67% nguy cơ huyết khối stent',
              'Tăng 31% nguy cơ chảy máu nặng',
            ],
            Colors.green,
            'Lợi ích > Nguy cơ',
          ),
          const SizedBox(height: 12),
          _buildAnalysisCard(
            'DAPT Score <2: Ngừng DAPT',
            [
              'Giảm 7% nguy cơ MACE (không có ý nghĩa)',
              'Tăng 61% nguy cơ chảy máu nặng',
              'Giảm nguy cơ chảy máu đường tiêu hóa',
              'Giảm nguy cơ chảy máu nội sọ',
            ],
            Colors.red,
            'Nguy cơ > Lợi ích',
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisCard(String title, List<String> points, Color color, String conclusion) {
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
              Icon(Icons.analytics, color: color, size: 20),
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
          ...points.map((point) => Padding(
            padding: const EdgeInsets.only(left: 28, bottom: 2),
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
                    point,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              conclusion,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
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
            'DAPT Score ≥2: Khuyến nghị DAPT kéo dài',
            [
              'Tiếp tục aspirin + P2Y12 inhibitor',
              'Thời gian: thêm 18-30 tháng',
              'Theo dõi chức năng thận, gan',
              'Tư vấn dấu hiệu chảy máu',
            ],
            Colors.green,
          ),
          const SizedBox(height: 12),
          _buildGuidelineCard(
            'DAPT Score <2: Ngừng DAPT',
            [
              'Chuyển sang aspirin đơn trị',
              'Liều aspirin 75-100mg/ngày',
              'Theo dõi biến cố tim mạch',
              'Tái khám định kỳ',
            ],
            Colors.red,
          ),
          const SizedBox(height: 12),
          _buildGuidelineCard(
            'Trường hợp đặc biệt',
            [
              'Nguy cơ chảy máu cao: cân nhắc ngừng',
              'Bệnh nhân già: đánh giá cẩn thận',
              'Tương tác thuốc: điều chỉnh liều',
              'Phẫu thuật: tạm ngừng tối thiểu',
            ],
            Colors.orange,
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
            'DAPT Score hỗ trợ quyết định tiếp tục hay ngừng thuốc chống kết tập tiểu cầu kép\n\n'
            'Nguồn gốc:\n'
            '• Nghiên cứu DAPT Trial (n=25,682)\n'
            '• So sánh DAPT vs placebo sau 12 tháng\n'
            '• Phát triển năm 2016\n'
            '• Validation ở nhiều nghiên cứu\n\n'
            'Thành phần DAPT:\n'
            '• Aspirin 75-100mg\n'
            '• P2Y12 inhibitor (clopidogrel/ticagrelor/prasugrel)\n'
            '• Thời gian tối thiểu 12 tháng sau ACS/PCI\n\n'
            'Cơ chế tác dụng:\n'
            '• Ức chế COX-1 (aspirin)\n'
            '• Ức chế P2Y12 receptor\n'
            '• Giảm kết tập tiểu cầu\n'
            '• Ngăn ngừa huyết khối\n\n'
            'Biến chứng DAPT:\n'
            '• Chảy máu đường tiêu hóa\n'
            '• Chảy máu nội sọ\n'
            '• Chảy máu niêm mạc\n'
            '• Tương tác thuốc\n\n'
            'Ứng dụng:\n'
            '• Sau nhồi máu cơ tim\n'
            '• Sau can thiệp mạch vành\n'
            '• Bệnh động mạch vành ổn định\n'
            '• Phòng ngừa thứ phát\n\n'
            'Hạn chế:\n'
            '• Không áp dụng cho tất cả bệnh nhân\n'
            '• Cần đánh giá nguy cơ chảy máu\n'
            '• Thay đổi theo thời gian\n'
            '• Kết hợp với đánh giá lâm sàng',
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
