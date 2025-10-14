import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/colors.dart';

class BMICalculatorPage extends StatefulWidget {
  const BMICalculatorPage({super.key});

  @override
  State<BMICalculatorPage> createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  double? _bmi;
  String _category = '';
  Color _categoryColor = Colors.grey;
  String _interpretation = '';
  List<String> _recommendations = [];

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _calculateBMI() {
    if (_formKey.currentState!.validate()) {
      final weight = double.parse(_weightController.text);
      final height = double.parse(_heightController.text) / 100; // Convert cm to m
      
      setState(() {
        _bmi = weight / (height * height);
        _updateBMICategory();
      });
    }
  }

  void _updateBMICategory() {
    if (_bmi == null) return;
    
    if (_bmi! < 18.5) {
      _category = 'Thiếu cân';
      _categoryColor = Colors.blue.shade300;
      _interpretation = 'Cân nặng thấp hơn bình thường. Cần tăng cân.';
      _recommendations = [
        'Tăng lượng calo nạp vào',
        'Ăn nhiều bữa nhỏ trong ngày',
        'Tập thể dục để tăng khối lượng cơ',
        'Tham khảo ý kiến chuyên gia dinh dưỡng',
      ];
    } else if (_bmi! < 25.0) {
      _category = 'Bình thường';
      _categoryColor = Colors.green.shade300;
      _interpretation = 'Cân nặng trong tầm kiểm soát tốt. Duy trì lối sống lành mạnh.';
      _recommendations = [
        'Duy trì chế độ ăn cân bằng',
        'Tập thể dục đều đặn',
        'Kiểm tra sức khỏe định kỳ',
        'Giữ cân nặng ổn định',
      ];
    } else if (_bmi! < 30.0) {
      _category = 'Thừa cân';
      _categoryColor = Colors.orange.shade300;
      _interpretation = 'Cân nặng cao hơn bình thường. Nên giảm cân.';
      _recommendations = [
        'Giảm lượng calo nạp vào',
        'Tăng cường hoạt động thể chất',
        'Ăn nhiều rau xanh và trái cây',
        'Tránh đồ ăn nhanh và đồ ngọt',
      ];
    } else if (_bmi! < 35.0) {
      _category = 'Béo phì độ I';
      _categoryColor = Colors.red.shade300;
      _interpretation = 'Béo phì mức độ nhẹ. Cần giảm cân nghiêm túc.';
      _recommendations = [
        'Xây dựng kế hoạch giảm cân cụ thể',
        'Tập thể dục ít nhất 150 phút/tuần',
        'Kiểm soát khẩu phần ăn',
        'Theo dõi y tế thường xuyên',
      ];
    } else if (_bmi! < 40.0) {
      _category = 'Béo phì độ II';
      _categoryColor = Colors.red.shade400;
      _interpretation = 'Béo phì mức độ trung bình. Nguy cơ cao các bệnh liên quan.';
      _recommendations = [
        'Cần can thiệp y tế chuyên sâu',
        'Chế độ ăn kiêng nghiêm ngặt',
        'Tập luyện có giám sát',
        'Theo dõi các bệnh đi kèm',
      ];
    } else {
      _category = 'Béo phì độ III';
      _categoryColor = Colors.red.shade500;
      _interpretation = 'Béo phì nặng. Nguy cơ rất cao các biến chứng.';
      _recommendations = [
        'Can thiệp y tế khẩn cấp',
        'Cân nhắc phẫu thuật giảm béo',
        'Theo dõi chuyên khoa',
        'Hỗ trợ tâm lý chuyên nghiệp',
      ];
    }
  }

  void _clearForm() {
    setState(() {
      _weightController.clear();
      _heightController.clear();
      _bmi = null;
      _category = '';
      _interpretation = '';
      _recommendations = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          if (_bmi != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _clearForm,
              tooltip: 'Tính toán mới',
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
                      Icon(Icons.accessibility_new, 
                           size: 48, 
                           color: AppColors.primary),
                      const SizedBox(height: 8),
                      const Text(
                        'Tính chỉ số BMI',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Body Mass Index - Chỉ số khối cơ thể',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Input form
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.input, color: AppColors.primary),
                          const SizedBox(width: 8),
                          const Text(
                            'Nhập thông tin',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      TextFormField(
                        controller: _weightController,
                        decoration: const InputDecoration(
                          labelText: 'Cân nặng (kg)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.monitor_weight),
                          hintText: 'Ví dụ: 70',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập cân nặng';
                          }
                          final weight = double.tryParse(value);
                          if (weight == null || weight <= 0 || weight > 300) {
                            return 'Cân nặng không hợp lệ (1-300 kg)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      
                      TextFormField(
                        controller: _heightController,
                        decoration: const InputDecoration(
                          labelText: 'Chiều cao (cm)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.height),
                          hintText: 'Ví dụ: 170',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập chiều cao';
                          }
                          final height = double.tryParse(value);
                          if (height == null || height < 100 || height > 250) {
                            return 'Chiều cao không hợp lệ (100-250 cm)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      
                      ElevatedButton(
                        onPressed: _calculateBMI,
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
                            Icon(Icons.calculate),
                            SizedBox(width: 8),
                            Text(
                              'Tính BMI',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Results
              if (_bmi != null) ...[
                const SizedBox(height: 16),
                _buildResultCard(),
              ],
              const SizedBox(height: 16),
              _buildCitationWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.assessment, color: AppColors.primary),
                const SizedBox(width: 8),
                const Text(
                  'Kết quả BMI',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // BMI value
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    _bmi!.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: _categoryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _category,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: _categoryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Interpretation
            Text(
              'Diễn giải:',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _interpretation,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Recommendations
            Text(
              'Khuyến nghị:',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            
            ..._recommendations.map((recommendation) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _categoryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      recommendation,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            )),
            
            const SizedBox(height: 16),
            
            // BMI scale reference
            _buildBMIScale(),
          ],
        ),
      ),
    );
  }

  Widget _buildBMIScale() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thang đo BMI:',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildScaleItem('< 18.5', 'Thiếu cân', Colors.blue.shade300),
          _buildScaleItem('18.5 - 24.9', 'Bình thường', Colors.green.shade300),
          _buildScaleItem('25.0 - 29.9', 'Thừa cân', Colors.orange.shade300),
          _buildScaleItem('30.0 - 34.9', 'Béo phì độ I', Colors.red.shade300),
          _buildScaleItem('35.0 - 39.9', 'Béo phì độ II', Colors.red.shade400),
          _buildScaleItem('≥ 40.0', 'Béo phì độ III', Colors.red.shade500),
        ],
      ),
    );
  }

  Widget _buildScaleItem(String range, String category, Color color) {
    final isCurrentCategory = category == _category;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isCurrentCategory ? color.withValues(alpha: 0.2) : null,
          borderRadius: BorderRadius.circular(4),
          border: isCurrentCategory ? Border.all(color: color, width: 1) : null,
        ),
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
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isCurrentCategory ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isCurrentCategory ? FontWeight.bold : FontWeight.normal,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
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
            'World Health Organization. BMI classification. 2004.\n'
            'Keys A, et al. Indices of relative weight and obesity. J Chronic Dis. 1972;25(6):329-43.\n'
            'WPRO-WHO Expert Consultation. Redefining obesity for Asians. 2000.',
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
