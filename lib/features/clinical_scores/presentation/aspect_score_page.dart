import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AspectScorePage extends StatefulWidget {
  const AspectScorePage({super.key});

  @override
  State<AspectScorePage> createState() => _AspectScorePageState();
}

class _AspectScorePageState extends State<AspectScorePage> {
  final Map<String, bool> _abnormalRegions = {
    'M1_cortex': false,
    'M2_cortex': false,
    'M3_cortex': false,
    'M4_cortex': false,
    'M5_cortex': false,
    'M6_cortex': false,
    'IC_internal_capsule': false,
    'L_lentiform': false,
    'C_caudate': false,
    'I_insula': false,
  };

  int _aspectScore = 10;

  void _calculateScore() {
    int score = 10;
    
    // Each abnormal region reduces the score
    for (var region in _abnormalRegions.entries) {
      if (region.value) {
        if (region.key.startsWith('M')) {
          // M1-M6 cortical regions
          score -= 1;
        } else {
          // IC, L, C, I subcortical regions  
          score -= 1;
        }
      }
    }

    setState(() {
      _aspectScore = score;
    });
  }

  Color get riskColor {
    if (_aspectScore >= 8) {
      return Colors.green;
    }
    if (_aspectScore >= 6) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String get riskLevel {
    if (_aspectScore >= 8) {
      return 'Tốt';
    }
    if (_aspectScore >= 6) {
      return 'Trung bình';
    }
    return 'Kém';
  }

  String get prognosis {
    if (_aspectScore >= 8) {
      return 'Tiên lượng tốt cho EVT';
    }
    if (_aspectScore >= 6) {
      return 'Cân nhắc EVT cẩn thận';
    }
    return 'Nguy cơ cao biến chứng';
  }

  String get recommendations {
    if (_aspectScore >= 8) {
      return 'Tiến hành EVT trong khung thời gian thích hợp';
    }
    if (_aspectScore >= 6) {
      return 'Cân nhắc EVT, đánh giá lợi ích/nguy cơ';
    }
    return 'Thận trọng với EVT, ưu tiên điều trị nội khoa';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Main AppBar (sticky)
          SliverAppBar(
            pinned: true,
            title: const Text('ASPECT Score'),
            backgroundColor: Colors.indigo.shade700,
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
                            'ASPECT Score',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: riskColor,
                            ),
                          ),
                          Text(
                            'Tiên lượng $riskLevel',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.darkGrey,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '$_aspectScore/10',
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
                // Prognosis Info
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: riskColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: riskColor.withValues(alpha: 0.3)),
                  ),
                  child: _buildPrognosisInfo(),
                ),

                // Brain Regions Assessment
                _buildBrainRegionsSection(),

                // Score Interpretation
                _buildScoreInterpretation(),

                // Clinical Guidelines
                _buildClinicalGuidelines(),

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

  Widget _buildPrognosisInfo() {
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
            children: [
              Icon(Icons.psychology, color: riskColor, size: 20),
              const SizedBox(width: 8),
              Text(
                'Tiên lượng:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: riskColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            prognosis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.darkGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
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

  Widget _buildBrainRegionsSection() {
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
            'Vùng não MCA (Middle Cerebral Artery)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          // Cortical regions
          _buildRegionCategory('Vùng vỏ não (Cortical)', [
            {'key': 'M1_cortex', 'name': 'M1: Frontal operculum, motor cortex'},
            {'key': 'M2_cortex', 'name': 'M2: Temporal pole, anterior temporal cortex'},
            {'key': 'M3_cortex', 'name': 'M3: Posterior temporal cortex'},
            {'key': 'M4_cortex', 'name': 'M4: Anterior parietal cortex'},
            {'key': 'M5_cortex', 'name': 'M5: Posterior parietal cortex'},
            {'key': 'M6_cortex', 'name': 'M6: Angular gyrus, posterior superior temporal'},
          ]),
          
          const SizedBox(height: 16),
          
          // Subcortical regions
          _buildRegionCategory('Vùng dưới vỏ (Subcortical)', [
            {'key': 'IC_internal_capsule', 'name': 'IC: Internal capsule'},
            {'key': 'L_lentiform', 'name': 'L: Lentiform nucleus'},
            {'key': 'C_caudate', 'name': 'C: Caudate nucleus'},
            {'key': 'I_insula', 'name': 'I: Insular cortex'},
          ]),
        ],
      ),
    );
  }

  Widget _buildRegionCategory(String title, List<Map<String, String>> regions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.indigo.shade600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        ...regions.map((region) => _buildRegionCheckbox(
          region['key']!,
          region['name']!,
        )),
      ],
    );
  }

  Widget _buildRegionCheckbox(String key, String name) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: _abnormalRegions[key]! ? Colors.red.withValues(alpha: 0.1) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _abnormalRegions[key]! ? Colors.red.withValues(alpha: 0.3) : Colors.grey.shade300,
        ),
      ),
      child: CheckboxListTile(
        title: Text(
          name,
          style: TextStyle(
            fontWeight: _abnormalRegions[key]! ? FontWeight.w600 : FontWeight.normal,
            color: _abnormalRegions[key]! ? Colors.red.shade700 : Colors.grey.shade700,
          ),
        ),
        subtitle: _abnormalRegions[key]! ? Text(
          'Có tổn thương (giảm 1 điểm)',
          style: TextStyle(
            color: Colors.red.shade600,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ) : null,
        value: _abnormalRegions[key],
        // ignore: deprecated_member_use
        onChanged: (value) {
          setState(() {
            _abnormalRegions[key] = value!;
          });
          _calculateScore();
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }

  Widget _buildScoreInterpretation() {
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
            'Giải thích điểm ASPECT',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildScoreItem('8-10', 'Tốt', 'Tiên lượng tốt cho EVT', 'Thực hiện EVT theo chỉ định', Colors.green),
          _buildScoreItem('6-7', 'Trung bình', 'Cân nhắc EVT', 'Đánh giá lợi ích/nguy cơ', Colors.orange),
          _buildScoreItem('0-5', 'Kém', 'Nguy cơ cao', 'Thận trọng với EVT', Colors.red),
        ],
      ),
    );
  }

  Widget _buildScoreItem(String score, String level, String prognosis, String action, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
                width: 50,
                child: Text(
                  score,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  level,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            prognosis,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
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

  Widget _buildClinicalGuidelines() {
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
            'Hướng dẫn lâm sàng',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildGuidelineCard(
            'ASPECT ≥8: EVT khuyến nghị',
            [
              'Tiên lượng tốt cho EVT',
              'Thực hiện trong khung thời gian',
              'Nguy cơ thấp biến chứng xuất huyết',
              'Kết quả chức năng tốt',
            ],
            Colors.green,
          ),
          const SizedBox(height: 12),
          _buildGuidelineCard(
            'ASPECT 6-7: Cân nhắc EVT',
            [
              'Đánh giá từng trường hợp',
              'Xem xét tuổi, thời gian',
              'Thảo luận với gia đình',
              'Theo dõi chặt chẽ',
            ],
            Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildGuidelineCard(
            'ASPECT <6: Thận trọng',
            [
              'Nguy cơ cao biến chứng',
              'Ưu tiên điều trị nội khoa',
              'Cân nhắc đặc biệt cho EVT',
              'Hỗ trợ tích cực',
            ],
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildGuidelineCard(String title, List<String> items, Color color) {
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
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
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
            'ASPECT Score đánh giá mức độ thiếu máu não cấp tính\n\n'
            'Mục đích:\n'
            '• Dự đoán kết quả EVT\n'
            '• Lựa chọn bệnh nhân phù hợp\n'
            '• Đánh giá nguy cơ biến chứng\n'
            '• Hỗ trợ quyết định lâm sàng\n\n'
            'Phương pháp đánh giá:\n'
            '• CT không cản quang\n'
            '• Đánh giá tại 2 lát cắt\n'
            '• Lát cắt qua hạch nền\n'
            '• Lát cắt trên thalamus\n\n'
            'Dấu hiệu thiếu máu:\n'
            '• Mất ranh giới chất xám-trắng\n'
            '• Giảm tỷ trọng vỏ não\n'
            '• Phù não khu trú\n'
            '• Hiệu ứng khối\n\n'
            '10 vùng đánh giá:\n'
            '• M1-M6: Vùng vỏ não MCA\n'
            '• IC: Nang trong\n'
            '• L: Nhân thấu kính\n'
            '• C: Nhân đuôi\n'
            '• I: Vỏ não đảo\n\n'
            'Ưu điểm:\n'
            '• Đơn giản, dễ thực hiện\n'
            '• Tái lập tốt\n'
            '• Dự đoán chính xác\n'
            '• Ứng dụng rộng rãi\n\n'
            'Hạn chế:\n'
            '• Phụ thuộc kinh nghiệm\n'
            '• Biến thiên giữa người đọc\n'
            '• Khó phân biệt tổn thương nhẹ\n'
            '• Không đánh giá lưu lượng\n\n'
            'Khuyến nghị:\n'
            '• Kết hợp thông tin lâm sàng\n'
            '• Xem xét perfusion imaging\n'
            '• Đánh giá toàn diện\n'
            '• Theo dõi sau điều trị',
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
            'Barber PA, et al. Validity and reliability of a quantitative computed tomography score in predicting outcome of hyperacute stroke before thrombolytic therapy. Lancet. 2000;355(9216):1670-4.\n\nPexman JH, et al. Use of the Alberta Stroke Program Early CT Score (ASPECTS) for assessing CT scans in patients with acute stroke. AJNR Am J Neuroradiol. 2001;22(8):1534-42.',
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
