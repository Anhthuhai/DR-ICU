import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class WellsDvtScorePage extends StatefulWidget {
  const WellsDvtScorePage({super.key});

  @override
  State<WellsDvtScorePage> createState() => _WellsDvtScorePageState();
}

class _WellsDvtScorePageState extends State<WellsDvtScorePage> {
  bool _cancer = false;
  bool _paralysis = false;
  bool _bedRest = false;
  bool _majorSurgery = false;
  bool _localizedTenderness = false;
  bool _entireLegSwollen = false;
  bool _calfSwelling = false;
  bool _pittingEdema = false;
  bool _collateralVeins = false;
  bool _previousDvt = false;
  bool _alternativeDiagnosis = false;

  int _totalScore = 0;

  void _calculateScore() {
    int score = 0;
    
    if (_cancer) {
      score += 1;
    }
    if (_paralysis) {
      score += 1;
    }
    if (_bedRest) {
      score += 1;
    }
    if (_majorSurgery) {
      score += 1;
    }
    if (_localizedTenderness) {
      score += 1;
    }
    if (_entireLegSwollen) {
      score += 1;
    }
    if (_calfSwelling) {
      score += 1;
    }
    if (_pittingEdema) {
      score += 1;
    }
    if (_collateralVeins) {
      score += 1;
    }
    if (_previousDvt) {
      score += 1;
    }
    if (_alternativeDiagnosis) {
      score -= 2;
    }

    setState(() {
      _totalScore = score;
    });
  }

