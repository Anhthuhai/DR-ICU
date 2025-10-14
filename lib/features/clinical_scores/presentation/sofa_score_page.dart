import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

class SOFAScorePage extends StatefulWidget {
  const SOFAScorePage({super.key});

  @override
  State<SOFAScorePage> createState() => _SOFAScorePageState();
}

class _SOFAScorePageState extends State<SOFAScorePage> {
  // SOFA component scores (0-4 each)
  int respiratoryScore = 0;
  int cardiovascularScore = 0;
  int hepaticScore = 0;
  int coagulationScore = 0;
  int renalScore = 0;
  int neurologicalScore = 0;

  // Controllers for inputs
  final TextEditingController pao2Controller = TextEditingController();
  final TextEditingController bilirubinController = TextEditingController();
  final TextEditingController plateletsController = TextEditingController();
  final TextEditingController creatinineController = TextEditingController();
  final TextEditingController urineController = TextEditingController();

  // Unit selections
  String bilirubinUnit = 'mg/dL'; // 'mg/dL' or 'umol/L'
  String creatinineUnit = 'mg/dL'; // 'mg/dL' or 'umol/L'

  int get totalScore => respiratoryScore + cardiovascularScore + hepaticScore + 
                       coagulationScore + renalScore + neurologicalScore;

  String interpretation(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (totalScore == 0) {
      return l10n.no_organ_failure;
    }
    if (totalScore <= 6) {
      return l10n.mild_organ_failure;
    }
    if (totalScore <= 9) {
      return l10n.moderate_organ_failure;
    }
    if (totalScore <= 12) {
      return l10n.severe_organ_failure;
    }
    return l10n.very_severe_multi_organ_failure;
  }

  Color get scoreColor {
    if (totalScore == 0) {
      return Colors.green;
    }
    if (totalScore <= 6) {
      return Colors.yellow.shade700;
    }
    if (totalScore <= 9) {
      return Colors.orange;
    }
    if (totalScore <= 12) {
      return Colors.red;
    }
    return Colors.red.shade900;
  }

  String get mortalityRisk {
    if (totalScore <= 6) {
      return '< 10%';
    }
    if (totalScore <= 9) {
      return '15-20%';
    }
    if (totalScore <= 12) {
      return '40-50%';
    }
    return '> 80%';
  }

  // Unit conversion functions
  double _convertBilirubinToMgDl(double value, String unit) {
    if (unit == 'umol/L') {
      // Convert umol/L to mg/dL: umol/L ÷ 17.1 = mg/dL
      return value / 17.1;
    }
    return value; // Already in mg/dL
  }

  double _convertCreatinineToMgDl(double value, String unit) {
    if (unit == 'umol/L') {
      // Convert umol/L to mg/dL: umol/L ÷ 88.4 = mg/dL
      return value / 88.4;
    }
    return value; // Already in mg/dL
  }

