import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

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

  String get severity {
    switch (childPughClass) {
      case 'A': return 'Bệnh gan nhẹ';
      case 'B': return 'Bệnh gan trung bình';
      case 'C': return 'Bệnh gan nặng';
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

  String get operativeRisk {
    switch (childPughClass) {
      case 'A': return 'Nguy cơ phẫu thuật thấp (10%)';
      case 'B': return 'Nguy cơ phẫu thuật trung bình (30%)';
      case 'C': return 'Nguy cơ phẫu thuật cao (82%)';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Child-Pugh Score'),
        backgroundColor: Colors.amber.shade700,
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
                    'Child-Pugh Classification',
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
                    severity,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSurvivalInfo(),
                ],
              ),
            ),

            // Laboratory values
            _buildSection(
              'Xét nghiệm',
              Colors.blue.shade600,
              [
                _buildLabInputWithUnit(
                  'Bilirubin',
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
                  'Albumin (g/dL)',
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
                  'INR/Prothrombin Time',
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
              'Triệu chứng lâm sàng',
              Colors.purple.shade600,
              [
                _buildClinicalFinding(
                  'Cổ trướng',
                  Icons.airline_seat_recline_extra,
                  ascitesScore,
                  [
                    {'label': 'Không', 'value': 1},
                    {'label': 'Ít - vừa (điều trị được)', 'value': 2},
                    {'label': 'Nhiều (điều trị kháng thuốc)', 'value': 3},
                  ],
                  (value) => setState(() => ascitesScore = value),
                ),
                const SizedBox(height: 16),
                _buildClinicalFinding(
                  'Bệnh não gan',
                  Icons.psychology,
                  encephalopathyScore,
                  [
                    {'label': 'Không', 'value': 1},
                    {'label': 'Độ I-II (nhẹ-vừa)', 'value': 2},
                    {'label': 'Độ III-IV (nặng)', 'value': 3},
                  ],
                  (value) => setState(() => encephalopathyScore = value),
                ),
              ],
            ),

            // Reference information
            _buildInfoBox(),

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

  Widget _buildSurvivalInfo() {
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
                    'Sống còn 1 năm',
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
                    'Sống còn 2 năm',
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
            operativeRisk,
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
                  'Điểm: $score',
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
                  decoration: const InputDecoration(
                    labelText: 'Nhập giá trị',
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
                  'Điểm: $score',
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
            decoration: const InputDecoration(
              labelText: 'Nhập giá trị',
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

  Widget _buildInfoBox() {
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
                'Thông tin lâm sàng',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.amber.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '• Child-Pugh được sử dụng để đánh giá mức độ nặng của xơ gan\n'
            '• Class A (5-6 điểm): Dự hậu tốt, có thể phẫu thuật\n'
            '• Class B (7-9 điểm): Dự hậu trung bình, cân nhắc can thiệp\n'
            '• Class C (10-15 điểm): Dự hậu xấu, ưu tiên ghép gan\n'
            '• Thường kết hợp với MELD score trong đánh giá bệnh gan',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }
}
