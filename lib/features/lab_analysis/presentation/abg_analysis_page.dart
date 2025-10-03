import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/colors.dart';
import '../domain/entities/abg_result.dart';

class ABGAnalysisPage extends StatefulWidget {
  const ABGAnalysisPage({super.key});

  @override
  State<ABGAnalysisPage> createState() => _ABGAnalysisPageState();
}

class _ABGAnalysisPageState extends State<ABGAnalysisPage> {
  final _formKey = GlobalKey<FormState>();
  final _phController = TextEditingController();
  final _pco2Controller = TextEditingController();
  final _po2Controller = TextEditingController();
  final _hco3Controller = TextEditingController();
  final _baseExcessController = TextEditingController();
  final _sao2Controller = TextEditingController();
  final _fio2Controller = TextEditingController(text: '21');
  final _notesController = TextEditingController();

  ABGResult? _currentResult;
  bool _showResults = false;

  @override
  void dispose() {
    _phController.dispose();
    _pco2Controller.dispose();
    _po2Controller.dispose();
    _hco3Controller.dispose();
    _baseExcessController.dispose();
    _sao2Controller.dispose();
    _fio2Controller.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _analyzeABG() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _currentResult = ABGResult(
          ph: double.parse(_phController.text),
          pco2: double.parse(_pco2Controller.text),
          po2: double.parse(_po2Controller.text),
          hco3: double.parse(_hco3Controller.text),
          baseExcess: double.parse(_baseExcessController.text),
          sao2: double.parse(_sao2Controller.text),
          fio2: double.parse(_fio2Controller.text) / 100,
          timestamp: DateTime.now(),
          notes: _notesController.text.isNotEmpty ? _notesController.text : null,
        );
        _showResults = true;
      });
    }
  }

  void _clearForm() {
    setState(() {
      _phController.clear();
      _pco2Controller.clear();
      _po2Controller.clear();
      _hco3Controller.clear();
      _baseExcessController.clear();
      _sao2Controller.clear();
      _fio2Controller.text = '21';
      _notesController.clear();
      _currentResult = null;
      _showResults = false;
    });
  }

  String _getInterpretationText(ABGInterpretation interpretation) {
    switch (interpretation) {
      case ABGInterpretation.normal:
        return 'Bình thường';
      case ABGInterpretation.respiratoryAcidosis:
        return 'Toan hô hấp cấp';
      case ABGInterpretation.respiratoryAlkalosis:
        return 'Kiềm hô hấp cấp';
      case ABGInterpretation.metabolicAcidosis:
        return 'Toan chuyển hóa cấp';
      case ABGInterpretation.metabolicAlkalosis:
        return 'Kiềm chuyển hóa cấp';
      case ABGInterpretation.compensatedRespiratoryAcidosis:
        return 'Toan hô hấp có bù trừ';
      case ABGInterpretation.compensatedRespiratoryAlkalosis:
        return 'Kiềm hô hấp có bù trừ';
      case ABGInterpretation.compensatedMetabolicAcidosis:
        return 'Toan chuyển hóa có bù trừ';
      case ABGInterpretation.compensatedMetabolicAlkalosis:
        return 'Kiềm chuyển hóa có bù trừ';
      case ABGInterpretation.mixedDisorder:
        return 'Rối loạn hỗn hợp';
    }
  }

  String _getOxygenationText(OxygenationStatus status) {
    switch (status) {
      case OxygenationStatus.normal:
        return 'Oxy hóa bình thường';
      case OxygenationStatus.mildHypoxemia:
        return 'Thiếu oxy nhẹ';
      case OxygenationStatus.moderateHypoxemia:
        return 'Thiếu oxy vừa';
      case OxygenationStatus.severeHypoxemia:
        return 'Thiếu oxy nặng';
      case OxygenationStatus.normalWithSupplementalO2:
        return 'Oxy hóa tốt với O2 bổ sung';
    }
  }

  Color _getInterpretationColor(ABGInterpretation interpretation) {
    switch (interpretation) {
      case ABGInterpretation.normal:
        return Colors.green;
      case ABGInterpretation.compensatedRespiratoryAcidosis:
      case ABGInterpretation.compensatedRespiratoryAlkalosis:
      case ABGInterpretation.compensatedMetabolicAcidosis:
      case ABGInterpretation.compensatedMetabolicAlkalosis:
        return Colors.orange;
      case ABGInterpretation.respiratoryAcidosis:
      case ABGInterpretation.respiratoryAlkalosis:
      case ABGInterpretation.metabolicAcidosis:
      case ABGInterpretation.metabolicAlkalosis:
        return Colors.red;
      case ABGInterpretation.mixedDisorder:
        return Colors.purple;
    }
  }

  Color _getOxygenationColor(OxygenationStatus status) {
    switch (status) {
      case OxygenationStatus.normal:
      case OxygenationStatus.normalWithSupplementalO2:
        return Colors.green;
      case OxygenationStatus.mildHypoxemia:
        return Colors.orange;
      case OxygenationStatus.moderateHypoxemia:
        return Colors.red.shade400;
      case OxygenationStatus.severeHypoxemia:
        return Colors.red.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phân tích khí máu động mạch'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.local_hospital, color: AppColors.primary),
                        const SizedBox(width: 8),
                        const Text(
                          'Nhập kết quả ABG',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildNumberField(
                                  controller: _phController,
                                  label: 'pH',
                                  hint: '7.35-7.45',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập pH';
                                    }
                                    final ph = double.tryParse(value);
                                    if (ph == null || ph < 6.8 || ph > 8.0) {
                                      return 'pH không hợp lệ (6.8-8.0)';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildNumberField(
                                  controller: _pco2Controller,
                                  label: 'PCO₂ (mmHg)',
                                  hint: '35-45',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập PCO₂';
                                    }
                                    final pco2 = double.tryParse(value);
                                    if (pco2 == null || pco2 < 10 || pco2 > 150) {
                                      return 'PCO₂ không hợp lệ';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildNumberField(
                                  controller: _po2Controller,
                                  label: 'PO₂ (mmHg)',
                                  hint: '80-100',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập PO₂';
                                    }
                                    final po2 = double.tryParse(value);
                                    if (po2 == null || po2 < 20 || po2 > 600) {
                                      return 'PO₂ không hợp lệ';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildNumberField(
                                  controller: _hco3Controller,
                                  label: 'HCO₃⁻ (mEq/L)',
                                  hint: '22-26',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập HCO₃⁻';
                                    }
                                    final hco3 = double.tryParse(value);
                                    if (hco3 == null || hco3 < 5 || hco3 > 50) {
                                      return 'HCO₃⁻ không hợp lệ';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildNumberField(
                                  controller: _baseExcessController,
                                  label: 'Base Excess (mEq/L)',
                                  hint: '-2 đến +2',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập BE';
                                    }
                                    final be = double.tryParse(value);
                                    if (be == null || be < -30 || be > 30) {
                                      return 'BE không hợp lệ';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildNumberField(
                                  controller: _sao2Controller,
                                  label: 'SaO₂ (%)',
                                  hint: '95-100',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập SaO₂';
                                    }
                                    final sao2 = double.tryParse(value);
                                    if (sao2 == null || sao2 < 0 || sao2 > 100) {
                                      return 'SaO₂ không hợp lệ (0-100)';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildNumberField(
                            controller: _fio2Controller,
                            label: 'FiO₂ (%)',
                            hint: '21-100',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập FiO₂';
                              }
                              final fio2 = double.tryParse(value);
                              if (fio2 == null || fio2 < 21 || fio2 > 100) {
                                return 'FiO₂ không hợp lệ (21-100)';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
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
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _analyzeABG,
                                  icon: const Icon(Icons.analytics),
                                  label: const Text('Phân tích ABG'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.all(16),
                                  ),
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
            ),
            if (_showResults && _currentResult != null) ...[
              const SizedBox(height: 16),
              _buildResultsCard(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNumberField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      validator: validator,
    );
  }

  Widget _buildResultsCard() {
    final result = _currentResult!;
    final interpretation = result.acidBaseInterpretation;
    final oxygenation = result.oxygenationStatus;

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
            
            // Acid-Base Status
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getInterpretationColor(interpretation).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _getInterpretationColor(interpretation),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tình trạng Acid-Base',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _getInterpretationColor(interpretation),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getInterpretationText(interpretation),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Oxygenation Status
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getOxygenationColor(oxygenation).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _getOxygenationColor(oxygenation),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tình trạng Oxy hóa',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _getOxygenationColor(oxygenation),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getOxygenationText(oxygenation),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Calculated Values
            const Text(
              'Chỉ số tính toán',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            Row(
              children: [
                Expanded(
                  child: _buildCalculatedValue(
                    'P/F Ratio',
                    result.pfRatio.toStringAsFixed(1),
                    'mmHg',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildCalculatedValue(
                    'A-a Gradient',
                    result.aaGradient.toStringAsFixed(1),
                    'mmHg',
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Compensation Analysis
            if (interpretation != ABGInterpretation.normal) ...[
              const Text(
                'Phân tích bù trừ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              
              if (interpretation.toString().contains('metabolic')) ...[
                Text(
                  'PCO₂ dự kiến: ${result.expectedPco2ForMetabolicCompensation.toStringAsFixed(1)} ± 2 mmHg',
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  'PCO₂ thực tế: ${result.pco2.toStringAsFixed(1)} mmHg',
                  style: const TextStyle(fontSize: 14),
                ),
              ] else if (interpretation.toString().contains('respiratory')) ...[
                Text(
                  'HCO₃⁻ dự kiến: ${result.expectedHco3ForRespiratoryCompensation.toStringAsFixed(1)} mEq/L',
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  'HCO₃⁻ thực tế: ${result.hco3.toStringAsFixed(1)} mEq/L',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ],
            
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

  Widget _buildCalculatedValue(String label, String value, String unit) {
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
}
