import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class RansonPage extends StatefulWidget {
  const RansonPage({super.key});

  @override
  State<RansonPage> createState() => _RansonPageState();
}

class _RansonPageState extends State<RansonPage> {
  // At admission criteria
  int age = 0;
  int wbc = 0;
  int glucose = 0;
  int ldh = 0;
  int ast = 0;

  // At 48 hours criteria
  int hematocritDrop = 0;
  int bunRise = 0;
  int calciumDrop = 0;
  int po2Drop = 0;
  int baseDeficit = 0;
  int fluidSequestration = 0;

  final TextEditingController ageController = TextEditingController();
  final TextEditingController wbcController = TextEditingController();
  final TextEditingController glucoseController = TextEditingController();
  final TextEditingController ldhController = TextEditingController();
  final TextEditingController astController = TextEditingController();
  final TextEditingController hctController = TextEditingController();
  final TextEditingController bunController = TextEditingController();
  final TextEditingController calciumController = TextEditingController();
  final TextEditingController po2Controller = TextEditingController();
  final TextEditingController baseDeficitController = TextEditingController();
  final TextEditingController fluidController = TextEditingController();

  // Unit variables
  String _glucoseUnit = 'mg/dL';
  String _bunUnit = 'mg/dL';

  int get totalScore => age + wbc + glucose + ldh + ast + hematocritDrop + 
                       bunRise + calciumDrop + po2Drop + baseDeficit + fluidSequestration;

  Color get scoreColor {
    if (totalScore <= 2) {
      return Colors.green;
    }
    if (totalScore <= 5) {
      return Colors.yellow.shade700;
    }
    return Colors.red;
  }

  String get severity {
    if (totalScore <= 2) {
      return 'Viêm tụy nhẹ';
    }
    if (totalScore <= 5) {
      return 'Viêm tụy vừa';
    }
    return 'Viêm tụy nặng';
  }

  String get mortalityRate {
    if (totalScore <= 2) {
      return '< 1%';
    }
    if (totalScore == 3) {
      return '15%';
    }
    if (totalScore == 4) {
      return '15%';
    }
    if (totalScore == 5) {
      return '40%';
    }
    if (totalScore == 6) {
      return '40%';
    }
    return '> 50%';
  }

  String get management {
    if (totalScore <= 2) {
      return 'Theo dõi nội khoa, điều trị hỗ trợ';
    }
    if (totalScore <= 5) {
      return 'Cần theo dõi chặt chẽ, cân nhắc ICU';
    }
    return 'Chỉ định ICU, cân nhắc can thiệp tích cực';
  }

  // Unit conversion functions
  double convertGlucoseToMgDL(double value, String unit) {
    if (unit == 'mmol/L') {
      return value * 18.0; // Convert mmol/L to mg/dL
    }
    return value; // Already in mg/dL
  }

