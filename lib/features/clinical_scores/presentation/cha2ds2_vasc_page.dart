import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
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

  Color _getSolidBackgroundColor() {
    if (totalScore == 0) {
      return Colors.green.shade100;
    }
    if (totalScore == 1) {
      return Colors.yellow.shade100;
    }
    if (totalScore <= 3) {
      return Colors.orange.shade100;
    }
    return Colors.red.shade100;
  }

  String getRiskLevel(AppLocalizations localizations) {
    if (totalScore == 0) {
      return localizations.risk_very_low;
    }
    if (totalScore == 1) {
      return localizations.risk_low;
    }
    if (totalScore <= 3) {
      return localizations.risk_moderate;
    }
    return localizations.risk_high;
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

  String getAnticoagulationRecommendation(AppLocalizations localizations) {
    if (totalScore == 0) {
      return localizations.no_anticoagulation_needed;
    }
    if (totalScore == 1) {
      return localizations.consider_anticoagulation_or_aspirin;
    }
    return localizations.oral_anticoagulation_recommended;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final riskLevel = getRiskLevel(localizations);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(Localizations.localeOf(context).languageCode == 'vi' 
                ? 'Thang điểm CHA₂DS₂-VASc' 
                : 'CHA₂DS₂-VASc Score'),
            backgroundColor: Colors.teal.shade100,
            pinned: true,
            floating: false,
          ),
          SliverAppBar(
            pinned: true,
            floating: false,
            toolbarHeight: 70,
            backgroundColor: _getSolidBackgroundColor(),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: _getSolidBackgroundColor(),
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'CHA₂DS₂-VASc Score',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '$totalScore',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            riskLevel,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Medical Disclaimer Banner
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: Colors.red.shade700, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          Localizations.localeOf(context).languageCode == 'vi'
                              ? 'LƯU Ý Y KHOA: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ chuyên khoa tim mạch trước khi đưa ra quyết định điều trị.'
                              : 'MEDICAL DISCLAIMER: Results are for reference only. Always consult with a cardiologist before making treatment decisions.',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
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
                    Localizations.localeOf(context).languageCode == 'vi' 
                        ? 'Thang điểm CHA₂DS₂-VASc' 
                        : 'CHA₂DS₂-VASc Score',
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
                    getRiskLevel(localizations),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    localizations.stroke_risk_per_year(annualStrokeRisk),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    getAnticoagulationRecommendation(localizations),
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
              localizations.major_risk_factors,
              Colors.red.shade600,
              [
                _buildRiskFactorCard(
                  Localizations.localeOf(context).languageCode == 'vi' 
                      ? 'Suy tim sung huyết' 
                      : 'Congestive Heart Failure',
                  localizations.cha2ds2_chf_description,
                  Icons.favorite_border,
                  1,
                  chfScore,
                  (value) => setState(() => chfScore = value),
                ),
                _buildRiskFactorCard(
                  Localizations.localeOf(context).languageCode == 'vi' 
                      ? 'Tăng huyết áp' 
                      : 'Hypertension',
                  localizations.cha2ds2_hypertension_description,
                  Icons.trending_up,
                  1,
                  hypertensionScore,
                  (value) => setState(() => hypertensionScore = value),
                ),
                _buildRiskFactorCard(
                  Localizations.localeOf(context).languageCode == 'vi' 
                      ? 'Đái tháo đường' 
                      : 'Diabetes mellitus',
                  localizations.cha2ds2_diabetes_description,
                  Icons.bloodtype,
                  1,
                  diabetesScore,
                  (value) => setState(() => diabetesScore = value),
                ),
                _buildRiskFactorCard(
                  Localizations.localeOf(context).languageCode == 'vi' 
                      ? 'Tiền sử đột quỵ/TIA' 
                      : 'Stroke/TIA History',
                  localizations.cha2ds2_stroke_description,
                  Icons.psychology,
                  2,
                  strokeScore,
                  (value) => setState(() => strokeScore = value * 2),
                ),
                _buildRiskFactorCard(
                  Localizations.localeOf(context).languageCode == 'vi' 
                      ? 'Bệnh mạch máu' 
                      : 'Vascular Disease',
                  localizations.cha2ds2_vascular_description,
                  Icons.device_hub,
                  1,
                  vascularDiseaseScore,
                  (value) => setState(() => vascularDiseaseScore = value),
                ),
              ],
            ),

            _buildSection(
              localizations.age_and_gender_factors,
              Colors.blue.shade600,
              [
                _buildAgeSection(localizations),
                _buildGenderSection(localizations),
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
                      Icon(Icons.info_outline, color: Colors.blue.shade700),
                      const SizedBox(width: 8),
                      Text(
                        localizations.clinical_information,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${localizations.cha2ds2_vasc_usage}\n'
                    '${localizations.anticoagulation_male_recommendation}\n'
                    '${localizations.anticoagulation_consideration}\n'
                    '${localizations.hasbled_combination}',
                    style: const TextStyle(height: 1.4),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildCitationWidget(localizations),
            ),

            const SizedBox(height: 20),
          ],
        ),
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

  Widget _buildAgeSection(AppLocalizations localizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.age_label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: ageController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: localizations.enter_age,
            border: const OutlineInputBorder(),
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
            localizations.cha2ds2_age_score(ageScore),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: ageScore > 0 ? Colors.blue.shade700 : Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSection(AppLocalizations localizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          localizations.gender_label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile<int>(
                title: Text(localizations.male),
                subtitle: Text(localizations.zero_points),
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
                title: Text(localizations.female),
                subtitle: Text(localizations.one_point),
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

  Widget _buildCitationWidget(AppLocalizations localizations) {
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
                localizations.references,
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
            'Lip GY, et al. Refining clinical risk stratification for predicting stroke and thromboembolism in atrial fibrillation using a novel risk factor-based approach: the euro heart survey on atrial fibrillation. Chest. 2010;137(2):263-72.',
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
