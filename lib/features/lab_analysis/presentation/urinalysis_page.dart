import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/colors.dart';
import '../domain/entities/urinalysis_result.dart';

class UrinalysisPage extends StatefulWidget {
  const UrinalysisPage({super.key});

  @override
  State<UrinalysisPage> createState() => _UrinalysisPageState();
}

class _UrinalysisPageState extends State<UrinalysisPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for physical properties
  final _specificGravityController = TextEditingController();
  final _phController = TextEditingController();
  
  // Controllers for microscopic analysis
  final _rbcController = TextEditingController();
  final _wbcController = TextEditingController();
  final _epithelialController = TextEditingController();
  final _bacteriaController = TextEditingController();
  final _castsController = TextEditingController();
  final _crystalsController = TextEditingController();
  
  final _notesController = TextEditingController();
  
  // Dropdown selections
  UrineColor _selectedColor = UrineColor.yellow;
  UrineClarity _selectedClarity = UrineClarity.clear;
  UrineProtein _selectedProtein = UrineProtein.negative;
  UrineGlucose _selectedGlucose = UrineGlucose.negative;
  UrineKetones _selectedKetones = UrineKetones.negative;
  UrineBlood _selectedBlood = UrineBlood.negative;
  UrineLeukocytes _selectedLeukocytes = UrineLeukocytes.negative;
  UrineNitrites _selectedNitrites = UrineNitrites.negative;
  UrineBilirubin _selectedBilirubin = UrineBilirubin.negative;
  UrineUrobilinogen _selectedUrobilinogen = UrineUrobilinogen.normal;
  
  UrinalysisResult? _currentResult;
  bool _showResults = false;

  @override
  void dispose() {
    _specificGravityController.dispose();
    _phController.dispose();
    _rbcController.dispose();
    _wbcController.dispose();
    _epithelialController.dispose();
    _bacteriaController.dispose();
    _castsController.dispose();
    _crystalsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _analyzeUrine() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _currentResult = UrinalysisResult(
          color: _selectedColor,
          clarity: _selectedClarity,
          specificGravity: double.parse(_specificGravityController.text),
          ph: double.parse(_phController.text),
          protein: _selectedProtein,
          glucose: _selectedGlucose,
          ketones: _selectedKetones,
          blood: _selectedBlood,
          leukocytes: _selectedLeukocytes,
          nitrites: _selectedNitrites,
          bilirubin: _selectedBilirubin,
          urobilinogen: _selectedUrobilinogen,
          rbcCount: _rbcController.text.isNotEmpty 
              ? int.parse(_rbcController.text) : null,
          wbcCount: _wbcController.text.isNotEmpty 
              ? int.parse(_wbcController.text) : null,
          epithelialCells: _epithelialController.text.isNotEmpty 
              ? int.parse(_epithelialController.text) : null,
          bacteria: _bacteriaController.text.isNotEmpty 
              ? int.parse(_bacteriaController.text) : null,
          casts: _castsController.text.isNotEmpty 
              ? int.parse(_castsController.text) : null,
          crystals: _crystalsController.text.isNotEmpty 
              ? int.parse(_crystalsController.text) : null,
          timestamp: DateTime.now(),
          notes: _notesController.text.isNotEmpty ? _notesController.text : null,
        );
        _showResults = true;
      });
    }
  }

  void _clearForm() {
    setState(() {
      _specificGravityController.clear();
      _phController.clear();
      _rbcController.clear();
      _wbcController.clear();
      _epithelialController.clear();
      _bacteriaController.clear();
      _castsController.clear();
      _crystalsController.clear();
      _notesController.clear();
      
      _selectedColor = UrineColor.yellow;
      _selectedClarity = UrineClarity.clear;
      _selectedProtein = UrineProtein.negative;
      _selectedGlucose = UrineGlucose.negative;
      _selectedKetones = UrineKetones.negative;
      _selectedBlood = UrineBlood.negative;
      _selectedLeukocytes = UrineLeukocytes.negative;
      _selectedNitrites = UrineNitrites.negative;
      _selectedBilirubin = UrineBilirubin.negative;
      _selectedUrobilinogen = UrineUrobilinogen.normal;
      
      _currentResult = null;
      _showResults = false;
    });
  }

  String _getUrinalysisTypeText(UrinalysisType type) {
    switch (type) {
      case UrinalysisType.normal:
        return 'Bình thường';
      case UrinalysisType.uti:
        return 'Nhiễm khuẩn đường tiểu';
      case UrinalysisType.kidney_disease:
        return 'Bệnh thận';
      case UrinalysisType.diabetes:
        return 'Đái tháo đường';
      case UrinalysisType.liver_disease:
        return 'Bệnh gan';
      case UrinalysisType.dehydration:
        return 'Mất nước';
      case UrinalysisType.hematuria:
        return 'Hematuria';
      case UrinalysisType.proteinuria:
        return 'Proteinuria';
      case UrinalysisType.glycosuria:
        return 'Glycosuria';
      case UrinalysisType.ketonuria:
        return 'Ketonuria';
    }
  }

  String _getCauseText(UrinalysisCause cause) {
    switch (cause) {
      case UrinalysisCause.normal:
        return 'Bình thường';
      case UrinalysisCause.bacterial_uti:
        return 'Nhiễm khuẩn đường tiểu';
      case UrinalysisCause.acute_cystitis:
        return 'Viêm bàng quang cấp';
      case UrinalysisCause.pyelonephritis:
        return 'Viêm thận bể thận';
      case UrinalysisCause.diabetes_mellitus:
        return 'Đái tháo đường';
      case UrinalysisCause.diabetic_ketoacidosis:
        return 'Coma nhiễm toan do đái tháo đường';
      case UrinalysisCause.diabetic_nephropathy:
        return 'Bệnh thận do đái tháo đường';
      case UrinalysisCause.glomerulonephritis:
        return 'Viêm cầu thận';
      case UrinalysisCause.nephrotic_syndrome:
        return 'Hội chứng thận hư';
      case UrinalysisCause.acute_kidney_injury:
        return 'Suy thận cấp';
      case UrinalysisCause.chronic_kidney_disease:
        return 'Bệnh thận mạn';
      case UrinalysisCause.hepatitis:
        return 'Viêm gan';
      case UrinalysisCause.cirrhosis:
        return 'Xơ gan';
      case UrinalysisCause.biliary_obstruction:
        return 'Tắc mật';
      case UrinalysisCause.kidney_stones:
        return 'Sỏi thận';
      case UrinalysisCause.bladder_cancer:
        return 'Ung thư bàng quang';
      case UrinalysisCause.kidney_cancer:
        return 'Ung thư thận';
      case UrinalysisCause.rhabdomyolysis:
        return 'Tan rã cơ vân';
      case UrinalysisCause.dehydration_concentrated:
        return 'Nước tiểu cô đặc do mất nước';
      default:
        return cause.toString().replaceAll('_', ' ');
    }
  }

  String _getColorText(UrineColor color) {
    switch (color) {
      case UrineColor.pale_yellow:
        return 'Vàng nhạt';
      case UrineColor.yellow:
        return 'Vàng';
      case UrineColor.dark_yellow:
        return 'Vàng đậm';
      case UrineColor.amber:
        return 'Hổ phách';
      case UrineColor.red:
        return 'Đỏ';
      case UrineColor.brown:
        return 'Nâu';
      case UrineColor.green:
        return 'Xanh lá';
      case UrineColor.blue:
        return 'Xanh dương';
      case UrineColor.colorless:
        return 'Không màu';
    }
  }

  String _getClarityText(UrineClarity clarity) {
    switch (clarity) {
      case UrineClarity.clear:
        return 'Trong';
      case UrineClarity.slightly_cloudy:
        return 'Hơi đục';
      case UrineClarity.cloudy:
        return 'Đục';
      case UrineClarity.turbid:
        return 'Rất đục';
    }
  }

  String _getProteinText(UrineProtein protein) {
    switch (protein) {
      case UrineProtein.negative:
        return 'Âm tính';
      case UrineProtein.trace:
        return 'Trace';
      case UrineProtein.plus_1:
        return '+1';
      case UrineProtein.plus_2:
        return '+2';
      case UrineProtein.plus_3:
        return '+3';
      case UrineProtein.plus_4:
        return '+4';
    }
  }

  String _getGlucoseText(UrineGlucose glucose) {
    switch (glucose) {
      case UrineGlucose.negative:
        return 'Âm tính';
      case UrineGlucose.trace:
        return 'Trace';
      case UrineGlucose.plus_1:
        return '+1';
      case UrineGlucose.plus_2:
        return '+2';
      case UrineGlucose.plus_3:
        return '+3';
      case UrineGlucose.plus_4:
        return '+4';
    }
  }

  String _getKetonesText(UrineKetones ketones) {
    switch (ketones) {
      case UrineKetones.negative:
        return 'Âm tính';
      case UrineKetones.trace:
        return 'Trace';
      case UrineKetones.small:
        return 'Nhỏ';
      case UrineKetones.moderate:
        return 'Vừa';
      case UrineKetones.large:
        return 'Lớn';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phân tích nước tiểu'),
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
                      Icon(Icons.opacity, 
                           size: 48, 
                           color: AppColors.primary),
                      const SizedBox(height: 8),
                      const Text(
                        'Phân tích nước tiểu',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Chẩn đoán nhiễm khuẩn, bệnh thận, đái tháo đường',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              if (!_showResults) ...[
                // Physical Properties Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.visibility, color: AppColors.primary),
                            const SizedBox(width: 8),
                            const Text(
                              'Tính chất vật lý',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Color and Clarity row
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<UrineColor>(
                                initialValue: _selectedColor,
                                decoration: const InputDecoration(
                                  labelText: 'Màu sắc',
                                  border: OutlineInputBorder(),
                                ),
                                items: UrineColor.values.map((color) {
                                  return DropdownMenuItem(
                                    value: color,
                                    child: Text(_getColorText(color)),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedColor = value!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: DropdownButtonFormField<UrineClarity>(
                                initialValue: _selectedClarity,
                                decoration: const InputDecoration(
                                  labelText: 'Độ trong',
                                  border: OutlineInputBorder(),
                                ),
                                items: UrineClarity.values.map((clarity) {
                                  return DropdownMenuItem(
                                    value: clarity,
                                    child: Text(_getClarityText(clarity)),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedClarity = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Specific Gravity and pH row
                        Row(
                          children: [
                            Expanded(
                              child: _buildNumberField(
                                controller: _specificGravityController,
                                label: 'Tỷ trọng *',
                                hint: '1.003-1.030',
                                validator: _validateRequiredNumber,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildNumberField(
                                controller: _phController,
                                label: 'pH *',
                                hint: '4.5-8.0',
                                validator: _validateRequiredNumber,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Chemical Analysis Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.science, color: AppColors.secondary),
                            const SizedBox(width: 8),
                            const Text(
                              'Phân tích hóa học',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // First row - Protein and Glucose
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<UrineProtein>(
                                initialValue: _selectedProtein,
                                decoration: const InputDecoration(
                                  labelText: 'Protein',
                                  border: OutlineInputBorder(),
                                ),
                                items: UrineProtein.values.map((protein) {
                                  return DropdownMenuItem(
                                    value: protein,
                                    child: Text(_getProteinText(protein)),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedProtein = value!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: DropdownButtonFormField<UrineGlucose>(
                                initialValue: _selectedGlucose,
                                decoration: const InputDecoration(
                                  labelText: 'Glucose',
                                  border: OutlineInputBorder(),
                                ),
                                items: UrineGlucose.values.map((glucose) {
                                  return DropdownMenuItem(
                                    value: glucose,
                                    child: Text(_getGlucoseText(glucose)),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGlucose = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Second row - Ketones and Blood
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<UrineKetones>(
                                initialValue: _selectedKetones,
                                decoration: const InputDecoration(
                                  labelText: 'Ketones',
                                  border: OutlineInputBorder(),
                                ),
                                items: UrineKetones.values.map((ketones) {
                                  return DropdownMenuItem(
                                    value: ketones,
                                    child: Text(_getKetonesText(ketones)),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedKetones = value!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: DropdownButtonFormField<UrineBlood>(
                                initialValue: _selectedBlood,
                                decoration: const InputDecoration(
                                  labelText: 'Blood',
                                  border: OutlineInputBorder(),
                                ),
                                items: UrineBlood.values.map((blood) {
                                  return DropdownMenuItem(
                                    value: blood,
                                    child: Text(_getProteinText(UrineProtein.values[blood.index])),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedBlood = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Third row - Leukocytes and Nitrites
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<UrineLeukocytes>(
                                initialValue: _selectedLeukocytes,
                                decoration: const InputDecoration(
                                  labelText: 'Leukocytes',
                                  border: OutlineInputBorder(),
                                ),
                                items: UrineLeukocytes.values.map((leukocytes) {
                                  return DropdownMenuItem(
                                    value: leukocytes,
                                    child: Text(_getProteinText(UrineProtein.values[leukocytes.index])),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedLeukocytes = value!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: DropdownButtonFormField<UrineNitrites>(
                                initialValue: _selectedNitrites,
                                decoration: const InputDecoration(
                                  labelText: 'Nitrites',
                                  border: OutlineInputBorder(),
                                ),
                                items: UrineNitrites.values.map((nitrites) {
                                  return DropdownMenuItem(
                                    value: nitrites,
                                    child: Text(nitrites == UrineNitrites.negative ? 'Âm tính' : 'Dương tính'),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedNitrites = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Fourth row - Bilirubin and Urobilinogen
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<UrineBilirubin>(
                                initialValue: _selectedBilirubin,
                                decoration: const InputDecoration(
                                  labelText: 'Bilirubin',
                                  border: OutlineInputBorder(),
                                ),
                                items: UrineBilirubin.values.map((bilirubin) {
                                  return DropdownMenuItem(
                                    value: bilirubin,
                                    child: Text(_getProteinText(UrineProtein.values[bilirubin.index])),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedBilirubin = value!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: DropdownButtonFormField<UrineUrobilinogen>(
                                initialValue: _selectedUrobilinogen,
                                decoration: const InputDecoration(
                                  labelText: 'Urobilinogen',
                                  border: OutlineInputBorder(),
                                ),
                                items: UrineUrobilinogen.values.map((urobilinogen) {
                                  return DropdownMenuItem(
                                    value: urobilinogen,
                                    child: Text(urobilinogen == UrineUrobilinogen.normal ? 'Bình thường' : 'Cao'),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedUrobilinogen = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Microscopic Analysis Card (Optional)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.zoom_in, color: AppColors.secondary),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Phân tích kính hiển vi (Tùy chọn)',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // First row - RBC and WBC
                        Row(
                          children: [
                            Expanded(
                              child: _buildNumberField(
                                controller: _rbcController,
                                label: 'Hồng cầu (/hpf)',
                                hint: '0-2',
                                validator: _validateOptionalNumber,
                                isInteger: true,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildNumberField(
                                controller: _wbcController,
                                label: 'Bạch cầu (/hpf)',
                                hint: '0-5',
                                validator: _validateOptionalNumber,
                                isInteger: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Second row - Epithelial cells and Bacteria
                        Row(
                          children: [
                            Expanded(
                              child: _buildNumberField(
                                controller: _epithelialController,
                                label: 'Tế bào biểu mô (/hpf)',
                                hint: '0-5',
                                validator: _validateOptionalNumber,
                                isInteger: true,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildNumberField(
                                controller: _bacteriaController,
                                label: 'Vi khuẩn (/hpf)',
                                hint: 'Ít/Nhiều',
                                validator: _validateOptionalNumber,
                                isInteger: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Third row - Casts and Crystals
                        Row(
                          children: [
                            Expanded(
                              child: _buildNumberField(
                                controller: _castsController,
                                label: 'Trụ (/lpf)',
                                hint: '0-1',
                                validator: _validateOptionalNumber,
                                isInteger: true,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildNumberField(
                                controller: _crystalsController,
                                label: 'Tinh thể (/hpf)',
                                hint: 'Ít/Nhiều',
                                validator: _validateOptionalNumber,
                                isInteger: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Notes Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.note_add, color: Colors.grey[600]),
                            const SizedBox(width: 8),
                            const Text(
                              'Ghi chú (Tùy chọn)',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _notesController,
                          decoration: const InputDecoration(
                            hintText: 'Nhập ghi chú thêm...',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Analyze button
                ElevatedButton(
                  onPressed: _analyzeUrine,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.analytics),
                      SizedBox(width: 8),
                      Text(
                        'Phân tích nước tiểu',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
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

  // Validators
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

  String? _validateOptionalNumber(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Optional field
    }
    final number = double.tryParse(value);
    if (number == null || number < 0) {
      return 'Giá trị không hợp lệ';
    }
    return null;
  }

  Widget _buildResultsCard() {
    final result = _currentResult!;
    final urinalysisType = result.urinalysisType;
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
            
            // Main diagnosis
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getTypeColor(urinalysisType).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _getTypeColor(urinalysisType),
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getTypeIcon(urinalysisType),
                        color: _getTypeColor(urinalysisType),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _getUrinalysisTypeText(urinalysisType),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _getTypeColor(urinalysisType),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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

  Color _getTypeColor(UrinalysisType type) {
    switch (type) {
      case UrinalysisType.normal:
        return Colors.green;
      case UrinalysisType.uti:
        return Colors.red;
      case UrinalysisType.kidney_disease:
        return Colors.purple;
      case UrinalysisType.diabetes:
        return Colors.orange;
      case UrinalysisType.liver_disease:
        return Colors.brown;
      case UrinalysisType.hematuria:
        return Colors.red.shade700;
      case UrinalysisType.proteinuria:
        return Colors.purple.shade700;
      case UrinalysisType.glycosuria:
        return Colors.orange.shade700;
      case UrinalysisType.ketonuria:
        return Colors.pink;
      case UrinalysisType.dehydration:
        return Colors.amber;
    }
  }

  IconData _getTypeIcon(UrinalysisType type) {
    switch (type) {
      case UrinalysisType.normal:
        return Icons.check_circle;
      case UrinalysisType.uti:
        return Icons.dangerous;
      case UrinalysisType.kidney_disease:
        return Icons.healing;
      case UrinalysisType.diabetes:
        return Icons.health_and_safety;
      case UrinalysisType.liver_disease:
        return Icons.local_hospital;
      case UrinalysisType.hematuria:
        return Icons.bloodtype;
      case UrinalysisType.proteinuria:
        return Icons.water_drop;
      case UrinalysisType.glycosuria:
        return Icons.gradient;
      case UrinalysisType.ketonuria:
        return Icons.science;
      case UrinalysisType.dehydration:
        return Icons.dry;
    }
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
}