  @override
  void dispose() {
    pao2Controller.dispose();
    bilirubinController.dispose();
    plateletsController.dispose();
    creatinineController.dispose();
    urineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky App Bar
          SliverAppBar(
            title: Text(l10n.sofaScore),
            backgroundColor: AppTheme.primaryBlue,
            foregroundColor: Colors.white,
            floating: false,
            pinned: true,
            snap: false,
            expandedHeight: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _resetAll,
              ),
            ],
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
                  color: scoreColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: scoreColor.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Text(
                      'SOFA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: scoreColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '$totalScore',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: scoreColor,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        mortalityRisk,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: scoreColor,
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
          
          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Organ Systems
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildRespiratorySection(),
                      const SizedBox(height: 16),
                      _buildCardiovascularSection(),
                      const SizedBox(height: 16),
                      _buildHepaticSection(),
                      const SizedBox(height: 16),
                      _buildCoagulationSection(),
                      const SizedBox(height: 16),
                      _buildRenalSection(),
                      const SizedBox(height: 16),
                      _buildNeurologicalSection(),
                      const SizedBox(height: 16),
                      _buildSOFACitation(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRespiratorySection() {
    final l10n = AppLocalizations.of(context)!;
    return _buildOrganSection(
      l10n.respiratory_system,
      Colors.blue.shade600,
      Icons.air,
      [
        TextField(
          controller: pao2Controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: l10n.pao2_fio2_mmhg,
            border: const OutlineInputBorder(),
            helperText: l10n.if_not_ventilated_helper,
          ),
          // ignore: deprecated_member_use
          onChanged: (value) {
            double pao2fio2 = double.tryParse(value) ?? 0;
            setState(() {
              if (pao2fio2 >= 400) {
                respiratoryScore = 0;
              }
              else if (pao2fio2 >= 300) {
   respiratoryScore = 1;
 }
              else if (pao2fio2 >= 200) {
   respiratoryScore = 2;
 }
              else if (pao2fio2 >= 100) {
   respiratoryScore = 3;
 }
              else if (pao2fio2 > 0) {
   respiratoryScore = 4;
 }
              else {
                respiratoryScore = 0;
              }
            });
          },
        ),
        _buildScoreIndicator(respiratoryScore),
      ],
    );
  }

  Widget _buildCardiovascularSection() {
    final l10n = AppLocalizations.of(context)!;
    return _buildOrganSection(
      l10n.cardiovascular_system,
      Colors.red.shade600,
      Icons.favorite,
      [
        Text(l10n.mean_arterial_pressure_or_vasopressors, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Column(
          children: [
            RadioListTile<int>(
              title: const Text('MAP ≥ 70 mmHg'),
              value: 0,
              // ignore: deprecated_member_use
              groupValue: cardiovascularScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => cardiovascularScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: Text(l10n.map_less_than_70),
              value: 1,
              // ignore: deprecated_member_use
              groupValue: cardiovascularScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => cardiovascularScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: Text(l10n.dopamine_dobutamine),
              value: 2,
              // ignore: deprecated_member_use
              groupValue: cardiovascularScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => cardiovascularScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: Text(l10n.dopamine_5_15),
              value: 3,
              // ignore: deprecated_member_use
              groupValue: cardiovascularScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => cardiovascularScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: Text(l10n.dopamine_greater_15),
              value: 4,
              // ignore: deprecated_member_use
              groupValue: cardiovascularScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => cardiovascularScore = value!),
              dense: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHepaticSection() {
    final l10n = AppLocalizations.of(context)!;
    return _buildOrganSection(
      l10n.hepatic_system,
      Colors.amber.shade700,
      Icons.healing,
      [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: bilirubinController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: '${l10n.bilirubin_mg_dl.split('(')[0]}($bilirubinUnit)',
                border: const OutlineInputBorder(),
                helperText: l10n.enter_total_bilirubin_value,
              ),
              // ignore: deprecated_member_use
              onChanged: (value) {
                double inputValue = double.tryParse(value) ?? 0;
                double bilirubin = _convertBilirubinToMgDl(inputValue, bilirubinUnit);
                setState(() {
                  if (bilirubin < 1.2) {
                    hepaticScore = 0;
                  }
                  else if (bilirubin < 2.0) {
         hepaticScore = 1;
       }
                  else if (bilirubin < 6.0) {
         hepaticScore = 2;
       }
                  else if (bilirubin < 12.0) {
         hepaticScore = 3;
       }
                  else if (bilirubin > 0) {
         hepaticScore = 4;
       }
                  else {
                    hepaticScore = 0;
                  }
                });
              },
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: DropdownButtonFormField<String>(
                initialValue: bilirubinUnit,
                decoration: InputDecoration(
                  labelText: l10n.bilirubin_unit_label,
                  border: const OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'mg/dL', child: Text('mg/dL')),
                  DropdownMenuItem(value: 'umol/L', child: Text('umol/L')),
                ],
                onChanged: (String? newUnit) {
                  setState(() {
                    bilirubinUnit = newUnit!;
                    // Trigger recalculation with current value
                    if (bilirubinController.text.isNotEmpty) {
                      double inputValue = double.tryParse(bilirubinController.text) ?? 0;
                      double bilirubin = _convertBilirubinToMgDl(inputValue, bilirubinUnit);
                      if (bilirubin < 1.2) {
                        hepaticScore = 0;
                      }
                      else if (bilirubin < 2.0) {
             hepaticScore = 1;
           }
                      else if (bilirubin < 6.0) {
             hepaticScore = 2;
           }
                      else if (bilirubin < 12.0) {
             hepaticScore = 3;
           }
                      else if (bilirubin > 0) {
             hepaticScore = 4;
           }
                      else {
                        hepaticScore = 0;
                      }
                    }
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Text(
            l10n.bilirubin_conversion_note,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        _buildScoreIndicator(hepaticScore),
      ],
    );
  }

  Widget _buildCoagulationSection() {
    final l10n = AppLocalizations.of(context)!;
    return _buildOrganSection(
      l10n.coagulation_system,
      Colors.purple.shade600,
      Icons.bloodtype,
      [
        TextField(
          controller: plateletsController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: l10n.platelets_1000_ul,
            border: const OutlineInputBorder(),
            helperText: l10n.enter_platelet_count,
          ),
          // ignore: deprecated_member_use
          onChanged: (value) {
            int platelets = int.tryParse(value) ?? 0;
            setState(() {
              if (platelets >= 150) {
                coagulationScore = 0;
              }
              else if (platelets >= 100) {
   coagulationScore = 1;
 }
              else if (platelets >= 50) {
   coagulationScore = 2;
 }
              else if (platelets >= 20) {
   coagulationScore = 3;
 }
              else if (platelets > 0) {
   coagulationScore = 4;
 }
              else {
                coagulationScore = 0;
              }
            });
          },
        ),
        _buildScoreIndicator(coagulationScore),
      ],
    );
  }

  Widget _buildRenalSection() {
    final l10n = AppLocalizations.of(context)!;
    return _buildOrganSection(
      l10n.renal_system,
      Colors.teal.shade600,
      Icons.water_drop,
      [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: creatinineController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: '${l10n.creatinine_mg_dl_label.split('(')[0]}($creatinineUnit)',
                border: const OutlineInputBorder(),
                helperText: l10n.enter_creatinine_value,
              ),
              // ignore: deprecated_member_use
              onChanged: (value) {
                double inputValue = double.tryParse(value) ?? 0;
                double creatinine = _convertCreatinineToMgDl(inputValue, creatinineUnit);
                setState(() {
                  if (creatinine < 1.2) {
                    renalScore = 0;
                  }
                  else if (creatinine < 2.0) {
         renalScore = 1;
       }
                  else if (creatinine < 3.5) {
         renalScore = 2;
       }
                  else if (creatinine < 5.0) {
         renalScore = 3;
       }
                  else if (creatinine > 0) {
         renalScore = 4;
       }
                  else {
                    renalScore = 0;
                  }
                });
              },
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: DropdownButtonFormField<String>(
                initialValue: creatinineUnit,
                decoration: InputDecoration(
                  labelText: l10n.creatinine_unit,
                  border: const OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'mg/dL', child: Text('mg/dL')),
                  DropdownMenuItem(value: 'umol/L', child: Text('umol/L')),
                ],
                onChanged: (String? newUnit) {
                  setState(() {
                    creatinineUnit = newUnit!;
                    // Trigger recalculation with current value
                    if (creatinineController.text.isNotEmpty) {
                      double inputValue = double.tryParse(creatinineController.text) ?? 0;
                      double creatinine = _convertCreatinineToMgDl(inputValue, creatinineUnit);
                      if (creatinine < 1.2) {
                        renalScore = 0;
                      }
                      else if (creatinine < 2.0) {
             renalScore = 1;
           }
                      else if (creatinine < 3.5) {
             renalScore = 2;
           }
                      else if (creatinine < 5.0) {
             renalScore = 3;
           }
                      else if (creatinine > 0) {
             renalScore = 4;
           }
                      else {
                        renalScore = 0;
                      }
                    }
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Text(
            l10n.conversion_note,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: urineController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: l10n.urine_output_ml_day,
            border: const OutlineInputBorder(),
            helperText: l10n.enter_urine_output_24h,
          ),
          // ignore: deprecated_member_use
          onChanged: (value) {
            int urine = int.tryParse(value) ?? 0;
            if (urine > 0) {
              setState(() {
                if (urine < 200) {
                  renalScore = 4;
                }
                else if (urine < 500) {
   renalScore = 3;
 }
                // Creatinine score takes precedence if higher
              });
            }
          },
        ),
        _buildScoreIndicator(renalScore),
      ],
    );
  }

  Widget _buildNeurologicalSection() {
    final l10n = AppLocalizations.of(context)!;
    return _buildOrganSection(
      l10n.neurological_system,
      Colors.indigo.shade600,
      Icons.psychology,
      [
        Text(l10n.glasgow_coma_scale_score, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Column(
          children: [
            RadioListTile<int>(
              title: const Text('GCS 15'),
              value: 0,
              // ignore: deprecated_member_use
              groupValue: neurologicalScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => neurologicalScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: const Text('GCS 13-14'),
              value: 1,
              // ignore: deprecated_member_use
              groupValue: neurologicalScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => neurologicalScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: const Text('GCS 10-12'),
              value: 2,
              // ignore: deprecated_member_use
              groupValue: neurologicalScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => neurologicalScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: const Text('GCS 6-9'),
              value: 3,
              // ignore: deprecated_member_use
              groupValue: neurologicalScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => neurologicalScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: const Text('GCS < 6'),
              value: 4,
              // ignore: deprecated_member_use
              groupValue: neurologicalScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => neurologicalScore = value!),
              dense: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrganSection(String title, Color color, IconData icon, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        color: color.withValues(alpha: 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildScoreIndicator(int score) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Text(l10n.score_colon, style: const TextStyle(fontWeight: FontWeight.w500)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: score == 0 ? Colors.green : 
                     score <= 2 ? Colors.orange : Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              score.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _resetAll() {
    setState(() {
      respiratoryScore = cardiovascularScore = hepaticScore = 0;
      coagulationScore = renalScore = neurologicalScore = 0;
      // Reset units to default
      bilirubinUnit = 'mg/dL';
      creatinineUnit = 'mg/dL';
    });
    
    pao2Controller.clear();
    bilirubinController.clear();
    plateletsController.clear();
    creatinineController.clear();
    urineController.clear();
  }

  Widget _buildSOFACitation() {
    final l10n = AppLocalizations.of(context)!;
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
                l10n.references,
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
            'Vincent JL, Moreno R, Takala J, et al. The SOFA (Sepsis-related Organ Failure Assessment) score to describe organ dysfunction/failure. Intensive Care Med. 1996;22(7):707-10.',
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
