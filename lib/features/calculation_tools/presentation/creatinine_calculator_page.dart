import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/colors.dart';
import 'dart:math' as math;

class CreatinineCalculatorPage extends StatefulWidget {
  const CreatinineCalculatorPage({super.key});

  @override
  State<CreatinineCalculatorPage> createState() => _CreatinineCalculatorPageState();
}

class _CreatinineCalculatorPageState extends State<CreatinineCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _creatinineController = TextEditingController();
  
  String _selectedGender = 'Nam';
  String _selectedFormula = 'Cockcroft-Gault';
  double? _creatinineClearance;
  String? _interpretation;
  
  final Map<String, String> _formulas = {
    'Cockcroft-Gault': 'Cockcroft-Gault',
    'MDRD': 'MDRD (Simplified)',
    'CKD-EPI': 'CKD-EPI',
  };

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _creatinineController.dispose();
    super.dispose();
  }

  double _calculateCreatinineClearance(int age, double weight, double creatinine, String gender, String formula) {
    switch (formula) {
      case 'Cockcroft-Gault':
        // CrCl = ((140 - age) × weight) / (72 × creatinine)
        // Multiply by 0.85 for females
        double clearance = ((140 - age) * weight) / (72 * creatinine);
        return gender == 'Nữ' ? clearance * 0.85 : clearance;
        
      case 'MDRD':
        // eGFR = 175 × (creatinine)^-1.154 × (age)^-0.203
        // Multiply by 0.742 for females
        double egfr = (175 * math.pow(creatinine, -1.154) * math.pow(age.toDouble(), -0.203)).toDouble();
        return gender == 'Nữ' ? egfr * 0.742 : egfr;
        
      case 'CKD-EPI':
        // Simplified CKD-EPI equation
        double kappa = gender == 'Nữ' ? 0.7 : 0.9;
        double alpha = gender == 'Nữ' ? -0.329 : -0.411;
        double genderFactor = gender == 'Nữ' ? 1.018 : 1.0;
        
        double egfr = (141 * math.pow(math.min(creatinine / kappa, 1), alpha) * 
                      math.pow(math.max(creatinine / kappa, 1), -1.209) * 
                      math.pow(0.993, age.toDouble()) * genderFactor).toDouble();
        return egfr;
        
      default:
        return 0;
    }
  }

  String _getInterpretation(double clearance, String formula) {
    if (formula == 'Cockcroft-Gault') {
      if (clearance >= 90) {
        return 'Bình thường (≥ 90 mL/min)';
      } else if (clearance >= 60) {
        return 'Giảm nhẹ (60-89 mL/min)';
      } else if (clearance >= 30) {
        return 'Giảm vừa (30-59 mL/min)';
      } else if (clearance >= 15) {
        return 'Giảm nặng (15-29 mL/min)';
      } else {
        return 'Suy thận giai đoạn cuối (< 15 mL/min)';
      }
    } else {
      // For MDRD and CKD-EPI (eGFR)
      if (clearance >= 90) {
        return 'Bình thường (≥ 90 mL/min/1.73m²)';
      } else if (clearance >= 60) {
        return 'Giảm nhẹ (60-89 mL/min/1.73m²)';
      } else if (clearance >= 30) {
        return 'Giảm vừa (30-59 mL/min/1.73m²)';
      } else if (clearance >= 15) {
        return 'Giảm nặng (15-29 mL/min/1.73m²)';
      } else {
        return 'Suy thận giai đoạn cuối (< 15 mL/min/1.73m²)';
      }
    }
  }

  Color _getInterpretationColor(double clearance) {
    if (clearance >= 90) {
      return Colors.green;
    } else if (clearance >= 60) {
      return Colors.yellow[700]!;
    } else if (clearance >= 30) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  void _calculateResult() {
    if (_formKey.currentState!.validate()) {
      final age = int.parse(_ageController.text);
      final weight = double.parse(_weightController.text);
      final creatinine = double.parse(_creatinineController.text);
      
      setState(() {
        _creatinineClearance = _calculateCreatinineClearance(age, weight, creatinine, _selectedGender, _selectedFormula);
        _interpretation = _getInterpretation(_creatinineClearance!, _selectedFormula);
      });
    }
  }

  void _resetCalculation() {
    setState(() {
      _ageController.clear();
      _weightController.clear();
      _creatinineController.clear();
      _selectedGender = 'Nam';
      _selectedFormula = 'Cockcroft-Gault';
      _creatinineClearance = null;
      _interpretation = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Tính Creatinine Clearance',
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
                      'Creatinine Clearance / eGFR',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Đánh giá chức năng thận qua độ thanh thải creatinine',
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
                    // Age Input
                    TextFormField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        labelText: 'Tuổi',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.cake),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập tuổi';
                        }
                        final age = int.tryParse(value);
                        if (age == null || age < 1 || age > 120) {
                          return 'Tuổi không hợp lệ (1-120)';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (_creatinineClearance != null) {
                          _calculateResult();
                        }
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Weight Input
                    TextFormField(
                      controller: _weightController,
                      decoration: InputDecoration(
                        labelText: 'Cân nặng (kg)',
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
                          return 'Vui lòng nhập cân nặng';
                        }
                        final weight = double.tryParse(value);
                        if (weight == null || weight <= 0 || weight > 500) {
                          return 'Cân nặng không hợp lệ (1-500 kg)';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (_creatinineClearance != null) {
                          _calculateResult();
                        }
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Creatinine Input
                    TextFormField(
                      controller: _creatinineController,
                      decoration: InputDecoration(
                        labelText: 'Creatinine huyết thanh (mg/dL)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.bloodtype),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập Creatinine';
                        }
                        final creatinine = double.tryParse(value);
                        if (creatinine == null || creatinine <= 0 || creatinine > 20) {
                          return 'Creatinine không hợp lệ (0.1-20 mg/dL)';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (_creatinineClearance != null) {
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
                                if (_creatinineClearance != null) {
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
                                if (_creatinineClearance != null) {
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
                    
                    const SizedBox(height: 16),
                    
                    // Formula Selection
                    const Text(
                      'Công thức tính',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedFormula,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.calculate),
                      ),
                      items: _formulas.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedFormula = value!;
                          if (_creatinineClearance != null) {
                            _calculateResult();
                          }
                        });
                      },
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
              
              if (_creatinineClearance != null) ...[
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
                      
                      // Result Value
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_formulas[_selectedFormula]}:',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${_creatinineClearance!.toStringAsFixed(1)} ${_selectedFormula == 'Cockcroft-Gault' ? 'mL/min' : 'mL/min/1.73m²'}',
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
                          color: _getInterpretationColor(_creatinineClearance!).withValues(alpha: 0.1),
                          border: Border.all(
                            color: _getInterpretationColor(_creatinineClearance!).withValues(alpha: 0.3),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _interpretation!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _getInterpretationColor(_creatinineClearance!),
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
                            'THÔNG TIN CÔNG THỨC',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _getFormulaInfo(_selectedFormula),
                        style: const TextStyle(
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

  String _getFormulaInfo(String formula) {
    switch (formula) {
      case 'Cockcroft-Gault':
        return '• Cockcroft-Gault (1976):\n'
               '  CrCl = ((140 - tuổi) × cân nặng) / (72 × creatinine)\n'
               '  Nhân với 0.85 nếu là nữ\n\n'
               '• Ưu điểm: Đơn giản, phổ biến\n'
               '• Nhược điểm: Kém chính xác ở người béo phì\n'
               '• Đơn vị: mL/min';
               
      case 'MDRD':
        return '• MDRD Simplified (1999):\n'
               '  eGFR = 175 × (Cr)^-1.154 × (tuổi)^-0.203\n'
               '  Nhân với 0.742 nếu là nữ\n\n'
               '• Ưu điểm: Chính xác hơn Cockcroft-Gault\n'
               '• Nhược điểm: Kém chính xác khi eGFR > 60\n'
               '• Đơn vị: mL/min/1.73m²';
               
      case 'CKD-EPI':
        return '• CKD-EPI (2009):\n'
               '  Công thức phức tạp dựa trên tuổi, giới tính, creatinine\n\n'
               '• Ưu điểm: Chính xác nhất, đặc biệt khi eGFR > 60\n'
               '• Được khuyến cáo sử dụng hiện tại\n'
               '• Đơn vị: mL/min/1.73m²';
               
      default:
        return '';
    }
  }
}