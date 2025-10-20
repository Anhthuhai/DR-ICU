import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

class WellsDvtScorePage extends StatefulWidget {
  const WellsDvtScorePage({super.key});

  @override
  State<WellsDvtScorePage> createState() => _WellsDvtScorePageState();
}

class _WellsDvtScorePageState extends State<WellsDvtScorePage> {
  bool _cancer = false;
  bool _paralysis = false;
  bool _bedRest = false;
  bool _majorSurgery = false;
  bool _localizedTenderness = false;
  bool _entireLegSwollen = false;
  bool _calfSwelling = false;
  bool _pittingEdema = false;
  bool _collateralVeins = false;
  bool _previousDvt = false;
  bool _alternativeDiagnosis = false;

  int _totalScore = 0;

  void _calculateScore() {
    int score = 0;
    
    if (_cancer) {
      score += 1;
    }
    if (_paralysis) {
      score += 1;
    }
    if (_bedRest) {
      score += 1;
    }
    if (_majorSurgery) {
      score += 1;
    }
    if (_localizedTenderness) {
      score += 1;
    }
    if (_entireLegSwollen) {
      score += 1;
    }
    if (_calfSwelling) {
      score += 1;
    }
    if (_pittingEdema) {
      score += 1;
    }
    if (_collateralVeins) {
      score += 1;
    }
    if (_previousDvt) {
      score += 1;
    }
    if (_alternativeDiagnosis) {
      score -= 2;
    }

    setState(() {
      _totalScore = score;
    });
  }

