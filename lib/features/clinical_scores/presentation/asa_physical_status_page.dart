import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../l10n/app_localizations.dart';
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

  String classification(BuildContext context) {
    switch (asaClass) {
      case 1: return 'ASA I';
      case 2: return 'ASA II';
      case 3: return 'ASA III';
      case 4: return 'ASA IV';
      case 5: return 'ASA V';
      case 6: return 'ASA VI';
      default: return AppLocalizations.of(context)!.asa_not_classified;
    }
  }

  String description(BuildContext context) {
    switch (asaClass) {
      case 1: return AppLocalizations.of(context)!.asa_class_1_description;
      case 2: return AppLocalizations.of(context)!.asa_class_2_description;
      case 3: return AppLocalizations.of(context)!.asa_class_3_description;
      case 4: return AppLocalizations.of(context)!.asa_class_4_description;
      case 5: return AppLocalizations.of(context)!.asa_class_5_description;
      case 6: return AppLocalizations.of(context)!.asa_class_6_description;
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
      case 6: return 'N/A';
      default: return '';
    }
  }

  String anesthesiaRisk(BuildContext context) {
    switch (asaClass) {
      case 1: return AppLocalizations.of(context)!.asa_risk_low;
      case 2: return AppLocalizations.of(context)!.asa_risk_low_moderate;
      case 3: return AppLocalizations.of(context)!.asa_risk_moderate_high;
      case 4: return AppLocalizations.of(context)!.asa_risk_high;
      case 5: return AppLocalizations.of(context)!.asa_risk_very_high;
      case 6: return AppLocalizations.of(context)!.asa_risk_not_applicable;
      default: return '';
    }
  }

  String recommendations(BuildContext context) {
    switch (asaClass) {
      case 1: return AppLocalizations.of(context)!.asa_recommendation_class_1;
      case 2: return AppLocalizations.of(context)!.asa_recommendation_class_2;
      case 3: return AppLocalizations.of(context)!.asa_recommendation_class_3;
      case 4: return AppLocalizations.of(context)!.asa_recommendation_class_4;
      case 5: return AppLocalizations.of(context)!.asa_recommendation_class_5;
      case 6: return AppLocalizations.of(context)!.asa_recommendation_class_6;
      default: return '';
    }
  }

  List<Map<String, dynamic>> asaOptions(BuildContext context) {
    return [
      {
        'class': 1,
        'title': AppLocalizations.of(context)!.asa_class_1_title,
        'description': AppLocalizations.of(context)!.asa_class_1_description,
        'examples': AppLocalizations.of(context)!.asa_class_1_examples,
        'mortality': '0.05%',
      },
      {
        'class': 2,
        'title': AppLocalizations.of(context)!.asa_class_2_title,
        'description': AppLocalizations.of(context)!.asa_class_2_description,
        'examples': AppLocalizations.of(context)!.asa_class_2_examples,
        'mortality': '0.4%',
      },
      {
        'class': 3,
        'title': AppLocalizations.of(context)!.asa_class_3_title,
        'description': AppLocalizations.of(context)!.asa_class_3_description,
        'examples': AppLocalizations.of(context)!.asa_class_3_examples,
        'mortality': '4.3%',
      },
      {
        'class': 4,
        'title': AppLocalizations.of(context)!.asa_class_4_title,
        'description': AppLocalizations.of(context)!.asa_class_4_description,
        'examples': AppLocalizations.of(context)!.asa_class_4_examples,
        'mortality': '23.5%',
      },
      {
        'class': 5,
        'title': AppLocalizations.of(context)!.asa_class_5_title,
        'description': AppLocalizations.of(context)!.asa_class_5_description,
        'examples': AppLocalizations.of(context)!.asa_class_5_examples,
        'mortality': '50.7%',
      },
      {
        'class': 6,
        'title': AppLocalizations.of(context)!.asa_class_6_title,
        'description': AppLocalizations.of(context)!.asa_class_6_description,
        'examples': AppLocalizations.of(context)!.asa_class_6_examples,
        'mortality': 'N/A',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky AppBar
          SliverAppBar(
            title: Text(AppLocalizations.of(context)!.asa_title),
            backgroundColor: Colors.indigo.shade700,
            foregroundColor: Colors.white,
            pinned: true,
            floating: false,
            elevation: 2,
          ),
          // Sticky Score Header
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyAsaScoreHeaderDelegate(
              minHeight: 90,
              maxHeight: 100,
              child: _buildScoreCard(),
            ),
          ),
          // Main Content
          SliverList(
            delegate: SliverChildListDelegate([
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
                          ? 'LƯU Ý Y KHOA GÂY MÊ: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ gây mê hồi sức trước khi đưa ra quyết định.'
                          : 'ANESTHESIA MEDICAL DISCLAIMER: Results are for reference only. Always consult with anesthesiologist before making decisions.',
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
            // Risk Information (when ASA class is selected)
            if (asaClass > 0)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: scoreColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scoreColor.withValues(alpha: 0.3)),
                ),
                child: _buildRiskInfo(),
              ),
            
            // ASA Classifications
            _buildSection(
              AppLocalizations.of(context)!.asa_classifications,
              Colors.indigo.shade600,
              [
                ...asaOptions(context).map((option) => _buildAsaOption(option)),
              ],
            ),

            // Additional Information
            if (asaClass > 0) _buildAdditionalInfo(),

            // Medical Citation
            Container(
              margin: const EdgeInsets.all(16),
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
                        AppLocalizations.of(context)!.asa_reference_title,
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
                    AppLocalizations.of(context)!.asa_reference_text,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            ]),
          ),
        ],
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
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.asa_perioperative_mortality,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
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
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.asa_anesthesia_risk,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      anesthesiaRisk(context),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: scoreColor,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            recommendations(context),
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
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: isSelected ? optionColor.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      option['mortality'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: isSelected ? optionColor : Colors.grey.shade600,
                      ),
                      overflow: TextOverflow.ellipsis,
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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                option['examples'],
                style: TextStyle(
                  fontSize: 13,
                  color: isSelected ? optionColor : Colors.grey.shade600,
                  height: 1.3,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
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
                AppLocalizations.of(context)!.asa_important_notes,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.asa_notes_text,
            style: const TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: scoreColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: scoreColor.withValues(alpha: 0.3)),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (asaClass > 0) ...[
              // Classification
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: scoreColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  classification(context),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: scoreColor,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Description
              Expanded(
                child: Text(
                  description(context),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: scoreColor,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ] else ...[
              Icon(
                Icons.assignment,
                size: 20,
                color: Colors.grey.shade400,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.asa_select_classification,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StickyAsaScoreHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _StickyAsaScoreHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(minHeight, maxHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final currentHeight = math.max(minHeight, maxHeight - shrinkOffset);
    return SizedBox(
      height: currentHeight,
      width: double.infinity,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(_StickyAsaScoreHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
           minHeight != oldDelegate.minHeight ||
           child != oldDelegate.child;
  }
}
