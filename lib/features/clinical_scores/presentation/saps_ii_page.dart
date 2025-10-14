import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

class SAPSII extends StatefulWidget {
  const SAPSII({super.key});

  @override
  State<SAPSII> createState() => _SAPSIIState();
}

class _SAPSIIState extends State<SAPSII> {
  // Age score
  int ageScore = 0;
  final TextEditingController ageController = TextEditingController();

  // Vital signs scores
  int heartRateScore = 0;
  int systolicBPScore = 0;
  int tempScore = 0;

  // Lab values scores
  int pao2fio2Score = 0;
  int urineScore = 0;
  int bilirubiScore = 0;
  int bunScore = 0;
  int wbcScore = 0;
  int potassiumScore = 0;
  int sodiumScore = 0;
  int bicarboScore = 0;

  // Glasgow Coma Scale score
  int gcsScore = 0;

  // Admission type score
  int admissionTypeScore = 0;

  // Chronic diseases score  
  int chronicScore = 0;

  // Unit selections
  String bilirubinUnit = 'mg/dL';
  String bunUnit = 'mg/dL';

  // Controllers
  final TextEditingController hrController = TextEditingController();
  final TextEditingController sbpController = TextEditingController();
  final TextEditingController tempController = TextEditingController();
  final TextEditingController pao2Controller = TextEditingController();
  final TextEditingController urineController = TextEditingController();
  final TextEditingController bilirubinController = TextEditingController();
  final TextEditingController bunController = TextEditingController();
  final TextEditingController wbcController = TextEditingController();
  final TextEditingController kController = TextEditingController();
  final TextEditingController naController = TextEditingController();
  final TextEditingController hco3Controller = TextEditingController();

  int get totalScore => ageScore + heartRateScore + systolicBPScore + tempScore +
                       pao2fio2Score + urineScore + bilirubiScore + bunScore + 
                       wbcScore + potassiumScore + sodiumScore + bicarboScore +
                       gcsScore + admissionTypeScore + chronicScore;

  double get mortalityRisk {
    if (totalScore == 0) {
      return 0.0;
    }
    
    // SAPS II mortality prediction (evidence-based ranges)
    if (totalScore <= 29) {
      return 10.0;
    } else if (totalScore <= 39) {
      return 25.0;
    } else if (totalScore <= 49) {
      return 35.0;
    } else if (totalScore <= 59) {
      return 50.0;
    } else if (totalScore <= 69) {
      return 65.0;
    } else if (totalScore <= 79) {
      return 80.0;
    } else {
      return 90.0;
    }
  }

  String interpretation(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (totalScore == 0) {
      return l10n.please_enter_parameters;
    }
    if (totalScore <= 29) {
      return l10n.low_risk;
    }
    if (totalScore <= 39) {
      return l10n.low_moderate_risk;
    }
    if (totalScore <= 49) {
      return l10n.moderate_risk;
    }
    if (totalScore <= 59) {
      return l10n.high_mortality_risk;
    }
    if (totalScore <= 69) {
      return l10n.very_high_mortality_risk;
    }
    return l10n.extremely_high_risk;
  }

  // Unit conversion functions
  double convertBilirubinToMgDL(double value, String fromUnit) {
    if (fromUnit == 'umol/L') {
      return value * 0.0585; // umol/L to mg/dL
    }
    return value; // already in mg/dL
  }

  double convertBUNToMgDL(double value, String fromUnit) {
    if (fromUnit == 'mmol/L') {
      return value * 2.8; // mmol/L to mg/dL
    }
    return value; // already in mg/dL
  }

  void calculateBilirubinScore(String value) {
    double bilirubin = double.tryParse(value) ?? 0;
    if (bilirubin > 0) {
      // Convert to mg/dL for calculation
      double bilirubinMgDL = convertBilirubinToMgDL(bilirubin, bilirubinUnit);
      setState(() {
        if (bilirubinMgDL < 4.0) {
          bilirubiScore = 0;
        } else if (bilirubinMgDL < 6.0) {
          bilirubiScore = 4;
        } else {
          bilirubiScore = 9;
        }
      });
    } else {
      setState(() {
        bilirubiScore = 0;
      });
    }
  }

