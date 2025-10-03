import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/colors.dart';
import 'dart:math';

class BSACalculatorPage extends StatefulWidget {
  const BSACalculatorPage({super.key});

  @override
  State<BSACalculatorPage> createState() => _BSACalculatorPageState();
}

class _BSACalculatorPageState extends State<BSACalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  
  double? _bsa;

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  double _calculateBSA(double weight, double height) {
    // BSA = 0.007184 × Weight^0.425 × Height^0.725 (DuBois formula)
    return 0.007184 * pow(weight, 0.425) * pow(height, 0.725);
  }

  String _getBSAInterpretation(double bsa) {
    if (bsa < 1.0) {
      return 'Diện tích bề mặt cơ thể nhỏ';
    } else if (bsa >= 1.0 && bsa <= 2.0) {
      return 'Diện tích bề mặt cơ thể bình thường';
    } else {
      return 'Diện tích bề mặt cơ thể lớn';
    }
  }

  Color _getBSAColor(double bsa) {
    if (bsa < 1.0) {
      return Colors.orange.shade300;
    } else if (bsa >= 1.0 && bsa <= 2.0) {
      return Colors.green.shade300;
    } else {
      return Colors.red.shade300;
    }
  }

  List<String> _getBSARecommendations(double bsa) {
    List<String> recommendations = [];
    
    if (bsa < 1.0) {
      recommendations.addAll([
        '• BSA thấp có thể do cân nặng hoặc chiều cao dưới mức bình thường',
        '• Cần điều chỉnh liều thuốc theo BSA',
        '• Theo dõi dinh dưỡng và tăng trưởng',
      ]);
    } else if (bsa >= 1.0 && bsa <= 2.0) {
      recommendations.addAll([
        '• BSA trong khoảng bình thường',
        '• Có thể sử dụng liều thuốc tiêu chuẩn',
        '• Theo dõi định kỳ khi điều trị',
      ]);
    } else {
      recommendations.addAll([
        '• BSA cao, cần cân nhắc điều chỉnh liều thuốc',
        '• Theo dõi chức năng thận và gan',
        '• Cân nhắc giảm cân nếu cần thiết',
      ]);
    }
    
    recommendations.addAll([
      '• BSA được sử dụng để tính liều thuốc hóa trị',
      '• Quan trọng trong tính toán chỉ số tim mạch',
      '• Sử dụng trong đánh giá chức năng thận',
    ]);
    
    return recommendations;
  }

  void _calculateResult() {
    if (_formKey.currentState!.validate()) {
      final weight = double.parse(_weightController.text);
      final height = double.parse(_heightController.text);
      
      setState(() {
        _bsa = _calculateBSA(weight, height);
      });
    }
  }

  void _clearForm() {
    setState(() {
      _weightController.clear();
      _heightController.clear();
      _bsa = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BSA Calculator'),
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
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person_outline, color: AppColors.primary),
                          const SizedBox(width: 8),
                          const Text(
                            'Thông tin cơ thể',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Weight Input
                      TextFormField(
                        controller: _weightController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Cân nặng (kg)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.monitor_weight),
                          hintText: 'Nhập cân nặng (1-300 kg)',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập cân nặng';
                          }
                          final weight = double.tryParse(value);
                          if (weight == null || weight <= 0 || weight > 300) {
                            return 'Cân nặng phải từ 1-300 kg';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      
                      // Height Input
                      TextFormField(
                        controller: _heightController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Chiều cao (cm)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.height),
                          hintText: 'Nhập chiều cao (30-250 cm)',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập chiều cao';
                          }
                          final height = double.tryParse(value);
                          if (height == null || height < 30 || height > 250) {
                            return 'Chiều cao phải từ 30-250 cm';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Calculate Button
              ElevatedButton(
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
                  'Tính toán BSA',
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
              
              if (_bsa != null) ...[
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
                              'Kết quả BSA',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // BSA Value
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
                              Text(
                                '${_bsa!.toStringAsFixed(2)} m²',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: _getBSAColor(_bsa!),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _getBSAInterpretation(_bsa!),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: _getBSAColor(_bsa!),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Công thức: DuBois & DuBois (1916)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
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
                        ...(_getBSARecommendations(_bsa!).map((recommendation) => 
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
                
                // BSA Reference Scale
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Thang điểm tham khảo BSA',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildBSAScale(),
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
                            'Thông tin về BSA',
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
                        '• BSA (Body Surface Area) là diện tích bề mặt cơ thể\n'
                        '• Được sử dụng để tính liều thuốc, đặc biệt thuốc hóa trị\n'
                        '• Quan trọng trong đánh giá chức năng tim mạch và thận\n'
                        '• Sử dụng công thức DuBois: BSA = 0.007184 × Cân nặng^0.425 × Chiều cao^0.725\n'
                        '• Đơn vị: m² (mét vuông)\n'
                        '• Bình thường: 1.0 - 2.0 m²',
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

  Widget _buildBSAScale() {
    final ranges = [
      {'range': '< 1.0', 'label': 'Nhỏ', 'color': Colors.orange.shade300},
      {'range': '1.0 - 2.0', 'label': 'Bình thường', 'color': Colors.green.shade300},
      {'range': '> 2.0', 'label': 'Lớn', 'color': Colors.red.shade300},
    ];

    return Column(
      children: ranges.map((range) {
        final isCurrentRange = _bsa != null && _isInRange(_bsa!, range['range'] as String);
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
                '${range['range']} m²',
                style: TextStyle(
                  fontWeight: isCurrentRange ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const Spacer(),
              Text(
                range['label'] as String,
                style: TextStyle(
                  fontWeight: isCurrentRange ? FontWeight.bold : FontWeight.normal,
                  color: isCurrentRange ? (range['color'] as Color) : null,
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

  bool _isInRange(double bsa, String range) {
    switch (range) {
      case '< 1.0':
        return bsa < 1.0;
      case '1.0 - 2.0':
        return bsa >= 1.0 && bsa <= 2.0;
      case '> 2.0':
        return bsa > 2.0;
      default:
        return false;
    }
  }
}
