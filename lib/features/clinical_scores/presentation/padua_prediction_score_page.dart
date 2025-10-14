import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class PaduaPredictionScorePage extends StatefulWidget {
  const PaduaPredictionScorePage({super.key});

  @override
  State<PaduaPredictionScorePage> createState() => _PaduaPredictionScorePageState();
}

class _PaduaPredictionScorePageState extends State<PaduaPredictionScorePage> {
  bool _cancer = false;
  bool _previousVte = false;
  bool _reducedMobility = false;
  bool _thrombophilia = false;
  bool _recentTrauma = false;
  bool _elderlyCareHome = false;
  bool _heartFailure = false;
  bool _respiratoryFailure = false;
  bool _acuteInfection = false;
  bool _acuteRheumatic = false;
  bool _ibdStroke = false;
  bool _acuteMi = false;

  int _totalScore = 0;

  void _calculateScore() {
    int score = 0;
    
    if (_cancer) {
      score += 3;
    }
    if (_previousVte) {
      score += 3;
    }
    if (_reducedMobility) {
      score += 3;
    }
    if (_thrombophilia) {
      score += 3;
    }
    if (_recentTrauma) {
      score += 2;
    }
    if (_elderlyCareHome) {
      score += 1;
    }
    if (_heartFailure) {
      score += 1;
    }
    if (_respiratoryFailure) {
      score += 1;
    }
    if (_acuteInfection) {
      score += 1;
    }
    if (_acuteRheumatic) {
      score += 1;
    }
    if (_ibdStroke) {
      score += 1;
    }
    if (_acuteMi) {
      score += 1;
    }

    setState(() {
      _totalScore = score;
    });
  }

  Color get riskColor {
    if (_totalScore < 4) {
      return Colors.green;
    }
    return Colors.red;
  }

  String get riskLevel {
    if (_totalScore < 4) {
      return 'Nguy cơ thấp';
    }
    return 'Nguy cơ cao';
  }

  String get vteProbability {
    if (_totalScore < 4) {
      return '0.3%';
    }
    return '11%';
  }

  String get recommendations {
    if (_totalScore < 4) {
      return 'Không cần prophylaxis thuốc chống đông. Có thể sử dụng biện pháp cơ học';
    }
    return 'Cần prophylaxis thuốc chống đông nếu không có chống chỉ định';
  }

  String get prophylaxisStrategy {
    if (_totalScore < 4) {
      return 'Prophylaxis cơ học';
    }
    return 'Prophylaxis dược lý + cơ học';
  }

