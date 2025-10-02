import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

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

  String get interpretation {
    if (totalScore == 0) {
      return 'Vui lòng chọn các phản ứng';
    }
    if (totalScore >= 13) {
      return 'Chấn thương não nhẹ';
    }
    if (totalScore >= 9) {
      return 'Chấn thương não trung bình';
    }
    if (totalScore >= 3) {
      return 'Chấn thương não nặng';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Glasgow Coma Scale'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
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
                    'Tổng điểm GCS',
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
                    interpretation,
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
                  _buildAssessmentSection(
                    'Phản ứng mắt (Eye Response)',
                    eyeResponse,
                    [
                      AssessmentOption(4, 'Mở mắt tự phát'),
                      AssessmentOption(3, 'Mở mắt khi gọi'),
                      AssessmentOption(2, 'Mở mắt khi đau'),
                      AssessmentOption(1, 'Không mở mắt'),
                    ],
                    (value) => setState(() => eyeResponse = value),
                    Colors.blue.shade600,
                  ),
                  const SizedBox(height: 20),
                  
                  _buildAssessmentSection(
                    'Phản ứng lời nói (Verbal Response)',
                    verbalResponse,
                    [
                      AssessmentOption(5, 'Nói chuyện bình thường'),
                      AssessmentOption(4, 'Nói lẫn, nhầm lẫn'),
                      AssessmentOption(3, 'Nói từng từ không liên quan'),
                      AssessmentOption(2, 'Chỉ phát ra âm thanh'),
                      AssessmentOption(1, 'Không phản ứng'),
                    ],
                    (value) => setState(() => verbalResponse = value),
                    Colors.green.shade600,
                  ),
                  const SizedBox(height: 20),
                  
                  _buildAssessmentSection(
                    'Phản ứng vận động (Motor Response)',
                    motorResponse,
                    [
                      AssessmentOption(6, 'Làm theo lệnh'),
                      AssessmentOption(5, 'Định vị đau'),
                      AssessmentOption(4, 'Rút tay khi đau'),
                      AssessmentOption(3, 'Tư thế gấp bất thường'),
                      AssessmentOption(2, 'Tư thế duỗi bất thường'),
                      AssessmentOption(1, 'Không phản ứng'),
                    ],
                    (value) => setState(() => motorResponse = value),
                    Colors.purple.shade600,
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
                child: const Text(
                  'Đặt lại',
                  style: TextStyle(
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
      ],
    );
  }
}

class AssessmentOption {
  final int score;
  final String description;

  AssessmentOption(this.score, this.description);
}
