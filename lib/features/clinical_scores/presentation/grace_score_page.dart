import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    if (_totalScore <= 108) {
      return l10n.grace_risk_low;
    }
    if (_totalScore <= 140) {
      return l10n.grace_risk_moderate;
    }
    if (_totalScore <= 200) {
      return l10n.grace_risk_high;
    }
    return l10n.grace_risk_very_high;
  }

  String get mortalityRisk {
    final l10n = AppLocalizations.of(context)!;
    if (_totalScore <= 108) {
      return l10n.grace_mortality_6_month_low;
    }
    if (_totalScore <= 140) {
      return l10n.grace_mortality_6_month_moderate;
    }
    if (_totalScore <= 200) {
      return l10n.grace_mortality_6_month_high;
    }
    return l10n.grace_mortality_6_month_very_high;
  }

  String get hospitalizationMortality {
    final l10n = AppLocalizations.of(context)!;
    if (_totalScore <= 108) {
      return l10n.grace_mortality_hospital_low;
    }
    if (_totalScore <= 140) {
      return l10n.grace_mortality_hospital_moderate;
    }
    if (_totalScore <= 200) {
      return l10n.grace_mortality_hospital_high;
    }
    return l10n.grace_mortality_hospital_very_high;
  }

  String get recommendations {
    final l10n = AppLocalizations.of(context)!;
    if (_totalScore <= 108) {
      return l10n.grace_recommendation_low;
    }
    if (_totalScore <= 140) {
      return l10n.grace_recommendation_moderate;
    }
    if (_totalScore <= 200) {
      return l10n.grace_recommendation_high;
    }
    return l10n.grace_recommendation_very_high;
  }

  String get interventionStrategy {
    final l10n = AppLocalizations.of(context)!;
    if (_totalScore <= 108) {
      return l10n.grace_strategy_conservative;
    }
    if (_totalScore <= 140) {
      return l10n.grace_strategy_selective;
    }
    if (_totalScore <= 200) {
      return l10n.grace_strategy_early;
    }
    return l10n.grace_strategy_immediate;
  }

  String get interventionTiming {
    final l10n = AppLocalizations.of(context)!;
    if (_totalScore <= 108) {
      return l10n.grace_timing_72h;
    }
    if (_totalScore <= 140) {
      return l10n.grace_timing_24_72h;
    }
    if (_totalScore <= 200) {
      return l10n.grace_timing_24h;
    }
    return l10n.grace_timing_2h;
  }

  String get detailedInterventionTiming {
    final l10n = AppLocalizations.of(context)!;
    if (_totalScore <= 108) {
      return l10n.grace_detailed_timing_low;
    }
    if (_totalScore <= 140) {
      return l10n.grace_detailed_timing_moderate;
    }
    if (_totalScore <= 200) {
      return l10n.grace_detailed_timing_high;
    }
    return l10n.grace_detailed_timing_very_high;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky App Bar
          SliverAppBar(
            title: Text(AppLocalizations.of(context)!.grace_score_title),
            backgroundColor: Colors.red.shade700,
            foregroundColor: Colors.white,
            centerTitle: true,
            floating: false,
            pinned: true,
            snap: false,
            expandedHeight: 0,
          ),
          
          // Sticky Score Header
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            flexibleSpace: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: riskColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: riskColor.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Text(
                      'GRACE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: riskColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '$_totalScore',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: riskColor,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        riskLevel,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: riskColor,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
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
                          AppLocalizations.of(context)!.medical_disclaimer_professional_only,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(context)!.medical_disclaimer_grace_text,
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
          
          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Risk Info
                _buildRiskInfo(),

                // Input Parameters
                _buildInputSection(),

                // Clinical Factors
            _buildClinicalFactors(),

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
                        AppLocalizations.of(context)!.grace_reference_title,
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
                    AppLocalizations.of(context)!.grace_reference_text,
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
      margin: const EdgeInsets.all(16),
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
                      AppLocalizations.of(context)!.grace_6_month_mortality,
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
                      AppLocalizations.of(context)!.grace_hospital_mortality,
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
                  AppLocalizations.of(context)!.grace_intervention_strategy_label,
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
                  AppLocalizations.of(context)!.grace_recommendations_label,
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
                  AppLocalizations.of(context)!.grace_intervention_timing_label,
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
            AppLocalizations.of(context)!.grace_input_parameters,
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
                    labelText: AppLocalizations.of(context)!.grace_age_label.split('(')[0].trim(),
                    suffixText: AppLocalizations.of(context)!.years,
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
                    labelText: AppLocalizations.of(context)!.grace_heart_rate_label.split('(')[0].trim(),
                    suffixText: AppLocalizations.of(context)!.grace_per_minute_unit,
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
                    labelText: AppLocalizations.of(context)!.grace_systolic_bp_label.split('(')[0].trim(),
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
                  AppLocalizations.of(context)!.grace_creatinine_label,
                  AppLocalizations.of(context)!.creatinine_helper,
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
            AppLocalizations.of(context)!.grace_clinical_factors,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.grace_heart_failure_title),
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
            title: Text(AppLocalizations.of(context)!.grace_cardiac_arrest_title),
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
            title: Text(AppLocalizations.of(context)!.grace_st_elevation_title),
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
            title: Text(AppLocalizations.of(context)!.grace_elevated_markers_title),
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
            AppLocalizations.of(context)!.grace_risk_stratification,
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
                    AppLocalizations.of(context)!.score,
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
                    AppLocalizations.of(context)!.grace_risk_level,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.grace_6_month_mort,
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
                    AppLocalizations.of(context)!.grace_hospital_mort,
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
                    AppLocalizations.of(context)!.grace_intervention_timing_column,
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
          
          _buildRiskItem('≤ 108', AppLocalizations.of(context)!.grace_risk_low, AppLocalizations.of(context)!.grace_mortality_6_month_low, AppLocalizations.of(context)!.grace_mortality_hospital_low, AppLocalizations.of(context)!.grace_timing_72h, Colors.green),
          _buildRiskItem('109-140', AppLocalizations.of(context)!.grace_risk_moderate, AppLocalizations.of(context)!.grace_mortality_6_month_moderate, AppLocalizations.of(context)!.grace_mortality_hospital_moderate, AppLocalizations.of(context)!.grace_timing_24_72h, Colors.yellow.shade700),
          _buildRiskItem('141-200', AppLocalizations.of(context)!.grace_risk_high, AppLocalizations.of(context)!.grace_mortality_6_month_high, AppLocalizations.of(context)!.grace_mortality_hospital_high, AppLocalizations.of(context)!.grace_timing_24h, Colors.orange),
          _buildRiskItem('> 200', AppLocalizations.of(context)!.grace_risk_very_high, AppLocalizations.of(context)!.grace_mortality_6_month_very_high, AppLocalizations.of(context)!.grace_mortality_hospital_very_high, AppLocalizations.of(context)!.grace_timing_2h, Colors.red),
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
                AppLocalizations.of(context)!.grace_clinical_info_title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.purple.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.grace_clinical_info_content.replaceAll('\\n', '\n'),
            style: const TextStyle(height: 1.4),
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
                        AppLocalizations.of(context)!.grace_detailed_timing_title,
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
                  detailedInterventionTiming.replaceAll('\\n', '\n'),
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
