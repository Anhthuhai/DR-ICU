import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class ChildPughPage extends StatefulWidget {
  const ChildPughPage({super.key});

  @override
  State<ChildPughPage> createState() => _ChildPughPageState();
}

class _ChildPughPageState extends State<ChildPughPage> {
  int bilirubinScore = 0;
  int albuminScore = 0;
  int prothrombinScore = 0;
  int ascitesScore = 0;
  int encephalopathyScore = 0;

  final TextEditingController bilirubinController = TextEditingController();
  final TextEditingController albuminController = TextEditingController();
  final TextEditingController prothrombinController = TextEditingController();

  // Unit variables
  String _bilirubinUnit = 'mg/dL';

  int get totalScore => bilirubinScore + albuminScore + prothrombinScore + ascitesScore + encephalopathyScore;

  String get childPughClass {
    if (totalScore <= 6) {
      return 'A';
    }
    if (totalScore <= 9) {
      return 'B';
    }
    return 'C';
  }

  Color get scoreColor {
    switch (childPughClass) {
      case 'A': return Colors.green;
      case 'B': return Colors.orange;
      case 'C': return Colors.red;
      default: return Colors.grey;
    }
  }

  String getSeverity(AppLocalizations localizations) {
    switch (childPughClass) {
      case 'A': return localizations.mild_liver_disease;
      case 'B': return localizations.moderate_liver_disease;
      case 'C': return localizations.severe_liver_disease;
      default: return '';
    }
  }

  String get oneYearSurvival {
    switch (childPughClass) {
      case 'A': return '95%';
      case 'B': return '80%';
      case 'C': return '45%';
      default: return '';
    }
  }

  String get twoYearSurvival {
    switch (childPughClass) {
      case 'A': return '90%';
      case 'B': return '70%';
      case 'C': return '35%';
      default: return '';
    }
  }

  String getOperativeRisk(AppLocalizations localizations) {
    switch (childPughClass) {
      case 'A': return localizations.low_operative_risk;
      case 'B': return localizations.moderate_operative_risk;
      case 'C': return localizations.high_operative_risk;
      default: return '';
    }
  }

