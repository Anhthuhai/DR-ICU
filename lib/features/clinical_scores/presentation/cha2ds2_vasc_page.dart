import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class Cha2ds2VascPage extends StatefulWidget {
  const Cha2ds2VascPage({super.key});

  @override
  State<Cha2ds2VascPage> createState() => _Cha2ds2VascPageState();
}

class _Cha2ds2VascPageState extends State<Cha2ds2VascPage> {
  int chfScore = 0;
  int hypertensionScore = 0;
  int ageScore = 0;
  int diabetesScore = 0;
  int strokeScore = 0;
  int vascularDiseaseScore = 0;
  int sexScore = 0;

  final TextEditingController ageController = TextEditingController();

  int get totalScore => chfScore + hypertensionScore + ageScore + 
                       diabetesScore + strokeScore + vascularDiseaseScore + sexScore;

  Color get scoreColor {
    if (totalScore == 0) {
      return Colors.green;
    }
    if (totalScore == 1) {
      return Colors.yellow.shade700;
    }
    if (totalScore <= 3) {
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
    if (totalScore <= 3) {
      return 'Nguy cơ trung bình';
    }
    return 'Nguy cơ cao';
  }

  String get annualStrokeRisk {
    switch (totalScore) {
      case 0: return '0%';
      case 1: return '1.3%';
      case 2: return '2.2%';
      case 3: return '3.2%';
      case 4: return '4.0%';
      case 5: return '6.7%';
      case 6: return '9.8%';
      case 7: return '9.6%';
      case 8: return '6.7%';
      case 9: return '15.2%';
      default: return '> 15%';
    }
  }

  String get anticoagulationRecommendation {
    if (totalScore == 0) {
      return 'Không cần kháng đông';
    }
    if (totalScore == 1) {
      return 'Cân nhắc kháng đông hoặc aspirin';
    }
    return 'Khuyến cáo kháng đông đường uống';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CHA₂DS₂-VASc Score'),
        backgroundColor: Colors.purple.shade700,
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
                    'CHA₂DS₂-VASc Score',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: scoreColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    totalScore.toString(),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: scoreColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    riskLevel,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nguy cơ đột quỵ/năm: $annualStrokeRisk',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    anticoagulationRecommendation,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.darkGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Risk Factors
            _buildSection(
              'Yếu tố nguy cơ chính',
              Colors.red.shade600,
              [
                _buildRiskFactorCard(
                  'Congestive Heart Failure',
                  'Suy tim sung huyết',
                  Icons.favorite_border,
                  1,
                  chfScore,
                  (value) => setState(() => chfScore = value),
                ),
                _buildRiskFactorCard(
                  'Hypertension',
                  'Tăng huyết áp',
                  Icons.trending_up,
                  1,
                  hypertensionScore,
                  (value) => setState(() => hypertensionScore = value),
                ),
                _buildRiskFactorCard(
                  'Diabetes mellitus',
                  'Đái tháo đường',
                  Icons.bloodtype,
                  1,
                  diabetesScore,
                  (value) => setState(() => diabetesScore = value),
                ),
                _buildRiskFactorCard(
                  'Stroke/TIA History',
                  'Tiền sử đột quỵ/TIA',
                  Icons.psychology,
                  2,
                  strokeScore,
                  (value) => setState(() => strokeScore = value * 2),
                ),
                _buildRiskFactorCard(
                  'Vascular Disease',
                  'Bệnh mạch máu ngoại biên/MI/aortic plaque',
                  Icons.device_hub,
                  1,
                  vascularDiseaseScore,
                  (value) => setState(() => vascularDiseaseScore = value),
                ),
              ],
            ),

            _buildSection(
              'Yếu tố tuổi tác và giới tính',
              Colors.blue.shade600,
              [
                _buildAgeSection(),
                _buildGenderSection(),
              ],
            ),

            // Information box
            Container(
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
                        'Thông tin quan trọng',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• CHA₂DS₂-VASc được sử dụng để đánh giá nguy cơ đột quỵ ở bệnh nhân rung nhĩ không do bệnh van tim\n'
                    '• Điểm ≥ 2 (nam) hoặc ≥ 3 (nữ): khuyến cáo kháng đông\n'
                    '• Điểm = 1 (nam) hoặc = 2 (nữ): cân nhắc kháng đông\n'
                    '• Cần cân nhắc cùng với HAS-BLED score để đánh giá nguy cơ chảy máu',
                    style: TextStyle(height: 1.4),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
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

  Widget _buildRiskFactorCard(
    String title,
    String subtitle,
    IconData icon,
    int points,
    int currentScore,
    Function(int) onChanged,
  ) {
    bool isSelected = currentScore > 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => onChanged(isSelected ? 0 : 1),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? Colors.red : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
            color: isSelected ? Colors.red.withValues(alpha: 0.1) : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.red : Colors.grey,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.red : Colors.black87,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.red.shade700 : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${points}pt',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAgeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tuổi:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: ageController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Nhập tuổi',
            border: OutlineInputBorder(),
          ),
          // ignore: deprecated_member_use
          onChanged: (value) {
            int age = int.tryParse(value) ?? 0;
            setState(() {
              if (age >= 75) {
                ageScore = 2;
              } else if (age >= 65) {
                ageScore = 1;
              } else {
                ageScore = 0;
              }
            });
          },
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ageScore > 0 ? Colors.blue.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Điểm tuổi: $ageScore (65-74: 1pt, ≥75: 2pts)',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: ageScore > 0 ? Colors.blue.shade700 : Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Giới tính:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile<int>(
                title: const Text('Nam'),
                subtitle: const Text('0 điểm'),
                value: 0,
                // ignore: deprecated_member_use
                groupValue: sexScore,
                // ignore: deprecated_member_use
                onChanged: (value) => setState(() => sexScore = value!),
                dense: true,
              ),
            ),
            Expanded(
              child: RadioListTile<int>(
                title: const Text('Nữ'),
                subtitle: const Text('1 điểm'),
                value: 1,
                // ignore: deprecated_member_use
                groupValue: sexScore,
                // ignore: deprecated_member_use
                onChanged: (value) => setState(() => sexScore = value!),
                dense: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
