import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class GraceScorePage extends StatefulWidget {
  const GraceScorePage({super.key});

  @override
  State<GraceScorePage> createState() => _GraceScorePageState();
}

class _GraceScorePageState extends State<GraceScorePage> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _systolicBPController = TextEditingController();
  final TextEditingController _creatinineController = TextEditingController();
  
  // Unit variables
  String _creatinineUnit = 'mg/dL';
  
  bool _heartFailure = false;
  bool _cardiacArrest = false;
  bool _stElevation = false;
  bool _elevatedMarkers = false;

  int _totalScore = 0;

    @override
  void initState() {
    super.initState();
    _ageController.addListener(_calculateScore);
    _heartRateController.addListener(_calculateScore);
    _systolicBPController.addListener(_calculateScore);
    _creatinineController.addListener(_calculateScore);
  }

  // Unit conversion functions
  double convertCreatinineToMgDL(double value, String unit) {
    if (unit == 'umol/L') {
      return value / 88.42; // Convert umol/L to mg/dL
    }
    return value; // Already in mg/dL
  }

  void _calculateScore() {
    int score = 0;
    
    // Age
    final age = int.tryParse(_ageController.text) ?? 0;
    if (age >= 80) {
      score += 100;
    } else if (age >= 70) {
      score += 91;
    } else if (age >= 60) {
      score += 61;
    } else if (age >= 50) {
      score += 32;
    } else if (age >= 40) {
      score += 8;
    }
    
    // Heart Rate
    final hr = int.tryParse(_heartRateController.text) ?? 0;
    if (hr >= 200) {
      score += 46;
    } else if (hr >= 170) {
      score += 38;
    } else if (hr >= 140) {
      score += 29;
    } else if (hr >= 110) {
      score += 19;
    } else if (hr >= 80) {
      score += 9;
    }
    
    // Systolic BP
    final sbp = int.tryParse(_systolicBPController.text) ?? 0;
    if (sbp >= 200) {
      score += 0;
    }
    else if (sbp >= 160) {
   score += 10;
 }
    else if (sbp >= 140) {
   score += 15;
 }
    else if (sbp >= 120) {
   score += 19;
 }
    else if (sbp >= 100) {
   score += 24;
 }
    else if (sbp >= 80) {
   score += 34;
 }
    else if (sbp > 0) {
   score += 43;
 }
    
    // Creatinine
    final creatinineInput = double.tryParse(_creatinineController.text) ?? 0;
    final creatinine = convertCreatinineToMgDL(creatinineInput, _creatinineUnit);
    if (creatinine >= 4.0) {
      score += 28;
    }
    else if (creatinine >= 2.0) {
   score += 21;
 }
    else if (creatinine >= 1.4) {
   score += 13;
 }
    else if (creatinine >= 1.2) {
   score += 7;
 }
    else if (creatinine >= 1.0) {
   score += 4;
 }
    
    // Additional factors
    if (_heartFailure) {
      score += 39;
    }
    if (_cardiacArrest) {
      score += 39;
    }
    if (_stElevation) {
      score += 28;
    }
    if (_elevatedMarkers) {
      score += 14;
    }

    setState(() {
      _totalScore = score;
    });
  }

  Color get riskColor {
    if (_totalScore <= 108) {
      return Colors.green;
    }
    if (_totalScore <= 140) {
      return Colors.yellow.shade700;
    }
    if (_totalScore <= 200) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String get riskLevel {
    if (_totalScore <= 108) {
      return 'Nguy cơ thấp';
    }
    if (_totalScore <= 140) {
      return 'Nguy cơ trung bình';
    }
    if (_totalScore <= 200) {
      return 'Nguy cơ cao';
    }
    return 'Nguy cơ rất cao';
  }

  String get mortalityRisk {
    if (_totalScore <= 108) {
      return '< 1%';
    }
    if (_totalScore <= 140) {
      return '1-3%';
    }
    if (_totalScore <= 200) {
      return '3-8%';
    }
    return '> 8%';
  }

  String get hospitalizationMortality {
    if (_totalScore <= 108) {
      return '< 2%';
    }
    if (_totalScore <= 140) {
      return '2-5%';
    }
    if (_totalScore <= 200) {
      return '5-12%';
    }
    return '> 12%';
  }

  String get recommendations {
    if (_totalScore <= 108) {
      return 'Điều trị ngoại trú có thể xem xét, theo dõi thường xuyên';
    }
    if (_totalScore <= 140) {
      return 'Nhập viện theo dõi, điều trị theo hướng dẫn ACS';
    }
    if (_totalScore <= 200) {
      return 'Cần can thiệp sớm, xem xét chuyển tuyến cao';
    }
    return 'Can thiệp cấp cứu ngay, ICU monitoring, PCI sớm';
  }

  String get interventionStrategy {
    if (_totalScore <= 108) {
      return 'Chiến lược bảo tồn';
    }
    if (_totalScore <= 140) {
      return 'Chiến lược can thiệp chọn lọc';
    }
    if (_totalScore <= 200) {
      return 'Chiến lược can thiệp sớm';
    }
    return 'Chiến lược can thiệp ngay lập tức';
  }

  String get interventionTiming {
    if (_totalScore <= 108) {
      return 'Can thiệp trong vòng 72 giờ';
    }
    if (_totalScore <= 140) {
      return 'Can thiệp trong vòng 24-72 giờ';
    }
    if (_totalScore <= 200) {
      return 'Can thiệp trong vòng 24 giờ';
    }
    return 'Can thiệp khẩn cấp trong vòng 2 giờ';
  }

  String get detailedInterventionTiming {
    if (_totalScore <= 108) {
      return 'Thời gian can thiệp: Trong vòng 72 giờ\n'
             '• PCI có thể trì hoãn nếu không có biến chứng\n'
             '• Theo dõi tại khoa nội tim mạch\n'
             '• Điều trị nội khoa tối ưu trước tiên';
    }
    if (_totalScore <= 140) {
      return 'Thời gian can thiệp: Trong vòng 24-72 giờ\n'
             '• PCI chọn lọc dựa trên triệu chứng\n'
             '• Theo dõi chặt chẽ tại CCU\n'
             '• Chuẩn bị sẵn sàng can thiệp khi cần';
    }
    if (_totalScore <= 200) {
      return 'Thời gian can thiệp: Trong vòng 24 giờ\n'
             '• PCI sớm được khuyến cáo\n'
             '• Theo dõi ICU/CCU\n'
             '• Đánh giá huyết động học thường xuyên';
    }
    return 'Thời gian can thiệp: Khẩn cấp trong vòng 2 giờ\n'
           '• PCI cấp cứu ngay lập tức\n'
           '• Hồi sức tích cực tại ICU\n'
           '• Chuẩn bị ECMO/IABP nếu cần thiết';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GRACE Score'),
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
                    'GRACE Score',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _totalScore.toString(),
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

            // Clinical Factors
            _buildClinicalFactors(),

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
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Tử vong 6 tháng',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      mortalityRisk,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: riskColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Tử vong nội viện',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      hospitalizationMortality,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: riskColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
                  interventionStrategy,
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
                const SizedBox(height: 8),
                Text(
                  'Thời gian can thiệp:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: riskColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  interventionTiming,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
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
            'Thông số sinh tồn',
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
            ],
          ),
          const SizedBox(height: 12),
          
          Row(
            children: [
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
              const SizedBox(width: 12),
              Expanded(
                child: _buildLabInputWithUnit(
                  'Creatinine',
                  'Tối đa 4.0 mg/dL (354 umol/L), tối thiểu 1.0 mg/dL (88 umol/L)',
                  _creatinineController,
                  _creatinineUnit,
                  ['mg/dL', 'umol/L'],
                  (value) {
                    setState(() {
                      _creatinineUnit = value;
                    });
                    _calculateScore();
                  },
                  (value) => _calculateScore(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLabInputWithUnit(
    String label,
    String helperText,
    TextEditingController controller,
    String currentUnit,
    List<String> units,
    ValueChanged<String> onUnitChanged,
    ValueChanged<String> onValueChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 5,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                onChanged: onValueChanged,
                decoration: InputDecoration(
                  labelText: label,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<String>(
                initialValue: currentUnit,
                onChanged: (value) => onUnitChanged(value!),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                ),
                items: units.map((unit) {
                  return DropdownMenuItem(
                    value: unit,
                    child: Text(
                      unit,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        if (helperText.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            helperText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ],
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
            'Yếu tố lâm sàng',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            title: const Text('Suy tim hoặc rối loạn chức năng thất trái'),
            value: _heartFailure,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _heartFailure = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Ngừng tim tại viện'),
            value: _cardiacArrest,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _cardiacArrest = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Chênh ST trên ECG'),
            value: _stElevation,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _stElevation = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Tăng enzyme tim (Troponin/CK-MB)'),
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
            'Phân tầng nguy cơ',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          // Header row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  child: Text(
                    'Điểm',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Mức độ nguy cơ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'TT 6m',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.green.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    'TT NV',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.green.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Can thiệp',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.green.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          
          _buildRiskItem('≤ 108', 'Nguy cơ thấp', '< 1%', '< 2%', '72h', Colors.green),
          _buildRiskItem('109-140', 'Nguy cơ trung bình', '1-3%', '2-5%', '24-72h', Colors.yellow.shade700),
          _buildRiskItem('141-200', 'Nguy cơ cao', '3-8%', '5-12%', '24h', Colors.orange),
          _buildRiskItem('> 200', 'Nguy cơ rất cao', '> 8%', '> 12%', '2h', Colors.red),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String risk, String mortality6m, String mortalityHosp, String timing, Color color) {
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
              risk,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              mortality6m,
              style: TextStyle(color: Colors.grey.shade700),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              mortalityHosp,
              style: TextStyle(color: Colors.grey.shade700),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              timing,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
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
            'GRACE Score đánh giá nguy cơ tử vong ở bệnh nhân hội chứng mạch vành cấp (ACS)\n\n'
            'Ứng dụng lâm sàng:\n'
            '• Phân tầng nguy cơ và lựa chọn chiến lược điều trị\n'
            '• Quyết định can thiệp sớm hay bảo tồn\n'
            '• Tư vấn tiên lượng cho bệnh nhân và gia đình\n'
            '• Đánh giá chỉ định chuyển tuyến\n\n'
            'Chiến lược can thiệp theo thời gian:\n'
            '• Nguy cơ thấp (≤108): Can thiệp trong 72h - PCI có thể trì hoãn\n'
            '• Nguy cơ trung bình (109-140): Can thiệp trong 24-72h - PCI chọn lọc\n'
            '• Nguy cơ cao (141-200): Can thiệp trong 24h - PCI sớm được khuyến cáo\n'
            '• Nguy cơ rất cao (>200): Can thiệp khẩn cấp trong 2h - PCI cấp cứu\n\n'
            'Lưu ý:\n'
            '• Điểm số càng cao, nguy cơ tử vong càng lớn\n'
            '• Cần kết hợp với đánh giá lâm sàng tổng thể\n'
            '• Theo dõi và tái đánh giá định kỳ\n'
            '• Áp dụng cho cả STEMI và NSTEMI/UA',
            style: TextStyle(height: 1.4),
          ),
          
          // Detailed intervention timing section
          const SizedBox(height: 16),
          Container(
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
                    Icon(Icons.schedule, color: Colors.blue.shade600, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Chi tiết thời gian can thiệp cho điểm số hiện tại',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade600,
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  detailedInterventionTiming,
                  style: const TextStyle(height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heartRateController.dispose();
    _systolicBPController.dispose();
    _creatinineController.dispose();
    super.dispose();
  }
}
