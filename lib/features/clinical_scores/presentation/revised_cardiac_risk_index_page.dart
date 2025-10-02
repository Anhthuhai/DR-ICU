import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class RevisedCardiacRiskIndexPage extends StatefulWidget {
  const RevisedCardiacRiskIndexPage({super.key});

  @override
  State<RevisedCardiacRiskIndexPage> createState() => _RevisedCardiacRiskIndexPageState();
}

class _RevisedCardiacRiskIndexPageState extends State<RevisedCardiacRiskIndexPage> {
  bool _ihd = false; // Ischemic heart disease
  bool _chf = false; // Congestive heart failure
  bool _cvd = false; // Cerebrovascular disease
  bool _dminsulin = false; // Diabetes mellitus requiring insulin
  bool _creatinine = false; // Creatinine >2.0 mg/dL
  bool _highrisk = false; // High-risk surgery

  int get totalScore {
    int score = 0;
    if (_ihd) {
      score++;
    }
    if (_chf) {
      score++;
    }
    if (_cvd) {
      score++;
    }
    if (_dminsulin) {
      score++;
    }
    if (_creatinine) {
      score++;
    }
    if (_highrisk) {
      score++;
    }
    return score;
  }

  Color get riskColor {
    if (totalScore == 0) {
      return Colors.green;
    }
    if (totalScore == 1) {
      return Colors.blue;
    }
    if (totalScore == 2) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String get riskLevel {
    if (totalScore == 0) {
      return 'Nguy cơ rất thấp';
    }
    if (totalScore == 1) {
      return 'Nguy cơ thấp';
    }
    if (totalScore == 2) {
      return 'Nguy cơ trung bình';
    }
    return 'Nguy cơ cao';
  }

  String get cardiacEventRisk {
    if (totalScore == 0) {
      return '0.4%';
    }
    if (totalScore == 1) {
      return '0.9%';
    }
    if (totalScore == 2) {
      return '7%';
    }
    if (totalScore >= 3) {
      return '11%';
    }
    return '0%';
  }

  String get recommendations {
    if (totalScore == 0) {
      return 'Tiến hành phẫu thuật theo kế hoạch, không cần đánh giá tim mạch thêm';
    }
    if (totalScore == 1) {
      return 'Cân nhắc đánh giá tim mạch nếu có triệu chứng hoặc phẫu thuật nguy cơ cao';
    }
    if (totalScore == 2) {
      return 'Khuyến nghị đánh giá tim mạch trước phẫu thuật, tối ưu hóa điều trị';
    }
    return 'Bắt buộc đánh giá tim mạch toàn diện, cân nhắc can thiệp trước phẫu thuật';
  }

  String get perioperativeManagement {
    if (totalScore == 0) {
      return 'Quản lý chu phẫu chuẩn';
    }
    if (totalScore == 1) {
      return 'Theo dõi tim mạch trong phẫu thuật';
    }
    if (totalScore == 2) {
      return 'Monitoring tim mạch chặt chẽ, ICU hậu phẫu';
    }
    return 'Monitoring xâm lấn, ICU monitoring, cân nhắc hỗ trợ tuần hoàn';
  }

  List<Map<String, dynamic>> get riskFactors {
    return [
      {
        'factor': 'Bệnh tim thiếu máu cục bộ',
        'description': 'Tiền sử nhồi máu cơ tim, dương tính test gắng sức, đau thắt ngực, dùng nitrate, sóng Q bệnh lý',
        'active': _ihd,
        'variable': 'ihd',
      },
      {
        'factor': 'Suy tim sung huyết',
        'description': 'Tiền sử suy tim, phù phổi, khó thở khi nằm, ran ẩm phổi, bóng tim to, phù ngoại biên',
        'active': _chf,
        'variable': 'chf',
      },
      {
        'factor': 'Bệnh mạch máu não',
        'description': 'Tiền sử đột quỵ hoặc thiếu máu não thoáng qua',
        'active': _cvd,
        'variable': 'cvd',
      },
      {
        'factor': 'Tiểu đường dùng insulin',
        'description': 'Tiểu đường type 1 hoặc type 2 cần điều trị insulin',
        'active': _dminsulin,
        'variable': 'dminsulin',
      },
      {
        'factor': 'Suy thận (Creatinine >2.0)',
        'description': 'Creatinine huyết thanh >2.0 mg/dL (177 μmol/L)',
        'active': _creatinine,
        'variable': 'creatinine',
      },
      {
        'factor': 'Phẫu thuật nguy cơ cao',
        'description': 'Phẫu thuật trong ổ bụng, ngực, mạch máu lớn',
        'active': _highrisk,
        'variable': 'highrisk',
      },
    ];
  }

  List<String> get highRiskSurgeries {
    return [
      'Phẫu thuật động mạch chủ và mạch máu lớn',
      'Phẫu thuật mạch máu ngoại biên',
      'Phẫu thuật trong ổ bụng lớn',
      'Phẫu thuật ngực (không phải tim)',
      'Phẫu thuật thận',
      'Phẫu thuật gan lớn',
      'Phẫu thuật đầu-cổ với tổn thất máu lớn',
      'Phẫu thuật xương khớp lớn với tổn thất máu',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revised Cardiac Risk Index'),
        backgroundColor: Colors.red.shade700,
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
                color: riskColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: riskColor.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    'RCRI (Lee Index)',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$totalScore/6',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    riskLevel,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildRiskInfo(),
                ],
              ),
            ),