  double convertBUNToMgDL(double value, String unit) {
    if (unit == 'mmol/L') {
      return value * 2.8; // Convert mmol/L to mg/dL
    }
    return value; // Already in mg/dL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranson Criteria'),
        backgroundColor: Colors.brown.shade700,
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
                    'Ranson Criteria Score',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: scoreColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    totalScore.toString(),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: scoreColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    severity,
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
                    management,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.darkGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // At admission criteria
            _buildSection(
              'Tiêu chí khi nhập viện',
              Colors.blue.shade600,
              [
                _buildNumericInput(
                  'Tuổi (> 55 tuổi)', 
                  ageController,
                  Icons.person,
                  (value) {
                    int ageValue = int.tryParse(value) ?? 0;
                    setState(() {
                      age = ageValue > 55 ? 1 : 0;
                    });
                  },
                  age,
                ),
                _buildNumericInput(
                  'Bạch cầu (> 16,000/μL)', 
                  wbcController,
                  Icons.water_drop,
                  (value) {
                    int wbcValue = int.tryParse(value) ?? 0;
                    setState(() {
                      wbc = wbcValue > 16000 ? 1 : 0;
                    });
                  },
                  wbc,
                ),
                _buildLabInputWithUnit(
                  'Glucose', 
                  glucoseController,
                  Icons.bloodtype,
                  (value) {
                    double glucoseInput = double.tryParse(value) ?? 0;
                    double glucoseValue = convertGlucoseToMgDL(glucoseInput, _glucoseUnit);
                    setState(() {
                      glucose = glucoseValue > 200 ? 1 : 0;
                    });
                  },
                  glucose,
                  _glucoseUnit,
                  ['mg/dL', 'mmol/L'],
                  (value) {
                    setState(() {
                      _glucoseUnit = value;
                    });
                    // Recalculate score with new unit
                    if (glucoseController.text.isNotEmpty) {
                      double glucoseInput = double.tryParse(glucoseController.text) ?? 0;
                      double glucoseValue = convertGlucoseToMgDL(glucoseInput, _glucoseUnit);
                      setState(() {
                        glucose = glucoseValue > 200 ? 1 : 0;
                      });
                    }
                  },
                ),
                _buildNumericInput(
                  'LDH (> 350 IU/L)', 
                  ldhController,
                  Icons.science,
                  (value) {
                    double ldhValue = double.tryParse(value) ?? 0;
                    setState(() {
                      ldh = ldhValue > 350 ? 1 : 0;
                    });
                  },
                  ldh,
                ),
                _buildNumericInput(
                  'AST (> 250 IU/L)', 
                  astController,
                  Icons.local_hospital,
                  (value) {
                    double astValue = double.tryParse(value) ?? 0;
                    setState(() {
                      ast = astValue > 250 ? 1 : 0;
                    });
                  },
                  ast,
                ),
              ],
            ),

            // At 48 hours criteria  
            _buildSection(
              'Tiêu chí tại 48 giờ',
              Colors.red.shade600,
              [
                _buildNumericInput(
                  'Giảm Hematocrit (> 10%)', 
                  hctController,
                  Icons.opacity,
                  (value) {
                    double hctValue = double.tryParse(value) ?? 0;
                    setState(() {
                      hematocritDrop = hctValue > 10 ? 1 : 0;
                    });
                  },
                  hematocritDrop,
                ),
                _buildLabInputWithUnit(
                  'Tăng BUN', 
                  bunController,
                  Icons.medical_services,
                  (value) {
                    double bunInput = double.tryParse(value) ?? 0;
                    double bunValue = convertBUNToMgDL(bunInput, _bunUnit);
                    setState(() {
                      bunRise = bunValue > 5 ? 1 : 0;
                    });
                  },
                  bunRise,
                  _bunUnit,
                  ['mg/dL', 'mmol/L'],
                  (value) {
                    setState(() {
                      _bunUnit = value;
                    });
                    // Recalculate score with new unit
                    if (bunController.text.isNotEmpty) {
                      double bunInput = double.tryParse(bunController.text) ?? 0;
                      double bunValue = convertBUNToMgDL(bunInput, _bunUnit);
                      setState(() {
                        bunRise = bunValue > 5 ? 1 : 0;
                      });
                    }
                  },
                ),
                _buildNumericInput(
                  'Ca²⁺ huyết thanh (< 8 mg/dL)', 
                  calciumController,
                  Icons.calculate,
                  (value) {
                    double caValue = double.tryParse(value) ?? 0;
                    setState(() {
                      calciumDrop = caValue < 8 ? 1 : 0;
                    });
                  },
                  calciumDrop,
                ),
                _buildNumericInput(
                  'PaO₂ (< 60 mmHg)', 
                  po2Controller,
                  Icons.air,
                  (value) {
                    double po2Value = double.tryParse(value) ?? 0;
                    setState(() {
                      po2Drop = po2Value < 60 ? 1 : 0;
                    });
                  },
                  po2Drop,
                ),
                _buildNumericInput(
                  'Base deficit (> 4 mEq/L)', 
                  baseDeficitController,
                  Icons.add_chart,
                  (value) {
                    double deficitValue = double.tryParse(value) ?? 0;
                    setState(() {
                      baseDeficit = deficitValue > 4 ? 1 : 0;
                    });
                  },
                  baseDeficit,
                ),
                _buildNumericInput(
                  'Dịch tích tụ (> 6L)', 
                  fluidController,
                  Icons.water,
                  (value) {
                    double fluidValue = double.tryParse(value) ?? 0;
                    setState(() {
                      fluidSequestration = fluidValue > 6 ? 1 : 0;
                    });
                  },
                  fluidSequestration,
                ),
              ],
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

  Widget _buildLabInputWithUnit(
    String title,
    TextEditingController controller,
    IconData icon,
    Function(String) onChanged,
    int score,
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
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Nhập giá trị',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
            onChanged: onChanged,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text(
                'Đơn vị: ',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              DropdownButton<String>(
                value: currentUnit,
                onChanged: (value) => onUnitChanged(value!),
                items: units.map((unit) {
                  return DropdownMenuItem(
                    value: unit,
                    child: Text(
                      unit, 
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumericInput(
    String title,
    TextEditingController controller,
    IconData icon,
    Function(String) onChanged,
    int score,
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
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Nhập giá trị',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            // ignore: deprecated_member_use
            onChanged: null,
          ),
        ],
      ),
    );
  }
}
