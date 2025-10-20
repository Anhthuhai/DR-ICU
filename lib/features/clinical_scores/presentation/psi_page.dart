import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class PsiPage extends StatefulWidget {
  const PsiPage({super.key});

  @override
  State<PsiPage> createState() => _PsiPageState();
}

class _PsiPageState extends State<PsiPage> {
  int gender = 0; // 0 = female, 1 = male
  int age = 0;
  int nursingHome = 0;
  int neoplasticDisease = 0;
  int liverDisease = 0;
  int chf = 0; // congestive heart failure
  int cerebrovascularDisease = 0;
  int renalDisease = 0;
  int alteredMentalStatus = 0;
  int respiratoryRate = 0;
  int systolicBP = 0;
  int temperature = 0;
  int pulse = 0;
  int arterialPH = 0;
  int bun = 0;
  int sodium = 0;
  int glucose = 0;
  int hematocrit = 0;
  int partialPressureO2 = 0;
  int pleuralEffusion = 0;

  // Unit selections for BUN and Glucose
  String bunUnit = 'mg/dL';
  String glucoseUnit = 'mg/dL';

  final TextEditingController ageController = TextEditingController();
  final TextEditingController rrController = TextEditingController();
  final TextEditingController sbpController = TextEditingController();
  final TextEditingController tempController = TextEditingController();
  final TextEditingController pulseController = TextEditingController();
  final TextEditingController phController = TextEditingController();
  final TextEditingController bunController = TextEditingController();
  final TextEditingController naController = TextEditingController();
  final TextEditingController glucoseController = TextEditingController();
  final TextEditingController hctController = TextEditingController();
  final TextEditingController po2Controller = TextEditingController();

  int get totalScore {
    int score = 0;
    
    // Demographics
    if (gender == 1) {
      score += age; // Male: age points
    } else {
      score += age - 10; // Female: age - 10 points
    }
    
    if (nursingHome == 1) {
      score += 10;
    }
    
    // Comorbidities  
    if (neoplasticDisease == 1) {
      score += 30;
    }
    if (liverDisease == 1) {
      score += 20;
    }
    if (chf == 1) {
      score += 10;
    }
    if (cerebrovascularDisease == 1) {
      score += 10;
    }
    if (renalDisease == 1) {
      score += 10;
    }
    
    // Physical exam - all scores are already calculated correctly
    score += alteredMentalStatus + respiratoryRate + systolicBP + temperature + pulse;
    score += arterialPH + bun + sodium + glucose + hematocrit + partialPressureO2;
    score += pleuralEffusion;
    
    return score;
  }

  int get riskClass {
    if (totalScore < 51) {
      return 1;
    }
    if (totalScore < 71) {
      return 2;
    }
    if (totalScore < 91) {
      return 3;
    }
    if (totalScore < 131) {
      return 4;
    }
    return 5;
  }

  Color get scoreColor {
    switch (riskClass) {
      case 1: return Colors.green;
      case 2: return Colors.yellow.shade700;
      case 3: return Colors.orange;
      case 4: return Colors.red.shade600;
      case 5: return Colors.red.shade800;
      default: return Colors.grey;
    }
  }

  String getRiskDescription(BuildContext context) {
    switch (riskClass) {
      case 1: return AppLocalizations.of(context)!.psi_risk_very_low;
      case 2: return AppLocalizations.of(context)!.psi_risk_low;
      case 3: return AppLocalizations.of(context)!.psi_risk_moderate;
      case 4: return AppLocalizations.of(context)!.psi_risk_high;
      case 5: return AppLocalizations.of(context)!.psi_risk_very_high;
      default: return '';
    }
  }

  String get mortalityRate {
    switch (riskClass) {
      case 1: return '0.1-0.4%';
      case 2: return '0.6-0.7%';
      case 3: return '0.9-2.8%';
      case 4: return '8.2-9.3%';
      case 5: return '27.0-31.1%';
      default: return '';
    }
  }

  String getRecommendation(BuildContext context) {
    switch (riskClass) {
      case 1:
      case 2: return AppLocalizations.of(context)!.psi_outpatient_treatment;
      case 3: return AppLocalizations.of(context)!.psi_outpatient_or_short;
      case 4: return AppLocalizations.of(context)!.psi_inpatient_required;
      case 5: return AppLocalizations.of(context)!.psi_inpatient_consider_icu;
      default: return '';
    }
  }

