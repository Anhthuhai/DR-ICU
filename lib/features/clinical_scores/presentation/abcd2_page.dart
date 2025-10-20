import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
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

  String getRiskLevel(BuildContext context) {
    if (_totalScore <= 3) {
      return AppLocalizations.of(context)!.abcd2_low_risk;
    }
    if (_totalScore <= 5) {
      return AppLocalizations.of(context)!.abcd2_moderate_risk;
    }
    return AppLocalizations.of(context)!.abcd2_high_risk;
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

  String getRecommendations(BuildContext context) {
    if (_totalScore <= 3) {
      return AppLocalizations.of(context)!.abcd2_recommendation_low;
    }
    if (_totalScore <= 5) {
      return AppLocalizations.of(context)!.abcd2_recommendation_moderate;
    }
    return AppLocalizations.of(context)!.abcd2_recommendation_high;
  }

  String getUrgency(BuildContext context) {
    if (_totalScore <= 3) {
      return AppLocalizations.of(context)!.abcd2_urgency_non_urgent;
    }
    if (_totalScore <= 5) {
      return AppLocalizations.of(context)!.abcd2_urgency_priority;
    }
    return AppLocalizations.of(context)!.abcd2_urgency_emergency;
  }

  List<Map<String, dynamic>> getClinicalFeaturesOptions(BuildContext context) {
    return [
      {
        'value': 0,
        'text': AppLocalizations.of(context)!.abcd2_other_symptoms,
        'description': AppLocalizations.of(context)!.abcd2_other_symptoms_desc,
        'points': 0,
      },
      {
        'value': 1,
        'text': AppLocalizations.of(context)!.abcd2_speech_without_weakness,
        'description': AppLocalizations.of(context)!.abcd2_speech_without_weakness_desc,
        'points': 1,
      },
      {
        'value': 2,
        'text': AppLocalizations.of(context)!.abcd2_unilateral_weakness,
        'description': AppLocalizations.of(context)!.abcd2_unilateral_weakness_desc,
        'points': 2,
      },
    ];
  }

  List<Map<String, dynamic>> getDurationOptions(BuildContext context) {
    return [
      {
        'value': 0,
        'text': AppLocalizations.of(context)!.abcd2_duration_less_10,
        'description': AppLocalizations.of(context)!.abcd2_duration_less_10_desc,
        'points': 0,
      },
      {
        'value': 1,
        'text': AppLocalizations.of(context)!.abcd2_duration_10_59,
        'description': AppLocalizations.of(context)!.abcd2_duration_10_59_desc,
        'points': 1,
      },
      {
        'value': 2,
        'text': AppLocalizations.of(context)!.abcd2_duration_60_plus,
        'description': AppLocalizations.of(context)!.abcd2_duration_60_plus_desc,
        'points': 2,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Main AppBar (sticky)
          SliverAppBar(
            pinned: true,
            title: Text(AppLocalizations.of(context)!.abcd2_score_title),
            backgroundColor: Colors.indigo.shade700,
            foregroundColor: Colors.white,
          ),
          
          // Score Display Header (sticky)
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 56,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  bottom: BorderSide(color: riskColor.withValues(alpha: 0.3)),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.abcd2_score,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: riskColor,
                          ),
                        ),
                        Text(
                          getRiskLevel(context),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.darkGrey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '$_totalScore/7',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: riskColor,
                      ),
                    ),
                  ],
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
                              ? 'LƯU Ý Y KHOA THẦN KINH: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ chuyên khoa thần kinh trước khi đưa ra quyết định điều trị.'
                              : 'NEUROLOGICAL MEDICAL DISCLAIMER: Results are for reference only. Always consult with neurologist before making treatment decisions.',
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
                
                // Risk Info
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: riskColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: riskColor.withValues(alpha: 0.3)),
                  ),
                  child: _buildRiskInfo(),
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
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.abcd2_stroke_2_days,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      strokeRisk2Days,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.abcd2_stroke_7_days,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      strokeRisk7Days,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.abcd2_stroke_90_days,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      strokeRisk90Days,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
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
                      AppLocalizations.of(context)!.abcd2_urgency_level,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  getUrgency(context),
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
                      AppLocalizations.of(context)!.abcd2_recommendations,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  getRecommendations(context),
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
            AppLocalizations.of(context)!.abcd2_basic_info,
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
                    labelText: AppLocalizations.of(context)!.abcd2_age,
                    suffixText: AppLocalizations.of(context)!.abcd2_age_unit,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    helperText: AppLocalizations.of(context)!.abcd2_age_help,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _bpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.abcd2_blood_pressure,
                    suffixText: AppLocalizations.of(context)!.abcd2_bp_unit,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    helperText: AppLocalizations.of(context)!.abcd2_bp_help,
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
            AppLocalizations.of(context)!.abcd2_clinical_features,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          ...getClinicalFeaturesOptions(context).map((option) => Container(
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
            AppLocalizations.of(context)!.abcd2_duration,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
          ),
          const SizedBox(height: 16),
          ...getDurationOptions(context).map((option) => Container(
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
            AppLocalizations.of(context)!.abcd2_diabetes,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.abcd2_has_diabetes),
            subtitle: Text(AppLocalizations.of(context)!.abcd2_diabetes_desc),
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
            AppLocalizations.of(context)!.abcd2_risk_stratification,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem(context, AppLocalizations.of(context)!.abcd2_risk_range_low, AppLocalizations.of(context)!.abcd2_low_risk, AppLocalizations.of(context)!.abcd2_risk_2d_low, AppLocalizations.of(context)!.abcd2_risk_90d_low, Colors.green),
          _buildRiskItem(context, AppLocalizations.of(context)!.abcd2_risk_range_moderate, AppLocalizations.of(context)!.abcd2_moderate_risk, AppLocalizations.of(context)!.abcd2_risk_2d_moderate, AppLocalizations.of(context)!.abcd2_risk_90d_moderate, Colors.orange),
          _buildRiskItem(context, AppLocalizations.of(context)!.abcd2_risk_range_high, AppLocalizations.of(context)!.abcd2_high_risk, AppLocalizations.of(context)!.abcd2_risk_2d_high, AppLocalizations.of(context)!.abcd2_risk_90d_high, Colors.red),
        ],
      ),
    );
  }

  Widget _buildRiskItem(BuildContext context, String score, String risk, String risk2d, String risk90d, Color color) {
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
            '2 days: $risk2d, 90 days: $risk90d',
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
                AppLocalizations.of(context)!.abcd2_clinical_information,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.abcd2_clinical_info_text,
            style: const TextStyle(height: 1.4),
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
                AppLocalizations.of(context)!.abcd2_reference_title,
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
            AppLocalizations.of(context)!.abcd2_reference_text,
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
