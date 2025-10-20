import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class GlasgowComaScalePage extends StatefulWidget {
  const GlasgowComaScalePage({super.key});

  @override
  State<GlasgowComaScalePage> createState() => _GlasgowComaScalePageState();
}

class _GlasgowComaScalePageState extends State<GlasgowComaScalePage> {
  int eyeResponse = 0;
  int verbalResponse = 0;
  int motorResponse = 0;

  int get totalScore => eyeResponse + verbalResponse + motorResponse;

  String interpretation(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (totalScore == 0) {
      return l10n.please_select_responses;
    }
    if (totalScore >= 13) {
      return l10n.mild_brain_injury;
    }
    if (totalScore >= 9) {
      return l10n.moderate_brain_injury;
    }
    if (totalScore >= 3) {
      return l10n.severe_brain_injury;
    }
    return '';
  }

  Color get scoreColor {
    if (totalScore == 0) {
      return Colors.grey;
    }
    if (totalScore >= 13) {
      return Colors.green;
    }
    if (totalScore >= 9) {
      return Colors.orange;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.glasgowComaScale),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Score Display
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: scoreColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: scoreColor.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    l10n.total_gcs_score,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                    '(E$eyeResponse + V$verbalResponse + M$motorResponse)',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.mediumGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    interpretation(context),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: scoreColor,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Assessment Sections
            Expanded(
              child: ListView(
                children: [
                  // Medical Disclaimer Banner
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
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
                  _buildAssessmentSection(
                    '${l10n.eyeResponse} (Eye Response)',
                    eyeResponse,
                    [
                      AssessmentOption(4, l10n.gcs_eye_spontaneous),
                      AssessmentOption(3, l10n.gcs_eye_to_voice),
                      AssessmentOption(2, l10n.gcs_eye_to_pain),
                      AssessmentOption(1, l10n.gcs_eye_none),
                    ],
                    (value) => setState(() => eyeResponse = value),
                    Colors.blue.shade600,
                  ),
                  const SizedBox(height: 20),
                  
                  _buildAssessmentSection(
                    '${l10n.verbalResponse} (Verbal Response)',
                    verbalResponse,
                    [
                      AssessmentOption(5, l10n.gcs_verbal_oriented),
                      AssessmentOption(4, l10n.gcs_verbal_confused),
                      AssessmentOption(3, l10n.gcs_verbal_inappropriate),
                      AssessmentOption(2, l10n.gcs_verbal_incomprehensible),
                      AssessmentOption(1, l10n.gcs_verbal_none),
                    ],
                    (value) => setState(() => verbalResponse = value),
                    Colors.green.shade600,
                  ),
                  const SizedBox(height: 20),
                  
                  _buildAssessmentSection(
                    '${l10n.motorResponse} (Motor Response)',
                    motorResponse,
                    [
                      AssessmentOption(6, l10n.gcs_motor_obeys),
                      AssessmentOption(5, l10n.gcs_motor_localizes),
                      AssessmentOption(4, l10n.gcs_motor_withdrawal),
                      AssessmentOption(3, l10n.gcs_motor_flexion),
                      AssessmentOption(2, l10n.gcs_motor_extension),
                      AssessmentOption(1, l10n.gcs_motor_none),
                    ],
                    (value) => setState(() => motorResponse = value),
                    Colors.purple.shade600,
                  ),
                  
                  // Medical Citation
                  const SizedBox(height: 16),
                  Container(
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
                              l10n.references,
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
                          'Teasdale G, Jennett B. Assessment of coma and impaired consciousness. A practical scale. Lancet. 1974;2(7872):81-4.',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.blue.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Reset Button
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    eyeResponse = 0;
                    verbalResponse = 0;
                    motorResponse = 0;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.mediumGrey,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  l10n.reset,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssessmentSection(
    String title,
    int selectedValue,
    List<AssessmentOption> options,
    Function(int) onChanged,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 12),
        ...options.map((option) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: InkWell(
            onTap: () => onChanged(option.score),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: selectedValue == option.score ? color : Colors.grey.shade300,
                  width: selectedValue == option.score ? 2 : 1,
                ),
                color: selectedValue == option.score ? color.withValues(alpha: 0.1) : null,
              ),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedValue == option.score ? color : Colors.grey.shade300,
                    ),
                    child: Center(
                      child: Text(
                        option.score.toString(),
                        style: TextStyle(
                          color: selectedValue == option.score ? Colors.white : Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      option.description,
                      style: TextStyle(
                        color: selectedValue == option.score ? color : Colors.black87,
                        fontWeight: selectedValue == option.score ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
        
        const SizedBox(height: 20),
      ],
    );
  }
}

class AssessmentOption {
  final int score;
  final String description;

  AssessmentOption(this.score, this.description);
}