  Color get riskColor {
    if (_totalScore <= 0) {
      return Colors.green;
    }
    if (_totalScore <= 2) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String get riskLevel {
    if (_totalScore <= 0) {
      return 'Nguy cơ thấp';
    }
    if (_totalScore <= 2) {
      return 'Nguy cơ trung bình';
    }
    return 'Nguy cơ cao';
  }

  String get dvtProbability {
    if (_totalScore <= 0) {
      return '3%';
    }
    if (_totalScore <= 2) {
      return '17%';
    }
    return '75%';
  }

  String get recommendations {
    if (_totalScore <= 0) {
      return 'D-dimer âm tính có thể loại trừ DVT. Nếu D-dimer dương tính, xem xét siêu âm doppler';
    }
    if (_totalScore <= 2) {
      return 'Cần làm thêm xét nghiệm D-dimer hoặc siêu âm doppler để xác định';
    }
    return 'Khả năng cao có DVT, cần siêu âm doppler ngay lập tức';
  }

  String get nextStep {
    if (_totalScore <= 0) {
      return 'Kiểm tra D-dimer';
    }
    if (_totalScore <= 2) {
      return 'D-dimer hoặc siêu âm doppler';
    }
    return 'Siêu âm doppler tức thì';
  }

  String get clinicalApproach {
    if (_totalScore <= 0) {
      return 'Nếu D-dimer (-): Loại trừ DVT\nNếu D-dimer (+): Siêu âm doppler';
    }
    if (_totalScore <= 2) {
      return 'Nếu D-dimer (-): Loại trừ DVT\nNếu D-dimer (+): Siêu âm doppler\nHoặc siêu âm doppler trực tiếp';
    }
    return 'Siêu âm doppler bắt buộc\nCân nhắc điều trị chống đông ngay';
  }

  List<Map<String, dynamic>> get criteria {
    return [
      {
        'criterion': 'Ung thư đang hoạt động',
        'description': 'Ung thư hiện tại hoặc đã điều trị trong 6 tháng',
        'points': 1,
        'active': _cancer,
      },
      {
        'criterion': 'Liệt hoặc yếu chi dưới',
        'description': 'Liệt toàn bộ hoặc yếu chi dưới gần đây',
        'points': 1,
        'active': _paralysis,
      },
      {
        'criterion': 'Nằm giường >3 ngày',
        'description': 'Nằm giường >3 ngày hoặc phẫu thuật lớn trong 4 tuần',
        'points': 1,
        'active': _bedRest,
      },
      {
        'criterion': 'Phẫu thuật lớn',
        'description': 'Phẫu thuật lớn trong vòng 4 tuần',
        'points': 1,
        'active': _majorSurgery,
      },
      {
        'criterion': 'Đau khu trú',
        'description': 'Đau khu trú theo đường tĩnh mạch sâu',
        'points': 1,
        'active': _localizedTenderness,
      },
      {
        'criterion': 'Sưng toàn chân',
        'description': 'Sưng toàn bộ chân',
        'points': 1,
        'active': _entireLegSwollen,
      },
      {
        'criterion': 'Sưng bắp chân',
        'description': 'Chu vi bắp chân >3cm so với bên đối diện',
        'points': 1,
        'active': _calfSwelling,
      },
      {
        'criterion': 'Phù lõm',
        'description': 'Phù lõm chân bị ảnh hưởng',
        'points': 1,
        'active': _pittingEdema,
      },
      {
        'criterion': 'Tĩnh mạch bàng hệ',
        'description': 'Tĩnh mạch bàng hệ phát triển (không tĩnh mạch giãn)',
        'points': 1,
        'active': _collateralVeins,
      },
      {
        'criterion': 'Tiền sử DVT',
        'description': 'Tiền sử thuyên tắc tĩnh mạch sâu',
        'points': 1,
        'active': _previousDvt,
      },
      {
        'criterion': 'Chẩn đoán khác khả thi',
        'description': 'Chẩn đoán khác khả thi hơn DVT',
        'points': -2,
        'active': _alternativeDiagnosis,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wells DVT Score'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Score Display
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: riskColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: riskColor.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    'Wells DVT Score',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_totalScore',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    riskLevel,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildRiskInfo(),
                ],
              ),
            ),

            // Clinical Criteria
            _buildCriteriaSection(),

            // Active Criteria
            if (_totalScore != 0) _buildActiveCriteria(),

            // Risk Stratification
            _buildRiskStratification(),

            // Clinical Approach
            _buildClinicalApproach(),

            // Clinical Information
            _buildClinicalInfo(),

            const SizedBox(height: 20),
          ],
        ),
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
                    'Xác suất DVT',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    dvtProbability,
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
                    'Bước tiếp theo',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    nextStep,
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
            'Tiêu chí Wells DVT',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            title: const Text('Ung thư đang hoạt động (+1)'),
            subtitle: const Text('Ung thư hiện tại hoặc đã điều trị trong 6 tháng'),
            value: _cancer,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _cancer = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Liệt hoặc yếu chi dưới (+1)'),
            subtitle: const Text('Liệt toàn bộ hoặc yếu chi dưới gần đây'),
            value: _paralysis,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _paralysis = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Nằm giường >3 ngày (+1)'),
            subtitle: const Text('Nằm giường >3 ngày hoặc phẫu thuật lớn trong 4 tuần'),
            value: _bedRest,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _bedRest = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Phẫu thuật lớn (+1)'),
            subtitle: const Text('Phẫu thuật lớn trong vòng 4 tuần'),
            value: _majorSurgery,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _majorSurgery = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Đau khu trú (+1)'),
            subtitle: const Text('Đau khu trú theo đường tĩnh mạch sâu'),
            value: _localizedTenderness,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _localizedTenderness = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Sưng toàn chân (+1)'),
            subtitle: const Text('Sưng toàn bộ chân'),
            value: _entireLegSwollen,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _entireLegSwollen = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Sưng bắp chân (+1)'),
            subtitle: const Text('Chu vi bắp chân >3cm so với bên đối diện'),
            value: _calfSwelling,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _calfSwelling = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Phù lõm (+1)'),
            subtitle: const Text('Phù lõm chân bị ảnh hưởng'),
            value: _pittingEdema,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _pittingEdema = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Tĩnh mạch bàng hệ (+1)'),
            subtitle: const Text('Tĩnh mạch bàng hệ phát triển (không tĩnh mạch giãn)'),
            value: _collateralVeins,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _collateralVeins = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Tiền sử DVT (+1)'),
            subtitle: const Text('Tiền sử thuyên tắc tĩnh mạch sâu'),
            value: _previousDvt,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _previousDvt = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Chẩn đoán khác khả thi (-2)'),
            subtitle: const Text('Chẩn đoán khác khả thi hơn DVT'),
            value: _alternativeDiagnosis,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _alternativeDiagnosis = value!;
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
    List<Map<String, dynamic>> activeCriteria = criteria.where((criterion) => criterion['active']).toList();
    
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
            'Tiêu chí hiện tại (${activeCriteria.length})',
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
                    color: criterion['points'] > 0 ? riskColor : Colors.green,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      '${criterion['points'] > 0 ? '+' : ''}${criterion['points']}',
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
            'Phân tầng nguy cơ DVT',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('≤0', 'Nguy cơ thấp', '3%', 'D-dimer để loại trừ', Colors.green),
          _buildRiskItem('1-2', 'Nguy cơ trung bình', '17%', 'D-dimer hoặc siêu âm', Colors.orange),
          _buildRiskItem('≥3', 'Nguy cơ cao', '75%', 'Siêu âm doppler tức thì', Colors.red),
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
            'Wells DVT Score đánh giá xác suất thuyên tắc tĩnh mạch sâu\n\n'
            'Cách sử dụng:\n'
            '• Đánh giá lâm sàng ban đầu nghi ngờ DVT\n'
            '• Kết hợp với D-dimer và siêu âm doppler\n'
            '• Hướng dẫn chiến lược chẩn đoán\n'
            '• Tránh làm xét nghiệm không cần thiết\n\n'
            'Lưu ý quan trọng:\n'
            '• Điểm số thấp + D-dimer âm → loại trừ DVT\n'
            '• Điểm số cao → siêu âm doppler bắt buộc\n'
            '• Luôn xem xét bối cảnh lâm sàng\n'
            '• Đánh giá lại nếu triệu chứng tiến triển\n\n'
            'Chẩn đoán khác cần xem xét:\n'
            '• Viêm tĩnh mạch nông\n'
            '• Phù do tim, gan, thận\n'
            '• Huyết khối cơ\n'
            '• Tổn thương mô mềm\n'
            '• Hội chứng chèn ép\n'
            '• Viêm khớp',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }
}
