import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  int get totalScore => respiratoryScore + cardiovascularScore + hepaticScore + 
                       coagulationScore + renalScore + neurologicalScore;

  String get interpretation {
    if (totalScore == 0) {
      return 'Không có suy cơ quan';
    }
    if (totalScore <= 6) {
      return 'Suy cơ quan nhẹ';
    }
    if (totalScore <= 9) {
      return 'Suy cơ quan trung bình';
    }
    if (totalScore <= 12) {
      return 'Suy cơ quan nặng';
    }
    return 'Suy đa cơ quan rất nặng';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOFA Score'),
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
                  'SOFA Score',
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
                const SizedBox(height: 4),
                Text(
                  '(R$respiratoryScore + CV$cardiovascularScore + H$hepaticScore + C$coagulationScore + R$renalScore + N$neurologicalScore)',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.mediumGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  interpretation,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: scoreColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (totalScore > 0) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Tỷ lệ tử vong: $mortalityRisk',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scoreColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Organ Systems
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRespiratorySection() {
    return _buildOrganSection(
      'Hệ hô hấp',
      Colors.blue.shade600,
      Icons.air,
      [
        TextField(
          controller: pao2Controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'PaO2/FiO2 (mmHg)',
            border: OutlineInputBorder(),
            helperText: 'Nếu không thở máy, nhập SpO2/FiO2 x 315',
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
    return _buildOrganSection(
      'Hệ tim mạch',
      Colors.red.shade600,
      Icons.favorite,
      [
        const Text('Huyết áp và vận mạch:', style: TextStyle(fontWeight: FontWeight.w600)),
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
              title: const Text('MAP < 70 mmHg'),
              value: 1,
              // ignore: deprecated_member_use
              groupValue: cardiovascularScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => cardiovascularScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: const Text('Dopamine ≤ 5 hoặc Dobutamine'),
              value: 2,
              // ignore: deprecated_member_use
              groupValue: cardiovascularScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => cardiovascularScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: const Text('Dopamine 5-15 hoặc Adrenaline ≤ 0.1'),
              value: 3,
              // ignore: deprecated_member_use
              groupValue: cardiovascularScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => cardiovascularScore = value!),
              dense: true,
            ),
            RadioListTile<int>(
              title: const Text('Dopamine > 15 hoặc Adrenaline > 0.1'),
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
    return _buildOrganSection(
      'Hệ gan',
      Colors.amber.shade700,
      Icons.healing,
      [
        TextField(
          controller: bilirubinController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Bilirubin (mg/dL)',
            border: OutlineInputBorder(),
            helperText: 'Nhập giá trị bilirubin toàn phần',
          ),
          // ignore: deprecated_member_use
          onChanged: (value) {
            double bilirubin = double.tryParse(value) ?? 0;
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
        _buildScoreIndicator(hepaticScore),
      ],
    );
  }

  Widget _buildCoagulationSection() {
    return _buildOrganSection(
      'Hệ đông máu',
      Colors.purple.shade600,
      Icons.bloodtype,
      [
        TextField(
          controller: plateletsController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            labelText: 'Tiểu cầu (x10³/μL)',
            border: OutlineInputBorder(),
            helperText: 'Nhập số lượng tiểu cầu',
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
    return _buildOrganSection(
      'Hệ thận',
      Colors.teal.shade600,
      Icons.water_drop,
      [
        TextField(
          controller: creatinineController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Creatinine (mg/dL)',
            border: OutlineInputBorder(),
          ),
          // ignore: deprecated_member_use
          onChanged: (value) {
            double creatinine = double.tryParse(value) ?? 0;
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
        TextField(
          controller: urineController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            labelText: 'Nước tiểu (mL/ngày)',
            border: OutlineInputBorder(),
            helperText: 'Tổng lượng nước tiểu 24h',
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
    return _buildOrganSection(
      'Hệ thần kinh',
      Colors.indigo.shade600,
      Icons.psychology,
      [
        const Text('Glasgow Coma Scale:', style: TextStyle(fontWeight: FontWeight.w600)),
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
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          const Text('Điểm: ', style: TextStyle(fontWeight: FontWeight.w500)),
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
    });
    
    pao2Controller.clear();
    bilirubinController.clear();
    plateletsController.clear();
    creatinineController.clear();
    urineController.clear();
  }
}