  // Unit conversion function
  double convertBilirubinToMgDL(double value, String unit) {
    if (unit == 'umol/L') {
      return value / 17.1; // Convert umol/L to mg/dL
    }
    return value; // Already in mg/dL
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.child_pugh_score),
        backgroundColor: Colors.amber.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
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
                          ? 'LƯU Ý Y KHOA GAN MẬT: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ chuyên khoa tiêu hóa gan mật trước khi đưa ra quyết định điều trị.'
                          : 'HEPATOLOGY MEDICAL DISCLAIMER: Results are for reference only. Always consult with hepatologist before making treatment decisions.',
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
                color: scoreColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: scoreColor.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    localizations.child_pugh_classification,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: scoreColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        totalScore.toString(),
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: scoreColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Class $childPughClass',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: scoreColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    getSeverity(localizations),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSurvivalInfo(localizations),
                ],
              ),
            ),

            // Laboratory values
            _buildSection(
              localizations.child_pugh_laboratory_tests,
              Colors.blue.shade600,
              [
                _buildLabInputWithUnit(
                  localizations,
                  localizations.bilirubin,
                  bilirubinController,
                  Icons.water_drop,
                  (value) {
                    double bilirubinInput = double.tryParse(value) ?? 0;
                    double bilirubin = convertBilirubinToMgDL(bilirubinInput, _bilirubinUnit);
                    setState(() {
                      if (bilirubin < 2) {
                        bilirubinScore = 1;
                      } else if (bilirubin <= 3) {
                        bilirubinScore = 2;
                      } else {
                        bilirubinScore = 3;
                      }
                    });
                  },
                  bilirubinScore,
                  '<2 mg/dL (<34 umol/L): 1pt, 2-3 mg/dL (34-51 umol/L): 2pts, >3 mg/dL (>51 umol/L): 3pts',
                  _bilirubinUnit,
                  ['mg/dL', 'umol/L'],
                  (value) {
                    setState(() {
                      _bilirubinUnit = value;
                    });
                    // Recalculate score with new unit
                    if (bilirubinController.text.isNotEmpty) {
                      double bilirubinInput = double.tryParse(bilirubinController.text) ?? 0;
                      double bilirubin = convertBilirubinToMgDL(bilirubinInput, _bilirubinUnit);
                      setState(() {
                        if (bilirubin < 2) {
                          bilirubinScore = 1;
                        } else if (bilirubin <= 3) {
                          bilirubinScore = 2;
                        } else {
                          bilirubinScore = 3;
                        }
                      });
                    }
                  },
                ),
                _buildLabInput(
                  localizations,
                  '${localizations.albumin} (g/dL)',
                  albuminController,
                  Icons.science,
                  (value) {
                    double albumin = double.tryParse(value) ?? 0;
                    setState(() {
                      if (albumin > 3.5) {
                        albuminScore = 1;
                      } else if (albumin >= 2.8) {
                        albuminScore = 2;
                      } else {
                        albuminScore = 3;
                      }
                    });
                  },
                  albuminScore,
                  '>3.5: 1pt, 2.8-3.5: 2pts, <2.8: 3pts',
                ),
                _buildLabInput(
                  localizations,
                  localizations.inr_prothrombin_time,
                  prothrombinController,
                  Icons.timer,
                  (value) {
                    double inr = double.tryParse(value) ?? 0;
                    setState(() {
                      if (inr < 1.7) {
                        prothrombinScore = 1;
                      } else if (inr <= 2.3) {
                        prothrombinScore = 2;
                      } else {
                        prothrombinScore = 3;
                      }
                    });
                  },
                  prothrombinScore,
                  '<1.7: 1pt, 1.7-2.3: 2pts, >2.3: 3pts',
                ),
              ],
            ),

            // Clinical findings
            _buildSection(
              localizations.clinical_symptoms,
              Colors.purple.shade600,
              [
                _buildClinicalFinding(
                  localizations.ascites,
                  Icons.airline_seat_recline_extra,
                  ascitesScore,
                  [
                    {'label': localizations.ascites_none, 'value': 1},
                    {'label': localizations.ascites_mild_moderate, 'value': 2},
                    {'label': localizations.ascites_severe, 'value': 3},
                  ],
                  (value) => setState(() => ascitesScore = value),
                ),
                const SizedBox(height: 16),
                _buildClinicalFinding(
                  localizations.hepatic_encephalopathy,
                  Icons.psychology,
                  encephalopathyScore,
                  [
                    {'label': localizations.encephalopathy_none, 'value': 1},
                    {'label': localizations.encephalopathy_grade_1_2, 'value': 2},
                    {'label': localizations.encephalopathy_grade_3_4, 'value': 3},
                  ],
                  (value) => setState(() => encephalopathyScore = value),
                ),
              ],
            ),

            // Reference information
            _buildInfoBox(localizations),

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
                        localizations.reference_material,
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
                    'Child CG, Turcotte JG. Surgery and portal hypertension. Major Probl Clin Surg. 1964;1:1-85. Modified by Pugh RN, Murray-Lyon IM, Dawson JL, et al. Transection of the oesophagus for bleeding oesophageal varices. Br J Surg. 1973;60(8):646-9.',
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
    );
  }

  Widget _buildSection(String title, Color color, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        color: color.withValues(alpha: 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSurvivalInfo(AppLocalizations localizations) {
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
                    localizations.one_year_survival,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    oneYearSurvival,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: scoreColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    localizations.two_year_survival,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    twoYearSurvival,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: scoreColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            getOperativeRisk(localizations),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppTheme.darkGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLabInputWithUnit(
    AppLocalizations localizations,
    String title,
    TextEditingController controller,
    IconData icon,
    Function(String) onChanged,
    int score,
    String ranges,
    String currentUnit,
    List<String> units,
    ValueChanged<String> onUnitChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: score > 0 ? scoreColor.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  localizations.child_pugh_score_display(score),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: score > 0 ? scoreColor : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: localizations.enter_value,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onChanged: onChanged,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  initialValue: currentUnit,
                  onChanged: (value) => onUnitChanged(value!),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
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
          const SizedBox(height: 4),
          Text(
            ranges,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildLabInput(
    AppLocalizations localizations,
    String title,
    TextEditingController controller,
    IconData icon,
    Function(String) onChanged,
    int score,
    String ranges,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: score > 0 ? scoreColor.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  localizations.child_pugh_score_display(score),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: score > 0 ? scoreColor : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: localizations.enter_value,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            // ignore: deprecated_member_use
            onChanged: null,
          ),
          const SizedBox(height: 4),
          Text(
            ranges,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClinicalFinding(
    String title,
    IconData icon,
    int selectedValue,
    List<Map<String, dynamic>> options,
    Function(int) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Column(
          children: options.map((option) => RadioListTile<int>(
            title: Text(option['label']),
            value: option['value'],
            // ignore: deprecated_member_use
            groupValue: selectedValue,
            // ignore: deprecated_member_use
            onChanged: (value) => onChanged(value!),
            dense: true,
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildInfoBox(AppLocalizations localizations) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.amber.shade50,
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.amber.shade700),
              const SizedBox(width: 8),
              Text(
                localizations.child_pugh_clinical_information,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.amber.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${localizations.child_pugh_usage}\n'
            '${localizations.class_a_info}\n'
            '${localizations.class_b_info}\n'
            '${localizations.class_c_info}\n'
            '${localizations.meld_combination}',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }
}
