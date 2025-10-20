import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class MEWSPage extends StatefulWidget {
  const MEWSPage({super.key});

  @override
  State<MEWSPage> createState() => _MEWSPageState();
}

class _MEWSPageState extends State<MEWSPage> {
  // MEWS component scores
  int systolicBPScore = 0;
  int heartRateScore = 0;
  int respiratoryRateScore = 0;
  int temperatureScore = 0;
  int avpuScore = 0;

  // Controllers for inputs
  final TextEditingController systolicBPController = TextEditingController();
  final TextEditingController heartRateController = TextEditingController();
  final TextEditingController respiratoryRateController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();

  int get totalScore => systolicBPScore + heartRateScore + respiratoryRateScore + 
                       temperatureScore + avpuScore;

  String getInterpretation(AppLocalizations localizations) {
    if (totalScore == 0) {
      return localizations.mews_interpretation_enter_data;
    }
    if (totalScore <= 2) {
      return localizations.mews_interpretation_stable;
    }
    if (totalScore <= 3) {
      return localizations.mews_interpretation_increased;
    }
    if (totalScore <= 5) {
      return localizations.mews_interpretation_warning;
    }
    return localizations.mews_interpretation_critical;
  }

  Color get scoreColor {
    if (totalScore == 0) {
      return Colors.grey;
    }
    if (totalScore <= 2) {
      return Colors.green;
    }
    if (totalScore <= 3) {
      return Colors.yellow.shade700;
    }
    if (totalScore <= 5) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String getActionRequired(AppLocalizations localizations) {
    if (totalScore <= 2) {
      return localizations.mews_action_routine;
    }
    if (totalScore <= 3) {
      return localizations.mews_action_increased;
    }
    if (totalScore <= 5) {
      return localizations.mews_action_urgent;
    }
    return localizations.mews_action_critical;
  }

  @override
  void dispose() {
    systolicBPController.dispose();
    heartRateController.dispose();
    respiratoryRateController.dispose();
    temperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.mews_title),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetAll,
          ),
        ],
      ),
      body: Column(
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
                  Localizations.localeOf(context).languageCode == 'vi' 
                      ? 'Thang điểm MEWS' 
                      : 'MEWS Score',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.darkGrey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  totalScore.toString(),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: scoreColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '(BP$systolicBPScore + HR$heartRateScore + RR$respiratoryRateScore + T$temperatureScore + A$avpuScore)',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.mediumGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  getInterpretation(localizations),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: scoreColor,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  getActionRequired(localizations),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scoreColor,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Medical Disclaimer Banner
          Container(
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
                        ? 'LƯU Ý Y KHOA: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ chuyên khoa trước khi đưa ra quyết định điều trị.'
                        : 'MEDICAL DISCLAIMER: Results are for reference only. Always consult with a specialist before making treatment decisions.',
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

          // Parameters
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildVitalSignSection(
                  localizations.mews_systolic_bp,
                  systolicBPController,
                  Icons.favorite,
                  Colors.red.shade600,
                  (value) {
                    int sbp = int.tryParse(value) ?? 0;
                    setState(() {
                      if (sbp <= 70) {
                        systolicBPScore = 3;
                      } else if (sbp <= 80) {
                        systolicBPScore = 2;
                      } else if (sbp <= 100) {
                        systolicBPScore = 1;
                      } else if (sbp <= 199) {
                        systolicBPScore = 0;
                      } else {
                        systolicBPScore = 2;
                      }
                    });
                  },
                  systolicBPScore,
                  localizations,
                ),
                const SizedBox(height: 16),
                
                _buildVitalSignSection(
                  localizations.mews_heart_rate,
                  heartRateController,
                  Icons.monitor_heart,
                  Colors.blue.shade600,
                  (value) {
                    int hr = int.tryParse(value) ?? 0;
                    setState(() {
                      if (hr < 40) {
                        heartRateScore = 2;
                      } else if (hr <= 50) {
                        heartRateScore = 1;
                      } else if (hr <= 100) {
                        heartRateScore = 0;
                      } else if (hr <= 110) {
                        heartRateScore = 1;
                      } else if (hr <= 129) {
                        heartRateScore = 2;
                      } else {
                        heartRateScore = 3;
                      }
                    });
                  },
                  heartRateScore,
                  localizations,
                ),
                const SizedBox(height: 16),
                
                _buildVitalSignSection(
                  localizations.mews_respiratory_rate,
                  respiratoryRateController,
                  Icons.air,
                  Colors.teal.shade600,
                  (value) {
                    int rr = int.tryParse(value) ?? 0;
                    setState(() {
                      if (rr < 9) {
                        respiratoryRateScore = 2;
                      } else if (rr <= 14) {
                        respiratoryRateScore = 0;
                      } else if (rr <= 20) {
                        respiratoryRateScore = 1;
                      } else if (rr <= 29) {
                        respiratoryRateScore = 2;
                      } else {
                        respiratoryRateScore = 3;
                      }
                    });
                  },
                  respiratoryRateScore,
                  localizations,
                ),
                const SizedBox(height: 16),
                
                _buildVitalSignSection(
                  localizations.mews_temperature,
                  temperatureController,
                  Icons.device_thermostat,
                  Colors.orange.shade600,
                  (value) {
                    double temp = double.tryParse(value) ?? 0;
                    setState(() {
                      if (temp < 35.0) {
                        temperatureScore = 2;
                      } else if (temp <= 38.4) {
                        temperatureScore = 0;
                      } else {
                        temperatureScore = 2;
                      }
                    });
                  },
                  temperatureScore,
                  localizations,
                ),
                const SizedBox(height: 16),
                
                _buildAVPUSection(localizations),
                
                // Medical Citation
                const SizedBox(height: 16),
                _buildCitationWidget(localizations),
                
                const SizedBox(height: 20),
              ],
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
    AppLocalizations localizations,
  ) {
    return Container(
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
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    isDense: true,
                    hintText: localizations.mews_enter_value,
                  ),
                  // ignore: deprecated_member_use
                  onChanged: null,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: score == 0 ? Colors.green : 
                         score <= 2 ? Colors.orange : Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  localizations.mews_score_label(score),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAVPUSection(AppLocalizations localizations) {
    return Container(
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
              Text(
                localizations.mews_consciousness_level,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            children: [
              RadioListTile<int>(
                title: Text(localizations.mews_avpu_alert),
                subtitle: Text(localizations.mews_avpu_alert_subtitle),
                value: 0,
                // ignore: deprecated_member_use
                groupValue: avpuScore,
                // ignore: deprecated_member_use
                onChanged: (value) => setState(() => avpuScore = value!),
                dense: true,
              ),
              RadioListTile<int>(
                title: Text(localizations.mews_avpu_voice),
                subtitle: Text(localizations.mews_avpu_voice_subtitle),
                value: 1,
                // ignore: deprecated_member_use
                groupValue: avpuScore,
                // ignore: deprecated_member_use
                onChanged: (value) => setState(() => avpuScore = value!),
                dense: true,
              ),
              RadioListTile<int>(
                title: Text(localizations.mews_avpu_pain),
                subtitle: Text(localizations.mews_avpu_pain_subtitle),
                value: 2,
                // ignore: deprecated_member_use
                groupValue: avpuScore,
                // ignore: deprecated_member_use
                onChanged: (value) => setState(() => avpuScore = value!),
                dense: true,
              ),
              RadioListTile<int>(
                title: Text(localizations.mews_avpu_unresponsive),
                subtitle: Text(localizations.mews_avpu_unresponsive_subtitle),
                value: 3,
                // ignore: deprecated_member_use
                groupValue: avpuScore,
                // ignore: deprecated_member_use
                onChanged: (value) => setState(() => avpuScore = value!),
                dense: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _resetAll() {
    setState(() {
      systolicBPScore = heartRateScore = respiratoryRateScore = 0;
      temperatureScore = avpuScore = 0;
    });
    
    systolicBPController.clear();
    heartRateController.clear();
    respiratoryRateController.clear();
    temperatureController.clear();
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
                localizations.mews_references_title,
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
            'Subbe CP, et al. Validation of a modified Early Warning Score in medical admissions. QJM. 2001;94(10):521-6.\n\nGoldhill DR, et al. A physiologically-based early warning score for ward patients: the association between score and outcome. Anaesthesia. 2005;60(6):547-53.',
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
