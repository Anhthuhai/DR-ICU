import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

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
    
    // Physical exam
    if (alteredMentalStatus == 1) {
      score += 20;
    }
    
    // Add vital signs and lab scores
    score += respiratoryRate + systolicBP + temperature + pulse;
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

  String get riskDescription {
    switch (riskClass) {
      case 1: return 'Nguy cơ rất thấp';
      case 2: return 'Nguy cơ thấp';
      case 3: return 'Nguy cơ trung bình';
      case 4: return 'Nguy cơ cao';
      case 5: return 'Nguy cơ rất cao';
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

  String get recommendation {
    switch (riskClass) {
      case 1:
      case 2: return 'Có thể điều trị ngoại trú';
      case 3: return 'Cân nhắc điều trị ngoại trú hoặc nội trú ngắn ngày';
      case 4: return 'Cần điều trị nội trú';
      case 5: return 'Cần điều trị nội trú, cân nhắc ICU';
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

  String get icuRecommendation {
    switch (riskClass) {
      case 1:
      case 2: return 'Không cần ICU';
      case 3: return 'Không cần ICU, theo dõi tại khoa nội';
      case 4: return 'Cân nhắc ICU nếu có yếu tố nguy cơ cao';
      case 5: return 'Khuyến cáo nhập ICU';
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
      appBar: AppBar(
        title: const Text('PSI Score'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
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
                    'Pneumonia Severity Index',
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
                        'Class $riskClass',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: scoreColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    riskDescription,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tỷ lệ tử vong: $mortalityRate',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    recommendation,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.darkGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  // ICU Recommendation Box
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: icuRecommendationColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: icuRecommendationColor.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_hospital,
                          color: icuRecommendationColor,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'ICU: $icuRecommendation',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: icuRecommendationColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Demographics
            _buildSection('Thông tin cơ bản', Colors.blue.shade600, [
              _buildGenderSection(),
              _buildAgeSection(),
              _buildNursingHomeSection(),
            ]),

            // Comorbidities
            _buildSection('Bệnh đi kèm', Colors.orange.shade600, [
              _buildComorbiditySection('Bệnh ác tính', neoplasticDisease, 30, (value) {
                setState(() => neoplasticDisease = value);
              }),
              _buildComorbiditySection('Bệnh gan', liverDisease, 20, (value) {
                setState(() => liverDisease = value);
              }),
              _buildComorbiditySection('Suy tim sung huyết', chf, 10, (value) {
                setState(() => chf = value);
              }),
              _buildComorbiditySection('Bệnh mạch máu não', cerebrovascularDisease, 10, (value) {
                setState(() => cerebrovascularDisease = value);
              }),
              _buildComorbiditySection('Bệnh thận', renalDisease, 10, (value) {
                setState(() => renalDisease = value);
              }),
            ]),

            // Physical Examination
            _buildSection('Khám lâm sàng', Colors.purple.shade600, [
              _buildComorbiditySection('Rối loạn ý thức', alteredMentalStatus, 20, (value) {
                setState(() => alteredMentalStatus = value);
              }),
              _buildVitalSignInput('Nhịp thở (≥30/phút)', rrController, (value) {
                int rr = int.tryParse(value) ?? 0;
                setState(() {
                  respiratoryRate = rr >= 30 ? 20 : 0;
                });
              }),
              _buildVitalSignInput('Huyết áp tâm thu (<90 mmHg)', sbpController, (value) {
                int sbp = int.tryParse(value) ?? 0;
                setState(() {
                  systolicBP = sbp < 90 ? 20 : 0;
                });
              }),
              _buildVitalSignInput('Nhiệt độ (<35°C hoặc ≥40°C)', tempController, (value) {
                double temp = double.tryParse(value) ?? 0;
                setState(() {
                  temperature = (temp < 35 || temp >= 40) ? 15 : 0;
                });
              }),
              _buildVitalSignInput('Mạch (≥125/phút)', pulseController, (value) {
                int hr = int.tryParse(value) ?? 0;
                setState(() {
                  pulse = hr >= 125 ? 10 : 0;
                });
              }),
            ]),

            // Laboratory Values
            _buildSection('Xét nghiệm', Colors.teal.shade600, [
              _buildLabInput('pH động mạch (<7.35)', phController, (value) {
                double ph = double.tryParse(value) ?? 0;
                setState(() {
                  arterialPH = ph < 7.35 ? 30 : 0;
                });
              }),
              _buildLabInputWithUnit(
                'BUN',
                '≥30 mg/dL (10.7 mmol/L)',
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
              _buildLabInput('Natri (<130 mmol/L)', naController, (value) {
                double na = double.tryParse(value) ?? 0;
                setState(() {
                  sodium = na < 130 ? 20 : 0;
                });
              }),
              _buildLabInputWithUnit(
                'Glucose',
                '≥250 mg/dL (13.9 mmol/L)',
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
              _buildLabInput('Hematocrit (<30%)', hctController, (value) {
                double hct = double.tryParse(value) ?? 0;
                setState(() {
                  hematocrit = hct < 30 ? 10 : 0;
                });
              }),
              _buildLabInput('PaO₂ (<60 mmHg)', po2Controller, (value) {
                double po2 = double.tryParse(value) ?? 0;
                setState(() {
                  partialPressureO2 = po2 < 60 ? 10 : 0;
                });
              }),
              _buildComorbiditySection('Tràn dịch màng phổi', pleuralEffusion, 10, (value) {
                setState(() => pleuralEffusion = value * 10);
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
                        'Tiêu chí cân nhắc ICU',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.red.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• PSI Class IV-V: Cần theo dõi chặt chẽ, cân nhắc ICU\n'
                    '• Các yếu tố nguy cơ cao thêm:\n'
                    '  - Suy hô hấp (PaO₂ < 60 mmHg)\n'
                    '  - Rối loạn ý thức\n'
                    '  - Tụt huyết áp (SBP < 90 mmHg)\n'
                    '  - Nhiều bệnh đi kèm nặng\n'
                    '  - Tuổi cao + triệu chứng nặng\n'
                    '• Class V (>130 điểm): Khuyến cáo ICU do tỷ lệ tử vong cao (>27%)',
                    style: TextStyle(height: 1.4),
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

  Widget _buildGenderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Giới tính:', style: TextStyle(fontWeight: FontWeight.w500)),
        Row(
          children: [
            Expanded(
              child: RadioListTile<int>(
                title: const Text('Nữ'),
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
                title: const Text('Nam'),
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
          decoration: const InputDecoration(
            labelText: 'Tuổi',
            border: OutlineInputBorder(),
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
            const Expanded(child: Text('Sống tại viện dưỡng lão (+10 điểm)')),
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
          Expanded(child: Text('$title (+$points điểm)')),
        ],
      ),
    );
  }

  Widget _buildVitalSignInput(String label, TextEditingController controller, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        // ignore: deprecated_member_use
        onChanged: null,
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
}
