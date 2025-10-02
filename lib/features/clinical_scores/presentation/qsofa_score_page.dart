import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class QsofaScorePage extends StatefulWidget {
  const QsofaScorePage({super.key});

  @override
  State<QsofaScorePage> createState() => _QsofaScorePageState();
}

class _QsofaScorePageState extends State<QsofaScorePage> {
  final TextEditingController _respiratoryRateController = TextEditingController();
  final TextEditingController _systolicBpController = TextEditingController();

  String _alteredMentation = 'no';

  int _totalScore = 0;

  @override
  void initState() {
    super.initState();
    _respiratoryRateController.addListener(_calculateScore);
    _systolicBpController.addListener(_calculateScore);
  }

  void _calculateScore() {
    int score = 0;
    
    // Respiratory rate ≥22
    final respiratoryRate = int.tryParse(_respiratoryRateController.text) ?? 0;
    if (respiratoryRate >= 22) {
      score += 1;
    }
    
    // Altered mentation
    if (_alteredMentation == 'yes') {
      score += 1;
    }
    
    // Systolic BP ≤100
    final systolicBp = int.tryParse(_systolicBpController.text) ?? 0;
    if (systolicBp > 0 && systolicBp <= 100) {
      score += 1;
    }

    setState(() {
      _totalScore = score;
    });
  }

  Color get riskColor {
    if (_totalScore <= 1) {
      return Colors.green;
    }
    return Colors.red;
  }

  String get riskLevel {
    if (_totalScore <= 1) {
      return 'Nguy cơ thấp';
    }
    return 'Nguy cơ cao';
  }

  String get mortalityRisk {
    if (_totalScore <= 1) {
      return '< 10%';
    }
    return '≥ 10%';
  }

  String get recommendations {
    if (_totalScore <= 1) {
      return 'Theo dõi thường quy, không cần can thiệp đặc biệt';
    }
    return 'Nghi ngờ sepsis, cần đánh giá và điều trị tích cực ngay lập tức';
  }

  String get clinicalAction {
    if (_totalScore <= 1) {
      return 'Tiếp tục theo dõi và điều trị hiện tại';
    }
    return 'Khởi động quy trình sepsis bundle trong 1 giờ';
  }

