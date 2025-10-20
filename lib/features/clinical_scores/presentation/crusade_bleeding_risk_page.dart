import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

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
  String _creatinineUnit = 'mg/dL';

  int _totalScore = 0;

  double convertCreatinineToMgDL(double value, String unit) {
    if (unit == 'umol/L') {
      return value / 88.4; // Convert umol/L to mg/dL
    }
    return value; // Already in mg/dL
  }

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
    final creatinineInput = double.tryParse(_creatinineController.text) ?? 0;
    final creatinine = convertCreatinineToMgDL(creatinineInput, _creatinineUnit);
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
      return AppLocalizations.of(context)!.crusade_risk_very_low;
    }
    if (_totalScore <= 30) {
      return AppLocalizations.of(context)!.crusade_risk_low;
    }
    if (_totalScore <= 40) {
      return AppLocalizations.of(context)!.crusade_risk_moderate;
    }
    if (_totalScore <= 50) {
      return AppLocalizations.of(context)!.crusade_risk_high;
    }
    return AppLocalizations.of(context)!.crusade_risk_very_high;
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
    final isVietnamese = Localizations.localeOf(context).languageCode == 'vi';
    
    if (_totalScore <= 20) {
      return isVietnamese ? 'Rất thấp (<5%)' : 'Very Low (<5%)';
    }
    if (_totalScore <= 30) {
      return isVietnamese ? 'Thấp (5-10%)' : 'Low (5-10%)';
    }
    if (_totalScore <= 40) {
      return isVietnamese ? 'Trung bình (10-15%)' : 'Moderate (10-15%)';
    }
    if (_totalScore <= 50) {
      return isVietnamese ? 'Cao (15-20%)' : 'High (15-20%)';
    }
    return isVietnamese ? 'Rất cao (>20%)' : 'Very High (>20%)';
  }

  String get recommendations {
    if (_totalScore <= 20) {
      return AppLocalizations.of(context)!.crusade_recommendation_very_low;
    }
    if (_totalScore <= 30) {
      return AppLocalizations.of(context)!.crusade_recommendation_low;
    }
    if (_totalScore <= 40) {
      return AppLocalizations.of(context)!.crusade_recommendation_moderate;
    }
    if (_totalScore <= 50) {
      return AppLocalizations.of(context)!.crusade_recommendation_high;
    }
    return AppLocalizations.of(context)!.crusade_recommendation_very_high;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky AppBar
          SliverAppBar(
            title: Text(AppLocalizations.of(context)!.crusade_title),
            backgroundColor: Colors.red.shade800,
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
              minHeight: 60,
              maxHeight: 60,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: riskColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: riskColor.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$_totalScore - $riskLevel',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
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

          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Medical Disclaimer Banner
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: Colors.red.shade700, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          Localizations.localeOf(context).languageCode == 'vi'
                              ? 'LƯU Ý Y KHOA: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ chuyên khoa tim mạch trước khi đưa ra quyết định điều trị.'
                              : 'MEDICAL DISCLAIMER: Results are for reference only. Always consult with a cardiologist before making treatment decisions.',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
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
                        AppLocalizations.of(context)!.crusade_score,
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
                        Localizations.localeOf(context).languageCode == 'vi'
                            ? 'Nguy cơ: $riskLevel'
                            : 'Risk: $riskLevel',
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
                        AppLocalizations.of(context)!.crusade_references,
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
                    'Subherwal S, Bach RG, Chen AY, et al. Baseline risk of major bleeding in non-ST-segment-elevation myocardial infarction: the CRUSADE (Can Rapid risk stratification of Unstable angina patients Suppress ADverse outcomes with Early implementation) Bleeding Score. Circulation. 2009;119(14):1873-82.',
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.crusade_bleeding_risk_label,
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
                    AppLocalizations.of(context)!.crusade_major_bleeding_label,
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
                      AppLocalizations.of(context)!.crusade_recommendation_label,
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
            AppLocalizations.of(context)!.crusade_clinical_parameters,
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
              labelText: AppLocalizations.of(context)!.crusade_hematocrit_label,
              suffixText: '%',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: AppLocalizations.of(context)!.crusade_hematocrit_helper,
            ),
          ),
          const SizedBox(height: 12),
          
          // Creatinine
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _creatinineController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.crusade_creatinine_label,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  helperText: AppLocalizations.of(context)!.crusade_creatinine_helper,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.crusade_unit_label,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  DropdownButton<String>(
                    value: _creatinineUnit,
                    onChanged: (value) {
                      setState(() {
                        _creatinineUnit = value!;
                        _calculateScore();
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: 'mg/dL',
                        child: Text('mg/dL', style: TextStyle(fontSize: 12)),
                      ),
                      DropdownMenuItem(
                        value: 'umol/L',
                        child: Text('umol/L', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Heart Rate
          TextField(
            controller: _heartRateController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.crusade_heart_rate,
              suffixText: AppLocalizations.of(context)!.crusade_heart_rate_unit,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: AppLocalizations.of(context)!.crusade_heart_rate_helper,
            ),
          ),
          const SizedBox(height: 12),
          
          // Systolic BP
          TextField(
            controller: _systolicBpController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.crusade_systolic_bp,
              suffixText: AppLocalizations.of(context)!.crusade_systolic_bp_unit,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: AppLocalizations.of(context)!.crusade_systolic_bp_helper,
            ),
          ),
          const SizedBox(height: 16),
          
          // Gender
          Text(
            AppLocalizations.of(context)!.crusade_gender_label,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: Text(AppLocalizations.of(context)!.crusade_male_label),
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
                  title: Text(AppLocalizations.of(context)!.crusade_female_label),
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
            AppLocalizations.of(context)!.crusade_diabetes_label,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: Text(AppLocalizations.of(context)!.crusade_no_label),
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
                  title: Text(AppLocalizations.of(context)!.crusade_yes_diabetes),
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
            AppLocalizations.of(context)!.crusade_vascular_disease_label,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: Text(AppLocalizations.of(context)!.crusade_no_label),
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
                  title: Text(AppLocalizations.of(context)!.crusade_yes_vascular),
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
            AppLocalizations.of(context)!.crusade_risk_stratification,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('≤20', AppLocalizations.of(context)!.crusade_risk_very_low, '3.1%', AppLocalizations.of(context)!.crusade_strategy_very_low, Colors.green),
          _buildRiskItem('21-30', AppLocalizations.of(context)!.crusade_risk_low, '5.5%', AppLocalizations.of(context)!.crusade_strategy_low, Colors.yellow.shade700),
          _buildRiskItem('31-40', AppLocalizations.of(context)!.crusade_risk_moderate, '8.6%', AppLocalizations.of(context)!.crusade_strategy_moderate, Colors.orange),
          _buildRiskItem('41-50', AppLocalizations.of(context)!.crusade_risk_high, '11.9%', AppLocalizations.of(context)!.crusade_strategy_high, Colors.red.shade700),
          _buildRiskItem('>50', AppLocalizations.of(context)!.crusade_risk_very_high, '19.5%', AppLocalizations.of(context)!.crusade_strategy_very_high, Colors.red.shade900),
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
            AppLocalizations.of(context)!.crusade_clinical_approach,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildStrategyCard(
            AppLocalizations.of(context)!.crusade_invasive_strategy,
            [
              AppLocalizations.of(context)!.crusade_invasive_item1,
              AppLocalizations.of(context)!.crusade_invasive_item2,
              AppLocalizations.of(context)!.crusade_invasive_item3,
              AppLocalizations.of(context)!.crusade_invasive_item4,
            ],
            Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildStrategyCard(
            AppLocalizations.of(context)!.crusade_conservative_strategy,
            [
              AppLocalizations.of(context)!.crusade_conservative_item1,
              AppLocalizations.of(context)!.crusade_conservative_item2,
              AppLocalizations.of(context)!.crusade_conservative_item3,
              AppLocalizations.of(context)!.crusade_conservative_item4,
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
                AppLocalizations.of(context)!.crusade_clinical_info,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.crusade_clinical_info_content,
            style: const TextStyle(height: 1.4),
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
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_StickyScoreHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
           minHeight != oldDelegate.minHeight ||
           child != oldDelegate.child;
  }
}