  // Unit conversion functions
  double convertBUNToMgDL(double value, String fromUnit) {
    if (fromUnit == 'mmol/L') {
      return value * 2.8; // mmol/L to mg/dL
    }
    return value; // already in mg/dL
  }

  double convertGlucoseToMgDL(double value, String fromUnit) {
    if (fromUnit == 'mmol/L') {
      return value * 18.0; // mmol/L to mg/dL
    }
    return value; // already in mg/dL
  }

  void calculateBUNScore(String value) {
    double bunValue = double.tryParse(value) ?? 0;
    // Convert to mg/dL for calculation
    double bunMgDL = convertBUNToMgDL(bunValue, bunUnit);
    setState(() {
      bun = bunMgDL >= 30.0 ? 20 : 0;
    });
  }

  void calculateGlucoseScore(String value) {
    double glucoseValue = double.tryParse(value) ?? 0;
    if (glucoseValue > 0) {
      // Convert to mg/dL for calculation
      double glucoseMgDL = convertGlucoseToMgDL(glucoseValue, glucoseUnit);
      setState(() {
        glucose = glucoseMgDL >= 250 ? 10 : 0;
      });
    } else {
      setState(() {
        glucose = 0;
      });
    }
  }

  String getIcuRecommendation(BuildContext context) {
    switch (riskClass) {
      case 1:
      case 2: return AppLocalizations.of(context)!.psi_icu_no_need;
      case 3: return AppLocalizations.of(context)!.psi_icu_not_needed;
      case 4: return AppLocalizations.of(context)!.psi_icu_consider;
      case 5: return AppLocalizations.of(context)!.psi_icu_recommended;
      default: return '';
    }
  }

