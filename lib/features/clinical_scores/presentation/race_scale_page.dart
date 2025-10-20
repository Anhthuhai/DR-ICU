import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

class RaceScalePage extends StatefulWidget {
  const RaceScalePage({super.key});

  @override
  State<RaceScalePage> createState() => _RaceScalePageState();
}

class _RaceScalePageState extends State<RaceScalePage> {
  String _facialPalsy = '0';
  String _armMotor = '0';
  String _legMotor = '0';
  String _headEyeDeviation = '0';
  String _hemianeglect = '0';
  String _aphasia = '0';

  int _totalScore = 0;

  void _calculateScore() {
    int score = 0;
    
    score += int.parse(_facialPalsy);
    score += int.parse(_armMotor);
    score += int.parse(_legMotor);
    score += int.parse(_headEyeDeviation);
    score += int.parse(_hemianeglect);
    score += int.parse(_aphasia);

    setState(() {
      _totalScore = score;
    });
  }

  Color get riskColor {
    if (_totalScore < 5) {
      return Colors.green;
    }
    return Colors.red;
  }

  String getLvoLikelihood(BuildContext context) {
    if (_totalScore < 5) {
      return AppLocalizations.of(context)!.race_low_lvo;
    }
    return AppLocalizations.of(context)!.race_high_lvo;
  }

  String get lvoProbability {
    if (_totalScore < 5) {
      return '< 10%';
    }
    return '≥ 85%';
  }

  String getRecommendations(BuildContext context) {
    if (_totalScore < 5) {
      return AppLocalizations.of(context)!.race_recommendation_low;
    }
    return AppLocalizations.of(context)!.race_recommendation_high;
  }

