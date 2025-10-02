import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AsaPhysicalStatusPage extends StatefulWidget {
  const AsaPhysicalStatusPage({super.key});

  @override
  State<AsaPhysicalStatusPage> createState() => _AsaPhysicalStatusPageState();
}

class _AsaPhysicalStatusPageState extends State<AsaPhysicalStatusPage> {
  int asaClass = 0;

  Color get scoreColor {
    switch (asaClass) {
      case 1: return Colors.green;
      case 2: return Colors.blue;
      case 3: return Colors.orange;
      case 4: return Colors.red;
      case 5: return Colors.red.shade800;
      case 6: return Colors.purple;
      default: return Colors.grey;
    }
  }

  String get classification {
    switch (asaClass) {
      case 1: return 'ASA I';
      case 2: return 'ASA II';
      case 3: return 'ASA III';
      case 4: return 'ASA IV';
      case 5: return 'ASA V';
      case 6: return 'ASA VI';
      default: return 'Chưa phân loại';
    }
  }

  String get description {
    switch (asaClass) {
      case 1: return 'Bệnh nhân khỏe mạnh bình thường';
      case 2: return 'Bệnh nhân có bệnh lý toàn thân nhẹ';
      case 3: return 'Bệnh nhân có bệnh lý toàn thân nghiêm trọng';
      case 4: return 'Bệnh nhân có bệnh lý toàn thân nghiêm trọng đe dọa tính mạng';
      case 5: return 'Bệnh nhân hấp hối, không mổ sẽ chết trong 24h';
      case 6: return 'Bệnh nhân chết não để lấy tạng';
      default: return '';
    }
  }

  String get perioperativeMortality {
    switch (asaClass) {
      case 1: return '0.05%';
      case 2: return '0.4%';
      case 3: return '4.3%';
      case 4: return '23.5%';
      case 5: return '50.7%';
      case 6: return 'Không áp dụng';
      default: return '';
    }
  }

  String get anesthesiaRisk {
    switch (asaClass) {
      case 1: return 'Nguy cơ gây mê thấp';
      case 2: return 'Nguy cơ gây mê thấp-trung bình';
      case 3: return 'Nguy cơ gây mê trung bình-cao';
      case 4: return 'Nguy cơ gây mê cao';
      case 5: return 'Nguy cơ gây mê rất cao';
      case 6: return 'Không áp dụng';
      default: return '';
    }
  }

  String get recommendations {
    switch (asaClass) {
      case 1: return 'Có thể phẫu thuật bình thường';
      case 2: return 'Cần kiểm soát bệnh lý trước mổ';
      case 3: return 'Cần tối ưu hóa tình trạng trước mổ, theo dõi chặt chẽ';
      case 4: return 'Cân nhắc lợi ích/nguy cơ, cần ICU hậu phẫu';
      case 5: return 'Chỉ mổ cấp cứu cứu sống, tiên lượng xấu';
      case 6: return 'Phẫu thuật lấy tạng';
      default: return '';
    }
  }

