import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

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

  String recommendation(BuildContext context) {
    if (_daptScore >= 2) {
      return AppLocalizations.of(context)!.dapt_continue;
    }
    return AppLocalizations.of(context)!.dapt_discontinue;
  }

  String reasoning(BuildContext context) {
    if (_daptScore >= 2) {
      return AppLocalizations.of(context)!.dapt_reasoning_continue;
    } else {
      return AppLocalizations.of(context)!.dapt_reasoning_discontinue;
    }
  }

  String ischemicBenefit(BuildContext context) {
    if (_daptScore >= 2) {
      return AppLocalizations.of(context)!.dapt_ischemic_benefit_high;
    }
    return AppLocalizations.of(context)!.dapt_ischemic_benefit_low;
  }

  String bleedingRisk(BuildContext context) {
    if (_daptScore >= 2) {
      return AppLocalizations.of(context)!.dapt_bleeding_risk_high;
    }
    return AppLocalizations.of(context)!.dapt_bleeding_risk_low;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Main AppBar (sticky)
          SliverAppBar(
            pinned: true,
            title: Text(AppLocalizations.of(context)!.dapt_title),
            backgroundColor: Colors.cyan.shade700,
            foregroundColor: Colors.white,
          ),
          
          // Score Display Header (sticky)
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            backgroundColor: Colors.white,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: recommendationColor, width: 2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.dapt_title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: recommendationColor,
                              ),
                            ),
                            Text(
                              recommendation(context),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.darkGrey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '$_daptScore',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: recommendationColor,
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
                              ? 'LƯU Ý Y KHOA TIM MẠCH: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ chuyên khoa tim mạch trước khi đưa ra quyết định điều trị kháng tiểu cầu.'
                              : 'CARDIOLOGY MEDICAL DISCLAIMER: Results are for reference only. Always consult with cardiologist before making antiplatelet treatment decisions.',
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
                // Recommendation Info
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: recommendationColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: recommendationColor.withValues(alpha: 0.3)),
                  ),
                  child: _buildRecommendationInfo(),
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
                            AppLocalizations.of(context)!.dapt_reference_title,
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
                        AppLocalizations.of(context)!.dapt_reference_text,
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

  Widget _buildRecommendationInfo() {
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
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.dapt_ischemic_benefit_label,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ischemicBenefit(context),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.dapt_bleeding_risk_label,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      bleedingRisk(context),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                      AppLocalizations.of(context)!.dapt_rationale_label,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: recommendationColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  reasoning(context),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.darkGrey,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
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
            AppLocalizations.of(context)!.dapt_patient_factors,
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
              labelText: AppLocalizations.of(context)!.dapt_age_label,
              suffixText: AppLocalizations.of(context)!.dapt_age_unit,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: AppLocalizations.of(context)!.dapt_age_help,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildRiskFactorCheckbox(
            AppLocalizations.of(context)!.dapt_smoking,
            AppLocalizations.of(context)!.dapt_smoking_desc,
            _cigaretteSmoking,
            (value) {
              setState(() {
                _cigaretteSmoking = value!;
              });
              _calculateScore();
            },
            '+1 ${AppLocalizations.of(context)!.dapt_points_suffix}',
          ),
          
          _buildRiskFactorCheckbox(
            AppLocalizations.of(context)!.dapt_diabetes,
            AppLocalizations.of(context)!.dapt_diabetes_desc,
            _diabetesMellitus,
            (value) {
              setState(() {
                _diabetesMellitus = value!;
              });
              _calculateScore();
            },
            '+1 ${AppLocalizations.of(context)!.dapt_points_suffix}',
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
            AppLocalizations.of(context)!.dapt_clinical_factors,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildRiskFactorCheckbox(
            AppLocalizations.of(context)!.dapt_mi,
            AppLocalizations.of(context)!.dapt_mi_desc,
            _myocardialInfarction,
            (value) {
              setState(() {
                _myocardialInfarction = value!;
              });
              _calculateScore();
            },
            '+1 ${AppLocalizations.of(context)!.dapt_points_suffix}',
          ),
          
          _buildRiskFactorCheckbox(
            AppLocalizations.of(context)!.dapt_heart_failure,
            AppLocalizations.of(context)!.dapt_heart_failure_desc,
            _congestiveHeartFailure,
            (value) {
              setState(() {
                _congestiveHeartFailure = value!;
              });
              _calculateScore();
            },
            '+2 ${AppLocalizations.of(context)!.dapt_points_suffix}',
          ),
          
          _buildRiskFactorCheckbox(
            AppLocalizations.of(context)!.dapt_vein_graft,
            AppLocalizations.of(context)!.dapt_vein_graft_desc,
            _saphenousVeinGraft,
            (value) {
              setState(() {
                _saphenousVeinGraft = value!;
              });
              _calculateScore();
            },
            '+1 ${AppLocalizations.of(context)!.dapt_points_suffix}',
          ),
          
          const SizedBox(height: 16),
          
          Text(
            AppLocalizations.of(context)!.dapt_stent_characteristics,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 8),
          
          _buildRiskFactorCheckbox(
            AppLocalizations.of(context)!.dapt_bms,
            AppLocalizations.of(context)!.dapt_bms_desc,
            _stentType,
            (value) {
              setState(() {
                _stentType = value!;
              });
              _calculateScore();
            },
            '+1 ${AppLocalizations.of(context)!.dapt_points_suffix}',
          ),
          
          _buildRiskFactorCheckbox(
            AppLocalizations.of(context)!.dapt_small_stent,
            AppLocalizations.of(context)!.dapt_small_stent_desc,
            _stentDiameter,
            (value) {
              setState(() {
                _stentDiameter = value!;
              });
              _calculateScore();
            },
            '+1 ${AppLocalizations.of(context)!.dapt_points_suffix}',
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
            AppLocalizations.of(context)!.dapt_risk_benefit_analysis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildAnalysisCard(
            AppLocalizations.of(context)!.dapt_continue_title,
            [
              AppLocalizations.of(context)!.dapt_continue_mace,
              AppLocalizations.of(context)!.dapt_continue_mi,
              AppLocalizations.of(context)!.dapt_continue_stent,
              AppLocalizations.of(context)!.dapt_continue_bleeding,
            ],
            Colors.green,
            AppLocalizations.of(context)!.dapt_continue_conclusion,
          ),
          const SizedBox(height: 12),
          _buildAnalysisCard(
            AppLocalizations.of(context)!.dapt_discontinue_title,
            [
              AppLocalizations.of(context)!.dapt_discontinue_mace,
              AppLocalizations.of(context)!.dapt_discontinue_bleeding,
              AppLocalizations.of(context)!.dapt_discontinue_gi,
              AppLocalizations.of(context)!.dapt_discontinue_ich,
            ],
            Colors.red,
            AppLocalizations.of(context)!.dapt_discontinue_conclusion,
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
            AppLocalizations.of(context)!.dapt_clinical_guidelines,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildGuidelineCard(
            AppLocalizations.of(context)!.dapt_guideline_continue_title,
            [
              AppLocalizations.of(context)!.dapt_guideline_continue_1,
              AppLocalizations.of(context)!.dapt_guideline_continue_2,
              AppLocalizations.of(context)!.dapt_guideline_continue_3,
              AppLocalizations.of(context)!.dapt_guideline_continue_4,
            ],
            Colors.green,
          ),
          const SizedBox(height: 12),
          _buildGuidelineCard(
            AppLocalizations.of(context)!.dapt_guideline_discontinue_title,
            [
              AppLocalizations.of(context)!.dapt_guideline_discontinue_1,
              AppLocalizations.of(context)!.dapt_guideline_discontinue_2,
              AppLocalizations.of(context)!.dapt_guideline_discontinue_3,
              AppLocalizations.of(context)!.dapt_guideline_discontinue_4,
            ],
            Colors.red,
          ),
          const SizedBox(height: 12),
          _buildGuidelineCard(
            AppLocalizations.of(context)!.dapt_guideline_special_title,
            [
              AppLocalizations.of(context)!.dapt_guideline_special_1,
              AppLocalizations.of(context)!.dapt_guideline_special_2,
              AppLocalizations.of(context)!.dapt_guideline_special_3,
              AppLocalizations.of(context)!.dapt_guideline_special_4,
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
                AppLocalizations.of(context)!.dapt_clinical_info,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.dapt_clinical_text,
            style: const TextStyle(height: 1.4),
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
