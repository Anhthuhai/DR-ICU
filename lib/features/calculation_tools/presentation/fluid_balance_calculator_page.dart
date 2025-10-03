import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/colors.dart';

class FluidBalanceCalculatorPage extends StatefulWidget {
  const FluidBalanceCalculatorPage({super.key});

  @override
  State<FluidBalanceCalculatorPage> createState() => _FluidBalanceCalculatorPageState();
}

class _FluidBalanceCalculatorPageState extends State<FluidBalanceCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Input Controllers
  final _oralIntakeController = TextEditingController();
  final _ivFluidController = TextEditingController();
  final _bloodProductsController = TextEditingController();
  final _medicationController = TextEditingController();
  final _feedingController = TextEditingController();
  final _otherIntakeController = TextEditingController();
  
  final _urineOutputController = TextEditingController();
  final _drainageController = TextEditingController();
  final _nasogastricController = TextEditingController();
  final _stoolController = TextEditingController();
  final _insensibleController = TextEditingController();
  final _otherOutputController = TextEditingController();
  
  // Patient info for insensible loss calculation
  final _weightController = TextEditingController();
  final _temperatureController = TextEditingController();
  
  bool _useCalculatedInsensible = true;

  // Results
  double? _totalIntake;
  double? _totalOutput;
  double? _fluidBalance;
  String? _interpretation;

  @override
  void dispose() {
    _oralIntakeController.dispose();
    _ivFluidController.dispose();
    _bloodProductsController.dispose();
    _medicationController.dispose();
    _feedingController.dispose();
    _otherIntakeController.dispose();
    _urineOutputController.dispose();
    _drainageController.dispose();
    _nasogastricController.dispose();
    _stoolController.dispose();
    _insensibleController.dispose();
    _otherOutputController.dispose();
    _weightController.dispose();
    _temperatureController.dispose();
    super.dispose();
  }

  double _parseInput(String value) {
    return value.isEmpty ? 0.0 : double.tryParse(value) ?? 0.0;
  }

  double _calculateInsensibleLoss() {
    if (!_useCalculatedInsensible) return 0.0;
    
    double weight = _parseInput(_weightController.text);
    double temperature = _parseInput(_temperatureController.text);
    
    if (weight == 0) return 500.0; // Default if no weight
    
    // Base insensible loss: 15ml/kg/day (skin + respiratory)
    double baseLoss = weight * 15;
    
    // Fever adjustment: +13% per degree above 37°C
    if (temperature > 37.0) {
      double feverIncrease = (temperature - 37.0) * 0.13;
      baseLoss = baseLoss * (1 + feverIncrease);
    }
    
    return baseLoss;
  }

  void _updateInsensibleLoss() {
    if (_useCalculatedInsensible) {
      double calculatedLoss = _calculateInsensibleLoss();
      _insensibleController.text = calculatedLoss.toStringAsFixed(0);
    }
  }

  void _calculateFluidBalance() {
    if (_formKey.currentState!.validate()) {
      // Calculate total intake
      double totalIntake = _parseInput(_oralIntakeController.text) +
                          _parseInput(_ivFluidController.text) +
                          _parseInput(_bloodProductsController.text) +
                          _parseInput(_medicationController.text) +
                          _parseInput(_feedingController.text) +
                          _parseInput(_otherIntakeController.text);

      // Calculate total output
      double totalOutput = _parseInput(_urineOutputController.text) +
                          _parseInput(_drainageController.text) +
                          _parseInput(_nasogastricController.text) +
                          _parseInput(_stoolController.text) +
                          _parseInput(_insensibleController.text) +
                          _parseInput(_otherOutputController.text);

      // Calculate fluid balance
      double fluidBalance = totalIntake - totalOutput;

      setState(() {
        _totalIntake = totalIntake;
        _totalOutput = totalOutput;
        _fluidBalance = fluidBalance;
        _interpretation = _getFluidBalanceInterpretation(fluidBalance);
      });
    }
  }

  String _getFluidBalanceInterpretation(double balance) {
    if (balance > 1000) {
      return 'Dương tính đáng kể (>1000ml)';
    } else if (balance > 500) {
      return 'Dương tính vừa phải (500-1000ml)';
    } else if (balance >= -500) {
      return 'Cân bằng gần như bằng nhau (±500ml)';
    } else if (balance >= -1000) {
      return 'Âm tính vừa phải (-500 đến -1000ml)';
    } else {
      return 'Âm tính đáng kể (<-1000ml)';
    }
  }

  Color _getFluidBalanceColor(double balance) {
    if (balance > 1000 || balance < -1000) {
      return Colors.red.shade300;
    } else if (balance > 500 || balance < -500) {
      return Colors.orange.shade300;
    } else {
      return Colors.green.shade300;
    }
  }

  List<String> _getFluidBalanceRecommendations(double balance) {
    List<String> recommendations = [];
    
    if (balance > 1000) {
      recommendations.addAll([
        '• Cân nhắc giảm lượng dịch truyền',
        '• Đánh giá chức năng tim, thận',
        '• Theo dõi dấu hiệu quá tải dịch',
        '• Cân nhắc sử dụng lợi tiểu',
        '• Kiểm tra phù, khó thở',
      ]);
    } else if (balance > 500) {
      recommendations.addAll([
        '• Theo dõi cân bằng dịch chặt chẽ',
        '• Đánh giá tình trạng tim mạch',
        '• Cân nhắc điều chỉnh dịch truyền',
        '• Theo dõi diuresis',
      ]);
    } else if (balance >= -500) {
      recommendations.addAll([
        '• Cân bằng dịch trong giới hạn bình thường',
        '• Tiếp tục theo dõi',
        '• Duy trì chế độ dịch hiện tại',
        '• Đánh giá định kỳ',
      ]);
    } else if (balance >= -1000) {
      recommendations.addAll([
        '• Cân nhắc tăng lượng dịch truyền',
        '• Đánh giá nguyên nhân mất dịch',
        '• Theo dõi dấu hiệu thiếu dịch',
        '• Kiểm tra huyết áp, mạch',
      ]);
    } else {
      recommendations.addAll([
        '• Cần bù dịch tích cực',
        '• Đánh giá nguyên nhân mất dịch nghiêm trọng',
        '• Theo dõi dấu hiệu sốc thiếu dịch',
        '• Cân nhắc bù dịch nhanh',
        '• Theo dõi y tế chặt chẽ',
      ]);
    }
    
    recommendations.addAll([
      '• Cân bằng dịch là chỉ số quan trọng trong ICU',
      '• Cần theo dõi 24h liên tục',
      '• Kết hợp với các chỉ số khác (CVP, PCWP)',
    ]);
    
    return recommendations;
  }

  void _clearForm() {
    setState(() {
      _oralIntakeController.clear();
      _ivFluidController.clear();
      _bloodProductsController.clear();
      _medicationController.clear();
      _feedingController.clear();
      _otherIntakeController.clear();
      _urineOutputController.clear();
      _drainageController.clear();
      _nasogastricController.clear();
      _stoolController.clear();
      _insensibleController.clear();
      _otherOutputController.clear();
      _weightController.clear();
      _temperatureController.clear();
      _totalIntake = null;
      _totalOutput = null;
      _fluidBalance = null;
      _interpretation = null;
    });
  }

  Widget _buildInputField(String label, TextEditingController controller, IconData icon, {String? hint}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        ],
        decoration: InputDecoration(
          labelText: label,
          hintText: hint ?? 'ml',
          border: const OutlineInputBorder(),
          prefixIcon: Icon(icon, size: 20),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        validator: (value) {
          if (value != null && value.isNotEmpty) {
            final number = double.tryParse(value);
            if (number == null || number < 0 || number > 10000) {
              return 'Nhập 0-10000 ml';
            }
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fluid Balance Calculator'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Patient Info Section for Insensible Loss Calculation
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person, color: AppColors.primary),
                          const SizedBox(width: 8),
                          const Text(
                            'Thông tin bệnh nhân (để tính insensible loss)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _weightController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Cân nặng (kg)',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.monitor_weight, size: 20),
                              ),
                              onChanged: (value) => _updateInsensibleLoss(),
                              validator: (value) {
                                if (value != null && value.isNotEmpty) {
                                  final weight = double.tryParse(value);
                                  if (weight == null || weight < 10 || weight > 200) {
                                    return 'Cân nặng 10-200 kg';
                                  }
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _temperatureController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Nhiệt độ (°C)',
                                hintText: '37.0',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.thermostat, size: 20),
                              ),
                              onChanged: (value) => _updateInsensibleLoss(),
                              validator: (value) {
                                if (value != null && value.isNotEmpty) {
                                  final temp = double.tryParse(value);
                                  if (temp == null || temp < 30 || temp > 45) {
                                    return 'Nhiệt độ 30-45°C';
                                  }
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
                          Checkbox(
                            value: _useCalculatedInsensible,
                            onChanged: (value) {
                              setState(() {
                                _useCalculatedInsensible = value ?? true;
                                if (_useCalculatedInsensible) {
                                  _updateInsensibleLoss();
                                } else {
                                  _insensibleController.clear();
                                }
                              });
                            },
                          ),
                          const Expanded(
                            child: Text(
                              'Tự động tính insensible loss theo cân nặng và sốt',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      
                      if (_useCalculatedInsensible && _weightController.text.isNotEmpty) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue.shade200),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tính toán insensible loss:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '• Base: 15ml/kg/24h = ${(_parseInput(_weightController.text) * 15).toStringAsFixed(0)}ml',
                                style: const TextStyle(fontSize: 12),
                              ),
                              if (_parseInput(_temperatureController.text) > 37.0) ...[
                                Text(
                                  '• Sốt +${((_parseInput(_temperatureController.text) - 37.0) * 13).toStringAsFixed(0)}% = +${((_parseInput(_weightController.text) * 15) * (_parseInput(_temperatureController.text) - 37.0) * 0.13).toStringAsFixed(0)}ml',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                              Text(
                                '• Tổng: ${_calculateInsensibleLoss().toStringAsFixed(0)}ml',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
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
              
              const SizedBox(height: 16),
              
              // Intake Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.input, color: Colors.blue.shade600),
                          const SizedBox(width: 8),
                          const Text(
                            'INTAKE (Dịch vào)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      _buildInputField('Uống miệng', _oralIntakeController, Icons.local_drink),
                      _buildInputField('Dịch truyền tĩnh mạch', _ivFluidController, Icons.water_drop),
                      _buildInputField('Chế phẩm máu', _bloodProductsController, Icons.bloodtype),
                      _buildInputField('Thuốc (dịch)', _medicationController, Icons.medication),
                      _buildInputField('Dinh dưỡng (qua ống)', _feedingController, Icons.dining),
                      _buildInputField('Khác', _otherIntakeController, Icons.add_circle_outline),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Output Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.output, color: Colors.red.shade600),
                          const SizedBox(width: 8),
                          const Text(
                            'OUTPUT (Dịch ra)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      _buildInputField('Nước tiểu', _urineOutputController, Icons.wc),
                      _buildInputField('Dẫn lưu', _drainageController, Icons.device_hub),
                      _buildInputField('Hút dạ dày', _nasogastricController, Icons.psychology),
                      _buildInputField('Phân', _stoolController, Icons.circle_outlined),
                      
                      // Insensible Loss with special handling
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: TextFormField(
                          controller: _insensibleController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                          ],
                          enabled: !_useCalculatedInsensible,
                          decoration: InputDecoration(
                            labelText: 'Insensible loss',
                            hintText: _useCalculatedInsensible ? 'Tự động tính' : 'Da + hô hấp (~500ml)',
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.air, size: 20),
                            suffixIcon: _useCalculatedInsensible 
                                ? Icon(Icons.auto_awesome, color: Colors.blue.shade600, size: 16)
                                : null,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            filled: _useCalculatedInsensible,
                            fillColor: _useCalculatedInsensible ? Colors.blue.shade50 : null,
                          ),
                          validator: (value) {
                            if (!_useCalculatedInsensible && value != null && value.isNotEmpty) {
                              final number = double.tryParse(value);
                              if (number == null || number < 0 || number > 10000) {
                                return 'Nhập 0-10000 ml';
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                      
                      _buildInputField('Khác', _otherOutputController, Icons.remove_circle_outline),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Calculate Button
              ElevatedButton(
                onPressed: _calculateFluidBalance,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Tính cân bằng dịch',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Clear Button
              OutlinedButton(
                onPressed: _clearForm,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Xóa và nhập lại'),
              ),
              
              if (_fluidBalance != null) ...[
                const SizedBox(height: 24),
                
                // Results Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.assessment, color: AppColors.primary),
                            const SizedBox(width: 8),
                            const Text(
                              'Kết quả Cân bằng dịch',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Balance Summary
                        Container(
                          width: double.infinity,
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
                                        'INTAKE',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue.shade600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${_totalIntake!.toStringAsFixed(0)} ml',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'OUTPUT',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red.shade600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${_totalOutput!.toStringAsFixed(0)} ml',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 16),
                              
                              Divider(color: Colors.grey.shade300),
                              
                              const SizedBox(height: 16),
                              
                              // Fluid Balance Result
                              Column(
                                children: [
                                  const Text(
                                    'FLUID BALANCE',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${_fluidBalance! >= 0 ? '+' : ''}${_fluidBalance!.toStringAsFixed(0)} ml',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: _getFluidBalanceColor(_fluidBalance!),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _interpretation!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: _getFluidBalanceColor(_fluidBalance!),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Recommendations
                        const Text(
                          'Khuyến nghị:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...(_getFluidBalanceRecommendations(_fluidBalance!).map((recommendation) => 
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              recommendation,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Fluid Balance Reference
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Thang đánh giá Fluid Balance',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildFluidBalanceScale(),
                      ],
                    ),
                  ),
                ),
              ],
              
              const SizedBox(height: 24),
              
              // Information Card
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info, color: Colors.blue.shade700),
                          const SizedBox(width: 8),
                          Text(
                            'Thông tin về Fluid Balance',
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
                        '• Fluid Balance = Total Intake - Total Output\n'
                        '• Theo dõi trong 24h hoặc theo ca trực\n'
                        '• Quan trọng trong điều trị bệnh nhân ICU\n'
                        '• Dương tính: Intake > Output (tích dịch)\n'
                        '• Âm tính: Output > Intake (mất dịch)\n'
                        '• Insensible loss: 15ml/kg/24h (da + hô hấp)\n'
                        '• Sốt tăng insensible loss: +13%/°C >37°C\n'
                        '• Kết hợp với CVP, PCWP để đánh giá chính xác',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFluidBalanceScale() {
    final ranges = [
      {'range': '> +1000ml', 'label': 'Dương tính đáng kể', 'color': Colors.red.shade300},
      {'range': '+500 đến +1000ml', 'label': 'Dương tính vừa phải', 'color': Colors.orange.shade300},
      {'range': '-500 đến +500ml', 'label': 'Cân bằng bình thường', 'color': Colors.green.shade300},
      {'range': '-500 đến -1000ml', 'label': 'Âm tính vừa phải', 'color': Colors.orange.shade300},
      {'range': '< -1000ml', 'label': 'Âm tính đáng kể', 'color': Colors.red.shade300},
    ];

    return Column(
      children: ranges.map((range) {
        final isCurrentRange = _fluidBalance != null && _isInFluidBalanceRange(_fluidBalance!, range['range'] as String);
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isCurrentRange 
                ? (range['color'] as Color).withValues(alpha: 0.2)
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isCurrentRange 
                  ? (range['color'] as Color)
                  : Colors.grey.shade300,
              width: isCurrentRange ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: range['color'] as Color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                range['range'] as String,
                style: TextStyle(
                  fontWeight: isCurrentRange ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const Spacer(),
              Expanded(
                child: Text(
                  range['label'] as String,
                  style: TextStyle(
                    fontWeight: isCurrentRange ? FontWeight.bold : FontWeight.normal,
                    color: isCurrentRange ? (range['color'] as Color) : null,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              if (isCurrentRange) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_back,
                  size: 16,
                  color: range['color'] as Color,
                ),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }

  bool _isInFluidBalanceRange(double balance, String range) {
    switch (range) {
      case '> +1000ml':
        return balance > 1000;
      case '+500 đến +1000ml':
        return balance > 500 && balance <= 1000;
      case '-500 đến +500ml':
        return balance >= -500 && balance <= 500;
      case '-500 đến -1000ml':
        return balance >= -1000 && balance < -500;
      case '< -1000ml':
        return balance < -1000;
      default:
        return false;
    }
  }
}
