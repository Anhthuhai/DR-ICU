import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'glasgow_coma_scale_page.dart';
import 'apache_ii_page.dart';
import 'sofa_score_page.dart';
import 'ranson_page.dart';
import 'grace_score_page.dart';
import 'crusade_bleeding_risk_page.dart';

class ClinicalScoresPage extends StatefulWidget {
  const ClinicalScoresPage({super.key});

  @override
  State<ClinicalScoresPage> createState() => _ClinicalScoresPageState();
}

class _ClinicalScoresPageState extends State<ClinicalScoresPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _scoresList => [
    {
      'title': 'Glasgow Coma Scale (GCS)',
      'subtitle': 'Đánh giá mức độ ý thức bệnh nhân',
      'description': 'Phản ứng mắt, lời nói, vận động',
      'icon': Icons.visibility,
      'color': Colors.blue.shade600,
      'page': const GlasgowComaScalePage(),
    },
    {
      'title': 'APACHE II',
      'subtitle': 'Acute Physiology and Chronic Health Evaluation',
      'description': 'Dự đoán tỷ lệ tử vong trong ICU',
      'icon': Icons.monitor_heart,
      'color': Colors.red.shade600,
      'page': const ApacheIIPage(),
    },
    {
      'title': 'SOFA Score',
      'subtitle': 'Sequential Organ Failure Assessment',
      'description': 'Đánh giá suy cơ quan đa hệ thống',
      'icon': Icons.favorite,
      'color': Colors.orange.shade600,
      'page': const SOFAScorePage(),
    },
    {
      'title': 'GRACE Score',
      'subtitle': 'Global Registry of Acute Coronary Events',
      'description': 'Đánh giá nguy cơ trong hội chứng vành cấp',
      'icon': Icons.monitor_heart_outlined,
      'color': Colors.red.shade700,
      'page': const GraceScorePage(),
    },
    {
      'title': 'CRUSADE Score',
      'subtitle': 'Bleeding Risk in ACS',
      'description': 'Đánh giá nguy cơ chảy máu trong hội chứng vành cấp',
      'icon': Icons.bloodtype,
      'color': Colors.red.shade800,
      'page': const CrusadeBleedingRiskPage(),
    },
    {
      'title': 'Ranson Criteria',
      'subtitle': 'Acute Pancreatitis Severity',
      'description': 'Đánh giá độ nặng viêm tụy cấp',
      'icon': Icons.medical_information,
      'color': Colors.brown.shade600,
      'page': const RansonPage(),
    },
  ];

  List<Map<String, dynamic>> get _filteredScores {
    if (_searchQuery.isEmpty) {
      return _scoresList;
    }
    return _scoresList.where((score) {
      return score['title'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
             score['subtitle'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
             score['description'].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thang điểm lâm sàng'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Các thang điểm thường dùng trong ICU',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.darkGrey,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Tìm kiếm thang điểm...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredScores.isEmpty && _searchQuery.isNotEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Không tìm thấy thang điểm nào',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Thử tìm kiếm với từ khóa khác',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredScores.length,
                      itemBuilder: (context, index) {
                        final score = _filteredScores[index];
                        return Column(
                          children: [
                            _buildScoreCard(
                              context,
                              score['title'],
                              score['subtitle'],
                              score['description'],
                              score['icon'],
                              score['color'],
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => score['page'],
                                  ),
                                );
                              },
                            ),
                            if (index < _filteredScores.length - 1)
                              const SizedBox(height: 12),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard(
    BuildContext context,
    String title,
    String subtitle,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