  void calculateBUNScore(String value) {
    double bun = double.tryParse(value) ?? 0;
    if (bun > 0) {
      // Convert to mg/dL for calculation
      double bunMgDL = convertBUNToMgDL(bun, bunUnit);
      setState(() {
        if (bunMgDL < 28) {
          bunScore = 0;
        } else if (bunMgDL < 84) {
          bunScore = 6;
        } else {
          bunScore = 10;
        }
      });
    } else {
      setState(() {
        bunScore = 0;
      });
    }
  }

  Color get scoreColor {
    if (totalScore == 0) {
      return Colors.grey;
    }
    if (totalScore <= 29) {
      return Colors.green;
    }
    if (totalScore <= 39) {
      return Colors.green.shade600;
    }
    if (totalScore <= 49) {
      return Colors.orange;
    }
    if (totalScore <= 59) {
      return Colors.red.shade400;
    }
    if (totalScore <= 69) {
      return Colors.red;
    }
    return Colors.red.shade900;
  }

  @override
  void dispose() {
    ageController.dispose();
    hrController.dispose();
    sbpController.dispose();
    tempController.dispose();
    pao2Controller.dispose();
    urineController.dispose();
    bilirubinController.dispose();
    bunController.dispose();
    wbcController.dispose();
    kController.dispose();
    naController.dispose();
    hco3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final totalScore = this.totalScore;
    final mortalityRisk = this.mortalityRisk;
    final interpretationText = interpretation(context);
    final scoreColor = this.scoreColor;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.saps2Score),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetAll,
          ),
        ],
      ),
      body: Column(
        children: [
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
                  l10n.saps2Score,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.darkGrey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  totalScore.toString(),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: scoreColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  interpretationText,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: scoreColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (totalScore > 0) ...[
                  const SizedBox(height: 8),
                  Text(
                    '${l10n.predicted_mortality_rate}: ${mortalityRisk.toStringAsFixed(0)}%',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scoreColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Input Sections
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildDemographicsSection(l10n),
                const SizedBox(height: 16),
                _buildVitalSignsSection(l10n),
                const SizedBox(height: 16),
                                _buildLabValuesSection(l10n),
                const SizedBox(height: 16),
                _buildNeurologicalSection(l10n),
                const SizedBox(height: 16),
                _buildAdmissionSection(l10n),
                
                // Medical Citation
                const SizedBox(height: 16),
                _buildCitationWidget(),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemographicsSection(AppLocalizations l10n) {
    return _buildSection(
      l10n.basic_information,
      Colors.blue.shade600,
      [
        TextField(
          controller: ageController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: l10n.age_years,
            border: const OutlineInputBorder(),
            suffixText: l10n.years,
          ),
          // ignore: deprecated_member_use
          onChanged: (value) {
            int age = int.tryParse(value) ?? 0;
            setState(() {
              if (age < 40) {
                ageScore = 0;
              }
              else if (age < 60) {
   ageScore = 7;
 }
              else if (age < 70) {
   ageScore = 12;
 }
              else if (age < 75) {
   ageScore = 15;
 }
              else if (age < 80) {
   ageScore = 16;
 }
              else {
                ageScore = 18;
              }
            });
          },
        ),
        if (ageScore > 0) 
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('${l10n.age_score}: $ageScore', style: TextStyle(color: Colors.blue.shade600, fontWeight: FontWeight.w600)),
          ),
      ],
    );
  }

  Widget _buildVitalSignsSection(AppLocalizations l10n) {
    return _buildSection(
      l10n.vital_signs,
      Colors.red.shade600,
      [
        _buildVitalSignRow(l10n.heart_rate_bpm, hrController, (value) {
          int hr = int.tryParse(value) ?? 0;
          setState(() {
            if (hr < 40) {
              heartRateScore = 11;
            }
            else if (hr < 70) {
   heartRateScore = 2;
 }
            else if (hr < 120) {
   heartRateScore = 0;
 }
            else if (hr < 160) {
   heartRateScore = 4;
 }
            else {
              heartRateScore = 7;
            }
          });
        }, heartRateScore),
        
        _buildVitalSignRow(l10n.systolic_bp_mmhg, sbpController, (value) {
          int sbp = int.tryParse(value) ?? 0;
          setState(() {
            if (sbp < 70) {
              systolicBPScore = 13;
            }
            else if (sbp < 100) {
   systolicBPScore = 5;
 }
            else if (sbp < 200) {
   systolicBPScore = 0;
 }
            else {
              systolicBPScore = 2;
            }
          });
        }, systolicBPScore),
        
        _buildVitalSignRow(l10n.temperature_celsius, tempController, (value) {
          double temp = double.tryParse(value) ?? 0;
          setState(() {
            if (temp < 39.0) {
              tempScore = 0;
            }
            else {
              tempScore = 3;
            }
          });
        }, tempScore),
      ],
    );
  }

  Widget _buildLabValuesSection(AppLocalizations l10n) {
    return _buildSection(
      l10n.laboratory_tests,
      Colors.purple.shade600,
      [
        _buildVitalSignRow('PaO2/FiO2', pao2Controller, (value) {
          double ratio = double.tryParse(value) ?? 0;
          setState(() {
            if (ratio < 100) {
              pao2fio2Score = 11;
            }
            else if (ratio < 200) {
   pao2fio2Score = 9;
 }
            else {
              pao2fio2Score = 6;
            }
          });
        }, pao2fio2Score),
        
        _buildVitalSignRow(l10n.urine_output_l_day, urineController, (value) {
          double urine = double.tryParse(value) ?? 0;
          setState(() {
            if (urine < 0.5) {
              urineScore = 11;
            }
            else if (urine < 1.0) {
   urineScore = 4;
 }
            else {
              urineScore = 0;
            }
          });
        }, urineScore),
        
        // Bilirubin with unit conversion
        _buildLabValueWithUnit(
          'Bilirubin',
          bilirubinController,
          bilirubinUnit,
          ['mg/dL', 'umol/L'],
          (value) {
            bilirubinUnit = value;
            calculateBilirubinScore(bilirubinController.text);
          },
          (value) => calculateBilirubinScore(value),
          bilirubiScore,
        ),
        
        // BUN with unit conversion  
        _buildLabValueWithUnit(
          'BUN',
          bunController,
          bunUnit,
          ['mg/dL', 'mmol/L'],
          (value) {
            bunUnit = value;
            calculateBUNScore(bunController.text);
          },
          (value) => calculateBUNScore(value),
          bunScore,
        ),

        _buildVitalSignRow(l10n.wbc_count, wbcController, (value) {
          double wbc = double.tryParse(value) ?? 0;
          setState(() {
            if (wbc < 1.0) {
              wbcScore = 12;
            }
            else if (wbc < 20.0) {
   wbcScore = 0;
 }
            else {
              wbcScore = 3;
            }
          });
        }, wbcScore),

        _buildVitalSignRow(l10n.potassium_mmol, kController, (value) {
          double k = double.tryParse(value) ?? 0;
          setState(() {
            if (k < 3.0) {
              potassiumScore = 3;
            }
            else if (k < 5.0) {
   potassiumScore = 0;
 }
            else {
              potassiumScore = 3;
            }
          });
        }, potassiumScore),

        _buildVitalSignRow(l10n.sodium_mmol, naController, (value) {
          double na = double.tryParse(value) ?? 0;
          setState(() {
            if (na < 125) {
              sodiumScore = 5;
            }
            else if (na < 145) {
   sodiumScore = 0;
 }
            else {
              sodiumScore = 1;
            }
          });
        }, sodiumScore),

        _buildVitalSignRow(l10n.bicarbonate_mmol, hco3Controller, (value) {
          double hco3 = double.tryParse(value) ?? 0;
          setState(() {
            if (hco3 < 15) {
              bicarboScore = 6;
            }
            else if (hco3 < 20) {
   bicarboScore = 3;
 }
            else {
              bicarboScore = 0;
            }
          });
        }, bicarboScore),
      ],
    );
  }

  Widget _buildNeurologicalSection(AppLocalizations l10n) {
    return _buildSection(
      l10n.neurological_system,
      Colors.indigo.shade600,
      [
        Text('${l10n.glasgow_coma_scale}:', style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Column(
          children: [
            RadioListTile<int>(
              title: Text(l10n.gcs_less_than_6),
              value: 26,
              // ignore: deprecated_member_use
              groupValue: gcsScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => gcsScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: Text(l10n.gcs_6_to_8),
              value: 13,
              // ignore: deprecated_member_use
              groupValue: gcsScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => gcsScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: Text(l10n.gcs_9_to_10),
              value: 7,
              // ignore: deprecated_member_use
              groupValue: gcsScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => gcsScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: Text(l10n.gcs_11_to_13),
              value: 5,
              // ignore: deprecated_member_use
              groupValue: gcsScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => gcsScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: Text(l10n.gcs_14_to_15),
              value: 0,
              // ignore: deprecated_member_use
              groupValue: gcsScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => gcsScore = value!),
              dense: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAdmissionSection(AppLocalizations l10n) {
    return _buildSection(
      l10n.admission_chronic_disease,
      Colors.orange.shade600,
      [
        Text(l10n.admission_type_label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Column(
          children: [
            RadioListTile<int>(
              title: Text(l10n.scheduled_surgery),
              value: 0,
              // ignore: deprecated_member_use
              groupValue: admissionTypeScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => admissionTypeScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: Text(l10n.medical_admission),
              value: 6,
              // ignore: deprecated_member_use
              groupValue: admissionTypeScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => admissionTypeScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: Text(l10n.unscheduled_surgery),
              value: 8,
              // ignore: deprecated_member_use
              groupValue: admissionTypeScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => admissionTypeScore = value!),
              dense: true,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(l10n.chronic_diseases_label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Column(
          children: [
            RadioListTile<int>(
              title: Text(l10n.none),
              value: 0,
              // ignore: deprecated_member_use
              groupValue: chronicScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => chronicScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: Text(l10n.aids),
              value: 17,
              // ignore: deprecated_member_use
              groupValue: chronicScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => chronicScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: Text(l10n.metastatic_cancer),
              value: 9,
              // ignore: deprecated_member_use
              groupValue: chronicScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => chronicScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: Text(l10n.hematologic_malignancy),
              value: 10,
              // ignore: deprecated_member_use
              groupValue: chronicScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => chronicScore = value!),
              dense: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection(String title, Color color, List<Widget> children) {
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
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildLabValueWithUnit(
    String label,
    TextEditingController controller,
    String currentUnit,
    List<String> units,
    Function(String) onUnitChanged,
    Function(String) onValueChanged,
    int score,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: '$label ($currentUnit)',
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                  onChanged: onValueChanged,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  initialValue: currentUnit,
                  decoration: const InputDecoration(
                    labelText: 'Đơn vị',
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  ),
                  items: units.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit, style: const TextStyle(fontSize: 12)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      onUnitChanged(newValue);
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: score > 0 ? Colors.red.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Điểm: $score',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: score > 0 ? Colors.red : Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVitalSignRow(String label, TextEditingController controller, Function(String) onChanged, int score) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: onChanged,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: score > 0 ? Colors.red.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Điểm: $score',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: score > 0 ? Colors.red : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _resetAll() {
    setState(() {
      ageScore = heartRateScore = systolicBPScore = tempScore = 0;
      pao2fio2Score = urineScore = bilirubiScore = bunScore = 0;
      wbcScore = potassiumScore = sodiumScore = bicarboScore = 0;
      gcsScore = admissionTypeScore = chronicScore = 0;
      
      // Reset unit selections
      bilirubinUnit = 'mg/dL';
      bunUnit = 'mg/dL';
    });
    
    ageController.clear();
    hrController.clear();
    sbpController.clear();
    tempController.clear();
    pao2Controller.clear();
    urineController.clear();
    bilirubinController.clear();
    bunController.clear();
    wbcController.clear();
    kController.clear();
    naController.clear();
    hco3Controller.clear();
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
                'Tài liệu tham khảo',
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
            'Le Gall JR, et al. A new Simplified Acute Physiology Score (SAPS II) based on a European/North American multicenter study. JAMA. 1993;270(24):2957-63.\n\nMoreno RP, et al. SAPS 3--From evaluation of the patient to evaluation of the intensive care unit. Part 2: Development of a prognostic model for hospital mortality at ICU admission. Intensive Care Med. 2005;31(10):1345-55.',
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