  List<Map<String, dynamic>> get criteria {
    return [
      {
        'criterion': 'Tần số thở ≥22',
        'description': 'Tần số thở ≥22 lần/phút',
        'points': 1,
        'active': (int.tryParse(_respiratoryRateController.text) ?? 0) >= 22,
      },
      {
        'criterion': 'Rối loạn ý thức',
        'description': 'Thay đổi tình trạng tâm thần (GCS <15)',
        'points': 1,
        'active': _alteredMentation == 'yes',
      },
      {
        'criterion': 'Huyết áp tâm thu ≤100',
        'description': 'Huyết áp tâm thu ≤100 mmHg',
        'points': 1,
        'active': (int.tryParse(_systolicBpController.text) ?? 0) > 0 && 
                  (int.tryParse(_systolicBpController.text) ?? 0) <= 100,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('qSOFA Score'),
        backgroundColor: Colors.orange.shade700,
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
                    'qSOFA Score',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_totalScore/3',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
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

            // Input Parameters
            _buildInputSection(),

            // Active Criteria
            if (_totalScore > 0) _buildActiveCriteria(),

            // Risk Stratification
            _buildRiskStratification(),

            // Sepsis Bundle
            if (_totalScore >= 2) _buildSepsisBundle(),

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'Tử vong',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    mortalityRisk,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: riskColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Hành động',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    clinicalAction.split(' ').take(3).join(' '),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: riskColor,
                    ),
                    textAlign: TextAlign.center,
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

  Widget _buildInputSection() {
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
            'Tiêu chí qSOFA',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          TextField(
            controller: _respiratoryRateController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Tần số thở',
              suffixText: 'lần/phút',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: '+1 điểm nếu ≥22 lần/phút',
            ),
          ),
          const SizedBox(height: 16),
          
          TextField(
            controller: _systolicBpController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Huyết áp tâm thu',
              suffixText: 'mmHg',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: '+1 điểm nếu ≤100 mmHg',
            ),
          ),
          const SizedBox(height: 16),
          
          Text(
            'Rối loạn ý thức',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Không'),
                  value: 'no',
                  // ignore: deprecated_member_use
                  groupValue: _alteredMentation,
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    setState(() {
                      _alteredMentation = value!;
                    });
                    _calculateScore();
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Có (GCS <15)'),
                  value: 'yes',
                  // ignore: deprecated_member_use
                  groupValue: _alteredMentation,
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    setState(() {
                      _alteredMentation = value!;
                    });
                    _calculateScore();
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCriteria() {
    List<Map<String, dynamic>> activeCriteria = criteria.where((criterion) => criterion['active']).toList();
    
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
            'Tiêu chí dương tính (${activeCriteria.length})',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 12),
          ...activeCriteria.map((criterion) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 24,
                  decoration: BoxDecoration(
                    color: riskColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      '+${criterion['points']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        criterion['criterion'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        criterion['description'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
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
            'Phân tầng nguy cơ sepsis',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('0-1', 'Nguy cơ thấp', '< 10%', 'Theo dõi thường quy', Colors.green),
          _buildRiskItem('≥2', 'Nguy cơ cao', '≥ 10%', 'Sepsis bundle tức thì', Colors.red),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String risk, String mortality, String action, Color color) {
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
                width: 40,
                child: Text(
                  score,
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
                  mortality,
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

  Widget _buildSepsisBundle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade300),
        color: Colors.red.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: Colors.red.shade700),
              const SizedBox(width: 8),
              Text(
                'Sepsis Bundle - Hour 1',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildBundleItem('1. Lactate đo lường', 'Lấy máu xét nghiệm lactate', Icons.science),
          _buildBundleItem('2. Cấy máu', 'Cấy máu trước khi dùng kháng sinh', Icons.biotech),
          _buildBundleItem('3. Kháng sinh', 'Kháng sinh phổ rộng trong 1 giờ', Icons.medication),
          _buildBundleItem('4. Dịch truyền', '30ml/kg nếu hạ huyết áp hoặc lactate ≥4', Icons.water_drop),
          _buildBundleItem('5. Vasopressor', 'Nếu hạ huyết áp không đáp ứng dịch', Icons.favorite),
        ],
      ),
    );
  }

  Widget _buildBundleItem(String title, String description, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.red.shade600, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
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
        color: Colors.teal.shade50,
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.teal.shade600),
              const SizedBox(width: 8),
              Text(
                'Thông tin lâm sàng',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'qSOFA (Quick SOFA) là công cụ sàng lọc sepsis đơn giản và nhanh chóng\n\n'
            'Ưu điểm:\n'
            '• Đơn giản, không cần xét nghiệm\n'
            '• Thực hiện nhanh tại bedside\n'
            '• Giúp nhận diện sớm sepsis\n'
            '• Kích hoạt quy trình điều trị\n\n'
            'Giới hạn:\n'
            '• Độ nhạy thấp hơn SOFA đầy đủ\n'
            '• Không thay thế đánh giá lâm sàng\n'
            '• Có thể bỏ sót sepsis sớm\n'
            '• Cần kết hợp với nghi ngờ nhiễm trùng\n\n'
            'Sepsis 3.0 Definition:\n'
            '• Sepsis = Nhiễm trùng + qSOFA ≥2\n'
            '• Sốc sepsis = Sepsis + vasopressor + lactate >2\n'
            '• Điều trị trong "Golden Hour"\n\n'
            'Lưu ý quan trọng:\n'
            '• qSOFA không chẩn đoán sepsis\n'
            '• Chỉ là công cụ sàng lọc\n'
            '• Cần đánh giá tổng thể lâm sàng\n'
            '• Theo dõi diễn biến liên tục',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _respiratoryRateController.dispose();
    _systolicBpController.dispose();
    super.dispose();
  }
}
