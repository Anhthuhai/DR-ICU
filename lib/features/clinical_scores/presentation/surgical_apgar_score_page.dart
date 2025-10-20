import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class SurgicalApgarScorePage extends StatefulWidget {
  const SurgicalApgarScorePage({super.key});

  @override
  State<SurgicalApgarScorePage> createState() => _SurgicalApgarScorePageState();
}

class _SurgicalApgarScorePageState extends State<SurgicalApgarScorePage> {
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _bloodPressureController = TextEditingController();
  final TextEditingController _bloodLossController = TextEditingController();

  int _heartRateScore = 0;
  int _bloodPressureScore = 0;
  int _bloodLossScore = 0;
  int _totalScore = 0;

  @override
  void initState() {
    super.initState();
    _heartRateController.addListener(_calculateScore);
    _bloodPressureController.addListener(_calculateScore);
    _bloodLossController.addListener(_calculateScore);
  }

  void _calculateScore() {
    final heartRateText = _heartRateController.text.trim();
    final bloodPressureText = _bloodPressureController.text.trim();
    final bloodLossText = _bloodLossController.text.trim();

    // Heart Rate Score
    if (heartRateText.isEmpty) {
      _heartRateScore = 0;
    } else {
      final heartRate = int.tryParse(heartRateText) ?? 0;
      if (heartRate >= 56) {
        _heartRateScore = 2;
      } else if (heartRate >= 40) {
        _heartRateScore = 1;
      } else {
        _heartRateScore = 0;
      }
    }

    // Mean Arterial Pressure Score
    if (bloodPressureText.isEmpty) {
      _bloodPressureScore = 0;
    } else {
      final bloodPressure = int.tryParse(bloodPressureText) ?? 0;
      if (bloodPressure >= 70) {
        _bloodPressureScore = 2;
      } else if (bloodPressure >= 40) {
        _bloodPressureScore = 1;
      } else {
        _bloodPressureScore = 0;
      }
    }

    // Blood Loss Score (mL/kg)
    if (bloodLossText.isEmpty) {
      _bloodLossScore = 0;
    } else {
      final bloodLoss = int.tryParse(bloodLossText) ?? 0;
      if (bloodLoss <= 10) {
        _bloodLossScore = 2;
      } else if (bloodLoss <= 40) {
        _bloodLossScore = 1;
      } else {
        _bloodLossScore = 0;
      }
    }

    setState(() {
      _totalScore = _heartRateScore + _bloodPressureScore + _bloodLossScore;
    });
  }

  Color get riskColor {
    if (_totalScore >= 5) {
      return Colors.green;
    }
    if (_totalScore >= 3) {
      return Colors.yellow.shade700;
    }
    if (_totalScore >= 1) {
      return Colors.orange;
    }
    if (_totalScore == 0) {
      return Colors.red.shade900;
    }
    return Colors.red;
  }

  String riskLevel(BuildContext context) {
    if (_totalScore >= 5) {
      return AppLocalizations.of(context)!.surgical_apgar_risk_low;
    }
    if (_totalScore >= 3) {
      return AppLocalizations.of(context)!.surgical_apgar_risk_moderate_low;
    }
    if (_totalScore >= 1) {
      return AppLocalizations.of(context)!.surgical_apgar_risk_moderate_high;
    }
    if (_totalScore == 0) {
      return AppLocalizations.of(context)!.surgical_apgar_risk_very_high;
    }
    return AppLocalizations.of(context)!.surgical_apgar_risk_high;
  }

  String get complicationRisk {
    if (_totalScore >= 5) {
      return '5.0%';
    }
    if (_totalScore >= 3) {
      return '15.0%';
    }
    if (_totalScore >= 1) {
      return '30.0%';
    }
    if (_totalScore == 0) {
      return '85.0%';
    }
    return '60.0%';
  }

  String get mortalityRisk {
    if (_totalScore >= 5) {
      return '0.5%';
    }
    if (_totalScore >= 3) {
      return '1.5%';
    }
    if (_totalScore >= 1) {
      return '5.0%';
    }
    if (_totalScore == 0) {
      return '25.0%';
    }
    return '15.0%';
  }

