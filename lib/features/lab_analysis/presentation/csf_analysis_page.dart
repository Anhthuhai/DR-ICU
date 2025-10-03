import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/colors.dart';
import '../domain/entities/csf_result.dart';

class CsfAnalysisPage extends StatefulWidget {
  const CsfAnalysisPage({super.key});

  @override
  State<CsfAnalysisPage> createState() => _CsfAnalysisPageState();
}

class _CsfAnalysisPageState extends State<CsfAnalysisPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for CSF values
  final _proteinController = TextEditingController();
  final _glucoseController = TextEditingController();
  final _cellCountController = TextEditingController();
  final _neutrophilsController = TextEditingController();
  final _lymphocytesController = TextEditingController();
  final _rbcController = TextEditingController();
  final _pressureController = TextEditingController();
  
  // Controllers for serum values
  final _serumGlucoseController = TextEditingController();
  
  // Controller for additional biomarkers
  final _lactateController = TextEditingController();
  
  final _notesController = TextEditingController();
  
  CsfAppearance _selectedAppearance = CsfAppearance.clear;
  CsfResult? _currentResult;
  bool _showResults = false;

  @override
  void dispose() {
    _proteinController.dispose();
    _glucoseController.dispose();
    _cellCountController.dispose();
    _neutrophilsController.dispose();
    _lymphocytesController.dispose();
    _rbcController.dispose();
    _pressureController.dispose();
    _serumGlucoseController.dispose();
    _lactateController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _analyzeCsf() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        // Use default serum glucose of 90 mg/dL if not provided
        final serumGlucose = _serumGlucoseController.text.isNotEmpty 
            ? double.parse(_serumGlucoseController.text)
            : 90.0; // Default normal serum glucose
        
        // Use default pressure of 150 mmH2O if not provided
        final pressure = _pressureController.text.isNotEmpty
            ? double.parse(_pressureController.text)
            : 150.0; // Default normal CSF pressure
            
        _currentResult = CsfResult(
          protein: double.parse(_proteinController.text),
          glucose: double.parse(_glucoseController.text),
          cellCount: int.parse(_cellCountController.text),
          neutrophils: _neutrophilsController.text.isNotEmpty 
              ? int.parse(_neutrophilsController.text) : 0,
          lymphocytes: _lymphocytesController.text.isNotEmpty 
              ? int.parse(_lymphocytesController.text) : 0,
          redBloodCells: _rbcController.text.isNotEmpty 
              ? int.parse(_rbcController.text) : 0,
          pressure: pressure,
          appearance: _selectedAppearance,
          timestamp: DateTime.now(),
          serumGlucose: serumGlucose,
          lactate: _lactateController.text.isNotEmpty 
              ? double.parse(_lactateController.text) : null,
          notes: _notesController.text.isNotEmpty ? _notesController.text : null,
        );
        _showResults = true;
      });
    }
  }

  void _clearForm() {
    setState(() {
      _proteinController.clear();
      _glucoseController.clear();
      _cellCountController.clear();
      _neutrophilsController.clear();
      _lymphocytesController.clear();
      _rbcController.clear();
      _pressureController.clear();
      _serumGlucoseController.clear();
      _lactateController.clear();
      _notesController.clear();
      _selectedAppearance = CsfAppearance.clear;
      _currentResult = null;
      _showResults = false;
    });
  }

  String _getCsfTypeText(CsfType type) {
    switch (type) {
      case CsfType.normal:
        return 'Bình thường';
      case CsfType.bacterial:
        return 'Viêm màng não do vi khuẩn';
      case CsfType.viral:
        return 'Viêm màng não do virus';
      case CsfType.tuberculous:
        return 'Viêm màng não lao';
      case CsfType.fungal:
        return 'Viêm màng não do nấm';
      case CsfType.malignant:
        return 'Viêm màng não ung thư';
      case CsfType.hemorrhagic:
        return 'Xuất huyết dưới nhện';
      case CsfType.traumatic:
        return 'Chọc dò có máu';
    }
  }

  String _getCauseText(CsfCause cause) {
    switch (cause) {
      case CsfCause.normal:
        return 'Bình thường';
      case CsfCause.bacterialMeningitis:
        return 'Viêm màng não vi khuẩn';
      case CsfCause.pyogenicMeningitis:
        return 'Viêm màng não mủ';
      case CsfCause.viralMeningitis:
        return 'Viêm màng não virus';
      case CsfCause.asepticMeningitis:
        return 'Viêm màng não vô khuẩn';
      case CsfCause.tuberculousMeningitis:
        return 'Viêm màng não lao';
      case CsfCause.fungalMeningitis:
        return 'Viêm màng não nấm';
      case CsfCause.cryptococcalMeningitis:
        return 'Viêm màng não Cryptococcus';
      case CsfCause.malignantMeningitis:
        return 'Viêm màng não ung thư';
      case CsfCause.carcinomatousMeningitis:
        return 'Viêm màng não carcinomatous';
      case CsfCause.subarachnoidHemorrhage:
        return 'Xuất huyết dưới nhện';
      case CsfCause.intracerebralHemorrhage:
        return 'Xuất huyết não';
      case CsfCause.traumaticTap:
        return 'Chọc dò có máu';
      case CsfCause.encephalitis:
        return 'Viêm não';
      case CsfCause.brain_abscess:
        return 'Áp xe não';
      case CsfCause.guillainBarre:
        return 'Hội chứng Guillain-Barré';
      case CsfCause.multipleSclerosis:
        return 'Đa xơ cứng';
    }
  }

  String _getAppearanceText(CsfAppearance appearance) {
    switch (appearance) {
      case CsfAppearance.clear:
        return 'Trong';
      case CsfAppearance.turbid:
        return 'Đục';
      case CsfAppearance.purulent:
        return 'Mủ';
      case CsfAppearance.bloody:
        return 'Có máu';
      case CsfAppearance.xanthochromic:
        return 'Vàng (xanthochromic)';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phân tích dịch não tủy'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          if (_showResults)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _clearForm,
              tooltip: 'Phân tích mới',
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header info
              Card(
                color: AppColors.primary.withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(Icons.psychology, 
                           size: 48, 
                           color: AppColors.primary),
                      const SizedBox(height: 8),
                      const Text(
                        'Phân tích dịch não tủy',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Chẩn đoán viêm màng não và các bệnh lý thần kinh',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              if (!_showResults) ...[
                // CSF Values Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.water_drop, color: AppColors.primary),
                            const SizedBox(width: 8),
                            const Text(
                              'Thông số dịch não tủy',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '* Bắt buộc cho chẩn đoán',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // First row - Protein and Glucose
                        Row(
                          children: [
                            Expanded(
                              child: _buildNumberField(
                                controller: _proteinController,
                                label: 'Protein (mg/dL) *',
                                hint: '15-45',
                                validator: _validateRequiredNumber,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildNumberField(
                                controller: _glucoseController,
                                label: 'Glucose (mg/dL) *',
                                hint: '50-80',
                                validator: _validateRequiredNumber,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Second row - Cell count and Pressure
                        Row(
                          children: [
                            Expanded(
                              child: _buildNumberField(
                                controller: _cellCountController,
                                label: 'Số tế bào (/μL) *',
                                hint: '0-5',
                                isInteger: true,
                                validator: _validateRequiredInteger,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildNumberField(
                                controller: _pressureController,
                                label: 'Áp lực (mmH2O)',
                                hint: '70-180 (tùy chọn)',
                                validator: _validateOptionalNumber,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Third row - Neutrophils and Lymphocytes
                        Row(
                          children: [
                            Expanded(
                              child: _buildNumberField(
                                controller: _neutrophilsController,
                                label: 'Neutrophils (/μL)',
                                hint: '0-3',
                                isInteger: true,
                                validator: _validateOptionalInteger,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildNumberField(
                                controller: _lymphocytesController,
                                label: 'Lymphocytes (/μL)',
                                hint: '0-5',
                                isInteger: true,
                                validator: _validateOptionalInteger,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Fourth row - RBC and Lactate
                        Row(
                          children: [
                            Expanded(
                              child: _buildNumberField(
                                controller: _rbcController,
                                label: 'Hồng cầu (/μL)',
                                hint: '0-5',
                                isInteger: true,
                                validator: _validateOptionalInteger,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildNumberField(
                                controller: _lactateController,
                                label: 'Lactate (mmol/L)',
                                hint: '1.5-2.1 (tùy chọn)',
                                validator: _validateOptionalNumber,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Appearance
                        DropdownButtonFormField<CsfAppearance>(
                          initialValue: _selectedAppearance,
                          decoration: const InputDecoration(
                            labelText: 'Tính chất dịch',
                            border: OutlineInputBorder(),
                          ),
                          items: CsfAppearance.values.map((appearance) {
                            return DropdownMenuItem(
                              value: appearance,
                              child: Text(_getAppearanceText(appearance)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedAppearance = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Serum Values Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.bloodtype, color: AppColors.secondary),
                            const SizedBox(width: 8),
                            const Text(
                              'Thông số máu',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '* Để tính tỷ lệ glucose CSF/máu (mặc định 90 mg/dL)',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        _buildNumberField(
                          controller: _serumGlucoseController,
                          label: 'Glucose máu (mg/dL)',
                          hint: '70-110 (tùy chọn)',
                          validator: _validateOptionalNumber,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Notes
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Ghi chú (tùy chọn)',
                    hintText: 'Thông tin bổ sung...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                
                // Analyze Button
                ElevatedButton(
                  onPressed: _analyzeCsf,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Phân tích dịch não tủy',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              
              if (_showResults) _buildResultsCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String? Function(String?) validator,
    bool isInteger = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: !isInteger),
      inputFormatters: isInteger
          ? [FilteringTextInputFormatter.digitsOnly]
          : [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
      validator: validator,
    );
  }

  // Required validators
  String? _validateRequiredNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập giá trị';
    }
    final number = double.tryParse(value);
    if (number == null || number < 0) {
      return 'Giá trị không hợp lệ';
    }
    return null;
  }

  String? _validateRequiredInteger(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập giá trị';
    }
    final number = int.tryParse(value);
    if (number == null || number < 0) {
      return 'Giá trị không hợp lệ';
    }
    return null;
  }

  // Optional validators
  String? _validateOptionalInteger(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final number = int.tryParse(value);
    if (number == null || number < 0) {
      return 'Giá trị không hợp lệ';
    }
    return null;
  }

  String? _validateOptionalNumber(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final number = double.tryParse(value);
    if (number == null || number < 0) {
      return 'Giá trị không hợp lệ';
    }
    return null;
  }

  Widget _buildResultsCard() {
    final result = _currentResult!;
    final csfType = result.csfType;
    final likelyCauses = result.likelyCauses;
    final isDefaultSerum = _serumGlucoseController.text.isEmpty;
    final isDefaultPressure = _pressureController.text.isEmpty;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.assignment_turned_in, color: AppColors.primary),
                const SizedBox(width: 8),
                const Text(
                  'Kết quả phân tích',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Show default values notices if applicable
            if (isDefaultSerum || isDefaultPressure) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Sử dụng giá trị mặc định:',
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (isDefaultSerum)
                      Text(
                        '• Glucose máu: 90 mg/dL',
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontSize: 12,
                        ),
                      ),
                    if (isDefaultPressure)
                      Text(
                        '• Áp lực CSF: 150 mmH2O',
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // Main diagnosis
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getTypeColor(csfType).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _getTypeColor(csfType),
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getTypeIcon(csfType),
                        color: _getTypeColor(csfType),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _getCsfTypeText(csfType),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _getTypeColor(csfType),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Key parameters
            const Text(
              'Thông số chính:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            
            _buildParameterRow(
              'Tế bào',
              '${result.cellCount} /μL',
              result.cellCount <= 5 ? 'Bình thường (≤5)' : 'Tăng cao',
              result.cellCount <= 5,
            ),
            _buildParameterRow(
              'Protein',
              '${result.protein.toStringAsFixed(1)} mg/dL',
              result.protein <= 45 ? 'Bình thường (15-45)' : 'Tăng cao',
              result.protein <= 45,
            ),
            _buildParameterRow(
              'Glucose ratio',
              result.glucoseRatio.toStringAsFixed(2),
              result.glucoseRatio >= 0.6 ? '≥0.6 (Bình thường)' : '<0.6 (Thấp)',
              result.glucoseRatio >= 0.6,
            ),
            _buildParameterRow(
              'Áp lực',
              '${result.pressure.toStringAsFixed(0)} mmH2O',
              result.pressure <= 180 ? 'Bình thường (70-180)' : 'Tăng cao',
              result.pressure <= 180,
            ),
            
            // Add lactate parameter if available
            if (result.lactate != null)
              _buildParameterRow(
                'Lactate',
                '${result.lactate!.toStringAsFixed(1)} mmol/L',
                result.lactateInterpretation,
                result.hasNormalLactate,
              ),
            
            const SizedBox(height: 16),
            
            // Risk and urgency assessment
            _buildUrgencyCard(result.riskLevel, result.urgencyLevel),
            const SizedBox(height: 16),
            
            // Likely causes
            const Text(
              'Chẩn đoán có thể:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            
            ...likelyCauses.map((cause) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _getCauseText(cause),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildParameterRow(String label, String value, String reference, bool isNormal) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isNormal ? AppColors.normalGreen : AppColors.warning,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              reference,
              style: TextStyle(
                fontSize: 12,
                color: isNormal ? AppColors.normalGreen : AppColors.warning,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUrgencyCard(String riskLevel, String urgencyLevel) {
    Color color = _getRiskColor(riskLevel);
    IconData icon = _getRiskIcon(riskLevel);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(
                'Mức độ nguy cơ: $riskLevel',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            urgencyLevel,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(CsfType type) {
    switch (type) {
      case CsfType.normal:
        return Colors.green;
      case CsfType.bacterial:
      case CsfType.hemorrhagic:
        return Colors.red;
      case CsfType.viral:
        return Colors.blue;
      case CsfType.tuberculous:
      case CsfType.fungal:
      case CsfType.malignant:
        return Colors.orange;
      case CsfType.traumatic:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon(CsfType type) {
    switch (type) {
      case CsfType.normal:
        return Icons.check_circle;
      case CsfType.bacterial:
        return Icons.dangerous;
      case CsfType.viral:
        return Icons.warning;
      case CsfType.tuberculous:
        return Icons.personal_injury;
      case CsfType.fungal:
        return Icons.coronavirus;
      case CsfType.malignant:
        return Icons.health_and_safety;
      case CsfType.hemorrhagic:
        return Icons.emergency;
      case CsfType.traumatic:
        return Icons.healing;
    }
  }

  Color _getRiskColor(String risk) {
    switch (risk) {
      case 'Cấp cứu':
        return Colors.red;
      case 'Cao':
        return Colors.orange;
      case 'Trung bình':
        return Colors.blue;
      case 'Thấp':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getRiskIcon(String risk) {
    switch (risk) {
      case 'Cấp cứu':
        return Icons.emergency;
      case 'Cao':
        return Icons.dangerous;
      case 'Trung bình':
        return Icons.warning;
      case 'Thấp':
        return Icons.check_circle;
      default:
        return Icons.help;
    }
  }
}
