import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class ModifiedSgarbossaCriteriaPage extends StatefulWidget {
  const ModifiedSgarbossaCriteriaPage({super.key});

  @override
  State<ModifiedSgarbossaCriteriaPage> createState() => _ModifiedSgarbossaCriteriaPageState();
}

class _ModifiedSgarbossaCriteriaPageState extends State<ModifiedSgarbossaCriteriaPage> {
  bool _concordantStElevation = false;
  bool _concordantStDepression = false;
  bool _excessiveDiscordantStElevation = false;

  int _totalScore = 0;

  void _calculateScore() {
    int score = 0;
    
    if (_concordantStElevation) {
      score += 5;
    }
    if (_concordantStDepression) {
      score += 3;
    }
    if (_excessiveDiscordantStElevation) {
      score += 2;
    }

    setState(() {
      _totalScore = score;
    });
  }

  Color get riskColor {
    if (_totalScore == 0) {
      return Colors.green;
    }
    if (_totalScore < 3) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String getInterpretation(BuildContext context) {
    if (_totalScore == 0) {
      return AppLocalizations.of(context)!.sgarbossa_no_criteria;
    }
    if (_totalScore < 3) {
      return AppLocalizations.of(context)!.sgarbossa_suspected_stemi;
    }
    return AppLocalizations.of(context)!.sgarbossa_likely_stemi;
  }

  String getRecommendation(BuildContext context) {
    if (_totalScore == 0) {
      return AppLocalizations.of(context)!.sgarbossa_recommendation_exclude;
    }
    if (_totalScore < 3) {
      return AppLocalizations.of(context)!.sgarbossa_recommendation_evaluate;
    }
    return AppLocalizations.of(context)!.sgarbossa_recommendation_urgent;
  }

  String getClinicalAction(BuildContext context) {
    if (_totalScore == 0) {
      return AppLocalizations.of(context)!.sgarbossa_action_exclude;
    }
    if (_totalScore < 3) {
      return AppLocalizations.of(context)!.sgarbossa_action_evaluate;
    }
    return AppLocalizations.of(context)!.sgarbossa_action_urgent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Main AppBar (sticky)
          SliverAppBar(
            pinned: true,
            title: Text(AppLocalizations.of(context)!.modified_sgarbossa_title),
            backgroundColor: Colors.red.shade700,
            foregroundColor: Colors.white,
          ),
          
          // Score Display Header (sticky)
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 56,
            backgroundColor: Colors.white,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: riskColor.withValues(alpha: 0.3)),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.modified_sgarbossa_short,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: riskColor,
                              ),
                            ),
                            Text(
                              getInterpretation(context),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.darkGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '$_totalScore ${AppLocalizations.of(context)!.sgarbossa_points}',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: riskColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
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
                              ? 'LƯU Ý Y KHOA TIM MẠCH: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ chuyên khoa tim mạch trước khi đưa ra quyết định điều trị.'
                              : 'CARDIOLOGY MEDICAL DISCLAIMER: Results are for reference only. Always consult with cardiologist before making treatment decisions.',
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
                // Score Display Info
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: riskColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: riskColor.withValues(alpha: 0.3)),
                  ),
                  child: _buildResultInfo(),
                ),

            // Criteria Section
            _buildCriteriaSection(),

            // Active Criteria
            if (_totalScore > 0) _buildActiveCriteria(),

            // Interpretation Guide
            _buildInterpretationGuide(),

            // Clinical Information
            _buildClinicalInfo(),

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
                        AppLocalizations.of(context)!.sgarbossa_reference_title,
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
                    AppLocalizations.of(context)!.sgarbossa_reference_text,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ],
              ),
            ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultInfo() {
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
                    AppLocalizations.of(context)!.sgarbossa_action_label,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    getClinicalAction(context),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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
                      AppLocalizations.of(context)!.sgarbossa_recommendation_label,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  getRecommendation(context),
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

  Widget _buildCriteriaSection() {
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
            AppLocalizations.of(context)!.sgarbossa_criteria_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.sgarbossa_criteria_description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.blue.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.sgarbossa_concordant_elevation_title),
            subtitle: Text(AppLocalizations.of(context)!.sgarbossa_concordant_elevation_desc),
            value: _concordantStElevation,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _concordantStElevation = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.sgarbossa_concordant_depression_title),
            subtitle: Text(AppLocalizations.of(context)!.sgarbossa_concordant_depression_desc),
            value: _concordantStDepression,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _concordantStDepression = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.sgarbossa_excessive_discordant_title),
            subtitle: Text(AppLocalizations.of(context)!.sgarbossa_excessive_discordant_desc),
            value: _excessiveDiscordantStElevation,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _excessiveDiscordantStElevation = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCriteria() {
    List<Map<String, dynamic>> activeCriteria = [];
    
    if (_concordantStElevation) {
      activeCriteria.add({
        'criterion': AppLocalizations.of(context)!.sgarbossa_concordant_elevation_title,
        'description': AppLocalizations.of(context)!.sgarbossa_concordant_elevation_desc,
        'points': 5,
      });
    }
    
    if (_concordantStDepression) {
      activeCriteria.add({
        'criterion': AppLocalizations.of(context)!.sgarbossa_concordant_depression_title,
        'description': AppLocalizations.of(context)!.sgarbossa_concordant_depression_desc,
        'points': 3,
      });
    }
    
    if (_excessiveDiscordantStElevation) {
      activeCriteria.add({
        'criterion': AppLocalizations.of(context)!.sgarbossa_excessive_discordant_title,
        'description': AppLocalizations.of(context)!.sgarbossa_excessive_discordant_desc,
        'points': 2,
      });
    }
    
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
            'Positive criteria (${activeCriteria.length})',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
          ),
          const SizedBox(height: 12),
          ...activeCriteria.map((criterion) => Container(
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

  Widget _buildInterpretationGuide() {
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
            AppLocalizations.of(context)!.sgarbossa_interpretation_guide,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildInterpretationItem(
            AppLocalizations.of(context)!.sgarbossa_interpretation_0, 
            AppLocalizations.of(context)!.sgarbossa_no_criteria, 
            AppLocalizations.of(context)!.sgarbossa_action_exclude, 
            Colors.green
          ),
          _buildInterpretationItem(
            AppLocalizations.of(context)!.sgarbossa_interpretation_1_2, 
            AppLocalizations.of(context)!.sgarbossa_suspected_stemi, 
            AppLocalizations.of(context)!.sgarbossa_action_evaluate, 
            Colors.orange
          ),
          _buildInterpretationItem(
            AppLocalizations.of(context)!.sgarbossa_interpretation_3_plus, 
            AppLocalizations.of(context)!.sgarbossa_likely_stemi, 
            AppLocalizations.of(context)!.sgarbossa_action_urgent, 
            Colors.red
          ),
        ],
      ),
    );
  }

  Widget _buildInterpretationItem(String score, String interpretation, String action, Color color) {
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
                width: 60,
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
                  interpretation,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  action,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
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
                AppLocalizations.of(context)!.sgarbossa_clinical_info_title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.sgarbossa_clinical_info_text,
            style: const TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }
}
