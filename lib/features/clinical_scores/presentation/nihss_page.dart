// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class NihssPage extends StatefulWidget {
  const NihssPage({super.key});

  @override
  State<NihssPage> createState() => _NihssPageState();
}

class _NihssPageState extends State<NihssPage> {
  Map<String, int> scores = {
    'consciousness': 0,
    'questions': 0,
    'commands': 0,
    'gaze': 0,
    'visual': 0,
    'facial': 0,
    'leftArm': 0,
    'rightArm': 0,
    'leftLeg': 0,
    'rightLeg': 0,
    'ataxia': 0,
    'sensory': 0,
    'language': 0,
    'dysarthria': 0,
    'extinction': 0,
  };

  int get totalScore => scores.values.fold(0, (sum, score) => sum + score);

  Color get severityColor {
    if (totalScore <= 4) {
      return Colors.green;
    }
    if (totalScore <= 15) {
      return Colors.orange;
    }
    if (totalScore <= 20) {
      return Colors.red;
    }
    return Colors.red.shade800;
  }

  Color _getSolidBackgroundColor() {
    if (totalScore <= 4) {
      return Colors.green.shade100;
    }
    if (totalScore <= 15) {
      return Colors.orange.shade100;
    }
    if (totalScore <= 20) {
      return Colors.red.shade100;
    }
    return Colors.red.shade200;
  }

  String severity(AppLocalizations l10n) {
    if (totalScore <= 4) {
      return l10n.nihss_mild_stroke;
    }
    if (totalScore <= 15) {
      return l10n.nihss_moderate_stroke;
    }
    if (totalScore <= 20) {
      return l10n.nihss_severe_stroke;
    }
    return l10n.nihss_very_severe_stroke;
  }

  String prognosis(AppLocalizations l10n) {
    if (totalScore <= 4) {
      return l10n.nihss_good_prognosis;
    }
    if (totalScore <= 15) {
      return l10n.nihss_fair_prognosis;
    }
    if (totalScore <= 20) {
      return l10n.nihss_poor_prognosis;
    }
    return l10n.nihss_very_poor_prognosis;
  }

  String recommendations(AppLocalizations l10n) {
    if (totalScore <= 4) {
      return l10n.nihss_recommendation_mild;
    }
    if (totalScore <= 15) {
      return l10n.nihss_recommendation_moderate;
    }
    if (totalScore <= 20) {
      return l10n.nihss_recommendation_severe;
    }
    return l10n.nihss_recommendation_very_severe;
  }

