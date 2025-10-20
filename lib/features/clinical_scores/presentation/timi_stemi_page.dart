import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

// Sticky Header Delegate for Score Display
class _StickyScoreHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _StickyScoreHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_StickyScoreHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

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
    final isVietnamese = Localizations.localeOf(context).languageCode == 'vi';
    if (_totalScore <= 2) {
      return isVietnamese ? 'Nguy cơ thấp' : 'Low Risk';
    }
    if (_totalScore <= 4) {
      return isVietnamese ? 'Nguy cơ trung bình' : 'Moderate Risk';
    }
    if (_totalScore <= 8) {
      return isVietnamese ? 'Nguy cơ cao' : 'High Risk';
    }
    return isVietnamese ? 'Nguy cơ rất cao' : 'Very High Risk';
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
    final isVietnamese = Localizations.localeOf(context).languageCode == 'vi';
    if (_totalScore <= 2) {
      return isVietnamese ? 'PCI sớm trong 12h, điều trị theo hướng dẫn chuẩn' : 'Early PCI within 12h, standard guideline treatment';
    }
    if (_totalScore <= 4) {
      return isVietnamese ? 'PCI cấp cứu, theo dõi chặt chẽ các biến chứng' : 'Emergency PCI, close monitoring for complications';
    }
    if (_totalScore <= 8) {
      return isVietnamese ? 'PCI ngay lập tức, hỗ trợ tuần hoàn, theo dõi ICU' : 'Immediate PCI, circulatory support, ICU monitoring';
    }
    return isVietnamese ? 'Can thiệp cấp cứu tối đa, cân nhắc hỗ trợ tuần hoàn cơ học' : 'Maximum emergency intervention, consider mechanical circulatory support';
  }

  List<Map<String, dynamic>> get riskFactors {
    final isVietnamese = Localizations.localeOf(context).languageCode == 'vi';
    return [
      {
        'factor': isVietnamese ? 'Tuổi 65-74' : 'Age 65-74',
        'points': 2,
        'active': (int.tryParse(_ageController.text) ?? 0) >= 65 && (int.tryParse(_ageController.text) ?? 0) < 75,
      },
      {
        'factor': isVietnamese ? 'Tuổi ≥75' : 'Age ≥75',
        'points': 3,
        'active': (int.tryParse(_ageController.text) ?? 0) >= 75,
      },
      {
        'factor': isVietnamese ? 'Cân nặng <67kg' : 'Weight <67kg',
        'points': 1,
        'active': (double.tryParse(_weightController.text) ?? 0) > 0 && (double.tryParse(_weightController.text) ?? 0) < 67,
      },
      {
        'factor': isVietnamese ? 'ĐTĐ/THA/Đau thắt ngực' : 'DM/HTN/Angina',
        'points': 1,
        'active': _diabetes || _hypertension || _angina,
      },
      {
        'factor': isVietnamese ? 'Nhồi máu thành trước/LBBB' : 'Anterior MI/LBBB',
        'points': 1,
        'active': _anteriorMI,
      },
      {
        'factor': isVietnamese ? 'Thời gian điều trị >4h' : 'Time to treatment >4h',
        'points': 1,
        'active': _timeToTreatment,
      },
      {
        'factor': isVietnamese ? 'Nhịp tim ≥100' : 'Heart rate ≥100',
        'points': 2,
        'active': (int.tryParse(_heartRateController.text) ?? 0) >= 100,
      },
      {
        'factor': isVietnamese ? 'Huyết áp tâm thu <100' : 'Systolic BP <100',
        'points': 3,
        'active': (int.tryParse(_systolicBPController.text) ?? 0) > 0 && (int.tryParse(_systolicBPController.text) ?? 0) < 100,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky AppBar
          SliverAppBar(
            title: Text(AppLocalizations.of(context)!.timi_stemi_title),
            backgroundColor: Colors.red.shade700,
            foregroundColor: Colors.white,
            pinned: true,
            floating: false,
            snap: false,
            elevation: 4,
          ),
          
          // Sticky Score Header
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyScoreHeaderDelegate(
              minHeight: 50,
              maxHeight: 55,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: riskColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: riskColor.withValues(alpha: 0.3), width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // TIMI Score in one line
                      Text(
                        'TIMI Score: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        '$_totalScore',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: riskColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Medical Disclaimer Banner
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade300),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.red.shade600, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Localizations.localeOf(context).languageCode == 'vi' 
                            ? 'DÀNH CHO CÁN BỘ Y TẾ'
                            : 'FOR HEALTHCARE PROFESSIONALS ONLY',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          Localizations.localeOf(context).languageCode == 'vi'
                            ? 'Công cụ đánh giá nguy cơ nhồi máu cơ tim. Cần kết hợp đánh giá lâm sàng và can thiệp kịp thời.'
                            : 'Myocardial infarction risk assessment tool. Requires clinical evaluation and timely intervention.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Main Content
          SliverToBoxAdapter(
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
                    Localizations.localeOf(context).languageCode == 'vi' 
                      ? 'Thang điểm TIMI - STEMI'
                      : 'TIMI Score - STEMI',
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
        ],
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
                    Localizations.localeOf(context).languageCode == 'vi' 
                      ? 'Tỷ lệ tử vong 30 ngày'
                      : '30-day Mortality Rate',
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
                  Localizations.localeOf(context).languageCode == 'vi' 
                    ? 'Khuyến nghị điều trị:'
                    : 'Treatment Recommendations:',
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
            Localizations.localeOf(context).languageCode == 'vi' 
              ? 'Thông số bệnh nhân'
              : 'Patient Parameters',
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
                    labelText: Localizations.localeOf(context).languageCode == 'vi' 
                      ? 'Tuổi' 
                      : AppLocalizations.of(context)!.timi_stemi_age_label,
                    suffixText: Localizations.localeOf(context).languageCode == 'vi' ? 'tuổi' : 'years',
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
                    labelText: Localizations.localeOf(context).languageCode == 'vi' 
                      ? 'Cân nặng' 
                      : AppLocalizations.of(context)!.timi_stemi_weight_label,
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
                    labelText: Localizations.localeOf(context).languageCode == 'vi' 
                      ? 'Nhịp tim'
                      : 'Heart Rate',
                    suffixText: 'bpm',
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
                    labelText: Localizations.localeOf(context).languageCode == 'vi' 
                      ? 'Huyết áp tâm thu'
                      : 'Systolic BP',
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
            Localizations.localeOf(context).languageCode == 'vi' 
              ? 'Yếu tố nguy cơ'
              : 'Risk Factors',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            title: Text(Localizations.localeOf(context).languageCode == 'vi' 
              ? 'Đái tháo đường' 
              : AppLocalizations.of(context)!.timi_stemi_diabetes_label),
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
            title: Text(Localizations.localeOf(context).languageCode == 'vi' 
              ? 'Tăng huyết áp' 
              : AppLocalizations.of(context)!.timi_stemi_hypertension_label),
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
            title: Text(Localizations.localeOf(context).languageCode == 'vi' 
              ? 'Đau thắt ngực' 
              : AppLocalizations.of(context)!.timi_stemi_angina_label),
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
            title: Text(Localizations.localeOf(context).languageCode == 'vi' 
              ? 'Nhồi máu thành trước/LBBB' 
              : AppLocalizations.of(context)!.timi_stemi_anterior_mi_label),
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
            title: Text(Localizations.localeOf(context).languageCode == 'vi' 
              ? 'Thời gian điều trị >4 giờ' 
              : AppLocalizations.of(context)!.timi_stemi_time_4h_label),
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
            Localizations.localeOf(context).languageCode == 'vi' 
              ? 'Yếu tố nguy cơ hiện tại (${activeFactors.length})'
              : 'Current Risk Factors (${activeFactors.length})',
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
            Localizations.localeOf(context).languageCode == 'vi' 
              ? 'Phân tầng nguy cơ tử vong 30 ngày'
              : '30-day Mortality Risk Stratification',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('0-2', 
            Localizations.localeOf(context).languageCode == 'vi' ? 'Nguy cơ thấp' : 'Low Risk', 
            '0.8-2.2%', Colors.green),
          _buildRiskItem('3-4', 
            Localizations.localeOf(context).languageCode == 'vi' ? 'Nguy cơ trung bình' : 'Moderate Risk', 
            '4.4-7.3%', Colors.yellow.shade700),
          _buildRiskItem('5-8', 
            Localizations.localeOf(context).languageCode == 'vi' ? 'Nguy cơ cao' : 'High Risk', 
            '12.4-26.8%', Colors.orange),
          _buildRiskItem('>8', 
            Localizations.localeOf(context).languageCode == 'vi' ? 'Nguy cơ rất cao' : 'Very High Risk', 
            '>30%', Colors.red),
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
                Localizations.localeOf(context).languageCode == 'vi' 
                  ? 'Thông tin lâm sàng'
                  : 'Clinical Information',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.purple.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            Localizations.localeOf(context).languageCode == 'vi' 
              ? 'Thang điểm TIMI cho STEMI đánh giá nguy cơ tử vong 30 ngày sau nhồi máu cơ tim có ST chênh lên\n\n'
                'Ứng dụng lâm sàng:\n'
                '• Phân tầng nguy cơ và tiên lượng\n'
                '• Hỗ trợ quyết định điều trị\n'
                '• Tư vấn bệnh nhân và gia đình\n'
                '• Đánh giá hiệu quả can thiệp\n\n'
                'Lưu ý quan trọng:\n'
                '• Áp dụng cho STEMI, không áp dụng cho NSTEMI/UA\n'
                '• Phải kết hợp với đánh giá lâm sàng\n'
                '• PCI sớm là tiêu chuẩn vàng cho STEMI\n'
                '• Thời gian door-to-balloon <90 phút'
              : 'TIMI Score for STEMI assesses 30-day mortality risk after ST-elevation myocardial infarction\n\n'
                'Clinical applications:\n'
                '• Risk stratification and prognosis\n'
                '• Support treatment decisions\n'
                '• Patient and family counseling\n'
                '• Assess intervention effectiveness\n\n'
                'Important notes:\n'
                '• Applies to STEMI, not NSTEMI/UA\n'
                '• Must combine with clinical assessment\n'
                '• Early PCI is the gold standard for STEMI\n'
                '• Door-to-balloon time <90 minutes',
            style: const TextStyle(height: 1.4),
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
                Localizations.localeOf(context).languageCode == 'vi' 
                  ? 'Tài liệu tham khảo'
                  : 'References',
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
