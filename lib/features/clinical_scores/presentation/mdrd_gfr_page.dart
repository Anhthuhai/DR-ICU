import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../core/theme/app_theme.dart';

class MdrdGfrPage extends StatefulWidget {
  const MdrdGfrPage({super.key});

  @override
  State<MdrdGfrPage> createState() => _MdrdGfrPageState();
}

class _MdrdGfrPageState extends State<MdrdGfrPage> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _creatinineController = TextEditingController();
  bool _isFemale = false;
  bool _isAfricanAmerican = false;

  double _gfr = 0.0;

  @override
  void initState() {
    super.initState();
    _ageController.addListener(_calculateGFR);
    _creatinineController.addListener(_calculateGFR);
  }

  void _calculateGFR() {
    final age = double.tryParse(_ageController.text) ?? 0;
    final creatinine = double.tryParse(_creatinineController.text) ?? 0;

    if (age > 0 && creatinine > 0) {
      // MDRD GFR = 175 × (Scr)^-1.154 × (Age)^-0.203 × (0.742 if female) × (1.212 if African American)
      double gfr = 175 * 
                   (creatinine.pow(-1.154)) * 
                   (age.pow(-0.203));
      
      if (_isFemale) {
        gfr *= 0.742;
      }
      
      if (_isAfricanAmerican) {
        gfr *= 1.212;
      }
      
      setState(() {
        _gfr = gfr;
      });
    } else {
      setState(() {
        _gfr = 0.0;
      });
    }
  }

  Color get gfrColor {
    if (_gfr >= 90) {
      return Colors.green;
    }
    if (_gfr >= 60) {
      return Colors.blue;
    }
    if (_gfr >= 45) {
      return Colors.yellow.shade700;
    }
    if (_gfr >= 30) {
      return Colors.orange;
    }
    if (_gfr >= 15) {
      return Colors.red;
    }
    if (_gfr > 0) {
      return Colors.red.shade800;
    }
    return Colors.grey;
  }

  String get kidneyFunction {
    if (_gfr >= 90) {
      return 'Bình thường/Cao';
    }
    if (_gfr >= 60) {
      return 'Giảm nhẹ';
    }
    if (_gfr >= 45) {
      return 'Giảm nhẹ-vừa';
    }
    if (_gfr >= 30) {
      return 'Giảm vừa-nặng';
    }
    if (_gfr >= 15) {
      return 'Giảm nặng';
    }
    if (_gfr > 0) {
      return 'Suy thận giai đoạn cuối';
    }
    return '';
  }

  String get ckdStage {
    if (_gfr >= 90) {
      return 'CKD Stage 1 (nếu có tổn thương thận)';
    }
    if (_gfr >= 60) {
      return 'CKD Stage 2';
    }
    if (_gfr >= 45) {
      return 'CKD Stage 3a';
    }
    if (_gfr >= 30) {
      return 'CKD Stage 3b';
    }
    if (_gfr >= 15) {
      return 'CKD Stage 4';
    }
    if (_gfr > 0) {
      return 'CKD Stage 5';
    }
    return '';
  }

  String get clinicalAction {
    if (_gfr >= 90) {
      return 'Theo dõi bình thường nếu không có tổn thương thận';
    }
    if (_gfr >= 60) {
      return 'Tầm soát biến chứng CKD, kiểm soát yếu tố nguy cơ';
    }
    if (_gfr >= 45) {
      return 'Đánh giá và điều trị biến chứng CKD';
    }
    if (_gfr >= 30) {
      return 'Chuẩn bị cho liệu pháp thay thế thận';
    }
    if (_gfr >= 15) {
      return 'Bắt đầu liệu pháp thay thế thận';
    }
    if (_gfr > 0) {
      return 'Chạy thận hoặc ghép thận khẩn cấp';
    }
    return '';
  }

  String get drugDosing {
    if (_gfr >= 60) {
      return 'Liều bình thường cho hầu hết thuốc';
    }
    if (_gfr >= 30) {
      return 'Giảm liều thuốc thải qua thận 25-50%';
    }
    if (_gfr >= 15) {
      return 'Giảm liều thuốc thải qua thận 50-75%';
    }
    if (_gfr > 0) {
      return 'Tránh thuốc độc thận, điều chỉnh liều nghiêm ngặt';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MDRD GFR Equation'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Result Display
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: gfrColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: gfrColor.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    'MDRD GFR',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: gfrColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_gfr > 0) ...[
                    Text(
                      '${_gfr.toStringAsFixed(1)} ml/phút/1.73m²',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: gfrColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      kidneyFunction,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkGrey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ckdStage,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: gfrColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    _buildResultDetails(),
                  ] else ...[
                    Icon(
                      Icons.calculate,
                      size: 48,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Nhập thông số để tính toán GFR',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Input Parameters
            _buildInputSection(),

            // Comparison with other methods
            if (_gfr > 0) _buildComparisonSection(),

            // Reference Values
            _buildReferenceSection(),

            // Clinical Information
            _buildClinicalInfo(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildResultDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: gfrColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: gfrColor.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.medical_services, color: gfrColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Hành động lâm sàng:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: gfrColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  clinicalAction,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.darkGrey,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.medication, color: gfrColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Điều chỉnh liều thuốc:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: gfrColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  drugDosing,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.darkGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade300),
        color: Colors.teal.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông số đầu vào (MDRD)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Tuổi',
                    suffixText: 'năm',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _creatinineController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Creatinine huyết thanh',
                    suffixText: 'mg/dL',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    helperText: 'VD: 1.2',
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Gender and Race
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Đặc điểm nhân khẩu học',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                
                CheckboxListTile(
                  title: const Text('Nữ giới'),
                  subtitle: const Text('Hệ số điều chỉnh: ×0.742'),
                  value: _isFemale,
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    setState(() {
                      _isFemale = value!;
                    });
                    _calculateGFR();
                  },
                  contentPadding: EdgeInsets.zero,
                ),
                
                CheckboxListTile(
                  title: const Text('Người Mỹ gốc Phi'),
                  subtitle: const Text('Hệ số điều chỉnh: ×1.212'),
                  value: _isAfricanAmerican,
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    setState(() {
                      _isAfricanAmerican = value!;
                    });
                    _calculateGFR();
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonSection() {
    // Tính Cockcroft-Gault để so sánh (cần cân nặng giả định 70kg)
    double estimatedWeight = 70.0;
    double age = double.tryParse(_ageController.text) ?? 0;
    double creatinine = double.tryParse(_creatinineController.text) ?? 0;
    
    double cockcroftGault = 0;
    if (age > 0 && creatinine > 0) {
      cockcroftGault = ((140 - age) * estimatedWeight) / (72 * creatinine);
      if (_isFemale) {
        cockcroftGault *= 0.85;
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.shade300),
        color: Colors.purple.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'So sánh với phương pháp khác',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'MDRD GFR',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.purple.shade700,
                        ),
                      ),
                      Text(
                        _gfr.toStringAsFixed(1),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: gfrColor,
                        ),
                      ),
                      const Text(
                        'ml/min/1.73m²',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Cockcroft-Gault',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.purple.shade700,
                        ),
                      ),
                      Text(
                        cockcroftGault.toStringAsFixed(1),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.orange,
                        ),
                      ),
                      const Text(
                        'ml/min (ước tính)',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          Text(
            'Lưu ý: Cockcroft-Gault ước tính với cân nặng 70kg',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferenceSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade300),
        color: Colors.green.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phân loại chức năng thận (GFR)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildReferenceItem('≥ 90', 'Bình thường/Cao (CKD 1)', Colors.green),
          _buildReferenceItem('60-89', 'Giảm nhẹ (CKD Stage 2)', Colors.blue),
          _buildReferenceItem('45-59', 'Giảm nhẹ-vừa (CKD 3a)', Colors.yellow.shade700),
          _buildReferenceItem('30-44', 'Giảm vừa-nặng (CKD 3b)', Colors.orange),
          _buildReferenceItem('15-29', 'Giảm nặng (CKD Stage 4)', Colors.red),
          _buildReferenceItem('< 15', 'Suy thận cuối (CKD Stage 5)', Colors.red.shade800),
        ],
      ),
    );
  }

  Widget _buildReferenceItem(String range, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              description,
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClinicalInfo() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.blue.shade600),
              const SizedBox(width: 8),
              Text(
                'Thông tin lâm sàng',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'MDRD (Modification of Diet in Renal Disease) Equation:\n'
            'GFR = 175 × (SCr)^-1.154 × (Age)^-0.203 × (0.742 nếu nữ) × (1.212 nếu da đen)\n\n'
            'Ưu điểm của MDRD:\n'
            '• Chuẩn hóa theo diện tích bề mặt cơ thể (1.73 m²)\n'
            '• Chính xác hơn Cockcroft-Gault ở GFR thấp\n'
            '• Được khuyến nghị bởi các hướng dẫn quốc tế\n'
            '• Phù hợp cho CKD staging\n\n'
            'Hạn chế:\n'
            '• Ít chính xác ở GFR >60 ml/min/1.73m²\n'
            '• Không phù hợp cho trẻ em <18 tuổi\n'
            '• Ước tính kém ở người rất gầy hoặc béo phì\n'
            '• Cần thận trọng ở bệnh cấp tính\n\n'
            'Lưu ý: CKD-EPI equation (2009, 2021) hiện được ưu tiên hơn MDRD',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    _creatinineController.dispose();
    super.dispose();
  }
}

extension Pow on double {
  double pow(double exponent) {
    return math.pow(this, exponent).toDouble();
  }
}