  List<Map<String, dynamic>> get asaOptions {
    return [
      {
        'class': 1,
        'title': 'ASA I - Bình thường',
        'description': 'Bệnh nhân khỏe mạnh bình thường',
        'examples': 'Không có bệnh lý hệ thống, không hút thuốc, không/ít uống rượu',
        'mortality': '0.05%',
      },
      {
        'class': 2,
        'title': 'ASA II - Bệnh lý nhẹ',
        'description': 'Bệnh nhân có bệnh lý toàn thân nhẹ',
        'examples': 'Hút thuốc, uống rượu, béo phì, đang mang thai, ĐTĐ kiểm soát tốt, THA kiểm soát tốt',
        'mortality': '0.4%',
      },
      {
        'class': 3,
        'title': 'ASA III - Bệnh lý nghiêm trọng',
        'description': 'Bệnh nhân có bệnh lý toàn thân nghiêm trọng',
        'examples': 'ĐTĐ không kiểm soát, THA không kiểm soát, COPD, béo phì bệnh lý, rối loạn chức năng cơ quan',
        'mortality': '4.3%',
      },
      {
        'class': 4,
        'title': 'ASA IV - Đe dọa tính mạng',
        'description': 'Bệnh nhân có bệnh lý toàn thân nghiêm trọng đe dọa tính mạng',
        'examples': 'Nhồi máu cơ tim gần đây, CVA, TIA, CAD, suy thận nặng cần chạy thận',
        'mortality': '23.5%',
      },
      {
        'class': 5,
        'title': 'ASA V - Hấp hối',
        'description': 'Bệnh nhân hấp hối, không mổ sẽ chết trong 24h',
        'examples': 'Vỡ phình động mạch chủ, chấn thương đa cơ quan nặng, sepsis nặng với rối loạn cơ quan',
        'mortality': '50.7%',
      },
      {
        'class': 6,
        'title': 'ASA VI - Chết não',
        'description': 'Bệnh nhân chết não để lấy tạng',
        'examples': 'Bệnh nhân được tuyên bố chết não để hiến tạng',
        'mortality': 'N/A',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ASA Physical Status'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Score Display
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: scoreColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: scoreColor.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    'ASA Physical Status',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: scoreColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (asaClass > 0) ...[
                    Text(
                      classification,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: scoreColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkGrey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    _buildRiskInfo(),
                  ] else ...[
                    Icon(
                      Icons.assignment,
                      size: 48,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Vui lòng chọn phân loại ASA',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // ASA Classifications
            _buildSection(
              'Phân loại ASA Physical Status',
              Colors.indigo.shade600,
              [
                ...asaOptions.map((option) => _buildAsaOption(option)),
              ],
            ),

            // Additional Information
            if (asaClass > 0) _buildAdditionalInfo(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskInfo() {
    return Container(
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
                    'Tỷ lệ tử vong',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    perioperativeMortality,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: scoreColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Nguy cơ gây mê',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    anesthesiaRisk,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: scoreColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            recommendations,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppTheme.darkGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Color color, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        color: color.withValues(alpha: 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildAsaOption(Map<String, dynamic> option) {
    int classValue = option['class'];
    bool isSelected = asaClass == classValue;
    
    Color optionColor = Colors.green;
    switch (classValue) {
      case 1: optionColor = Colors.green; break;
      case 2: optionColor = Colors.blue; break;
      case 3: optionColor = Colors.orange; break;
      case 4: optionColor = Colors.red; break;
      case 5: optionColor = Colors.red.shade800; break;
      case 6: optionColor = Colors.purple; break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => setState(() => asaClass = classValue),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? optionColor : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
            color: isSelected ? optionColor.withValues(alpha: 0.1) : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isSelected ? optionColor : Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        classValue.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      option['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: isSelected ? optionColor : Colors.black87,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSelected ? optionColor.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      option['mortality'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isSelected ? optionColor : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                option['description'],
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isSelected ? optionColor : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                option['examples'],
                style: TextStyle(
                  fontSize: 13,
                  color: isSelected ? optionColor : Colors.grey.shade600,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalInfo() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.indigo.shade50,
        border: Border.all(color: Colors.indigo.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.indigo.shade600),
              const SizedBox(width: 8),
              Text(
                'Lưu ý quan trọng',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '• ASA được đánh giá bởi bác sĩ gây mê trước phẫu thuật\n'
            '• Suffix "E" được thêm vào cho phẫu thuật cấp cứu (VD: ASA III-E)\n'
            '• ASA không dự đoán trực tiếp nguy cơ gây mê mà chỉ phản ánh tình trạng sức khỏe\n'
            '• Cần kết hợp với các yếu tố khác: tuổi, loại phẫu thuật, kỹ thuật gây mê\n'
            '• ASA IV-V cần chuẩn bị đặc biệt và có thể cần ICU hậu phẫu',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }
}