  Color get riskColor {
    if (_totalScore <= 0) {
      return Colors.green;
    }
    if (_totalScore <= 2) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String getRiskLevel(BuildContext context) {
    if (_totalScore <= 0) {
      return AppLocalizations.of(context)!.wells_low_risk;
    }
    if (_totalScore <= 2) {
      return AppLocalizations.of(context)!.wells_moderate_risk;
    }
    return AppLocalizations.of(context)!.wells_high_risk;
  }

  String get dvtProbability {
    if (_totalScore <= 0) {
      return '3%';
    }
    if (_totalScore <= 2) {
      return '17%';
    }
    return '75%';
  }

  String getRecommendations(BuildContext context) {
    if (_totalScore <= 0) {
      return AppLocalizations.of(context)!.wells_low_risk_recommendation;
    }
    if (_totalScore <= 2) {
      return AppLocalizations.of(context)!.wells_moderate_risk_recommendation;
    }
    return AppLocalizations.of(context)!.wells_high_risk_recommendation;
  }

  String getNextStep(BuildContext context) {
    if (_totalScore <= 0) {
      return AppLocalizations.of(context)!.wells_check_ddimer;
    }
    if (_totalScore <= 2) {
      return AppLocalizations.of(context)!.wells_ddimer_or_ultrasound;
    }
    return AppLocalizations.of(context)!.wells_immediate_ultrasound;
  }

  String getClinicalApproach(BuildContext context) {
    if (_totalScore <= 0) {
      return AppLocalizations.of(context)!.wells_low_risk_approach;
    }
    if (_totalScore <= 2) {
      return AppLocalizations.of(context)!.wells_moderate_risk_approach;
    }
    return AppLocalizations.of(context)!.wells_high_risk_approach;
  }

  List<Map<String, dynamic>> getCriteria(BuildContext context) {
    return [
      {
        'criterion': AppLocalizations.of(context)!.wells_active_cancer,
        'description': AppLocalizations.of(context)!.wells_active_cancer_desc,
        'points': 1,
        'active': _cancer,
      },
      {
        'criterion': AppLocalizations.of(context)!.wells_paralysis,
        'description': AppLocalizations.of(context)!.wells_paralysis_desc,
        'points': 1,
        'active': _paralysis,
      },
      {
        'criterion': AppLocalizations.of(context)!.wells_bed_rest,
        'description': AppLocalizations.of(context)!.wells_bed_rest_desc,
        'points': 1,
        'active': _bedRest,
      },
      {
        'criterion': AppLocalizations.of(context)!.wells_major_surgery,
        'description': AppLocalizations.of(context)!.wells_major_surgery_desc,
        'points': 1,
        'active': _majorSurgery,
      },
      {
        'criterion': AppLocalizations.of(context)!.wells_localized_tenderness,
        'description': AppLocalizations.of(context)!.wells_localized_tenderness_desc,
        'points': 1,
        'active': _localizedTenderness,
      },
      {
        'criterion': AppLocalizations.of(context)!.wells_entire_leg_swollen,
        'description': AppLocalizations.of(context)!.wells_entire_leg_swollen_desc,
        'points': 1,
        'active': _entireLegSwollen,
      },
      {
        'criterion': AppLocalizations.of(context)!.wells_calf_swelling,
        'description': AppLocalizations.of(context)!.wells_calf_swelling_desc,
        'points': 1,
        'active': _calfSwelling,
      },
      {
        'criterion': AppLocalizations.of(context)!.wells_pitting_edema,
        'description': AppLocalizations.of(context)!.wells_pitting_edema_desc,
        'points': 1,
        'active': _pittingEdema,
      },
      {
        'criterion': AppLocalizations.of(context)!.wells_collateral_veins,
        'description': AppLocalizations.of(context)!.wells_collateral_veins_desc,
        'points': 1,
        'active': _collateralVeins,
      },
      {
        'criterion': AppLocalizations.of(context)!.wells_previous_dvt,
        'description': AppLocalizations.of(context)!.wells_previous_dvt_desc,
        'points': 1,
        'active': _previousDvt,
      },
      {
        'criterion': AppLocalizations.of(context)!.wells_alternative_diagnosis,
        'description': AppLocalizations.of(context)!.wells_alternative_diagnosis_desc,
        'points': -2,
        'active': _alternativeDiagnosis,
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
            title: Text(AppLocalizations.of(context)!.wells_dvt_title),
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
          ),
          
          // Score Display Header (sticky)
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 100,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  bottom: BorderSide(color: riskColor.withValues(alpha: 0.3)),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: riskColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: riskColor.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.wells_dvt_score,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: riskColor,
                          ),
                        ),
                        Text(
                          getRiskLevel(context),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.darkGrey,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '$_totalScore',
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
                              ? 'LƯU Ý Y KHOA HUYẾT KHỐI: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ chuyên khoa tim mạch hoặc huyết học trước khi đưa ra quyết định điều trị.'
                              : 'THROMBOSIS MEDICAL DISCLAIMER: Results are for reference only. Always consult with cardiologist or hematologist before making treatment decisions.',
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

                // Clinical Criteria
                _buildCriteriaSection(),

                // Active Criteria
                if (_totalScore != 0) _buildActiveCriteria(),

                // Risk Stratification
                _buildRiskStratification(),

                // Clinical Approach
                _buildClinicalApproach(),

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
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // DVT Probability
          Column(
            children: [
              Text(
                AppLocalizations.of(context)!.wells_dvt_probability,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                dvtProbability,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: riskColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Next Step
          Column(
            children: [
              Text(
                AppLocalizations.of(context)!.wells_next_step,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                getNextStep(context),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: riskColor,
                ),
                textAlign: TextAlign.center,
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
                      AppLocalizations.of(context)!.wells_recommendations,
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

  Widget _buildCriteriaSection() {
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
            AppLocalizations.of(context)!.wells_criteria_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.wells_active_cancer),
            subtitle: Text(AppLocalizations.of(context)!.wells_active_cancer_desc),
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
            title: Text(AppLocalizations.of(context)!.wells_paralysis),
            subtitle: Text(AppLocalizations.of(context)!.wells_paralysis_desc),
            value: _paralysis,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _paralysis = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.wells_bed_rest),
            subtitle: Text(AppLocalizations.of(context)!.wells_bed_rest_desc),
            value: _bedRest,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _bedRest = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.wells_major_surgery),
            subtitle: Text(AppLocalizations.of(context)!.wells_major_surgery_desc),
            value: _majorSurgery,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _majorSurgery = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.wells_localized_tenderness),
            subtitle: Text(AppLocalizations.of(context)!.wells_localized_tenderness_desc),
            value: _localizedTenderness,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _localizedTenderness = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.wells_entire_leg_swollen),
            subtitle: Text(AppLocalizations.of(context)!.wells_entire_leg_swollen_desc),
            value: _entireLegSwollen,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _entireLegSwollen = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.wells_calf_swelling),
            subtitle: Text(AppLocalizations.of(context)!.wells_calf_swelling_desc),
            value: _calfSwelling,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _calfSwelling = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.wells_pitting_edema),
            subtitle: Text(AppLocalizations.of(context)!.wells_pitting_edema_desc),
            value: _pittingEdema,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _pittingEdema = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.wells_collateral_veins),
            subtitle: Text(AppLocalizations.of(context)!.wells_collateral_veins_desc),
            value: _collateralVeins,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _collateralVeins = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.wells_previous_dvt),
            subtitle: Text(AppLocalizations.of(context)!.wells_previous_dvt_desc),
            value: _previousDvt,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _previousDvt = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.wells_alternative_diagnosis),
            subtitle: Text(AppLocalizations.of(context)!.wells_alternative_diagnosis_desc),
            value: _alternativeDiagnosis,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _alternativeDiagnosis = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCriteria() {
    List<Map<String, dynamic>> activeCriteria = getCriteria(context).where((criterion) => criterion['active']).toList();
    
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
            AppLocalizations.of(context)!.wells_current_criteria(activeCriteria.length),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
          ),
          const SizedBox(height: 12),
          ...activeCriteria.map((criterion) => Container(
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
                    color: criterion['points'] > 0 ? riskColor : Colors.green,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      '${criterion['points'] > 0 ? '+' : ''}${criterion['points']}',
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
                        criterion['criterion'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        criterion['description'],
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
            AppLocalizations.of(context)!.wells_risk_stratification,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('≤0', AppLocalizations.of(context)!.wells_low_risk, '3%', AppLocalizations.of(context)!.wells_check_ddimer, Colors.green),
          _buildRiskItem('1-2', AppLocalizations.of(context)!.wells_moderate_risk, '17%', AppLocalizations.of(context)!.wells_ddimer_or_ultrasound, Colors.orange),
          _buildRiskItem('≥3', AppLocalizations.of(context)!.wells_high_risk, '75%', AppLocalizations.of(context)!.wells_immediate_ultrasound, Colors.red),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String risk, String probability, String action, Color color) {
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
                  probability,
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
            AppLocalizations.of(context)!.wells_clinical_approach,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
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
                      AppLocalizations.of(context)!.wells_approach_for_score(_totalScore),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  getClinicalApproach(context),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.darkGrey,
                    height: 1.4,
                  ),
                ),
              ],
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
                AppLocalizations.of(context)!.wells_clinical_information,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.wells_clinical_info_text,
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
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
                AppLocalizations.of(context)!.wells_reference_title,
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
            AppLocalizations.of(context)!.wells_reference_text,
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
