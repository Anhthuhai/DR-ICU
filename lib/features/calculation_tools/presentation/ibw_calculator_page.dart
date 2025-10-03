import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/colors.dart';

class IBWCalculatorPage extends StatefulWidget {
  const IBWCalculatorPage({super.key});

  @override
  State<IBWCalculatorPage> createState() => _IBWCalculatorPageState();
}

class _IBWCalculatorPageState extends State<IBWCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _currentWeightController = TextEditingController();
  
  String _selectedGender = 'Nam';
  double? _ibw;
  double? _percentIBW;

  @override
  void dispose() {
    _heightController.dispose();
    _currentWeightController.dispose();
    super.dispose();
  }

  double _calculateIBW(double height, String gender) {
    // Convert height from cm to inches for calculation
    double heightInches = height / 2.54;
    
    // Devine formula
    if (gender == 'Nam') {
      return 50 + 2.3 * (heightInches - 60);
    } else {
      return 45.5 + 2.3 * (heightInches - 60);
    }
  }

  String _getIBWInterpretation(double percentIBW) {
    if (percentIBW < 80) {
      return 'Thiếu cân nghiêm trọng';
    } else if (percentIBW >= 80 && percentIBW < 90) {
      return 'Thiếu cân nhẹ';
    } else if (percentIBW >= 90 && percentIBW <= 110) {
      return 'Cân nặng lý tưởng';
    } else if (percentIBW > 110 && percentIBW <= 120) {
      return 'Thừa cân nhẹ';
    } else if (percentIBW > 120 && percentIBW <= 140) {
      return 'Thừa cân';
    } else {
      return 'Béo phì';
    }
  }

  Color _getInterpretationColor(double percentIBW) {
    if (percentIBW < 80 || percentIBW > 140) {
      return Colors.red;
    } else if ((percentIBW >= 80 && percentIBW < 90) || (percentIBW > 120 && percentIBW <= 140)) {
      return Colors.orange;
    } else if (percentIBW > 110 && percentIBW <= 120) {
      return Colors.yellow[700]!;
    } else {
      return Colors.green;
    }
  }

  void _calculateResult() {
    if (_formKey.currentState!.validate()) {
      final height = double.parse(_heightController.text);
      final currentWeight = double.parse(_currentWeightController.text);
      
      setState(() {
        _ibw = _calculateIBW(height, _selectedGender);
        _percentIBW = (currentWeight / _ibw!) * 100;
      });
    }
  }

  void _resetCalculation() {
    setState(() {
      _heightController.clear();
      _currentWeightController.clear();
      _selectedGender = 'Nam';
      _ibw = null;
      _percentIBW = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Tính IBW',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ideal Body Weight (IBW)',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tính toán cân nặng lý tưởng theo công thức Devine',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Input Form
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Height Input
                    TextFormField(
                      controller: _heightController,
                      decoration: InputDecoration(
                        labelText: 'Chiều cao (cm)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.height),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập chiều cao';
                        }
                        final height = double.tryParse(value);
                        if (height == null || height <= 0 || height > 250) {
                          return 'Chiều cao không hợp lệ (1-250 cm)';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (_ibw != null) {
                          _calculateResult();
                        }
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Current Weight Input
                    TextFormField(
                      controller: _currentWeightController,
                      decoration: InputDecoration(
                        labelText: 'Cân nặng hiện tại (kg)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.monitor_weight),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập cân nặng hiện tại';
                        }
                        final weight = double.tryParse(value);
                        if (weight == null || weight <= 0 || weight > 500) {
                          return 'Cân nặng không hợp lệ (1-500 kg)';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (_ibw != null) {
                          _calculateResult();
                        }
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Gender Selection
                    const Text(
                      'Giới tính',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedGender = 'Nam';
                                if (_ibw != null) {
                                  _calculateResult();
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _selectedGender == 'Nam' 
                                    ? AppColors.primary 
                                    : Colors.grey.shade300,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: _selectedGender == 'Nam' 
                                  ? AppColors.primary.withValues(alpha: 0.1)
                                  : Colors.transparent,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _selectedGender == 'Nam' 
                                      ? Icons.radio_button_checked 
                                      : Icons.radio_button_unchecked,
                                    color: _selectedGender == 'Nam' 
                                      ? AppColors.primary 
                                      : Colors.grey,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Nam',
                                    style: TextStyle(
                                      color: _selectedGender == 'Nam' 
                                        ? AppColors.primary 
                                        : Colors.black,
                                      fontWeight: _selectedGender == 'Nam' 
                                        ? FontWeight.w600 
                                        : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedGender = 'Nữ';
                                if (_ibw != null) {
                                  _calculateResult();
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _selectedGender == 'Nữ' 
                                    ? AppColors.primary 
                                    : Colors.grey.shade300,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: _selectedGender == 'Nữ' 
                                  ? AppColors.primary.withValues(alpha: 0.1)
                                  : Colors.transparent,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _selectedGender == 'Nữ' 
                                      ? Icons.radio_button_checked 
                                      : Icons.radio_button_unchecked,
                                    color: _selectedGender == 'Nữ' 
                                      ? AppColors.primary 
                                      : Colors.grey,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Nữ',
                                    style: TextStyle(
                                      color: _selectedGender == 'Nữ' 
                                        ? AppColors.primary 
                                        : Colors.black,
                                      fontWeight: _selectedGender == 'Nữ' 
                                        ? FontWeight.w600 
                                        : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Calculate Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculateResult,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'TÍNH TOÁN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Reset Button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: _resetCalculation,
                  child: const Text(
                    'RESET',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              
              if (_ibw != null && _percentIBW != null) ...[
                const SizedBox(height: 24),
                
                // Result Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'KẾT QUẢ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // IBW Result
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Cân nặng lý tưởng (IBW):',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${_ibw!.toStringAsFixed(1)} kg',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Percent IBW Result
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '% IBW:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${_percentIBW!.toStringAsFixed(1)}%',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Interpretation
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _getInterpretationColor(_percentIBW!).withValues(alpha: 0.1),
                          border: Border.all(
                            color: _getInterpretationColor(_percentIBW!).withValues(alpha: 0.3),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _getIBWInterpretation(_percentIBW!),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _getInterpretationColor(_percentIBW!),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Information Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border.all(color: Colors.blue.shade200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.blue.shade700,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'THÔNG TIN',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '• Công thức Devine (1974):\n'
                        '  - Nam: IBW = 50 + 2.3 × (chiều cao(inch) - 60)\n'
                        '  - Nữ: IBW = 45.5 + 2.3 × (chiều cao(inch) - 60)\n\n'
                        '• Phân loại theo % IBW:\n'
                        '  - < 80%: Thiếu cân nghiêm trọng\n'
                        '  - 80-89%: Thiếu cân nhẹ\n'
                        '  - 90-110%: Cân nặng lý tưởng\n'
                        '  - 111-120%: Thừa cân nhẹ\n'
                        '  - 121-140%: Thừa cân\n'
                        '  - > 140%: Béo phì',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