  Color get icuRecommendationColor {
    switch (riskClass) {
      case 1:
      case 2: return Colors.green;
      case 3: return Colors.blue;
      case 4: return Colors.orange;
      case 5: return Colors.red;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky AppBar
          SliverAppBar(
            title: Text(AppLocalizations.of(context)!.psi_title),
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            pinned: true,
            floating: false,
            elevation: 2,
          ),
          // Sticky Score Header
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyScoreHeaderDelegate(
              minHeight: 80,
              maxHeight: 90,
              child: _buildScoreCard(),
            ),
          ),
          // Main Content
          SliverList(
            delegate: SliverChildListDelegate([
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
                          ? 'LƯU Ý Y KHOA HÔ HẤP: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ chuyên khoa hô hấp trước khi đưa ra quyết định điều trị.'
                          : 'RESPIRATORY MEDICAL DISCLAIMER: Results are for reference only. Always consult with respiratory specialist before making treatment decisions.',
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
            // Demographics
            _buildSection(AppLocalizations.of(context)!.psi_basic_info, Colors.blue.shade600, [
              _buildGenderSection(),
              _buildAgeSection(),
              _buildNursingHomeSection(),
            ]),

            // Comorbidities
            _buildSection(AppLocalizations.of(context)!.psi_comorbidities, Colors.orange.shade600, [
              _buildComorbiditySection(AppLocalizations.of(context)!.psi_neoplastic_disease, neoplasticDisease, 30, (value) {
                setState(() => neoplasticDisease = value);
              }),
              _buildComorbiditySection(AppLocalizations.of(context)!.psi_liver_disease, liverDisease, 20, (value) {
                setState(() => liverDisease = value);
              }),
              _buildComorbiditySection(AppLocalizations.of(context)!.psi_congestive_heart_failure, chf, 10, (value) {
                setState(() => chf = value);
              }),
              _buildComorbiditySection(AppLocalizations.of(context)!.psi_cerebrovascular_disease, cerebrovascularDisease, 10, (value) {
                setState(() => cerebrovascularDisease = value);
              }),
              _buildComorbiditySection(AppLocalizations.of(context)!.psi_renal_disease, renalDisease, 10, (value) {
                setState(() => renalDisease = value);
              }),
            ]),

            // Physical Examination  
            _buildSection(AppLocalizations.of(context)!.psi_physical_exam, Colors.purple.shade600, [
              _buildComorbiditySection(AppLocalizations.of(context)!.psi_altered_mental_status, alteredMentalStatus, 20, (value) {
                setState(() => alteredMentalStatus = value > 0 ? 20 : 0);
              }),
              _buildVitalSignInput(
                AppLocalizations.of(context)!.psi_respiratory_rate, 
                AppLocalizations.of(context)!.psi_respiratory_rate_threshold,
                rrController, 
                'breaths/min',
                (value) {
                  double rr = double.tryParse(value) ?? 0;
                  setState(() {
                    respiratoryRate = rr >= 30 ? 20 : 0;
                  });
                },
                respiratoryRate,
              ),
              _buildVitalSignInput(
                AppLocalizations.of(context)!.psi_systolic_bp, 
                AppLocalizations.of(context)!.psi_systolic_bp_threshold,
                sbpController, 
                'mmHg',
                (value) {
                  double sbp = double.tryParse(value) ?? 0;
                  setState(() {
                    systolicBP = sbp < 90 ? 20 : 0;
                  });
                },
                systolicBP,
              ),
              _buildVitalSignInput(
                AppLocalizations.of(context)!.psi_temperature, 
                AppLocalizations.of(context)!.psi_temperature_threshold,
                tempController, 
                '°C',
                (value) {
                  double temp = double.tryParse(value) ?? 0;
                  setState(() {
                    temperature = (temp < 35 || temp >= 40) ? 15 : 0;
                  });
                },
                temperature,
              ),
              _buildVitalSignInput(
                AppLocalizations.of(context)!.psi_pulse, 
                AppLocalizations.of(context)!.psi_pulse_threshold,
                pulseController, 
                'bpm',
                (value) {
                  double hr = double.tryParse(value) ?? 0;
                  setState(() {
                    pulse = hr >= 125 ? 10 : 0;
                  });
                },
                pulse,
              ),
            ]),

            // Laboratory Values
            _buildSection(AppLocalizations.of(context)!.psi_laboratory, Colors.green.shade600, [
              _buildLabInput(AppLocalizations.of(context)!.psi_arterial_ph, phController, (value) {
                double ph = double.tryParse(value) ?? 0;
                setState(() {
                  arterialPH = ph < 7.35 ? 30 : 0;
                });
              }),
              _buildLabInputWithUnit(
                AppLocalizations.of(context)!.psi_bun,
                AppLocalizations.of(context)!.psi_bun_threshold,
                bunController,
                bunUnit,
                ['mg/dL', 'mmol/L'],
                (value) {
                  setState(() {
                    bunUnit = value;
                  });
                  calculateBUNScore(bunController.text);
                },
                calculateBUNScore,
                bun,
              ),
              _buildLabInput(AppLocalizations.of(context)!.psi_sodium, naController, (value) {
                double na = double.tryParse(value) ?? 0;
                setState(() {
                  sodium = na < 130 ? 20 : 0;
                });
              }),
              _buildLabInputWithUnit(
                AppLocalizations.of(context)!.psi_glucose,
                AppLocalizations.of(context)!.psi_glucose_threshold,
                glucoseController,
                glucoseUnit,
                ['mg/dL', 'mmol/L'],
                (value) {
                  setState(() {
                    glucoseUnit = value;
                  });
                  calculateGlucoseScore(glucoseController.text);
                },
                calculateGlucoseScore,
                glucose,
              ),
              _buildLabInput(AppLocalizations.of(context)!.psi_hematocrit, hctController, (value) {
                double hct = double.tryParse(value) ?? 0;
                setState(() {
                  hematocrit = hct < 30 ? 10 : 0;
                });
              }),
              _buildLabInput(AppLocalizations.of(context)!.psi_pao2, po2Controller, (value) {
                double po2 = double.tryParse(value) ?? 0;
                setState(() {
                  partialPressureO2 = po2 < 60 ? 10 : 0;
                });
              }),
              _buildComorbiditySection(AppLocalizations.of(context)!.psi_pleural_effusion, pleuralEffusion, 10, (value) {
                setState(() => pleuralEffusion = value);
              }),
            ]),

            // ICU Criteria Information Box
            Container(
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
                      Icon(Icons.local_hospital, color: Colors.red.shade600),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context)!.psi_icu_criteria_title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.red.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.psi_icu_criteria_content,
                    style: const TextStyle(height: 1.4),
                  ),
                ],
              ),
            ),

