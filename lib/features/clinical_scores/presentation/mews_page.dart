import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

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

  String get interpretation {
    if (totalScore == 0) {
      return 'Vui lòng nhập các thông số sinh hiệu';
    }
    if (totalScore <= 2) {
      return 'Tình trạng ổn định - theo dõi thường quy';
    }
    if (totalScore <= 3) {
      return 'Cần tăng cường theo dõi';
    }
    if (totalScore <= 5) {
      return 'Cảnh báo - cần đánh giá y tế khẩn cấp';
    }
    return 'Cảnh báo cao - cần can thiệp ngay lập tức';
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

  String get actionRequired {
    if (totalScore <= 2) {
      return 'Theo dõi 12 giờ/lần';
    }
    if (totalScore <= 3) {
      return 'Theo dõi 4-6 giờ/lần, thông báo bác sĩ';
    }
    if (totalScore <= 5) {
      return 'Theo dõi 1 giờ/lần, gọi bác sĩ ngay';
    }
    return 'Theo dõi liên tục, báo cáo khẩn cấp';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('MEWS Score'),
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
                  'MEWS Score',
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
                  interpretation,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: scoreColor,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  actionRequired,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scoreColor,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
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
                  'Huyết áp tâm thu (mmHg)',
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
                ),
                const SizedBox(height: 16),
                
                _buildVitalSignSection(
                  'Nhịp tim (lần/phút)',
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
                ),
                const SizedBox(height: 16),
                
                _buildVitalSignSection(
                  'Nhịp thở (lần/phút)',
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
                ),
                const SizedBox(height: 16),
                
                _buildVitalSignSection(
                  'Nhiệt độ (°C)',
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
                ),
                const SizedBox(height: 16),
                
                _buildAVPUSection(),
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
                    hintText: 'Nhập giá trị',
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
                  'Điểm: $score',
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

  Widget _buildAVPUSection() {
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
                'Mức độ ý thức (AVPU)',
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
                title: const Text('Alert (Tỉnh táo)'),
                subtitle: const Text('Bệnh nhân tỉnh táo, định hướng tốt'),
                value: 0,
                // ignore: deprecated_member_use
                groupValue: avpuScore,
                // ignore: deprecated_member_use
                onChanged: (value) => setState(() => avpuScore = value!),
                dense: true,
              ),
              RadioListTile<int>(
                title: const Text('Voice (Phản ứng với tiếng nói)'),
                subtitle: const Text('Chỉ phản ứng khi gọi to'),
                value: 1,
                // ignore: deprecated_member_use
                groupValue: avpuScore,
                // ignore: deprecated_member_use
                onChanged: (value) => setState(() => avpuScore = value!),
                dense: true,
              ),
              RadioListTile<int>(
                title: const Text('Pain (Phản ứng với đau)'),
                subtitle: const Text('Chỉ phản ứng khi kích thích đau'),
                value: 2,
                // ignore: deprecated_member_use
                groupValue: avpuScore,
                // ignore: deprecated_member_use
                onChanged: (value) => setState(() => avpuScore = value!),
                dense: true,
              ),
              RadioListTile<int>(
                title: const Text('Unresponsive (Không phản ứng)'),
                subtitle: const Text('Không phản ứng với bất kỳ kích thích nào'),
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
}
