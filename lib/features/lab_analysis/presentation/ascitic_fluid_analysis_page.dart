import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/colors.dart';
import '../domain/entities/ascitic_fluid_result.dart';

class AsciticFluidAnalysisPage extends StatefulWidget {
  const AsciticFluidAnalysisPage({super.key});

  @override
  State<AsciticFluidAnalysisPage> createState() => _AsciticFluidAnalysisPageState();
}

class _AsciticFluidAnalysisPageState extends State<AsciticFluidAnalysisPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for ascitic fluid values
  final _proteinController = TextEditingController();
  final _albuminController = TextEditingController();
  final _ldhController = TextEditingController();
  final _glucoseController = TextEditingController();
  final _amylaseController = TextEditingController();
  final _cellCountController = TextEditingController();
  final _neutrophilsController = TextEditingController();
  final _lymphocytesController = TextEditingController();
  final _rbcController = TextEditingController();
  final _triglyceridesController = TextEditingController();
  
  // Controllers for serum values
  final _serumProteinController = TextEditingController();
  final _serumAlbuminController = TextEditingController();
  final _serumLdhController = TextEditingController();
  final _serumGlucoseController = TextEditingController();
  
  final _notesController = TextEditingController();
  
  AsciticFluidAppearance _selectedAppearance = AsciticFluidAppearance.clear;
  AsciticFluidResult? _currentResult;
  bool _showResults = false;

  @override
  void dispose() {
    _proteinController.dispose();
    _albuminController.dispose();
    _ldhController.dispose();
    _glucoseController.dispose();
    _amylaseController.dispose();
    _cellCountController.dispose();
    _neutrophilsController.dispose();
    _lymphocytesController.dispose();
    _rbcController.dispose();
    _triglyceridesController.dispose();
    _serumProteinController.dispose();
    _serumAlbuminController.dispose();
    _serumLdhController.dispose();
    _serumGlucoseController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _analyzeAsciticFluid() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _currentResult = AsciticFluidResult(
          protein: double.parse(_proteinController.text),
          albumin: double.parse(_albuminController.text),
          ldh: _ldhController.text.isNotEmpty 
              ? double.parse(_ldhController.text) : 100.0,
          glucose: _glucoseController.text.isNotEmpty 
              ? double.parse(_glucoseController.text) : 80.0,
          amylase: _amylaseController.text.isNotEmpty 
              ? double.parse(_amylaseController.text) : 50.0,
          cellCount: _cellCountController.text.isNotEmpty 
              ? int.parse(_cellCountController.text) : 200,
          neutrophils: _neutrophilsController.text.isNotEmpty 
              ? int.parse(_neutrophilsController.text) : 50,
          lymphocytes: _lymphocytesController.text.isNotEmpty 
              ? int.parse(_lymphocytesController.text) : 50,
          redBloodCells: _rbcController.text.isNotEmpty 
              ? int.parse(_rbcController.text) : 100,
          triglycerides: _triglyceridesController.text.isNotEmpty 
              ? double.parse(_triglyceridesController.text) : 30.0,
          appearance: _selectedAppearance,
          timestamp: DateTime.now(),
          serumProtein: double.parse(_serumProteinController.text),
          serumAlbumin: double.parse(_serumAlbuminController.text),
          serumLdh: _serumLdhController.text.isNotEmpty 
              ? double.parse(_serumLdhController.text) : 200.0,
          serumGlucose: _serumGlucoseController.text.isNotEmpty 
              ? double.parse(_serumGlucoseController.text) : 100.0,
          notes: _notesController.text.isNotEmpty ? _notesController.text : null,
        );
        _showResults = true;
      });
    }
  }

  void _clearForm() {
    setState(() {
      _proteinController.clear();
      _albuminController.clear();
      _ldhController.clear();
      _glucoseController.clear();
      _amylaseController.clear();
      _cellCountController.clear();
      _neutrophilsController.clear();
      _lymphocytesController.clear();
      _rbcController.clear();
      _triglyceridesController.clear();
      _serumProteinController.clear();
      _serumAlbuminController.clear();
      _serumLdhController.clear();
      _serumGlucoseController.clear();
      _notesController.clear();
      _selectedAppearance = AsciticFluidAppearance.clear;
      _currentResult = null;
      _showResults = false;
    });
  }

  String _getFluidTypeText(AsciticFluidType type) {
    switch (type) {
      case AsciticFluidType.transudate:
        return 'Dịch thấm xuất (SAAG ≥ 1.1)';
      case AsciticFluidType.exudate:
        return 'Dịch thẩm xuất (SAAG < 1.1)';
      case AsciticFluidType.indeterminate:
        return 'Không xác định';
    }
  }

  String _getCauseText(AsciticFluidCause cause) {
    switch (cause) {
      case AsciticFluidCause.cirrhosis:
        return 'Xơ gan';
      case AsciticFluidCause.heartFailure:
        return 'Suy tim';
      case AsciticFluidCause.nephrotic:
        return 'Hội chứng thận hư';
      case AsciticFluidCause.hypoalbuminemia:
        return 'Hạ albumin máu';
      case AsciticFluidCause.peritonitis:
        return 'Viêm phúc mạc';
      case AsciticFluidCause.malignancy:
        return 'Ung thư';
      case AsciticFluidCause.tuberculosis:
        return 'Lao phúc mạc';
      case AsciticFluidCause.pancreatitis:
        return 'Viêm tụy';
      case AsciticFluidCause.nephrogenicAscites:
        return 'Cổ trướng do thận';
      case AsciticFluidCause.spontaneousBacterialPeritonitis:
        return 'Viêm phúc mạc nhiễm khuẩn tự phát (SBP)';
      case AsciticFluidCause.secondaryBacterialPeritonitis:
        return 'Viêm phúc mạc nhiễm khuẩn thứ phát';
      case AsciticFluidCause.chylousAscites:
        return 'Cổ trướng chứa chyle';
      case AsciticFluidCause.hemorrhagicAscites:
        return 'Cổ trướng xuất huyết';
    }
  }

  String _getAppearanceText(AsciticFluidAppearance appearance) {
    switch (appearance) {
      case AsciticFluidAppearance.clear:
        return 'Trong';
      case AsciticFluidAppearance.turbid:
        return 'Đục';
      case AsciticFluidAppearance.bloody:
        return 'Có máu';
      case AsciticFluidAppearance.milky:
        return 'Màu sữa';
      case AsciticFluidAppearance.purulent:
        return 'Mủ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phân tích dịch màng bụng'),
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
                      Icon(Icons.local_hospital, 
                           size: 48, 
                           color: AppColors.primary),
                      const SizedBox(height: 8),
                      const Text(
                        'Phân tích dịch màng bụng',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Sử dụng SAAG và các tiêu chí chẩn đoán',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              if (!_showResults) ...[
                // Ascitic Fluid Values Card
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
                              'Thông số dịch màng bụng',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '* Bắt buộc cho tính SAAG',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // First row - Protein and Albumin
                        Row(
                          children: [
                            Expanded(
                              child: _buildNumberField(
                                controller: _proteinController,
                                label: 'Protein (g/dL) *',
                                hint: '0.5-6.0',
                                validator: _validateRequiredNumber,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildNumberField(
                                controller: _albuminController,
                                label: 'Albumin (g/dL) *',
                                hint: '0.2-4.0',
                                validator: _validateRequiredNumber,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Second row - LDH and Glucose
                        Row(
                          children: [
                            Expanded(
                              child: _buildNumberField(
                                controller: _ldhController,
                                label: 'LDH (U/L)',
                                hint: '50-500',
                                validator: _validateOptionalNumber,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildNumberField(
                                controller: _glucoseController,
                                label: 'Glucose (mg/dL)',
                                hint: '30-150',
                                validator: _validateOptionalNumber,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Third row - Amylase and Cell count
                        Row(
                          children: [
                            Expanded(
                              child: _buildNumberField(
                                controller: _amylaseController,
                                label: 'Amylase (U/L)',
                                hint: '10-500',
                                validator: _validateOptionalNumber,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildNumberField(
                                controller: _cellCountController,
                                label: 'Số tế bào (/μL)',
                                hint: '100-5000',
                                isInteger: true,
                                validator: _validateOptionalInteger,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Fourth row - Neutrophils and Lymphocytes
                        Row(
                          children: [
                            Expanded(
                              child: _buildNumberField(
                                controller: _neutrophilsController,
                                label: 'Neutrophils (/μL)',
                                hint: '0-1000',
                                isInteger: true,
                                validator: _validateOptionalInteger,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildNumberField(
                                controller: _lymphocytesController,
                                label: 'Lymphocytes (/μL)',
                                hint: '0-1000',
                                isInteger: true,
                                validator: _validateOptionalInteger,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Fifth row - RBC and Triglycerides
                        Row(
                          children: [
                            Expanded(
                              child: _buildNumberField(
                                controller: _rbcController,
                                label: 'Hồng cầu (/μL)',
                                hint: '0-10000',
                                isInteger: true,
                                validator: _validateOptionalInteger,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildNumberField(
                                controller: _triglyceridesController,
                                label: 'Triglycerides (mg/dL)',
                                hint: '10-200',
                                validator: _validateOptionalNumber,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Appearance
                        DropdownButtonFormField<AsciticFluidAppearance>(
                          initialValue: _selectedAppearance,
                          decoration: const InputDecoration(
                            labelText: 'Tính chất dịch',
                            border: OutlineInputBorder(),
                          ),
                          items: AsciticFluidAppearance.values.map((appearance) {
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
                          '* Bắt buộc cho tính SAAG',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        Row(
                          children: [
                            Expanded(
                              child: _buildNumberField(
                                controller: _serumProteinController,
                                label: 'Serum Protein (g/dL) *',
                                hint: '6.0-8.0',
                                validator: _validateRequiredNumber,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildNumberField(
                                controller: _serumAlbuminController,
                                label: 'Serum Albumin (g/dL) *',
                                hint: '3.5-5.0',
                                validator: _validateRequiredNumber,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        Row(
                          children: [
                            Expanded(
                              child: _buildNumberField(
                                controller: _serumLdhController,
                                label: 'Serum LDH (U/L)',
                                hint: '100-250',
                                validator: _validateOptionalNumber,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildNumberField(
                                controller: _serumGlucoseController,
                                label: 'Serum Glucose (mg/dL)',
                                hint: '70-110',
                                validator: _validateOptionalNumber,
                              ),
                            ),
                          ],
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
                  onPressed: _analyzeAsciticFluid,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Phân tích dịch màng bụng',
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

  // Required validators for SAAG calculation
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

  // Optional validators for additional parameters
  String? _validateOptionalNumber(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Allow empty for optional fields
    }
    final number = double.tryParse(value);
    if (number == null || number < 0) {
      return 'Giá trị không hợp lệ';
    }
    return null;
  }

  String? _validateOptionalInteger(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Allow empty for optional fields
    }
    final number = int.tryParse(value);
    if (number == null || number < 0) {
      return 'Giá trị không hợp lệ';
    }
    return null;
  }

  Widget _buildResultsCard() {
    final result = _currentResult!;
    final fluidType = result.fluidType;
    final likelyCauses = result.likelyCauses;

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
            
            // SAAG and Classification
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: fluidType == AsciticFluidType.transudate 
                    ? Colors.blue.withValues(alpha: 0.1)
                    : Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: fluidType == AsciticFluidType.transudate 
                      ? Colors.blue
                      : Colors.orange,
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        fluidType == AsciticFluidType.transudate 
                            ? Icons.water
                            : Icons.warning,
                        color: fluidType == AsciticFluidType.transudate 
                            ? Colors.blue
                            : Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _getFluidTypeText(fluidType),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: fluidType == AsciticFluidType.transudate 
                                ? Colors.blue[700]
                                : Colors.orange[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'SAAG: ${result.saag.toStringAsFixed(1)} g/dL',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // SAAG Calculation Details
            const Text(
              'Chi tiết SAAG:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            
            _buildSaagRow(
              'Serum Albumin',
              result.serumAlbumin.toStringAsFixed(1),
              '',
              false,
            ),
            _buildSaagRow(
              'Ascitic Albumin',
              result.albumin.toStringAsFixed(1),
              '',
              false,
            ),
            const Divider(),
            _buildSaagRow(
              'SAAG',
              result.saag.toStringAsFixed(1),
              result.saag >= 1.1 ? '≥ 1.1 (Portal HTN)' : '< 1.1 (Non-portal HTN)',
              result.saag >= 1.1,
            ),
            
            const SizedBox(height: 16),
            
            // Special conditions
            if (result.suggestsSbp) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning, color: Colors.red),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Nghi ngờ SBP (Tế bào ≥250, Neutrophils ≥50%)',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
            
            if (result.suggestsSecondaryPeritonitis) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.emergency, color: Colors.red),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Nghi ngờ viêm phúc mạc thứ phát',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
            
            // Risk assessment
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getRiskColor(result.riskLevel).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _getRiskColor(result.riskLevel)),
              ),
              child: Row(
                children: [
                  Icon(
                    _getRiskIcon(result.riskLevel),
                    color: _getRiskColor(result.riskLevel),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Mức độ nguy cơ: ${result.riskLevel}',
                    style: TextStyle(
                      color: _getRiskColor(result.riskLevel),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Risk explanation
            _buildRiskExplanationCard(result.riskLevel),
            const SizedBox(height: 16),
            
            // Likely causes
            const Text(
              'Nguyên nhân có thể:',
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

  Widget _buildSaagRow(String label, String value, String reference, bool isAbnormal) {
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
                color: isAbnormal ? AppColors.warning : AppColors.normalGreen,
              ),
            ),
          ),
          if (reference.isNotEmpty)
            Expanded(
              flex: 2,
              child: Text(
                reference,
                style: TextStyle(
                  fontSize: 12,
                  color: isAbnormal ? AppColors.warning : AppColors.normalGreen,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getRiskColor(String risk) {
    switch (risk) {
      case 'Cao':
        return Colors.red;
      case 'Trung bình':
        return Colors.orange;
      case 'Thấp':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getRiskIcon(String risk) {
    switch (risk) {
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

  Widget _buildRiskExplanationCard(String riskLevel) {
    String title;
    List<String> explanations;
    List<String> actions;
    Color backgroundColor;
    Color borderColor;
    IconData icon;

    switch (riskLevel) {
      case 'Cao':
        title = 'NGUY CƠ CAO - Cần can thiệp khẩn cấp';
        explanations = [
          'Nhiễm khuẩn phúc mạc (SBP hoặc thứ phát)',
          'Tỷ lệ tử vong cao nếu không điều trị kịp thời',
          'Cần theo dõi sát trong ICU'
        ];
        actions = [
          'Kháng sinh tĩnh mạch ngay lập tức',
          'Nuôi cấy dịch màng bụng và máu',
          'Theo dõi dấu hiệu nhiễm khuẩn toàn thân',
          'Đánh giá khả năng phẫu thuật nếu là viêm thứ phát'
        ];
        backgroundColor = Colors.red.withValues(alpha: 0.05);
        borderColor = Colors.red;
        icon = Icons.dangerous;
        break;

      case 'Trung bình':
        title = 'NGUY CƠ TRUNG BÌNH - Cần đánh giá và theo dõi';
        explanations = [
          'Có thể do ung thư hoặc lao phúc mạc',
          'Cần làm thêm xét nghiệm chuyên sâu',
          'Tiên lượng phụ thuộc vào bệnh nguyên nhân'
        ];
        actions = [
          'Tham khảo ý kiến chuyên khoa (oncology/infectiology)',
          'Làm thêm cytology, ADA, PCR TB',
          'Chụp CT/MRI để đánh giá thêm',
          'Lập kế hoạch điều trị dài hạn'
        ];
        backgroundColor = Colors.orange.withValues(alpha: 0.05);
        borderColor = Colors.orange;
        icon = Icons.warning;
        break;

      case 'Thấp':
        title = 'NGUY CƠ THẤP - Điều trị triệu chứng';
        explanations = [
          'Thường do transudate (xơ gan, suy tim)',
          'Ít nguy hiểm tính mạng',
          'Có thể theo dõi ngoại trú'
        ];
        actions = [
          'Điều trị lợi tiểu, hạn chế natri',
          'Điều trị bệnh nguyên nhân gốc',
          'Theo dõi định kỳ chức năng gan, thận, tim',
          'Chọc hút dịch nếu cần thiết về triệu chứng'
        ];
        backgroundColor = Colors.green.withValues(alpha: 0.05);
        borderColor = Colors.green;
        icon = Icons.check_circle;
        break;

      default:
        title = 'Không xác định';
        explanations = ['Cần đánh giá thêm'];
        actions = ['Tham khảo ý kiến chuyên khoa'];
        backgroundColor = Colors.grey.withValues(alpha: 0.05);
        borderColor = Colors.grey;
        icon = Icons.help;
        break;
    }

    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: borderColor, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: borderColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Explanations
            const Text(
              'Ý nghĩa lâm sàng:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            ...explanations.map((explanation) => Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: borderColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      explanation,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            )),
            
            const SizedBox(height: 12),
            
            // Actions
            const Text(
              'Hướng xử lý:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            ...actions.map((action) => Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: borderColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      action,
                      style: const TextStyle(fontSize: 13),
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
}
