import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class Curb65Page extends StatefulWidget {
  const Curb65Page({super.key});

  @override
  State<Curb65Page> createState() => _Curb65PageState();
}

class _Curb65PageState extends State<Curb65Page> {
  int confusionScore = 0;
  int bunScore = 0;  
  int respiratoryRateScore = 0;
  int sbpScore = 0;
  int ageScore = 0;

  // Unit selection for BUN
  String bunUnit = 'mg/dL';

  final TextEditingController bunController = TextEditingController();
  final TextEditingController rrController = TextEditingController();
  final TextEditingController sbpController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  int get totalScore => confusionScore + bunScore + respiratoryRateScore + sbpScore + ageScore;

  Color get scoreColor {
    if (totalScore == 0) {
      return Colors.green;
    }
    if (totalScore <= 1) {
      return Colors.yellow.shade700;
    }
    if (totalScore == 2) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String getRiskLevel(BuildContext context) {
    if (totalScore == 0) {
      return AppLocalizations.of(context)!.curb65_very_low_risk;
    }
    if (totalScore == 1) {
      return AppLocalizations.of(context)!.curb65_low_risk;
    }
    if (totalScore == 2) {
      return AppLocalizations.of(context)!.curb65_moderate_risk;
    }
    if (totalScore == 3) {
      return AppLocalizations.of(context)!.curb65_high_risk;
    }
    return AppLocalizations.of(context)!.curb65_very_high_risk;
  }

  String getMortalityRisk(BuildContext context) {
    if (totalScore == 0) {
      return AppLocalizations.of(context)!.curb65_mortality_very_low;
    }
    if (totalScore == 1) {
      return AppLocalizations.of(context)!.curb65_mortality_low;
    }
    if (totalScore == 2) {
      return AppLocalizations.of(context)!.curb65_mortality_moderate;
    }
    if (totalScore == 3) {
      return AppLocalizations.of(context)!.curb65_mortality_high;
    }
    return AppLocalizations.of(context)!.curb65_mortality_very_high;
  }

  String getRecommendation(BuildContext context) {
    if (totalScore <= 1) {
      return AppLocalizations.of(context)!.curb65_outpatient_treatment;
    }
    if (totalScore == 2) {
      return AppLocalizations.of(context)!.curb65_consider_hospital;
    }
    return AppLocalizations.of(context)!.curb65_hospital_icu;
  }

  // BUN unit conversion function
  double convertBUNToMgDL(double value, String fromUnit) {
    if (fromUnit == 'mmol/L') {
      return value * 2.8; // mmol/L to mg/dL
    }
    return value; // already in mg/dL
  }

  void calculateBUNScore(String value) {
    double bun = double.tryParse(value) ?? 0;
    if (bun > 0) {
      // Convert to mg/dL for calculation
      double bunMgDL = convertBUNToMgDL(bun, bunUnit);
      setState(() {
        bunScore = bunMgDL > 19 ? 1 : 0;
      });
    } else {
      setState(() {
        bunScore = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Main AppBar
          SliverAppBar(
            title: Text(AppLocalizations.of(context)!.curb65_title),
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            pinned: true,
            floating: false,
            snap: false,
            expandedHeight: 60,
          ),
          
          // Sticky Score Header
          SliverAppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            pinned: true,
            floating: false,
            snap: false,
            automaticallyImplyLeading: false,
            toolbarHeight: 56,
            title: Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      'CURB-65: $totalScore',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: scoreColor,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      getRiskLevel(context),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: scoreColor,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Score Display (Full)
          SliverToBoxAdapter(
            child: Container(
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
                    AppLocalizations.of(context)!.curb65_title,
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
                    getRiskLevel(context),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.curb65_mortality_rate(getMortalityRisk(context)),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    getRecommendation(context),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.darkGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // Medical Disclaimer Banner
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                          ? 'LƯU Ý Y KHOA HÔ HẤP: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ chuyên khoa hô hấp trước khi đưa ra quyết định điều trị.'
                          : 'RESPIRATORY MEDICAL DISCLAIMER: Results are for reference only. Always consult with respiratory specialist before making treatment decisions.',
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
          ),

          // Assessment sections
          SliverToBoxAdapter(child: _buildConfusionSection()),
          SliverToBoxAdapter(child: _buildBUNSectionWithUnit()),
          SliverToBoxAdapter(
            child: _buildVitalSignSection(
              AppLocalizations.of(context)!.curb65_respiratory_rate, 
              rrController, 
              Icons.air, 
              Colors.teal.shade600,
              (value) {
                int rr = int.tryParse(value) ?? 0;
                setState(() {
                  respiratoryRateScore = rr >= 30 ? 1 : 0;
                });
              },
              respiratoryRateScore,
            ),
          ),
          SliverToBoxAdapter(
            child: _buildVitalSignSection(
              AppLocalizations.of(context)!.curb65_systolic_bp, 
              sbpController, 
              Icons.favorite, 
              Colors.red.shade600,
              (value) {
                int sbp = int.tryParse(value) ?? 0;
                setState(() {
                  sbpScore = sbp < 90 ? 1 : 0;
                });
              },
              sbpScore,
            ),
          ),
          SliverToBoxAdapter(
            child: _buildVitalSignSection(
              AppLocalizations.of(context)!.curb65_age, 
              ageController, 
              Icons.person, 
              Colors.orange.shade600,
              (value) {
                int age = int.tryParse(value) ?? 0;
                setState(() {
                  ageScore = age >= 65 ? 1 : 0;
                });
              },
              ageScore,
            ),
          ),

          // Citation
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildCitationWidget(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfusionSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.shade300),
        color: Colors.purple.withValues(alpha: 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology, color: Colors.purple.shade600, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${AppLocalizations.of(context)!.curb65_confusion} ${AppLocalizations.of(context)!.curb65_confusion_subtitle}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: confusionScore > 0 ? Colors.red.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  AppLocalizations.of(context)!.curb65_score_label(confusionScore),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: confusionScore > 0 ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            children: [
              RadioListTile<int>(
                title: Text(AppLocalizations.of(context)!.curb65_no_confusion),
                subtitle: Text(AppLocalizations.of(context)!.curb65_no_confusion_desc),
                value: 0,
                // ignore: deprecated_member_use
                groupValue: confusionScore,
                // ignore: deprecated_member_use
                onChanged: (value) => setState(() => confusionScore = value!),
                dense: true,
              ),
              RadioListTile<int>(
                title: Text(AppLocalizations.of(context)!.curb65_has_confusion),
                subtitle: Text(AppLocalizations.of(context)!.curb65_has_confusion_desc),
                value: 1,
                // ignore: deprecated_member_use
                groupValue: confusionScore,
                // ignore: deprecated_member_use
                onChanged: (value) => setState(() => confusionScore = value!),
                dense: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBUNSectionWithUnit() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade600.withValues(alpha: 0.3)),
        color: Colors.blue.shade600.withValues(alpha: 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.water_drop, color: Colors.blue.shade600, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.curb65_bun,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: bunScore > 0 ? Colors.red.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  AppLocalizations.of(context)!.curb65_score_label(bunScore),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: bunScore > 0 ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: bunController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.curb65_bun_label(bunUnit),
                    border: const OutlineInputBorder(),
                    suffixText: bunUnit,
                    isDense: true,
                  ),
                  onChanged: calculateBUNScore,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  initialValue: bunUnit,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.curb65_bun_unit,
                    border: const OutlineInputBorder(),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'mg/dL', child: Text('mg/dL', style: TextStyle(fontSize: 12))),
                    DropdownMenuItem(value: 'mmol/L', child: Text('mmol/L', style: TextStyle(fontSize: 12))),
                  ],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        bunUnit = newValue;
                      });
                      calculateBUNScore(bunController.text);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.curb65_bun_scoring,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalSignSection(
    String title,
    TextEditingController controller,
    IconData icon,
    Color color,
    Function(String) onChanged,
    int score,
  ) {
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
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: score > 0 ? Colors.red.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  AppLocalizations.of(context)!.curb65_score_label(score),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: score > 0 ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.curb65_enter_value,
              border: const OutlineInputBorder(),
              suffixIcon: Icon(icon, color: color),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    bunController.dispose();
    rrController.dispose();
    sbpController.dispose();
    ageController.dispose();
    super.dispose();
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
                AppLocalizations.of(context)!.curb65_reference_title,
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
            AppLocalizations.of(context)!.curb65_reference_text,
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
