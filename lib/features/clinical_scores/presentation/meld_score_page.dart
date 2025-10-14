import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class MeldScorePage extends StatefulWidget {
  const MeldScorePage({super.key});

  @override
  State<MeldScorePage> createState() => _MeldScorePageState();
}

class _MeldScorePageState extends State<MeldScorePage> {
  final TextEditingController _creatinineController = TextEditingController();
  final TextEditingController _bilirubinController = TextEditingController();
  final TextEditingController _inrController = TextEditingController();

  bool _dialysis = false;

  // Unit selections
  String _creatinineUnit = 'mg/dL';
  String _bilirubinUnit = 'mg/dL';

  double _meldScore = 0.0;

  @override
  void initState() {
    super.initState();
    _creatinineController.addListener(calculateMELDScore);
    _bilirubinController.addListener(calculateMELDScore);
    _inrController.addListener(calculateMELDScore);
  }

  // Unit conversion functions
  double convertCreatinineToMgDL(double value, String fromUnit) {
    if (fromUnit == 'umol/L') {
      return value / 88.4; // umol/L to mg/dL
    }
    return value; // already in mg/dL
  }

  double convertBilirubinToMgDL(double value, String fromUnit) {
    if (fromUnit == 'umol/L') {
      return value * 0.0585; // umol/L to mg/dL
    }
    return value; // already in mg/dL
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
            SizedBox(
              width: 80,
              child: DropdownButtonFormField<String>(
                initialValue: currentUnit,
                onChanged: (value) => onUnitChanged(value!),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                ),
                items: units.map((unit) {
                  return DropdownMenuItem(
                    value: unit,
                    child: Text(
                      unit,
                      style: const TextStyle(fontSize: 9),
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

  void calculateMELDScore() {
    double creatinineValue = double.tryParse(_creatinineController.text) ?? 0;
    double bilirubinValue = double.tryParse(_bilirubinController.text) ?? 0;
    final inr = double.tryParse(_inrController.text) ?? 0;

    // Convert to mg/dL for calculation
    double creatinine = convertCreatinineToMgDL(creatinineValue, _creatinineUnit);
    double bilirubin = convertBilirubinToMgDL(bilirubinValue, _bilirubinUnit);

    if (creatinine > 0 && bilirubin > 0 && inr > 0) {
      // MELD = 3.78 × ln(serum bilirubin mg/dL) + 11.2 × ln(INR) + 9.57 × ln(serum creatinine mg/dL) + 6.43
      
      double adjustedCreatinine = creatinine;
      
      // If dialysis, creatinine is set to 4.0
      if (_dialysis) {
        adjustedCreatinine = 4.0;
      } else {
        // Maximum creatinine value is 4.0
        adjustedCreatinine = math.min(creatinine, 4.0);
      }
      
      // Minimum values
      adjustedCreatinine = math.max(adjustedCreatinine, 1.0);
      final adjustedBilirubin = math.max(bilirubin, 1.0);
      final adjustedInr = math.max(inr, 1.0);

      double score = 3.78 * math.log(adjustedBilirubin) + 
                     11.2 * math.log(adjustedInr) + 
                     9.57 * math.log(adjustedCreatinine) + 
                     6.43;

      // Round to nearest integer
      score = (score * 10).round() / 10;
      
      // Minimum MELD score is 6
      score = math.max(score, 6.0);
      
      // Maximum MELD score is 40
      score = math.min(score, 40.0);

      setState(() {
        _meldScore = score;
      });
    } else {
      setState(() {
        _meldScore = 0.0;
      });
    }
  }

  Color get riskColor {
    if (_meldScore < 10) {
      return Colors.green;
    }
    if (_meldScore < 15) {
      return Colors.yellow.shade700;
    }
    if (_meldScore < 20) {
      return Colors.orange;
    }
    if (_meldScore < 25) {
      return Colors.red.shade600;
    }
    return Colors.red.shade900;
  }

  String getRiskLevel(AppLocalizations localizations) {
    if (_meldScore < 10) {
      return localizations.meld_risk_low;
    }
    if (_meldScore < 15) {
      return localizations.meld_risk_low_moderate;
    }
    if (_meldScore < 20) {
      return localizations.meld_risk_moderate;
    }
    if (_meldScore < 25) {
      return localizations.meld_risk_high;
    }
    return localizations.meld_risk_very_high;
  }

  String get mortalityRisk3Month {
    if (_meldScore < 10) {
      return '1.9%';
    }
    if (_meldScore < 15) {
      return '6.0%';
    }
    if (_meldScore < 20) {
      return '19.6%';
    }
    if (_meldScore < 25) {
      return '76.0%';
    }
    return '>90%';
  }

  String getTransplantPriority(AppLocalizations localizations) {
    if (_meldScore < 15) {
      return localizations.priority_low;
    }
    if (_meldScore < 25) {
      return localizations.priority_moderate;
    }
    return localizations.priority_high;
  }

  String getRecommendations(AppLocalizations localizations) {
    if (_meldScore < 10) {
      return localizations.meld_follow_up;
    }
    if (_meldScore < 15) {
      return localizations.meld_evaluation;
    }
    if (_meldScore < 20) {
      return localizations.meld_waitlist;
    }
    if (_meldScore < 25) {
      return localizations.meld_high_priority;
    }
    return localizations.meld_urgent;
  }

  Color _getSolidBackgroundColor() {
    if (_meldScore < 10) {
      return Colors.green.shade100;
    }
    if (_meldScore < 15) {
      return Colors.yellow.shade100;
    }
    if (_meldScore < 20) {
      return Colors.orange.shade100;
    }
    if (_meldScore < 25) {
      return Colors.red.shade200;
    }
    return Colors.red.shade300;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Main AppBar (sticky)
          SliverAppBar(
            pinned: true,
            title: Text(localizations.meld_score),
            backgroundColor: Colors.brown.shade700,
            foregroundColor: Colors.white,
          ),
          
          // Score Display Header (sticky)
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            backgroundColor: _getSolidBackgroundColor(),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: _getSolidBackgroundColor(),
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
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
                            localizations.meld_score,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: riskColor,
                            ),
                          ),
                          Text(
                            '${localizations.risk_text} ${getRiskLevel(localizations)}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.darkGrey,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        _meldScore > 0 ? _meldScore.toStringAsFixed(1) : '0',
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
                  child: _buildRiskInfo(localizations),
                ),

                // Input Parameters
                _buildInputSection(localizations),

                // Risk Stratification
                _buildRiskStratification(localizations),

                // Transplant Guidelines
                _buildTransplantGuidelines(localizations),

                // Clinical Information
                _buildClinicalInfo(localizations),

                // Medical Citation
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildCitationWidget(localizations),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskInfo(AppLocalizations localizations) {
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
                    localizations.mortality_3_month,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    mortalityRisk3Month,
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
                    localizations.transplant_priority,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    getTransplantPriority(localizations),
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
                      localizations.meld_recommendations,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  getRecommendations(localizations),
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

  Widget _buildInputSection(AppLocalizations localizations) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.brown.shade300),
        color: Colors.brown.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.meld_parameters,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.brown.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          // Creatinine with unit conversion
          _buildLabInputWithUnit(
            'Creatinine',
            localizations.creatinine_helper,
            _creatinineController,
            _creatinineUnit,
            ['mg/dL', 'umol/L'],
            (value) {
              setState(() {
                _creatinineUnit = value;
              });
              calculateMELDScore();
            },
            (value) => calculateMELDScore(),
          ),
          const SizedBox(height: 12),
          
          // Bilirubin with unit conversion  
          _buildLabInputWithUnit(
            'Bilirubin',
            localizations.bilirubin_helper,
            _bilirubinController,
            _bilirubinUnit,
            ['mg/dL', 'umol/L'],
            (value) {
              setState(() {
                _bilirubinUnit = value;
              });
              calculateMELDScore();
            },
            (value) => calculateMELDScore(),
          ),
          const SizedBox(height: 12),
          
          // INR
          TextField(
            controller: _inrController,
            keyboardType: TextInputType.number,
            onChanged: (value) => calculateMELDScore(),
            decoration: InputDecoration(
              labelText: 'INR',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: localizations.inr_helper,
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            title: Text(localizations.dialysis),
            subtitle: Text(localizations.dialysis_description),
            value: _dialysis,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _dialysis = value!;
              });
              calculateMELDScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildRiskStratification(AppLocalizations localizations) {
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
            localizations.meld_risk_stratification,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('<10', localizations.meld_risk_low, '1.9%', localizations.meld_follow_up_action, Colors.green),
          _buildRiskItem('10-14', localizations.meld_risk_low_moderate, '6.0%', localizations.meld_evaluation_action, Colors.yellow.shade700),
          _buildRiskItem('15-19', localizations.meld_risk_moderate, '19.6%', localizations.meld_waitlist_action, Colors.orange),
          _buildRiskItem('20-24', localizations.meld_risk_high, '76.0%', localizations.meld_high_priority_action, Colors.red.shade600),
          _buildRiskItem('≥25', localizations.meld_risk_very_high, '>90%', localizations.meld_urgent_action, Colors.red.shade900),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String risk, String mortality, String action, Color color) {
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
                  mortality,
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

  Widget _buildTransplantGuidelines(AppLocalizations localizations) {
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
            localizations.transplant_guidelines,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildGuidelineCard(
            localizations.meld_follow_up_title,
            [
              localizations.routine_visit_6_months,
              localizations.liver_ultrasound_6_months,
              localizations.afp_every_6_months,
              localizations.screen_complications,
            ],
            Colors.green,
          ),
          const SizedBox(height: 12),
          _buildGuidelineCard(
            localizations.meld_waitlist_title,
            [
              localizations.add_to_waitlist,
              localizations.comprehensive_evaluation,
              localizations.follow_up_3_months,
              localizations.screen_liver_cancer,
            ],
            Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildGuidelineCard(
            localizations.meld_high_priority_title,
            [
              localizations.high_priority_transplant,
              localizations.weekly_monitoring,
              localizations.consider_living_donor,
              localizations.intensive_support,
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

  Widget _buildClinicalInfo(AppLocalizations localizations) {
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
                localizations.clinical_information,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            localizations.meld_clinical_info,
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _creatinineController.dispose();
    _bilirubinController.dispose();
    _inrController.dispose();
    super.dispose();
  }

  Widget _buildCitationWidget(AppLocalizations localizations) {
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
                localizations.references,
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
            localizations.meld_reference_text,
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
