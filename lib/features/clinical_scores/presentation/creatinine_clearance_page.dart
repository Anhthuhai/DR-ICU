import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class CreatinineClearancePage extends StatefulWidget {
  const CreatinineClearancePage({super.key});

  @override
  State<CreatinineClearancePage> createState() => _CreatinineClearancePageState();
}

class _CreatinineClearancePageState extends State<CreatinineClearancePage> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _creatinineController = TextEditingController();
  bool _isFemale = false;

  // Unit variable
  String _creatinineUnit = 'mg/dL';

  double _clearance = 0.0;

  @override
  void initState() {
    super.initState();
    _ageController.addListener(_calculateClearance);
    _weightController.addListener(_calculateClearance);
    _creatinineController.addListener(_calculateClearance);
  }

  // Unit conversion function
  double convertCreatinineToMgDL(double value, String unit) {
    if (unit == 'umol/L') {
      return value / 88.42; // Convert umol/L to mg/dL
    }
    return value; // Already in mg/dL
  }

  void _calculateClearance() {
    final age = double.tryParse(_ageController.text) ?? 0;
    final weight = double.tryParse(_weightController.text) ?? 0;
    final creatinineInput = double.tryParse(_creatinineController.text) ?? 0;
    final creatinine = convertCreatinineToMgDL(creatinineInput, _creatinineUnit);

    if (age > 0 && weight > 0 && creatinine > 0) {
      // Cockcroft-Gault formula
      double clearance = ((140 - age) * weight) / (72 * creatinine);
      if (_isFemale) {
        clearance *= 0.85; // Correction factor for female
      }
      setState(() {
        _clearance = clearance;
      });
    } else {
      setState(() {
        _clearance = 0.0;
      });
    }
  }

  Color get clearanceColor {
    if (_clearance >= 90) {
      return Colors.green;
    }
    if (_clearance >= 60) {
      return Colors.blue;
    }
    if (_clearance >= 45) {
      return Colors.yellow.shade700;
    }
    if (_clearance >= 30) {
      return Colors.orange;
    }
    if (_clearance >= 15) {
      return Colors.red;
    }
    if (_clearance > 0) {
      return Colors.red.shade800;
    }
    return Colors.grey;
  }

  String get kidneyFunction {
    if (_clearance >= 90) {
      return 'Bình thường/Cao';
    }
    if (_clearance >= 60) {
      return 'Giảm nhẹ';
    }
    if (_clearance >= 45) {
      return 'Giảm nhẹ-vừa';
    }
    if (_clearance >= 30) {
      return 'Giảm vừa-nặng';
    }
    if (_clearance >= 15) {
      return 'Giảm nặng';
    }
    if (_clearance > 0) {
      return 'Suy thận giai đoạn cuối';
    }
    return '';
  }

  String get stage {
    if (_clearance >= 90) {
      return 'CKD Stage 1 (hoặc bình thường)';
    }
    if (_clearance >= 60) {
      return 'CKD Stage 2';
    }
    if (_clearance >= 45) {
      return 'CKD Stage 3a';
    }
    if (_clearance >= 30) {
      return 'CKD Stage 3b';
    }
    if (_clearance >= 15) {
      return 'CKD Stage 4';
    }
    if (_clearance > 0) {
      return 'CKD Stage 5';
    }
    return '';
  }

  String get drugDosing {
    if (_clearance >= 60) {
      return 'Liều bình thường';
    }
    if (_clearance >= 30) {
      return 'Giảm liều 25-50%';
    }
    if (_clearance >= 15) {
      return 'Giảm liều 50-75%';
    }
    if (_clearance > 0) {
      return 'Chống chỉ định hoặc cần chạy thận';
    }
    return '';
  }

  String get recommendations {
    if (_clearance >= 90) {
      return 'Theo dõi bình thường, kiểm soát yếu tố nguy cơ';
    }
    if (_clearance >= 60) {
      return 'Tầm soát biến chứng CKD, kiểm soát yếu tố nguy cơ';
    }
    if (_clearance >= 45) {
      return 'Đánh giá và điều trị biến chứng CKD';
    }
    if (_clearance >= 30) {
      return 'Chuẩn bị cho liệu pháp thay thế thận';
    }
    if (_clearance >= 15) {
      return 'Liệu pháp thay thế thận nếu có triệu chứng';
    }
    if (_clearance > 0) {
      return 'Chạy thận hoặc ghép thận';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creatinine Clearance'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Result Display
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: clearanceColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: clearanceColor.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    'Creatinine Clearance',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: clearanceColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_clearance > 0) ...[
                    Text(
                      '${_clearance.toStringAsFixed(1)} ml/phút',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: clearanceColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      kidneyFunction,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkGrey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stage,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: clearanceColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildResultDetails(),
                  ] else ...[
                    Icon(
                      Icons.calculate,
                      size: 48,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Nhập thông số để tính toán',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Input Parameters
            _buildInputSection(),

            // Reference Values
            _buildReferenceSection(),

            // Clinical Information
            _buildClinicalInfo(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildResultDetails() {
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
                    'Điều chỉnh liều thuốc',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    drugDosing,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: clearanceColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: clearanceColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: clearanceColor.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Khuyến nghị lâm sàng:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: clearanceColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  recommendations,
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

  Widget _buildInputSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade300),
        color: Colors.indigo.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông số đầu vào (Cockcroft-Gault)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          // Age
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Tuổi',
              suffixText: 'năm',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          
          // Weight
          TextField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Cân nặng',
              suffixText: 'kg',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          
          // Creatinine with unit conversion
          _buildLabInputWithUnit(
            'Creatinine huyết thanh',
            'Giá trị bình thường: Nam 0.7-1.3 mg/dL (62-115 umol/L), Nữ 0.6-1.1 mg/dL (53-97 umol/L)',
            _creatinineController,
            _creatinineUnit,
            ['mg/dL', 'umol/L'],
            (value) {
              setState(() {
                _creatinineUnit = value;
              });
              _calculateClearance();
            },
            (value) => _calculateClearance(),
          ),
          const SizedBox(height: 12),
          
          // Gender
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Giới tính',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<bool>(
                        title: const Text('Nam'),
                        value: false,
                        // ignore: deprecated_member_use
                        groupValue: _isFemale,
                        // ignore: deprecated_member_use
                        onChanged: (value) {
                          setState(() {
                            _isFemale = value!;
                          });
                          _calculateClearance();
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<bool>(
                        title: const Text('Nữ'),
                        value: true,
                        // ignore: deprecated_member_use
                        groupValue: _isFemale,
                        // ignore: deprecated_member_use
                        onChanged: (value) {
                          setState(() {
                            _isFemale = value!;
                          });
                          _calculateClearance();
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
              flex: 5,
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
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<String>(
                initialValue: currentUnit,
                onChanged: (value) => onUnitChanged(value!),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
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

  Widget _buildReferenceSection() {
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
            'Giá trị tham chiếu',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildReferenceItem('≥ 90 ml/phút', 'Bình thường/Cao', Colors.green),
          _buildReferenceItem('60-89 ml/phút', 'Giảm nhẹ (CKD Stage 2)', Colors.blue),
          _buildReferenceItem('45-59 ml/phút', 'Giảm nhẹ-vừa (CKD 3a)', Colors.yellow.shade700),
          _buildReferenceItem('30-44 ml/phút', 'Giảm vừa-nặng (CKD 3b)', Colors.orange),
          _buildReferenceItem('15-29 ml/phút', 'Giảm nặng (CKD Stage 4)', Colors.red),
          _buildReferenceItem('< 15 ml/phút', 'Suy thận cuối (CKD Stage 5)', Colors.red.shade800),
        ],
      ),
    );
  }

  Widget _buildReferenceItem(String range, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              range,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              description,
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClinicalInfo() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.blue.shade600),
              const SizedBox(width: 8),
              Text(
                'Thông tin lâm sàng',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Công thức Cockcroft-Gault:\n'
            'CrCl = [(140 - tuổi) × cân nặng] / (72 × creatinine)\n'
            'Nữ giới: nhân thêm 0.85\n\n'
            'Lưu ý quan trọng:\n'
            '• Độ chính xác giảm khi GFR > 60 ml/phút\n'
            '• Không chính xác ở người béo phì, người già, bệnh cấp tính\n'
            '• Cần điều chỉnh liều thuốc dựa vào độ thanh thải creatinine\n'
            '• Theo dõi chức năng thận định kỳ ở bệnh nhân CKD\n'
            '• Xem xét sử dụng CKD-EPI equation cho độ chính xác cao hơn',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _creatinineController.dispose();
    super.dispose();
  }
}
