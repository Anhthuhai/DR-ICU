import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/colors.dart';
import '../domain/entities/pleural_fluid_result.dart';

class PleuralFluidAnalysisPage extends StatefulWidget {
  const PleuralFluidAnalysisPage({super.key});

  @override
  State<PleuralFluidAnalysisPage> createState() => _PleuralFluidAnalysisPageState();
}

class _PleuralFluidAnalysisPageState extends State<PleuralFluidAnalysisPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Pleural fluid controllers
  final _proteinController = TextEditingController();
  final _ldhController = TextEditingController();
  final _glucoseController = TextEditingController();
  final _phController = TextEditingController();
  final _cellCountController = TextEditingController();
  final _neutrophilsController = TextEditingController();
  final _lymphocytesController = TextEditingController();
  final _cholesterolController = TextEditingController();
  final _triglyceridesController = TextEditingController();
  
  // Serum controllers
  final _serumProteinController = TextEditingController(text: '7.0');
  final _serumLdhController = TextEditingController(text: '200');
  final _serumGlucoseController = TextEditingController(text: '100');
  
  final _notesController = TextEditingController();

  PleuralFluidAppearance _selectedAppearance = PleuralFluidAppearance.clear;
  PleuralFluidResult? _currentResult;
  bool _showResults = false;

  @override
  void dispose() {
    _proteinController.dispose();
    _ldhController.dispose();
    _glucoseController.dispose();
    _phController.dispose();
    _cellCountController.dispose();
    _neutrophilsController.dispose();
    _lymphocytesController.dispose();
    _cholesterolController.dispose();
    _triglyceridesController.dispose();
    _serumProteinController.dispose();
    _serumLdhController.dispose();
    _serumGlucoseController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _analyzePleuralFluid() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _currentResult = PleuralFluidResult(
          protein: double.parse(_proteinController.text),
          ldh: double.parse(_ldhController.text),
          glucose: _glucoseController.text.isNotEmpty 
              ? double.parse(_glucoseController.text) : 80.0, // Default value
          ph: _phController.text.isNotEmpty 
              ? double.parse(_phController.text) : 7.4, // Default value
          cellCount: _cellCountController.text.isNotEmpty 
              ? int.parse(_cellCountController.text) : 1000, // Default value
          neutrophils: _neutrophilsController.text.isNotEmpty 
              ? int.parse(_neutrophilsController.text) : 50, // Default value
          lymphocytes: _lymphocytesController.text.isNotEmpty 
              ? int.parse(_lymphocytesController.text) : 50, // Default value
          cholesterol: _cholesterolController.text.isNotEmpty 
              ? double.parse(_cholesterolController.text) : 60.0, // Default value
          triglycerides: _triglyceridesController.text.isNotEmpty 
              ? double.parse(_triglyceridesController.text) : 30.0, // Default value
          appearance: _selectedAppearance,
          timestamp: DateTime.now(),
          serumProtein: double.parse(_serumProteinController.text),
          serumLdh: double.parse(_serumLdhController.text),
          serumGlucose: _serumGlucoseController.text.isNotEmpty 
              ? double.parse(_serumGlucoseController.text) : 100.0, // Default value
          notes: _notesController.text.isNotEmpty ? _notesController.text : null,
        );
        _showResults = true;
      });
    }
  }

  void _clearForm() {
    setState(() {
      _proteinController.clear();
      _ldhController.clear();
      _glucoseController.clear();
      _phController.clear();
      _cellCountController.clear();
      _neutrophilsController.clear();
      _lymphocytesController.clear();
      _cholesterolController.clear();
      _triglyceridesController.clear();
      _serumProteinController.text = '7.0';
      _serumLdhController.text = '200';
      _serumGlucoseController.text = '100';
      _notesController.clear();
      _selectedAppearance = PleuralFluidAppearance.clear;
      _currentResult = null;
      _showResults = false;
    });
  }

  String _getAppearanceText(PleuralFluidAppearance appearance) {
    switch (appearance) {
      case PleuralFluidAppearance.clear:
        return 'Trong suốt';
      case PleuralFluidAppearance.turbid:
        return 'Đục';
      case PleuralFluidAppearance.bloody:
        return 'Có máu';
      case PleuralFluidAppearance.purulent:
        return 'Mủ';
      case PleuralFluidAppearance.milky:
        return 'Trắng đục';
      case PleuralFluidAppearance.cholesterol:
        return 'Vàng cholesterol';
    }
  }

  String _getFluidTypeText(PleuralFluidType type) {
    switch (type) {
      case PleuralFluidType.transudate:
        return 'Dịch thấm xuất (Transudate)';
      case PleuralFluidType.exudate:
        return 'Dịch thẩm xuất (Exudate)';
      case PleuralFluidType.indeterminate:
        return 'Không xác định';
    }
  }

  String _getCauseText(PleuralFluidCause cause) {
    switch (cause) {
      case PleuralFluidCause.heartFailure:
        return 'Suy tim';
      case PleuralFluidCause.cirrhosis:
        return 'Xơ gan';
      case PleuralFluidCause.nephrotic:
        return 'Hội chứng thận hư';
      case PleuralFluidCause.hypoalbuminemia:
        return 'Hạ albumin máu';
      case PleuralFluidCause.pneumonia:
        return 'Viêm phổi';
      case PleuralFluidCause.malignancy:
        return 'Ung thư';
      case PleuralFluidCause.tuberculosis:
        return 'Lao phổi';
      case PleuralFluidCause.pulmonaryEmbolism:
        return 'Thuyên tắc phổi';
      case PleuralFluidCause.pancreatitis:
        return 'Viêm tụy';
      case PleuralFluidCause.rheumatoid:
        return 'Viêm khớp dạng thấp';
      case PleuralFluidCause.lupus:
        return 'Lupus ban đỏ hệ thống';
      case PleuralFluidCause.empyema:
        return 'Tụ mủ màng phổi';
      case PleuralFluidCause.unknown:
        return 'Chưa xác định nguyên nhân';
    }
  }

  Color _getFluidTypeColor(PleuralFluidType type) {
    switch (type) {
      case PleuralFluidType.transudate:
        return Colors.blue;
      case PleuralFluidType.exudate:
        return Colors.red;
      case PleuralFluidType.indeterminate:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phân tích dịch màng phổi'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _clearForm,
            icon: const Icon(Icons.clear_all),
            tooltip: 'Xóa tất cả',
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
              // Pleural Fluid Values Card
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
                            'Thông số dịch màng phổi',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '* Bắt buộc cho tiêu chuẩn Light',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Appearance
                      DropdownButtonFormField<PleuralFluidAppearance>(
                        initialValue: _selectedAppearance,
                        decoration: const InputDecoration(
                          labelText: 'Tính chất dịch',
                          border: OutlineInputBorder(),
                        ),
                        items: PleuralFluidAppearance.values.map((appearance) {
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
                      const SizedBox(height: 16),
                      
                      // First row
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
                              controller: _ldhController,
                              label: 'LDH (U/L) *',
                              hint: '50-1000',
                              validator: _validateRequiredNumber,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Second row
                      Row(
                        children: [
                          Expanded(
                            child: _buildNumberField(
                              controller: _glucoseController,
                              label: 'Glucose (mg/dL)',
                              hint: '30-150',
                              validator: _validateOptionalNumber,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildNumberField(
                              controller: _phController,
                              label: 'pH',
                              hint: '7.0-7.6',
                              validator: _validateOptionalNumber,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Third row
                      Row(
                        children: [
                          Expanded(
                            child: _buildNumberField(
                              controller: _cellCountController,
                              label: 'Số tế bào (/μL)',
                              hint: '100-10000',
                              isInteger: true,
                              validator: _validateOptionalInteger,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildNumberField(
                              controller: _neutrophilsController,
                              label: 'Neutrophils (%)',
                              hint: '0-100',
                              isInteger: true,
                              validator: _validateOptionalPercentage,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Fourth row
                      Row(
                        children: [
                          Expanded(
                            child: _buildNumberField(
                              controller: _lymphocytesController,
                              label: 'Lymphocytes (%)',
                              hint: '0-100',
                              isInteger: true,
                              validator: _validateOptionalPercentage,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildNumberField(
                              controller: _cholesterolController,
                              label: 'Cholesterol (mg/dL)',
                              hint: '20-200',
                              validator: _validateOptionalNumber,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      _buildNumberField(
                        controller: _triglyceridesController,
                        label: 'Triglycerides (mg/dL)',
                        hint: '10-200',
                        validator: _validateOptionalNumber,
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
                        '* Bắt buộc cho tiêu chuẩn Light',
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
                              controller: _serumLdhController,
                              label: 'Serum LDH (U/L) *',
                              hint: '100-250',
                              validator: _validateRequiredNumber,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      _buildNumberField(
                        controller: _serumGlucoseController,
                        label: 'Serum Glucose (mg/dL)',
                        hint: '70-110',
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
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              
              // Analyze Button
              ElevatedButton.icon(
                onPressed: _analyzePleuralFluid,
                icon: const Icon(Icons.analytics),
                label: const Text('Phân tích dịch màng phổi'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
              ),
              
              if (_showResults && _currentResult != null) ...[
                const SizedBox(height: 16),
                _buildResultsCard(),
              ],

              // Medical Citation
              const SizedBox(height: 16),
              _buildCitationWidget(),
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

  // Required validators for Light's criteria
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

  String? _validateOptionalPercentage(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Allow empty for optional fields
    }
    final number = int.tryParse(value);
    if (number == null || number < 0 || number > 100) {
      return 'Phần trăm không hợp lệ (0-100)';
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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Fluid Type
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getFluidTypeColor(fluidType).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _getFluidTypeColor(fluidType),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phân loại dịch',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _getFluidTypeColor(fluidType),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getFluidTypeText(fluidType),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Light's Criteria
            const Text(
              'Tiêu chí Light\'s',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            _buildCriteriaRow(
              'Protein ratio (PF/S)',
              (result.protein / result.serumProtein).toStringAsFixed(2),
              result.isExudateByProtein ? '> 0.5 (Exudate)' : '≤ 0.5 (Transudate)',
              result.isExudateByProtein,
            ),
            _buildCriteriaRow(
              'LDH ratio (PF/S)',
              (result.ldh / result.serumLdh).toStringAsFixed(2),
              result.isExudateByLdh ? '> 0.6 (Exudate)' : '≤ 0.6 (Transudate)',
              result.isExudateByLdh,
            ),
            _buildCriteriaRow(
              'LDH tuyệt đối',
              '${result.ldh.toStringAsFixed(0)} U/L',
              result.isExudateByAbsoluteLdh ? '> 133 (Exudate)' : '≤ 133 (Transudate)',
              result.isExudateByAbsoluteLdh,
            ),
            
            const SizedBox(height: 16),
            
            // Additional Parameters
            const Text(
              'Thông số bổ sung',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            Row(
              children: [
                Expanded(
                  child: _buildParameterCard(
                    'Glucose Ratio',
                    result.glucoseRatio.toStringAsFixed(2),
                    'PF/Serum',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildParameterCard(
                    'Tính chất',
                    _getAppearanceText(result.appearance),
                    '',
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Special Tests Results
            if (result.suggestsChylothorax || result.suggestsPseudochylothorax) ...[
              const Text(
                'Xét nghiệm đặc biệt',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              
              if (result.suggestsChylothorax) 
                _buildSpecialTestResult('Chylothorax', 'Dương tính', Colors.orange),
              if (result.suggestsPseudochylothorax) 
                _buildSpecialTestResult('Pseudochylothorax', 'Dương tính', Colors.orange),
              
              const SizedBox(height: 16),
            ],
            
            // Likely Causes
            const Text(
              'Nguyên nhân có thể',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: likelyCauses.map((cause) {
                return Chip(
                  label: Text(_getCauseText(cause)),
                  backgroundColor: _getFluidTypeColor(fluidType).withValues(alpha: 0.1),
                  side: BorderSide(color: _getFluidTypeColor(fluidType)),
                );
              }).toList(),
            ),
            
            if (result.notes != null) ...[
              const SizedBox(height: 16),
              const Text(
                'Ghi chú',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(result.notes!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCriteriaRow(String label, String value, String interpretation, bool isExudate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label)),
          Expanded(child: Text(value, textAlign: TextAlign.center)),
          Expanded(
            flex: 2,
            child: Text(
              interpretation,
              style: TextStyle(
                color: isExudate ? Colors.red : Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParameterCard(String label, String value, String unit) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$value $unit',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialTestResult(String test, String result, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: color, size: 20),
          const SizedBox(width: 8),
          Text('$test: $result'),
        ],
      ),
    );
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
            'Light RW, et al. Pleural effusions: the diagnostic separation of transudates and exudates. Ann Intern Med. 1972;77(4):507-13.\n\nBielsa S, et al. Accuracy of pleural fluid cholesterol in separating transudative from exudative pleural effusions. Respirology. 2013;18(5):857-62.',
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