  String recommendations(BuildContext context) {
    if (_totalScore >= 5) {
      return AppLocalizations.of(context)!.surgical_apgar_recommendation_low;
    }
    if (_totalScore >= 3) {
      return AppLocalizations.of(context)!.surgical_apgar_recommendation_moderate_low;
    }
    if (_totalScore >= 1) {
      return AppLocalizations.of(context)!.surgical_apgar_recommendation_moderate_high;
    }
    if (_totalScore == 0) {
      return AppLocalizations.of(context)!.surgical_apgar_recommendation_very_high;
    }
    return AppLocalizations.of(context)!.surgical_apgar_recommendation_high;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Main AppBar (sticky)
          SliverAppBar(
            pinned: true,
            title: Text(AppLocalizations.of(context)!.surgical_apgar_title),
            backgroundColor: Colors.teal.shade700,
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
                  bottom: BorderSide(color: riskColor.withValues(alpha: 0.3), width: 2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SafeArea(
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
                            AppLocalizations.of(context)!.surgical_apgar_title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: riskColor,
                            ),
                          ),
                          Text(
                            Localizations.localeOf(context).languageCode == 'vi'
                                ? 'Nguy cơ ${riskLevel(context)}'
                                : '${riskLevel(context)} Risk',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.darkGrey,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '$_totalScore/6',
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
                              ? 'LƯU Ý Y KHOA PHẪU THUẬT: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ gây mê hồi sức và phẫu thuật viên trước khi đưa ra quyết định.'
                              : 'SURGICAL MEDICAL DISCLAIMER: Results are for reference only. Always consult with anesthesiologist and surgeon before making decisions.',
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

                // Score Breakdown
                _buildScoreBreakdown(),

                // Risk Stratification
                _buildRiskStratification(),

                // Clinical Guidelines
                _buildClinicalGuidelines(),

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.surgical_apgar_complication_risk,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    complicationRisk,
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
                    AppLocalizations.of(context)!.surgical_apgar_mortality_risk,
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
                Row(
                  children: [
                    Icon(Icons.assignment, color: riskColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.surgical_apgar_recommendations,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  recommendations(context),
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
        border: Border.all(color: Colors.teal.shade300),
        color: Colors.teal.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.surgical_apgar_parameters_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          TextField(
            controller: _heartRateController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.surgical_apgar_heart_rate_label,
              suffixText: AppLocalizations.of(context)!.surgical_apgar_heart_rate_unit,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: AppLocalizations.of(context)!.surgical_apgar_heart_rate_helper,
            ),
          ),
          const SizedBox(height: 12),
          
          TextField(
            controller: _bloodPressureController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.surgical_apgar_blood_pressure_label,
              suffixText: AppLocalizations.of(context)!.surgical_apgar_blood_pressure_unit,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: AppLocalizations.of(context)!.surgical_apgar_blood_pressure_helper,
            ),
          ),
          const SizedBox(height: 12),
          
          TextField(
            controller: _bloodLossController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.surgical_apgar_blood_loss_label,
              suffixText: AppLocalizations.of(context)!.surgical_apgar_blood_loss_unit,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: AppLocalizations.of(context)!.surgical_apgar_blood_loss_helper,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreBreakdown() {
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
            AppLocalizations.of(context)!.surgical_apgar_score_breakdown_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildParameterScore(
            AppLocalizations.of(context)!.surgical_apgar_heart_rate_scoring,
            _heartRateScore,
            [
              AppLocalizations.of(context)!.surgical_apgar_hr_criteria_1,
              AppLocalizations.of(context)!.surgical_apgar_hr_criteria_2,
              AppLocalizations.of(context)!.surgical_apgar_hr_criteria_3,
            ],
          ),
          const SizedBox(height: 12),
          
          _buildParameterScore(
            AppLocalizations.of(context)!.surgical_apgar_map_scoring,
            _bloodPressureScore,
            [
              AppLocalizations.of(context)!.surgical_apgar_map_criteria_1,
              AppLocalizations.of(context)!.surgical_apgar_map_criteria_2,
              AppLocalizations.of(context)!.surgical_apgar_map_criteria_3,
            ],
          ),
          const SizedBox(height: 12),
          
          _buildParameterScore(
            AppLocalizations.of(context)!.surgical_apgar_blood_loss_scoring,
            _bloodLossScore,
            [
              AppLocalizations.of(context)!.surgical_apgar_bl_criteria_1,
              AppLocalizations.of(context)!.surgical_apgar_bl_criteria_2,
              AppLocalizations.of(context)!.surgical_apgar_bl_criteria_3,
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildParameterScore(String title, int score, List<String> criteria) {
    Color scoreColor = score == 2 ? Colors.green : 
                      score == 1 ? Colors.orange : Colors.red;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scoreColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: scoreColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: scoreColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: scoreColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$score ${AppLocalizations.of(context)!.surgical_apgar_score_points}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...criteria.map((criterion) => Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              '• $criterion',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
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
        border: Border.all(color: Colors.orange.shade300),
        color: Colors.orange.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.surgical_apgar_risk_stratification_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('5-6', 
            AppLocalizations.of(context)!.surgical_apgar_risk_low, '5.0%', '0.5%', 
            AppLocalizations.of(context)!.surgical_apgar_management_standard, Colors.green),
          _buildRiskItem('3-4', 
            AppLocalizations.of(context)!.surgical_apgar_risk_moderate_low, '15.0%', '1.5%', 
            AppLocalizations.of(context)!.surgical_apgar_management_close, Colors.yellow.shade700),
          _buildRiskItem('1-2', 
            AppLocalizations.of(context)!.surgical_apgar_risk_moderate_high, '30.0%', '5.0%', 
            AppLocalizations.of(context)!.surgical_apgar_management_active, Colors.orange),
          _buildRiskItem('0', 
            AppLocalizations.of(context)!.surgical_apgar_risk_very_high, '85.0%', '25.0%', 
            AppLocalizations.of(context)!.surgical_apgar_management_intensive, Colors.red.shade900),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String level, String complication, String mortality, String management, Color color) {
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
                  level,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  complication,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(width: 40),
              Expanded(
                child: Text(
                  '${AppLocalizations.of(context)!.surgical_apgar_mortality_risk}: $mortality',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(width: 40),
              Expanded(
                child: Text(
                  management,
                  style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
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
            AppLocalizations.of(context)!.surgical_apgar_clinical_guidelines_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildGuidelineCard(
            AppLocalizations.of(context)!.surgical_apgar_guideline_low_title,
            [
              AppLocalizations.of(context)!.surgical_apgar_guideline_low_1,
              AppLocalizations.of(context)!.surgical_apgar_guideline_low_2,
              AppLocalizations.of(context)!.surgical_apgar_guideline_low_3,
              AppLocalizations.of(context)!.surgical_apgar_guideline_low_4,
            ],
            Colors.green,
          ),
          const SizedBox(height: 12),
          _buildGuidelineCard(
            AppLocalizations.of(context)!.surgical_apgar_guideline_moderate_title,
            [
              AppLocalizations.of(context)!.surgical_apgar_guideline_moderate_1,
              AppLocalizations.of(context)!.surgical_apgar_guideline_moderate_2,
              AppLocalizations.of(context)!.surgical_apgar_guideline_moderate_3,
              AppLocalizations.of(context)!.surgical_apgar_guideline_moderate_4,
            ],
            Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildGuidelineCard(
            AppLocalizations.of(context)!.surgical_apgar_guideline_high_title,
            [
              AppLocalizations.of(context)!.surgical_apgar_guideline_high_1,
              AppLocalizations.of(context)!.surgical_apgar_guideline_high_2,
              AppLocalizations.of(context)!.surgical_apgar_guideline_high_3,
              AppLocalizations.of(context)!.surgical_apgar_guideline_high_4,
            ],
            Colors.red,
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
                AppLocalizations.of(context)!.surgical_apgar_clinical_info_title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.surgical_apgar_clinical_text,
            style: const TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _heartRateController.dispose();
    _bloodPressureController.dispose();
    _bloodLossController.dispose();
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
                AppLocalizations.of(context)!.surgical_apgar_reference_title,
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
            AppLocalizations.of(context)!.surgical_apgar_reference_text,
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
