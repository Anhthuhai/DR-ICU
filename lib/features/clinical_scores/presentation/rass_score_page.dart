import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class RassScorePage extends StatefulWidget {
  const RassScorePage({super.key});

  @override
  State<RassScorePage> createState() => _RassScorePageState();
}

class _RassScorePageState extends State<RassScorePage> {
  int _selectedScore = 0;
  
  String get _interpretation {
    final l10n = AppLocalizations.of(context)!;
    switch (_selectedScore) {
      case 4:
        return l10n.rass_combative_interpretation;
      case 3:
        return l10n.rass_very_agitated_interpretation;
      case 2:
        return l10n.rass_agitated_interpretation;
      case 1:
        return l10n.rass_restless_interpretation;
      case 0:
        return l10n.rass_alert_calm_interpretation;
      case -1:
        return l10n.rass_drowsy_interpretation;
      case -2:
        return l10n.rass_light_sedation_interpretation;
      case -3:
        return l10n.rass_moderate_sedation_interpretation;
      case -4:
        return l10n.rass_deep_sedation_interpretation;
      case -5:
        return l10n.rass_unarousable_interpretation;
      default:
        return l10n.rass_alert_calm_interpretation;
    }
  }

  Color get _scoreColor {
    if (_selectedScore >= 2) return Colors.red;
    if (_selectedScore >= 1) return Colors.orange;
    if (_selectedScore == 0) return Colors.green;
    if (_selectedScore >= -2) return Colors.blue;
    return Colors.purple;
  }

  String get _category {
    final l10n = AppLocalizations.of(context)!;
    if (_selectedScore >= 1) return l10n.rass_agitation_category;
    if (_selectedScore == 0) return l10n.rass_alert_calm_category;
    return l10n.rass_sedation_category;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky App Bar
          SliverAppBar(
            title: Text(l10n.rass_title),
            backgroundColor: Colors.indigo.shade700,
            foregroundColor: Colors.white,
            centerTitle: true,
            floating: false,
            pinned: true,
            snap: false,
            expandedHeight: 0,
          ),
          
          // Sticky Score Header
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            flexibleSpace: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _scoreColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _scoreColor.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Text(
                      'RASS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _scoreColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '$_selectedScore',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _scoreColor,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        _category,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: _scoreColor,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Medical Disclaimer Banner
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade300),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.red.shade600, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.medical_disclaimer_professional_only,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(context)!.medical_disclaimer_rass_text,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                // RASS Score Selection
                _buildRassScoreSelection(),
                
                // Interpretation
                _buildInterpretation(),
                
                // RASS Scale Reference
                _buildRassScale(),
                
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
                            l10n.rass_reference_title,
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
                        l10n.rass_reference_text,
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

  Widget _buildRassScoreSelection() {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade300),
        color: Colors.indigo.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.rass_score_selection_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          // Agitation Scores (+1 to +4)
          _buildScoreSection(l10n.rass_agitation_section, [4, 3, 2, 1]),
          
          const SizedBox(height: 16),
          
          // Alert and Calm (0)
          _buildScoreSection(l10n.rass_alert_section, [0]),
          
          const SizedBox(height: 16),
          
          // Sedation Scores (-1 to -5)
          _buildScoreSection(l10n.rass_sedation_section, [-1, -2, -3, -4, -5]),
        ],
      ),
    );
  }

  Widget _buildScoreSection(String title, List<int> scores) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.indigo.shade600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        ...scores.map((score) => _buildScoreOption(score)),
      ],
    );
  }

  Widget _buildScoreOption(int score) {
    final l10n = AppLocalizations.of(context)!;
    String description;
    
    switch (score) {
      case 4:
        description = l10n.rass_score_4_description;
        break;
      case 3:
        description = l10n.rass_score_3_description;
        break;
      case 2:
        description = l10n.rass_score_2_description;
        break;
      case 1:
        description = l10n.rass_score_1_description;
        break;
      case 0:
        description = l10n.rass_score_0_description;
        break;
      case -1:
        description = l10n.rass_score_neg1_description;
        break;
      case -2:
        description = l10n.rass_score_neg2_description;
        break;
      case -3:
        description = l10n.rass_score_neg3_description;
        break;
      case -4:
        description = l10n.rass_score_neg4_description;
        break;
      case -5:
        description = l10n.rass_score_neg5_description;
        break;
      default:
        description = '';
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: RadioListTile<int>(
        title: Text(
          '${score >= 0 ? '+' : ''}$score: $description',
          style: const TextStyle(fontSize: 13),
        ),
        value: score,
        // ignore: deprecated_member_use
        groupValue: _selectedScore,
        // ignore: deprecated_member_use
        onChanged: (value) => setState(() => _selectedScore = value!),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildInterpretation() {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _scoreColor.withValues(alpha: 0.3)),
        color: _scoreColor.withValues(alpha: 0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.rass_interpretation_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: _scoreColor,
            ),
          ),
          const SizedBox(height: 12),
          
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.rass_current_level_label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _scoreColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _interpretation,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRassScale() {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.rass_scale_reference_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          // Reference table for quick view
          Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            children: [
              // Header
              TableRow(
                decoration: BoxDecoration(color: Colors.grey.shade100),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      l10n.rass_score_column,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      l10n.rass_description_column,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              // Scores
              for (int score in [4, 3, 2, 1, 0, -1, -2, -3, -4, -5])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '${score >= 0 ? '+' : ''}$score',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: score == _selectedScore ? FontWeight.bold : FontWeight.normal,
                          color: score == _selectedScore ? _scoreColor : null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        _getScoreDescription(score),
                        style: TextStyle(
                          fontWeight: score == _selectedScore ? FontWeight.bold : FontWeight.normal,
                          color: score == _selectedScore ? _scoreColor : null,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _getScoreDescription(int score) {
    final l10n = AppLocalizations.of(context)!;
    switch (score) {
      case 4: return l10n.rass_score_4_description;
      case 3: return l10n.rass_score_3_description;
      case 2: return l10n.rass_score_2_description;
      case 1: return l10n.rass_score_1_description;
      case 0: return l10n.rass_score_0_description;
      case -1: return l10n.rass_score_neg1_description;
      case -2: return l10n.rass_score_neg2_description;
      case -3: return l10n.rass_score_neg3_description;
      case -4: return l10n.rass_score_neg4_description;
      case -5: return l10n.rass_score_neg5_description;
      default: return '';
    }
  }

  Widget _buildClinicalInfo() {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.green.shade50,
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.green.shade600),
              const SizedBox(width: 8),
              Text(
                l10n.rass_clinical_info_title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            l10n.rass_clinical_info_content.replaceAll('\\n', '\n'),
            style: const TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }
}
