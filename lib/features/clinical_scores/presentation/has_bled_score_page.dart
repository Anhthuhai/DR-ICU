import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class HasBledScorePage extends StatefulWidget {
  const HasBledScorePage({super.key});

  @override
  State<HasBledScorePage> createState() => _HasBledScorePageState();
}

class _HasBledScorePageState extends State<HasBledScorePage> {
  bool _hypertension = false;
  bool _abnormalRenal = false;
  bool _abnormalLiver = false;
  bool _stroke = false;
  bool _bleeding = false;
  bool _labileInr = false;
  bool _elderly = false;
  bool _drugs = false;
  bool _alcohol = false;

  int _totalScore = 0;

  void _calculateScore() {
    int score = 0;
    
    if (_hypertension) {
      score += 1;
    }
    if (_abnormalRenal) {
      score += 1;
    }
    if (_abnormalLiver) {
      score += 1;
    }
    if (_stroke) {
      score += 1;
    }
    if (_bleeding) {
      score += 1;
    }
    if (_labileInr) {
      score += 1;
    }
    if (_elderly) {
      score += 1;
    }
    if (_drugs) {
      score += 1;
    }
    if (_alcohol) {
      score += 1;
    }

    setState(() {
      _totalScore = score;
    });
  }

  Color get riskColor {
    if (_totalScore <= 2) {
      return Colors.green;
    }
    if (_totalScore == 3) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String get riskLevel {
    if (_totalScore <= 2) {
      return 'Nguy cơ thấp';
    }
    if (_totalScore == 3) {
      return 'Nguy cơ trung bình';
    }
    return 'Nguy cơ cao';
  }

  String get bleedingRisk {
    if (_totalScore == 0) {
      return '1.13%';
    }
    if (_totalScore == 1) {
      return '1.02%';
    }
    if (_totalScore == 2) {
      return '1.88%';
    }
    if (_totalScore == 3) {
      return '3.74%';
    }
    if (_totalScore == 4) {
      return '8.70%';
    }
    if (_totalScore == 5) {
      return '12.50%';
    }
    return '>12.50%';
  }

  String get recommendations {
    if (_totalScore <= 2) {
      return 'Có thể sử dụng thuốc chống đông với theo dõi thường quy';
    }
    if (_totalScore == 3) {
      return 'Cần thận trọng, cân nhắc lợi ích/nguy cơ, theo dõi chặt chẽ';
    }
    return 'Nguy cơ chảy máu cao, cần đánh giá kỹ lưỡng trước khi dùng thuốc chống đông';
  }

  String get clinicalApproach {
    if (_totalScore <= 2) {
      return 'Tiếp tục/bắt đầu thuốc chống đông với theo dõi định kỳ';
    }
    if (_totalScore == 3) {
      return 'Xem xét giảm liều hoặc theo dõi thường xuyên hơn';
    }
    return 'Cân nhắc ngừng thuốc chống đông hoặc chuyển sang thuốc khác';
  }

  List<Map<String, dynamic>> get riskFactors {
    return [
      {
        'factor': 'Hypertension (H)',
        'description': 'Tăng huyết áp không kiểm soát (>160 mmHg)',
        'points': 1,
        'active': _hypertension,
      },
      {
        'factor': 'Abnormal renal (A)',
        'description': 'Rối loạn chức năng thận (Cr >2.26 mg/dL)',
        'points': 1,
        'active': _abnormalRenal,
      },
      {
        'factor': 'Abnormal liver (S)',
        'description': 'Rối loạn chức năng gan (bilirubin >2x, AST/ALT >3x)',
        'points': 1,
        'active': _abnormalLiver,
      },
      {
        'factor': 'Stroke (B)',
        'description': 'Tiền sử đột quỵ',
        'points': 1,
        'active': _stroke,
      },
      {
        'factor': 'Bleeding (L)',
        'description': 'Tiền sử chảy máu hoặc xu hướng chảy máu',
        'points': 1,
        'active': _bleeding,
      },
      {
        'factor': 'Labile INR (E)',
        'description': 'INR không ổn định (TTR <60%)',
        'points': 1,
        'active': _labileInr,
      },
      {
        'factor': 'Elderly (D)',
        'description': 'Tuổi >65',
        'points': 1,
        'active': _elderly,
      },
      {
        'factor': 'Drugs',
        'description': 'Thuốc/rượu đồng thời',
        'points': 1,
        'active': _drugs,
      },
      {
        'factor': 'Alcohol',
        'description': 'Lạm dụng rượu',
        'points': 1,
        'active': _alcohol,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky App Bar
          SliverAppBar(
            title: const Text('HAS-BLED Score'),
            backgroundColor: Colors.red.shade700,
            foregroundColor: Colors.white,
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
                  color: riskColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: riskColor.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Text(
                      'HAS-BLED',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: riskColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '$_totalScore/9',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: riskColor,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        riskLevel,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: riskColor,
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
          
          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Risk Info
                _buildRiskInfo(),

                // Risk Factors
                _buildRiskFactorsSection(),

                // Active Risk Factors
                if (_totalScore > 0) _buildActiveFactors(),

                // Risk Stratification
                _buildRiskStratification(),

                // Clinical Approach
                _buildClinicalApproach(),

                // Clinical Information
                _buildClinicalInfo(),

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

  Widget _buildRiskInfo() {
    return Container(
      margin: const EdgeInsets.all(16),
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
                    'Nguy cơ chảy máu',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    bleedingRisk,
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
                    'Tiếp cận lâm sàng',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    clinicalApproach.split(' ').take(3).join(' '),
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
                      'Khuyến nghị:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  recommendations,
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

  Widget _buildRiskFactorsSection() {
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
          Text(
            'Yếu tố nguy cơ HAS-BLED',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            title: const Text('Hypertension (H) (+1)'),
            subtitle: const Text('Tăng huyết áp không kiểm soát (>160 mmHg)'),
            value: _hypertension,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _hypertension = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Abnormal renal function (A) (+1)'),
            subtitle: const Text('Rối loạn chức năng thận (Cr >2.26 mg/dL)'),
            value: _abnormalRenal,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _abnormalRenal = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Abnormal liver function (S) (+1)'),
            subtitle: const Text('Rối loạn chức năng gan (bilirubin >2x, AST/ALT >3x)'),
            value: _abnormalLiver,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _abnormalLiver = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Stroke (B) (+1)'),
            subtitle: const Text('Tiền sử đột quỵ'),
            value: _stroke,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _stroke = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Bleeding (L) (+1)'),
            subtitle: const Text('Tiền sử chảy máu hoặc xu hướng chảy máu'),
            value: _bleeding,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _bleeding = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Labile INR (E) (+1)'),
            subtitle: const Text('INR không ổn định (TTR <60%)'),
            value: _labileInr,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _labileInr = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Elderly (D) (+1)'),
            subtitle: const Text('Tuổi >65'),
            value: _elderly,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _elderly = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Drugs (+1)'),
            subtitle: const Text('Thuốc/rượu đồng thời'),
            value: _drugs,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _drugs = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Alcohol (+1)'),
            subtitle: const Text('Lạm dụng rượu'),
            value: _alcohol,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _alcohol = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildActiveFactors() {
    List<Map<String, dynamic>> activeFactors = riskFactors.where((factor) => factor['active']).toList();
    
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
            'Yếu tố nguy cơ hiện tại (${activeFactors.length})',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
          ),
          const SizedBox(height: 12),
          ...activeFactors.map((factor) => Container(
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
                      '+${factor['points']}',
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
                        factor['factor'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        factor['description'],
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

  Widget _buildRiskStratification() {
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
            'Phân tầng nguy cơ chảy máu',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('0-2', 'Nguy cơ thấp', '1.02-1.88%', 'Tiếp tục anticoagulation', Colors.green),
          _buildRiskItem('3', 'Nguy cơ trung bình', '3.74%', 'Thận trọng, theo dõi chặt', Colors.orange),
          _buildRiskItem('≥4', 'Nguy cơ cao', '>8.70%', 'Cân nhắc ngừng thuốc', Colors.red),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String risk, String bleedingRate, String action, Color color) {
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
                  bleedingRate,
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

  Widget _buildClinicalApproach() {
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
            'Tiếp cận lâm sàng',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
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
                    Icon(Icons.medical_services, color: riskColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Tiếp cận cho điểm số $_totalScore:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  clinicalApproach,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.darkGrey,
                    height: 1.4,
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
                'Thông tin lâm sàng',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'HAS-BLED Score đánh giá nguy cơ chảy máu khi dùng thuốc chống đông\n\n'
            'Ứng dụng lâm sàng:\n'
            '• Đánh giá nguy cơ chảy máu trước khi bắt đầu anticoagulation\n'
            '• Cân bằng lợi ích/nguy cơ trong điều trị\n'
            '• Quyết định liều lượng và tần suất theo dõi\n'
            '• Tư vấn bệnh nhân về nguy cơ\n\n'
            'Giải thích từng yếu tố:\n'
            '• H (Hypertension): HA tâm thu >160 mmHg\n'
            '• A (Abnormal): Cr >2.26 mg/dL hoặc chạy thận\n'
            '• S (Stroke): Tiền sử đột quỵ bất kể nguyên nhân\n'
            '• B (Bleeding): Tiền sử chảy máu nghiêm trọng\n'
            '• L (Labile): INR không ổn định, TTR <60%\n'
            '• E (Elderly): Tuổi >65\n'
            '• D (Drugs): NSAID, aspirin, corticosteroid\n\n'
            'Lưu ý quan trọng:\n'
            '• Điểm cao không có nghĩa cấm thuốc chống đông\n'
            '• Cần cân nhắc với nguy cơ thuyên tắc\n'
            '• Có thể điều chỉnh yếu tố nguy cơ\n'
            '• Theo dõi chặt chẽ nếu điểm số cao',
            style: TextStyle(height: 1.4),
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
                'Tài liệu tham khảo',
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
            'Pisters R, et al. A novel user-friendly score (HAS-BLED) to assess 1-year risk of major bleeding in patients with atrial fibrillation. Chest. 2010;138(5):1093-100.',
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
