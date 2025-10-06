import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class Curb65Page extends StatefulWidget {
  const Curb65Page({super.key});

  @override
  State<Curb65Page> createState() => _Curb65PageState();
}

class _Curb65PageState extends State<Curb65Page> {
  int confusionScore = 0;
  int bunScore = 0;  
  int respiratoryRateScore = 0;
  int sbpScore = 0;
  int ageScore = 0;

  // Unit selection for BUN
  String bunUnit = 'mg/dL';

  final TextEditingController bunController = TextEditingController();
  final TextEditingController rrController = TextEditingController();
  final TextEditingController sbpController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  int get totalScore => confusionScore + bunScore + respiratoryRateScore + sbpScore + ageScore;

  Color get scoreColor {
    if (totalScore == 0) {
      return Colors.green;
    }
    if (totalScore <= 1) {
      return Colors.yellow.shade700;
    }
    if (totalScore == 2) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String get riskLevel {
    if (totalScore == 0) {
      return 'Nguy cơ rất thấp';
    }
    if (totalScore == 1) {
      return 'Nguy cơ thấp';
    }
    if (totalScore == 2) {
      return 'Nguy cơ trung bình';
    }
    if (totalScore == 3) {
      return 'Nguy cơ cao';
    }
    return 'Nguy cơ rất cao';
  }

  String get mortalityRisk {
    if (totalScore == 0) {
      return '< 1%';
    }
    if (totalScore == 1) {
      return '1-3%';
    }
    if (totalScore == 2) {
      return '9-15%';
    }
    if (totalScore == 3) {
      return '15-40%';
    }
    return '> 40%';
  }

  String get recommendation {
    if (totalScore <= 1) {
      return 'Có thể điều trị ngoại trú';
    }
    if (totalScore == 2) {
      return 'Cân nhắc điều trị nội trú hoặc quan sát';
    }
    return 'Cần điều trị nội trú, cân nhắc ICU nếu điểm ≥ 4';
  }

  // BUN unit conversion function
  double convertBUNToMgDL(double value, String fromUnit) {
    if (fromUnit == 'mmol/L') {
      return value * 2.8; // mmol/L to mg/dL
    }
    return value; // already in mg/dL
  }

  void calculateBUNScore(String value) {
    double bun = double.tryParse(value) ?? 0;
    if (bun > 0) {
      // Convert to mg/dL for calculation
      double bunMgDL = convertBUNToMgDL(bun, bunUnit);
      setState(() {
        bunScore = bunMgDL > 19 ? 1 : 0;
      });
    } else {
      setState(() {
        bunScore = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CURB-65 Score'),
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
                    'CURB-65 Score',
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
                    riskLevel,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tỷ lệ tử vong: $mortalityRisk',
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
                ],
              ),
            ),

            // Assessment sections
            _buildConfusionSection(),
            _buildBUNSectionWithUnit(),
            _buildVitalSignSection(
              'Nhịp thở (lần/phút)', 
              rrController, 
              Icons.air, 
              Colors.teal.shade600,
              (value) {
                int rr = int.tryParse(value) ?? 0;
                setState(() {
                  respiratoryRateScore = rr >= 30 ? 1 : 0;
                });
              },
              respiratoryRateScore,
            ),
            _buildVitalSignSection(
              'Huyết áp tâm thu (mmHg)', 
              sbpController, 
              Icons.favorite, 
              Colors.red.shade600,
              (value) {
                int sbp = int.tryParse(value) ?? 0;
                setState(() {
                  sbpScore = sbp < 90 ? 1 : 0;
                });
              },
              sbpScore,
            ),
            _buildVitalSignSection(
              'Tuổi', 
              ageController, 
              Icons.person, 
              Colors.orange.shade600,
              (value) {
                int age = int.tryParse(value) ?? 0;
                setState(() {
                  ageScore = age >= 65 ? 1 : 0;
                });
              },
              ageScore,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildConfusionSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.shade300),
        color: Colors.purple.withValues(alpha: 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology, color: Colors.purple.shade600, size: 24),
              const SizedBox(width: 8),
              Text(
                'Confusion (Rối loạn ý thức)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: confusionScore > 0 ? Colors.red.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Điểm: $confusionScore',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: confusionScore > 0 ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            children: [
              RadioListTile<int>(
                title: const Text('Không có rối loạn ý thức'),
                subtitle: const Text('Định hướng tốt về thời gian, địa điểm, người'),
                value: 0,
                // ignore: deprecated_member_use
                groupValue: confusionScore,
                // ignore: deprecated_member_use
                onChanged: (value) => setState(() => confusionScore = value!),
                dense: true,
              ),
              RadioListTile<int>(
                title: const Text('Có rối loạn ý thức'),
                subtitle: const Text('Mất định hướng về thời gian, địa điểm hoặc người'),
                value: 1,
                // ignore: deprecated_member_use
                groupValue: confusionScore,
                // ignore: deprecated_member_use
                onChanged: (value) => setState(() => confusionScore = value!),
                dense: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBUNSectionWithUnit() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade600.withValues(alpha: 0.3)),
        color: Colors.blue.shade600.withValues(alpha: 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.water_drop, color: Colors.blue.shade600, size: 24),
              const SizedBox(width: 8),
              Text(
                'BUN',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade600,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: bunScore > 0 ? Colors.red.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Điểm: $bunScore',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: bunScore > 0 ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: bunController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'BUN ($bunUnit)',
                    border: const OutlineInputBorder(),
                    suffixText: bunUnit,
                    isDense: true,
                  ),
                  onChanged: calculateBUNScore,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  initialValue: bunUnit,
                  decoration: const InputDecoration(
                    labelText: 'Đơn vị',
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'mg/dL', child: Text('mg/dL', style: TextStyle(fontSize: 12))),
                    DropdownMenuItem(value: 'mmol/L', child: Text('mmol/L', style: TextStyle(fontSize: 12))),
                  ],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        bunUnit = newValue;
                      });
                      calculateBUNScore(bunController.text);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Điểm số: 1 nếu BUN > 19 mg/dL (6.8 mmol/L)',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalSignSection(
    String title,
    TextEditingController controller,
    IconData icon,
    Color color,
    Function(String) onChanged,
    int score,
  ) {
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
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
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
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Nhập giá trị',
              border: const OutlineInputBorder(),
              suffixIcon: Icon(icon, color: color),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    bunController.dispose();
    rrController.dispose();
    sbpController.dispose();
    ageController.dispose();
    super.dispose();
  }
}