            // Risk Factors
            _buildRiskFactorsSection(),

            // Active Risk Factors
            if (totalScore > 0) _buildActiveFactors(),

            // High-Risk Surgery Examples
            _buildHighRiskSurgerySection(),

            // Risk Stratification
            _buildRiskStratification(),

            // Clinical Information
            _buildClinicalInfo(),

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Nguy cơ biến cố tim mạch',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    cardiacEventRisk,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: riskColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: riskColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: riskColor.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.medical_services, color: riskColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Quản lý chu phẫu:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  perioperativeManagement,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkGrey,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.assignment, color: riskColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Khuyến nghị:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  recommendations,
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

  Widget _buildRiskFactorsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade300),
        color: Colors.blue.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Yếu tố nguy cơ tim mạch',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          ...riskFactors.map((factor) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: CheckboxListTile(
              title: Text(
                factor['factor'],
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                factor['description'],
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  height: 1.3,
                ),
              ),
              value: factor['active'],
              // ignore: deprecated_member_use
              onChanged: (value) {
                setState(() {
                  switch (factor['variable']) {
                    case 'ihd': _ihd = value!; break;
                    case 'chf': _chf = value!; break;
                    case 'cvd': _cvd = value!; break;
                    case 'dminsulin': _dminsulin = value!; break;
                    case 'creatinine': _creatinine = value!; break;
                    case 'highrisk': _highrisk = value!; break;
                  }
                });
              },
              activeColor: Colors.blue.shade600,
              contentPadding: EdgeInsets.zero,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildActiveFactors() {
    List<Map<String, dynamic>> activeFactors = riskFactors.where((factor) => factor['active']).toList();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade300),
        color: Colors.orange.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Yếu tố nguy cơ hiện tại (${activeFactors.length})',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
          ),
          const SizedBox(height: 12),
          ...activeFactors.map((factor) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: riskColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '+1',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    factor['factor'],
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildHighRiskSurgerySection() {
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
            'Phẫu thuật nguy cơ cao',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
          ),
          const SizedBox(height: 12),
          ...highRiskSurgeries.map((surgery) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 8, right: 12),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade600,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    surgery,
                    style: const TextStyle(height: 1.4),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildRiskStratification() {
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
            'Phân tầng nguy cơ biến cố tim mạch',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem(0, 'Nguy cơ rất thấp', '0.4%', 'Không cần đánh giá thêm', Colors.green),
          _buildRiskItem(1, 'Nguy cơ thấp', '0.9%', 'Cân nhắc đánh giá nếu có triệu chứng', Colors.blue),
          _buildRiskItem(2, 'Nguy cơ trung bình', '7%', 'Khuyến nghị đánh giá tim mạch', Colors.orange),
          _buildRiskItem(3, 'Nguy cơ cao', '≥11%', 'Bắt buộc đánh giá toàn diện', Colors.red),
        ],
      ),
    );
  }

  Widget _buildRiskItem(int score, String risk, String eventRate, String action, Color color) {
    String scoreText = score == 3 ? '≥3' : score.toString();
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                child: Text(
                  scoreText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  risk,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  eventRate,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            action,
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade600,
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
                'Thông tin lâm sàng',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Revised Cardiac Risk Index (RCRI/Lee Index) đánh giá nguy cơ biến cố tim mạch chu phẫu\n\n'
            'Biến cố tim mạch bao gồm:\n'
            '• Nhồi máu cơ tim\n'
            '• Phù phổi cấp\n'
            '• Block nhĩ thất hoàn toàn\n'
            '• Ngừng tim\n'
            '• Rung thất\n\n'
            'Ứng dụng lâm sàng:\n'
            '• Đánh giá nguy cơ trước phẫu thuật\n'
            '• Quyết định cần đánh giá tim mạch thêm\n'
            '• Lựa chọn phương pháp gây mê và theo dõi\n'
            '• Tư vấn nguy cơ cho bệnh nhân\n\n'
            'Lưu ý quan trọng:\n'
            '• Áp dụng cho phẫu thuật không tim\n'
            '• Không thay thế đánh giá lâm sàng toàn diện\n'
            '• Cân nhắc yếu tố nguy cơ khác\n'
            '• Tối ưu hóa điều trị nội khoa trước phẫu thuật',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }
}