  List<Map<String, dynamic>> nihssItems(AppLocalizations l10n) {
    return [
      {
        'key': 'consciousness',
        'title': l10n.nihss_1a_consciousness,
        'options': [
          {'value': 0, 'text': l10n.nihss_consciousness_0},
          {'value': 1, 'text': l10n.nihss_consciousness_1},
          {'value': 2, 'text': l10n.nihss_consciousness_2},
          {'value': 3, 'text': l10n.nihss_consciousness_3},
        ],
      },
      {
        'key': 'questions',
        'title': l10n.nihss_1b_questions,
        'options': [
          {'value': 0, 'text': l10n.nihss_questions_0},
          {'value': 1, 'text': l10n.nihss_questions_1},
          {'value': 2, 'text': l10n.nihss_questions_2},
        ],
      },
      {
        'key': 'commands',
        'title': l10n.nihss_1c_commands,
        'options': [
          {'value': 0, 'text': l10n.nihss_commands_0},
          {'value': 1, 'text': l10n.nihss_commands_1},
          {'value': 2, 'text': l10n.nihss_commands_2},
        ],
      },
      {
        'key': 'gaze',
        'title': l10n.nihss_2_gaze,
        'options': [
          {'value': 0, 'text': l10n.nihss_gaze_0},
          {'value': 1, 'text': l10n.nihss_gaze_1},
          {'value': 2, 'text': l10n.nihss_gaze_2},
        ],
      },
      {
        'key': 'visual',
        'title': l10n.nihss_3_visual,
        'options': [
          {'value': 0, 'text': l10n.nihss_visual_0},
          {'value': 1, 'text': l10n.nihss_visual_1},
          {'value': 2, 'text': l10n.nihss_visual_2},
          {'value': 3, 'text': l10n.nihss_visual_3},
        ],
      },
      {
        'key': 'facial',
        'title': l10n.nihss_4_facial,
        'options': [
          {'value': 0, 'text': l10n.nihss_facial_0},
          {'value': 1, 'text': l10n.nihss_facial_1},
          {'value': 2, 'text': l10n.nihss_facial_2},
          {'value': 3, 'text': l10n.nihss_facial_3},
        ],
      },
      {
        'key': 'leftArm',
        'title': l10n.nihss_5a_left_arm,
        'options': [
          {'value': 0, 'text': l10n.nihss_arm_0},
          {'value': 1, 'text': l10n.nihss_arm_1},
          {'value': 2, 'text': l10n.nihss_arm_2},
          {'value': 3, 'text': l10n.nihss_arm_3},
          {'value': 4, 'text': l10n.nihss_arm_4},
        ],
      },
      {
        'key': 'rightArm',
        'title': l10n.nihss_5b_right_arm,
        'options': [
          {'value': 0, 'text': l10n.nihss_arm_0},
          {'value': 1, 'text': l10n.nihss_arm_1},
          {'value': 2, 'text': l10n.nihss_arm_2},
          {'value': 3, 'text': l10n.nihss_arm_3},
          {'value': 4, 'text': l10n.nihss_arm_4},
        ],
      },
      {
        'key': 'leftLeg',
        'title': l10n.nihss_6a_left_leg,
        'options': [
          {'value': 0, 'text': l10n.nihss_leg_0},
          {'value': 1, 'text': l10n.nihss_leg_1},
          {'value': 2, 'text': l10n.nihss_leg_2},
          {'value': 3, 'text': l10n.nihss_leg_3},
          {'value': 4, 'text': l10n.nihss_leg_4},
        ],
      },
      {
        'key': 'rightLeg',
        'title': l10n.nihss_6b_right_leg,
        'options': [
          {'value': 0, 'text': l10n.nihss_leg_0},
          {'value': 1, 'text': l10n.nihss_leg_1},
          {'value': 2, 'text': l10n.nihss_leg_2},
          {'value': 3, 'text': l10n.nihss_leg_3},
          {'value': 4, 'text': l10n.nihss_leg_4},
        ],
      },
      {
        'key': 'ataxia',
        'title': l10n.nihss_7_ataxia,
        'options': [
          {'value': 0, 'text': l10n.nihss_ataxia_0},
          {'value': 1, 'text': l10n.nihss_ataxia_1},
          {'value': 2, 'text': l10n.nihss_ataxia_2},
        ],
      },
      {
        'key': 'sensory',
        'title': l10n.nihss_8_sensory,
        'options': [
          {'value': 0, 'text': l10n.nihss_sensory_0},
          {'value': 1, 'text': l10n.nihss_sensory_1},
          {'value': 2, 'text': l10n.nihss_sensory_2},
        ],
      },
      {
        'key': 'language',
        'title': l10n.nihss_9_language,
        'options': [
          {'value': 0, 'text': l10n.nihss_language_0},
          {'value': 1, 'text': l10n.nihss_language_1},
          {'value': 2, 'text': l10n.nihss_language_2},
          {'value': 3, 'text': l10n.nihss_language_3},
        ],
      },
      {
        'key': 'dysarthria',
        'title': l10n.nihss_10_dysarthria,
        'options': [
          {'value': 0, 'text': l10n.nihss_dysarthria_0},
          {'value': 1, 'text': l10n.nihss_dysarthria_1},
          {'value': 2, 'text': l10n.nihss_dysarthria_2},
        ],
      },
      {
        'key': 'extinction',
        'title': l10n.nihss_11_extinction,
        'options': [
          {'value': 0, 'text': l10n.nihss_extinction_0},
          {'value': 1, 'text': l10n.nihss_extinction_1},
          {'value': 2, 'text': l10n.nihss_extinction_2},
        ],
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Main AppBar (sticky)
          SliverAppBar(
            pinned: true,
            title: Text(l10n.nihss_score),
            backgroundColor: Colors.purple.shade700,
            foregroundColor: Colors.white,
          ),
          
          // Score Display Header (sticky)
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            backgroundColor: _getSolidBackgroundColor(),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: _getSolidBackgroundColor(),
                border: Border(
                  bottom: BorderSide(color: severityColor, width: 2),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            l10n.nihss_score_display,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: severityColor,
                            ),
                          ),
                          Text(
                            severity(l10n),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '$totalScore/42',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: severityColor,
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
                // Prognosis Info
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: severityColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: severityColor.withValues(alpha: 0.3)),
                  ),
                  child: _buildPrognosisInfo(l10n),
                ),

                // Assessment Items
                ...nihssItems(l10n).map((item) => _buildAssessmentItem(item, l10n)),

                // Reference and Clinical Info
                _buildBottomInfo(l10n),
                
                const SizedBox(height: 16),
                _buildCitationWidget(l10n),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrognosisInfo(AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timeline, color: severityColor),
              const SizedBox(width: 8),
              Text(
                l10n.prognosis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: severityColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            prognosis(l10n),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.medical_services, color: severityColor),
              const SizedBox(width: 8),
              Text(
                l10n.recommendations,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: severityColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            recommendations(l10n),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentItem(Map<String, dynamic> item, AppLocalizations l10n) {
    String key = item['key'];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        elevation: 2,
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Text(
            item['title'],
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            '${l10n.score_label}: ${scores[key]}',
            style: TextStyle(
              color: severityColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          children: [
            Column(
              children: item['options'].map<Widget>((option) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Radio<int>(
                    value: option['value'],
                    groupValue: scores[key],
                    onChanged: (value) {
                      setState(() {
                        scores[key] = value!;
                      });
                    },
                  ),
                  title: Text(
                    option['text'],
                    style: const TextStyle(fontSize: 14),
                  ),
                  onTap: () {
                    setState(() {
                      scores[key] = option['value'];
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomInfo(AppLocalizations l10n) {
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
                l10n.nihss_severity_classification,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildSeverityItem(l10n.nihss_score_range_mild, l10n.nihss_mild_stroke, Colors.green),
          _buildSeverityItem(l10n.nihss_score_range_moderate, l10n.nihss_moderate_stroke, Colors.orange),
          _buildSeverityItem(l10n.nihss_score_range_severe, l10n.nihss_severe_stroke, Colors.red),
          _buildSeverityItem(l10n.nihss_score_range_very_severe, l10n.nihss_very_severe_stroke, Colors.red.shade800),
          const SizedBox(height: 12),
          Text(
            l10n.nihss_clinical_note,
            style: const TextStyle(fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildSeverityItem(String range, String severity, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
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
              severity,
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCitationWidget(AppLocalizations l10n) {
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
                l10n.reference_materials,
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
            'Brott T, et al. Measurements of acute cerebral infarction: a clinical examination scale. Stroke. 1989;20(7):864-70.\n'
            'Lyden P, et al. Improved reliability of the NIH Stroke Scale using video training. Stroke. 1994;25(11):2220-6.',
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