  List<Map<String, dynamic>> get riskFactors {
    return [
      {
        'factor': 'Ung thư',
        'description': 'Ung thư đang hoạt động (không bao gồm ung thư da)',
        'points': 3,
        'active': _cancer,
      },
      {
        'factor': 'Tiền sử VTE',
        'description': 'Tiền sử thuyên tắc tĩnh mạch (DVT/PE)',
        'points': 3,
        'active': _previousVte,
      },
      {
        'factor': 'Giảm vận động',
        'description': 'Giảm vận động (nằm giường >3 ngày)',
        'points': 3,
        'active': _reducedMobility,
      },
      {
        'factor': 'Rối loạn đông máu',
        'description': 'Rối loạn đông máu di truyền hoặc mắc phải',
        'points': 3,
        'active': _thrombophilia,
      },
      {
        'factor': 'Chấn thương gần đây',
        'description': 'Chấn thương và/hoặc phẫu thuật trong 1 tháng',
        'points': 2,
        'active': _recentTrauma,
      },
      {
        'factor': 'Tuổi ≥70',
        'description': 'Tuổi ≥70 và/hoặc suy tim và/hoặc suy hô hấp',
        'points': 1,
        'active': _elderlyCareHome,
      },
      {
        'factor': 'Suy tim',
        'description': 'Suy tim cấp và/hoặc mạn tính',
        'points': 1,
        'active': _heartFailure,
      },
      {
        'factor': 'Suy hô hấp cấp',
        'description': 'Suy hô hấp cấp',
        'points': 1,
        'active': _respiratoryFailure,
      },
      {
        'factor': 'Nhiễm trùng cấp',
        'description': 'Nhiễm trùng cấp và/hoặc bệnh thấp khớp',
        'points': 1,
        'active': _acuteInfection,
      },
      {
        'factor': 'Bệnh thấp khớp',
        'description': 'Bệnh thấp khớp đang hoạt động',
        'points': 1,
        'active': _acuteRheumatic,
      },
      {
        'factor': 'IBD/Đột quỵ',
        'description': 'Bệnh ruột viêm hoặc đột quỵ cấp',
        'points': 1,
        'active': _ibdStroke,
      },
      {
        'factor': 'Nhồi máu cơ tim',
        'description': 'Nhồi máu cơ tim cấp',
        'points': 1,
        'active': _acuteMi,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Main AppBar (sticky)
          SliverAppBar(
            pinned: true,
            title: const Text('Padua Prediction Score'),
            backgroundColor: Colors.purple.shade700,
            foregroundColor: Colors.white,
          ),
          
          // Score Display Header (sticky)
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            backgroundColor: riskColor.withValues(alpha: 0.1),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: riskColor.withValues(alpha: 0.1),
                border: Border(
                  bottom: BorderSide(color: riskColor.withValues(alpha: 0.3)),
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
                            'Padua Prediction Score',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: riskColor,
                            ),
                          ),
                          Text(
                            riskLevel,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.darkGrey,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '$_totalScore',
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

                // Risk Factors
                _buildRiskFactorsSection(),

                // Active Risk Factors
                if (_totalScore > 0) _buildActiveFactors(),

                // Risk Stratification
                _buildRiskStratification(),

                // Prophylaxis Recommendations
                _buildProphylaxisRecommendations(),

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
      margin: const EdgeInsets.only(top: 16),
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
                    'Nguy cơ VTE',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    vteProbability,
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
                    'Prophylaxis',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    prophylaxisStrategy,
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
                    Icon(Icons.medical_services, color: riskColor, size: 20),
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
        border: Border.all(color: Colors.purple.shade300),
        color: Colors.purple.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Yếu tố nguy cơ VTE',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            title: const Text('Ung thư (+3)'),
            subtitle: const Text('Ung thư đang hoạt động (không bao gồm ung thư da)'),
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
            title: const Text('Tiền sử VTE (+3)'),
            subtitle: const Text('Tiền sử thuyên tắc tĩnh mạch (DVT/PE)'),
            value: _previousVte,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _previousVte = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Giảm vận động (+3)'),
            subtitle: const Text('Giảm vận động (nằm giường >3 ngày)'),
            value: _reducedMobility,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _reducedMobility = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Rối loạn đông máu (+3)'),
            subtitle: const Text('Rối loạn đông máu di truyền hoặc mắc phải'),
            value: _thrombophilia,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _thrombophilia = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Chấn thương gần đây (+2)'),
            subtitle: const Text('Chấn thương và/hoặc phẫu thuật trong 1 tháng'),
            value: _recentTrauma,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _recentTrauma = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Tuổi ≥70 (+1)'),
            subtitle: const Text('Tuổi ≥70 và/hoặc suy tim và/hoặc suy hô hấp'),
            value: _elderlyCareHome,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _elderlyCareHome = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Suy tim (+1)'),
            subtitle: const Text('Suy tim cấp và/hoặc mạn tính'),
            value: _heartFailure,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _heartFailure = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Suy hô hấp cấp (+1)'),
            subtitle: const Text('Suy hô hấp cấp'),
            value: _respiratoryFailure,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _respiratoryFailure = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Nhiễm trùng cấp (+1)'),
            subtitle: const Text('Nhiễm trùng cấp và/hoặc bệnh thấp khớp'),
            value: _acuteInfection,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _acuteInfection = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Bệnh thấp khớp (+1)'),
            subtitle: const Text('Bệnh thấp khớp đang hoạt động'),
            value: _acuteRheumatic,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _acuteRheumatic = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('IBD/Đột quỵ (+1)'),
            subtitle: const Text('Bệnh ruột viêm hoặc đột quỵ cấp'),
            value: _ibdStroke,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _ibdStroke = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: const Text('Nhồi máu cơ tim (+1)'),
            subtitle: const Text('Nhồi máu cơ tim cấp'),
            value: _acuteMi,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _acuteMi = value!;
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
        border: Border.all(color: Colors.blue.shade300),
        color: Colors.blue.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phân tầng nguy cơ VTE',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('<4', 'Nguy cơ thấp', '0.3%', 'Prophylaxis cơ học', Colors.green),
          _buildRiskItem('≥4', 'Nguy cơ cao', '11%', 'Prophylaxis dược lý', Colors.red),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String risk, String probability, String prophylaxis, Color color) {
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
            prophylaxis,
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

  Widget _buildProphylaxisRecommendations() {
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
            'Khuyến nghị prophylaxis VTE',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildProphylaxisCard(
            'Prophylaxis cơ học',
            [
              'Tất áp lực dần',
              'Nén khí gián đoạn',
              'Vận động sớm',
              'Nâng chân khi nghỉ',
            ],
            Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildProphylaxisCard(
            'Prophylaxis dược lý',
            [
              'LMWH (Enoxaparin 40mg/ngày)',
              'UFH (5000IU x2/ngày)',
              'Fondaparinux 2.5mg/ngày',
              'DOAC (theo chỉ định)',
            ],
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildProphylaxisCard(String title, List<String> items, Color color) {
    return Container(
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
              Icon(Icons.medical_services, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(left: 28, bottom: 4),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          )),
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
            'Padua Prediction Score đánh giá nguy cơ VTE ở bệnh nhân nội khoa\n\n'
            'Ứng dụng lâm sàng:\n'
            '• Quyết định prophylaxis VTE ở bệnh nhân nội khoa\n'
            '• Cân bằng lợi ích/nguy cơ chống đông\n'
            '• Lựa chọn phương pháp prophylaxis\n'
            '• Tối ưu hóa chi phí điều trị\n\n'
            'Chống chỉ định prophylaxis dược lý:\n'
            '• Chảy máu nặng hoặc nguy cơ cao\n'
            '• Phẫu thuật não/mắt/tủy sống gần đây\n'
            '• Thiếu máu cơ tim nặng\n'
            '• Tăng huyết áp nặng không kiểm soát\n'
            '• Suy gan nặng\n'
            '• Suy thận nặng (CrCl <15ml/phút)\n\n'
            'Theo dõi trong prophylaxis:\n'
            '• Dấu hiệu chảy máu\n'
            '• Số lượng tiểu cầu\n'
            '• Chức năng thận (nếu dùng LMWH)\n'
            '• Triệu chứng VTE mới\n'
            '• Tái đánh giá khi tình trạng thay đổi',
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
            'Barbar S, et al. A risk assessment model for the identification of hospitalized medical patients at risk for venous thromboembolism: the Padua Prediction Score. J Thromb Haemost. 2010;8(11):2450-7.\n\nKahn SR, et al. Prevention of VTE in nonsurgical patients: Antithrombotic Therapy and Prevention of Thrombosis, 9th ed: American College of Chest Physicians Evidence-Based Clinical Practice Guidelines. Chest. 2012;141(2 Suppl):e195S-e226S.',
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