            // Medical Citation
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildCitationWidget(),
            ),

            const SizedBox(height: 20),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: scoreColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: scoreColor.withValues(alpha: 0.3)),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Score và Class
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  totalScore.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: scoreColor,
                    fontSize: 24,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.psi_class(riskClass),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: scoreColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            // Vertical divider
            Container(
              width: 1,
              color: scoreColor.withValues(alpha: 0.3),
            ),
            // Risk và ICU
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    getRiskDescription(context),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: scoreColor,
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_hospital,
                        color: icuRecommendationColor,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          getIcuRecommendation(context),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: icuRecommendationColor,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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

  Widget _buildGenderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.psi_gender, style: const TextStyle(fontWeight: FontWeight.w500)),
        Row(
          children: [
            Expanded(
              child: RadioListTile<int>(
                title: Text(AppLocalizations.of(context)!.psi_female),
                value: 0,
                // ignore: deprecated_member_use
                groupValue: gender,
                // ignore: deprecated_member_use
                onChanged: (value) => setState(() => gender = value!),
                dense: true,
              ),
            ),
            Expanded(
              child: RadioListTile<int>(
                title: Text(AppLocalizations.of(context)!.psi_male),
                value: 1,
                // ignore: deprecated_member_use
                groupValue: gender,
                // ignore: deprecated_member_use
                onChanged: (value) => setState(() => gender = value!),
                dense: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAgeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        TextField(
          controller: ageController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.psi_age_label,
            border: const OutlineInputBorder(),
          ),
          // ignore: deprecated_member_use
          onChanged: (value) {
            setState(() {
              age = int.tryParse(value) ?? 0;
            });
          },
        ),
      ],
    );
  }

  Widget _buildNursingHomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Checkbox(
              value: nursingHome == 1,
              // ignore: deprecated_member_use
              onChanged: (value) {
                setState(() => nursingHome = value! ? 1 : 0);
              },
            ),
            Expanded(child: Text(AppLocalizations.of(context)!.psi_nursing_home)),
          ],
        ),
      ],
    );
  }

  Widget _buildComorbiditySection(String title, int value, int points, Function(int) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: value > 0,
            // ignore: deprecated_member_use
            onChanged: (bool? checked) {
              onChanged(checked! ? 1 : 0);
            },
          ),
          Expanded(child: Text(title)),
        ],
      ),
    );
  }

  Widget _buildLabInput(String label, TextEditingController controller, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildLabInputWithUnit(
    String label,
    String criterion,
    TextEditingController controller,
    String currentUnit,
    List<String> units,
    Function(String) onUnitChanged,
    Function(String) onValueChanged,
    int score,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ($criterion)',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: currentUnit,
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                  onChanged: onValueChanged,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 4,
                child: DropdownButtonFormField<String>(
                  initialValue: currentUnit,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.unit,
                    border: const OutlineInputBorder(),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  ),
                  items: units.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(
                        unit, 
                        style: const TextStyle(fontSize: 11),
                        overflow: TextOverflow.ellipsis,
                      ),
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
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: score > 0 ? Colors.red.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.psi_score_label(score),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: score > 0 ? Colors.red : Colors.grey,
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVitalSignInput(String label, String threshold, TextEditingController controller, String unit, Function(String) onChanged, int score) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                hintText: threshold,
                border: const OutlineInputBorder(),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: onChanged,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
              ),
              child: Text(
                unit,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: score > 0 ? Colors.red.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                AppLocalizations.of(context)!.psi_score_label(score),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: score > 0 ? Colors.red : Colors.grey,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    ageController.dispose();
    rrController.dispose();
    sbpController.dispose();
    tempController.dispose();
    pulseController.dispose();
    phController.dispose();
    bunController.dispose();
    naController.dispose();
    glucoseController.dispose();
    hctController.dispose();
    po2Controller.dispose();
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
                AppLocalizations.of(context)!.psi_reference_title,
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
            AppLocalizations.of(context)!.psi_reference_text,
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
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(minHeight, maxHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final currentHeight = math.max(minHeight, maxHeight - shrinkOffset);
    return SizedBox(
      height: currentHeight,
      width: double.infinity,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(_StickyScoreHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
           minHeight != oldDelegate.minHeight ||
           child != oldDelegate.child;
  }
}