  String getTimeTarget(BuildContext context) {
    if (_totalScore < 5) {
      return AppLocalizations.of(context)!.race_standard_time;
    }
    return AppLocalizations.of(context)!.race_door_to_groin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Main AppBar (sticky)
          SliverAppBar(
            pinned: true,
            title: Text(AppLocalizations.of(context)!.race_scale_title),
            backgroundColor: Colors.purple.shade700,
            foregroundColor: Colors.white,
          ),
          
          // Score Display Header (sticky)
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 56,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  bottom: BorderSide(color: riskColor.withValues(alpha: 0.3)),
                ),
              ),
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
                          AppLocalizations.of(context)!.race_scale,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: riskColor,
                          ),
                        ),
                        Text(
                          'LVO: ${getLvoLikelihood(context)}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.darkGrey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '$_totalScore/9',
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
                              ? 'LƯU Ý Y KHOA THẦN KINH: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ chuyên khoa thần kinh trước khi đưa ra quyết định điều trị.'
                              : 'NEUROLOGICAL MEDICAL DISCLAIMER: Results are for reference only. Always consult with neurologist before making treatment decisions.',
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
                
                // Risk Info
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: riskColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: riskColor.withValues(alpha: 0.3)),
                  ),
                  child: _buildRiskInfo(),
                ),

                // Assessment Items
                _buildAssessmentSection(),

                // Risk Stratification
                _buildRiskStratification(),

                // Emergency Protocol
                if (_totalScore >= 5) _buildEmergencyProtocol(),

                // Clinical Information
                _buildClinicalInfo(),

                // Medical Citation
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
                    AppLocalizations.of(context)!.race_lvo_probability,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    lvoProbability,
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
                    AppLocalizations.of(context)!.race_time_target,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    getTimeTarget(context),
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
                      AppLocalizations.of(context)!.race_recommendations,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  getRecommendations(context),
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

  Widget _buildAssessmentSection() {
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
            AppLocalizations.of(context)!.race_assessment_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.race_assessment_subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.purple.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          
          // Facial Palsy
          _buildAssessmentItem(
            AppLocalizations.of(context)!.race_facial_palsy,
            AppLocalizations.of(context)!.race_facial_palsy_instruction,
            _facialPalsy,
            [
              {'value': '0', 'text': AppLocalizations.of(context)!.race_facial_palsy_none},
              {'value': '1', 'text': AppLocalizations.of(context)!.race_facial_palsy_mild},
              {'value': '2', 'text': AppLocalizations.of(context)!.race_facial_palsy_severe},
            ],
            (value) {
              setState(() {
                _facialPalsy = value;
              });
              _calculateScore();
            },
          ),
          
          // Arm Motor
          _buildAssessmentItem(
            AppLocalizations.of(context)!.race_arm_motor,
            AppLocalizations.of(context)!.race_arm_motor_instruction,
            _armMotor,
            [
              {'value': '0', 'text': AppLocalizations.of(context)!.race_motor_normal},
              {'value': '1', 'text': AppLocalizations.of(context)!.race_motor_mild_drift},
              {'value': '2', 'text': AppLocalizations.of(context)!.race_motor_severe},
            ],
            (value) {
              setState(() {
                _armMotor = value;
              });
              _calculateScore();
            },
          ),
          
          // Leg Motor
          _buildAssessmentItem(
            AppLocalizations.of(context)!.race_leg_motor,
            AppLocalizations.of(context)!.race_leg_motor_instruction,
            _legMotor,
            [
              {'value': '0', 'text': AppLocalizations.of(context)!.race_motor_normal},
              {'value': '1', 'text': AppLocalizations.of(context)!.race_motor_mild_drift},
              {'value': '2', 'text': AppLocalizations.of(context)!.race_motor_severe},
            ],
            (value) {
              setState(() {
                _legMotor = value;
              });
              _calculateScore();
            },
          ),
          
          // Head and Eye Deviation
          _buildAssessmentItem(
            AppLocalizations.of(context)!.race_head_eye_deviation,
            AppLocalizations.of(context)!.race_head_eye_instruction,
            _headEyeDeviation,
            [
              {'value': '0', 'text': AppLocalizations.of(context)!.race_deviation_none},
              {'value': '1', 'text': AppLocalizations.of(context)!.race_deviation_present},
            ],
            (value) {
              setState(() {
                _headEyeDeviation = value;
              });
              _calculateScore();
            },
          ),
          
          // Hemianeglect
          _buildAssessmentItem(
            AppLocalizations.of(context)!.race_hemianeglect,
            AppLocalizations.of(context)!.race_hemianeglect_instruction,
            _hemianeglect,
            [
              {'value': '0', 'text': AppLocalizations.of(context)!.race_hemianeglect_normal},
              {'value': '1', 'text': AppLocalizations.of(context)!.race_hemianeglect_present},
            ],
            (value) {
              setState(() {
                _hemianeglect = value;
              });
              _calculateScore();
            },
          ),
          
          // Aphasia
          _buildAssessmentItem(
            AppLocalizations.of(context)!.race_aphasia,
            AppLocalizations.of(context)!.race_aphasia_instruction,
            _aphasia,
            [
              {'value': '0', 'text': AppLocalizations.of(context)!.race_aphasia_normal},
              {'value': '1', 'text': AppLocalizations.of(context)!.race_aphasia_mild},
              {'value': '2', 'text': AppLocalizations.of(context)!.race_aphasia_severe},
            ],
            (value) {
              setState(() {
                _aphasia = value;
              });
              _calculateScore();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentItem(
    String title,
    String instruction,
    String currentValue,
    List<Map<String, String>> options,
    Function(String) onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            instruction,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          ...options.map((option) => RadioListTile<String>(
            title: Text(option['text']!),
            value: option['value']!,
            // ignore: deprecated_member_use
            groupValue: currentValue,
            // ignore: deprecated_member_use
            onChanged: (value) => onChanged(value!),
            contentPadding: EdgeInsets.zero,
            dense: true,
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
        border: Border.all(color: Colors.blue.shade300),
        color: Colors.blue.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.race_risk_stratification,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem(AppLocalizations.of(context)!.race_risk_low_range, AppLocalizations.of(context)!.race_low_lvo, AppLocalizations.of(context)!.race_risk_low_probability, AppLocalizations.of(context)!.race_action_routine, Colors.green),
          _buildRiskItem(AppLocalizations.of(context)!.race_risk_high_range, AppLocalizations.of(context)!.race_high_lvo, AppLocalizations.of(context)!.race_risk_high_probability, AppLocalizations.of(context)!.race_action_evt, Colors.red),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String risk, String probability, String action, Color color) {
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
                  probability,
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

  Widget _buildEmergencyProtocol() {
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
                AppLocalizations.of(context)!.race_emergency_protocol,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildProtocolItem(AppLocalizations.of(context)!.race_protocol_stroke_code, AppLocalizations.of(context)!.race_protocol_stroke_code_desc, Icons.phone),
          _buildProtocolItem(AppLocalizations.of(context)!.race_protocol_ct_cta, AppLocalizations.of(context)!.race_protocol_ct_cta_desc, Icons.scanner),
          _buildProtocolItem(AppLocalizations.of(context)!.race_protocol_transfer, AppLocalizations.of(context)!.race_protocol_transfer_desc, Icons.local_hospital),
          _buildProtocolItem(AppLocalizations.of(context)!.race_protocol_tpa, AppLocalizations.of(context)!.race_protocol_tpa_desc, Icons.medication),
          _buildProtocolItem(AppLocalizations.of(context)!.race_protocol_time, AppLocalizations.of(context)!.race_protocol_time_desc, Icons.timer),
        ],
      ),
    );
  }

  Widget _buildProtocolItem(String title, String description, IconData icon) {
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
                AppLocalizations.of(context)!.race_clinical_information,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.race_clinical_info_text,
            style: const TextStyle(height: 1.4),
          ),
        ],
      ),
    );
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
                AppLocalizations.of(context)!.race_reference_title,
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
            AppLocalizations.of(context)!.race_reference_text,
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
