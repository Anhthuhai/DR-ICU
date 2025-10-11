import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'glasgow_coma_scale_page.dart';
import 'apache_ii_page.dart';
import 'sofa_score_page.dart';
import 'ranson_page.dart';
import 'grace_score_page.dart';
import 'crusade_bleeding_risk_page.dart';
import 'qsofa_score_page.dart';
import 'timi_stemi_page.dart';
import 'timi_ua_nstemi_page.dart';
import 'saps_ii_page.dart';
import 'mews_page.dart';
import 'pews_score_page.dart';
import 'has_bled_score_page.dart';
import 'improve_bleeding_risk_page.dart';
import 'cha2ds2_vasc_page.dart';
import 'wells_dvt_score_page.dart';
import 'padua_prediction_score_page.dart';
import 'abcd2_page.dart';
import 'nihss_page.dart';
import 'race_scale_page.dart';
import 'aspect_score_page.dart';
import 'modified_sgarbossa_criteria_page.dart';
import 'child_pugh_page.dart';
import 'meld_score_page.dart';
import 'curb65_page.dart';
import 'psi_page.dart';
import 'asa_physical_status_page.dart';
import 'revised_cardiac_risk_index_page.dart';
import 'surgical_apgar_score_page.dart';
import 'preoperative_mortality_prediction_page.dart';
import 'dapt_score_page.dart';
import 'creatinine_clearance_page.dart';
import 'mdrd_gfr_page.dart';

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
    // Core ICU Scores
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
      'title': 'SAPS II',
      'subtitle': 'Simplified Acute Physiology Score',
      'description': 'Dự đoán tỷ lệ tử vong bệnh nhân ICU',
      'icon': Icons.analytics,
      'color': Colors.purple.shade600,
      'page': const SAPSII(),
    },
    {
      'title': 'qSOFA Score',
      'subtitle': 'Quick Sequential Organ Failure Assessment',
      'description': 'Sàng lọc nhiễm trùng huyết ngoài ICU',
      'icon': Icons.speed,
      'color': Colors.teal.shade600,
      'page': const QsofaScorePage(),
    },
    
    // Early Warning Systems
    {
      'title': 'MEWS',
      'subtitle': 'Modified Early Warning Score',
      'description': 'Hệ thống cảnh báo sớm tình trạng bệnh nhân',
      'icon': Icons.warning_amber,
      'color': Colors.amber.shade600,
      'page': const MEWSPage(),
    },
    {
      'title': 'PEWS',
      'subtitle': 'Pediatric Early Warning Score',
      'description': 'Hệ thống cảnh báo sớm cho trẻ em',
      'icon': Icons.child_care,
      'color': Colors.pink.shade600,
      'page': const PewsScorePage(),
    },
    
    // Cardiovascular Scores
    {
      'title': 'GRACE Score',
      'subtitle': 'Global Registry of Acute Coronary Events',
      'description': 'Đánh giá nguy cơ trong hội chứng vành cấp',
      'icon': Icons.monitor_heart_outlined,
      'color': Colors.red.shade700,
      'page': const GraceScorePage(),
    },
    {
      'title': 'TIMI STEMI',
      'subtitle': 'TIMI Risk Score for STEMI',
      'description': 'Đánh giá nguy cơ tử vong trong STEMI',
      'icon': Icons.favorite_border,
      'color': Colors.red.shade500,
      'page': const TimiStemiPage(),
    },
    {
      'title': 'TIMI UA/NSTEMI',
      'subtitle': 'TIMI Risk Score for UA/NSTEMI',
      'description': 'Đánh giá nguy cơ trong UA/NSTEMI',
      'icon': Icons.monitor_heart,
      'color': Colors.red.shade400,
      'page': const TimiUaNstemiPage(),
    },
    
    // Bleeding Risk Scores
    {
      'title': 'CRUSADE Score',
      'subtitle': 'Bleeding Risk in ACS',
      'description': 'Đánh giá nguy cơ chảy máu trong hội chứng vành cấp',
      'icon': Icons.bloodtype,
      'color': Colors.red.shade800,
      'page': const CrusadeBleedingRiskPage(),
    },
    {
      'title': 'HAS-BLED Score',
      'subtitle': 'Bleeding Risk Assessment',
      'description': 'Đánh giá nguy cơ chảy máu khi điều trị chống đông',
      'icon': Icons.water_drop,
      'color': Colors.red.shade600,
      'page': const HasBledScorePage(),
    },
    {
      'title': 'IMPROVE Bleeding Risk',
      'subtitle': 'Bleeding Risk in Medical Patients',
      'description': 'Đánh giá nguy cơ chảy máu bệnh nhân nội khoa',
      'icon': Icons.healing,
      'color': Colors.red.shade300,
      'page': const ImproveBleedingRiskPage(),
    },
    
    // Stroke & Thrombosis Scores
    {
      'title': 'CHA2DS2-VASc',
      'subtitle': 'Stroke Risk in Atrial Fibrillation',
      'description': 'Đánh giá nguy cơ đột quỵ trong rung nhĩ',
      'icon': Icons.graphic_eq,
      'color': Colors.indigo.shade600,
      'page': const Cha2ds2VascPage(),
    },
    {
      'title': 'Wells DVT Score',
      'subtitle': 'Deep Vein Thrombosis Probability',
      'description': 'Đánh giá xác suất huyết khối tĩnh mạch sâu',
      'icon': Icons.waves,
      'color': Colors.blue.shade700,
      'page': const WellsDvtScorePage(),
    },
    {
      'title': 'Padua Prediction Score',
      'subtitle': 'VTE Risk in Medical Patients',
      'description': 'Đánh giá nguy cơ huyết khối tĩnh mạch',
      'icon': Icons.timeline,
      'color': Colors.blue.shade800,
      'page': const PaduaPredictionScorePage(),
    },
    {
      'title': 'ABCD2 Score',
      'subtitle': 'Stroke Risk after TIA',
      'description': 'Đánh giá nguy cơ đột quỵ sau cơn thiếu máu não thoáng qua',
      'icon': Icons.psychology,
      'color': Colors.green.shade600,
      'page': const Abcd2Page(),
    },
    {
      'title': 'NIHSS',
      'subtitle': 'National Institutes of Health Stroke Scale',
      'description': 'Đánh giá độ nặng đột quỵ',
      'icon': Icons.psychology_alt,
      'color': Colors.green.shade700,
      'page': const NihssPage(),
    },
    {
      'title': 'RACE Scale',
      'subtitle': 'Rapid Arterial Occlusion Evaluation',
      'description': 'Sàng lọc tắc động mạch lớn',
      'icon': Icons.directions_run,
      'color': Colors.green.shade800,
      'page': const RaceScalePage(),
    },
    {
      'title': 'ASPECT Score',
      'subtitle': 'Alberta Stroke Program Early CT Score',
      'description': 'Đánh giá vùng nhồi máu não trên CT',
      'icon': Icons.medical_information,
      'color': Colors.green.shade500,
      'page': const AspectScorePage(),
    },
    
    // Cardiology Diagnostics
    {
      'title': 'Modified Sgarbossa Criteria',
      'subtitle': 'STEMI in LBBB',
      'description': 'Chẩn đoán STEMI khi có blốc nhánh trái',
      'icon': Icons.timeline,
      'color': Colors.orange.shade700,
      'page': const ModifiedSgarbossaCriteriaPage(),
    },
    
    // Gastrointestinal & Liver Scores
    {
      'title': 'Ranson Criteria',
      'subtitle': 'Acute Pancreatitis Severity',
      'description': 'Đánh giá độ nặng viêm tụy cấp',
      'icon': Icons.medical_information,
      'color': Colors.brown.shade600,
      'page': const RansonPage(),
    },
    {
      'title': 'Child-Pugh Score',
      'subtitle': 'Liver Disease Severity',
      'description': 'Đánh giá độ nặng bệnh gan',
      'icon': Icons.local_hospital,
      'color': Colors.brown.shade700,
      'page': const ChildPughPage(),
    },
    {
      'title': 'MELD Score',
      'subtitle': 'Model for End-Stage Liver Disease',
      'description': 'Dự đoán tỷ lệ tử vong bệnh gan giai đoạn cuối',
      'icon': Icons.biotech,
      'color': Colors.brown.shade800,
      'page': const MeldScorePage(),
    },
    
    // Respiratory Scores
    {
      'title': 'CURB-65',
      'subtitle': 'Community-Acquired Pneumonia Severity',
      'description': 'Đánh giá độ nặng viêm phổi cộng đồng',
      'icon': Icons.air,
      'color': Colors.cyan.shade600,
      'page': const Curb65Page(),
    },
    {
      'title': 'PSI',
      'subtitle': 'Pneumonia Severity Index',
      'description': 'Chỉ số độ nặng viêm phổi',
      'icon': Icons.coronavirus,
      'color': Colors.cyan.shade700,
      'page': const PsiPage(),
    },
    
    // Perioperative Scores
    {
      'title': 'ASA Physical Status',
      'subtitle': 'American Society of Anesthesiologists',
      'description': 'Phân loại tình trạng thể chất trước mổ',
      'icon': Icons.person_outline,
      'color': Colors.grey.shade600,
      'page': const AsaPhysicalStatusPage(),
    },
    {
      'title': 'Revised Cardiac Risk Index',
      'subtitle': 'Perioperative Cardiac Risk',
      'description': 'Đánh giá nguy cơ tim mạch quanh phẫu thuật',
      'icon': Icons.favorite_outline,
      'color': Colors.purple.shade700,
      'page': const RevisedCardiacRiskIndexPage(),
    },
    {
      'title': 'Surgical Apgar Score',
      'subtitle': 'Postoperative Outcome Prediction',
      'description': 'Dự đoán kết quả sau phẫu thuật',
      'icon': Icons.content_cut,
      'color': Colors.purple.shade800,
      'page': const SurgicalApgarScorePage(),
    },
    {
      'title': 'Preoperative Mortality Prediction',
      'subtitle': 'Surgical Risk Assessment',
      'description': 'Dự đoán tỷ lệ tử vong trước phẫu thuật',
      'icon': Icons.calculate,
      'color': Colors.deepPurple.shade600,
      'page': const PreoperativeMortalityPredictionPage(),
    },
    
    // Medication & Treatment Scores
    {
      'title': 'DAPT Score',
      'subtitle': 'Dual Antiplatelet Therapy',
      'description': 'Quyết định kéo dài điều trị kháng tiểu cầu kép',
      'icon': Icons.medication,
      'color': Colors.teal.shade700,
      'page': const DaptScorePage(),
    },
    
    // Renal Function Scores
    {
      'title': 'Creatinine Clearance',
      'subtitle': 'Kidney Function Assessment',
      'description': 'Đánh giá chức năng thận',
      'icon': Icons.opacity,
      'color': Colors.lightBlue.shade600,
      'page': const CreatinineClearancePage(),
    },
    {
      'title': 'MDRD GFR',
      'subtitle': 'Modification of Diet in Renal Disease',
      'description': 'Tính tốc độ lọc cầu thận',
      'icon': Icons.water,
      'color': Colors.lightBlue.shade700,
      'page': const MdrdGfrPage(),
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
