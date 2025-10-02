import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'glasgow_coma_scale_page.dart';
import 'apache_ii_page.dart';
import 'sofa_score_page.dart';
import 'mews_page.dart';
import 'saps_ii_page.dart';
import 'curb65_page.dart';
import 'psi_page.dart';
import 'ranson_page.dart';
import 'cha2ds2_vasc_page.dart';
import 'child_pugh_page.dart';
import 'asa_physical_status_page.dart';
import 'creatinine_clearance_page.dart';
import 'grace_score_page.dart';
import 'nihss_page.dart';
import 'timi_stemi_page.dart';
import 'timi_ua_nstemi_page.dart';
import 'abcd2_page.dart';
import 'revised_cardiac_risk_index_page.dart';
import 'mdrd_gfr_page.dart';
import 'improve_bleeding_risk_page.dart';
import 'wells_dvt_score_page.dart';
import 'padua_prediction_score_page.dart';
import 'has_bled_score_page.dart';
import 'crusade_bleeding_risk_page.dart';
import 'qsofa_score_page.dart';
import 'pews_score_page.dart';
import 'modified_sgarbossa_criteria_page.dart';
import 'race_scale_page.dart';
import 'meld_score_page.dart';
import 'aspect_score_page.dart';
import 'preoperative_mortality_prediction_page.dart';
import 'surgical_apgar_score_page.dart';
import 'dapt_score_page.dart';

class ClinicalScoresPage extends StatelessWidget {
  const ClinicalScoresPage({super.key});

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
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildScoreCard(
                    context,
                    'Glasgow Coma Scale (GCS)',
                    'Đánh giá mức độ ý thức bệnh nhân',
                    'Phản ứng mắt, lời nói, vận động',
                    Icons.visibility,
                    Colors.blue.shade600,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GlasgowComaScalePage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildScoreCard(
                    context,
                    'APACHE II',
                    'Acute Physiology and Chronic Health Evaluation',
                    'Dự đoán tỷ lệ tử vong trong ICU',
                    Icons.monitor_heart,
                    Colors.red.shade600,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ApacheIIPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildScoreCard(
                    context,
                    'SOFA Score',
                    'Sequential Organ Failure Assessment',
                    'Đánh giá mức độ suy cơ quan',
                    Icons.healing,
                    Colors.orange.shade600,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SOFAScorePage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildScoreCard(
                    context,
                    'MEWS',
                    'Modified Early Warning Score',
                    'Cảnh báo sớm tình trạng bệnh nhân',
                    Icons.warning,
                    Colors.amber.shade600,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MEWSPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildScoreCard(
                    context,
                    'SAPS II',
                    'Simplified Acute Physiology Score',
                    'Đánh giá độ nặng bệnh cấp tính',
                    Icons.analytics,
                    Colors.green.shade600,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SAPSII(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildScoreCard(
                    context,
                    'CURB-65',
                    'Pneumonia Severity Assessment',
                    'Đánh giá độ nặng viêm phổi',
                    Icons.air,
                    Colors.cyan.shade600,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Curb65Page(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildScoreCard(
                    context,
                    'PSI Score',
                    'Pneumonia Severity Index',
                    'Chỉ số độ nặng viêm phổi',
                    Icons.coronavirus,
                    Colors.indigo.shade600,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PsiPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildScoreCard(
                    context,
                    'Ranson Criteria',
                    'Acute Pancreatitis Severity',
                    'Đánh giá độ nặng viêm tụy cấp',
                    Icons.medical_information,
                    Colors.brown.shade600,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RansonPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildScoreCard(
                    context,
                    'CHA₂DS₂-VASc',
                    'Stroke Risk in Atrial Fibrillation',
                    'Nguy cơ đột quỵ trong rung nhĩ',
                    Icons.favorite_border,
                    Colors.purple.shade600,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Cha2ds2VascPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildScoreCard(
                    context,
                    'Child-Pugh Score',
                    'Liver Disease Severity',
                    'Phân loại độ nặng bệnh gan',
                    Icons.local_hospital,
                    Colors.amber.shade700,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChildPughPage(),
                        ),
                      );
                    },
                  ),
                  _buildScoreCard(
                    context,
                    'ASA Physical Status',
                    'Preoperative Risk Assessment',
                    'Đánh giá nguy cơ trước phẫu thuật',
                    Icons.healing,
                    Colors.indigo.shade600,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AsaPhysicalStatusPage(),
                        ),
                      );
                    },
                  ),
                  _buildScoreCard(
                    context,
                    'Creatinine Clearance',
                    'Kidney Function Assessment',
                    'Đánh giá chức năng thận (Cockcroft-Gault)',
                    Icons.water_drop,
                    Colors.cyan.shade600,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreatinineClearancePage(),
                        ),
                      );
                    },
                  ),
                  _buildScoreCard(
                    context,
                    'GRACE Score',
                    'ACS Risk Stratification',
                    'Phân tầng nguy cơ hội chứng mạch vành cấp',
                    Icons.favorite,
                    Colors.red.shade600,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GraceScorePage(),
                        ),
                      );
                    },
                  ),
                  _buildScoreCard(
                    context,
                    'NIHSS Score',
                    'Stroke Severity Assessment',
                    'Đánh giá mức độ nặng đột quỵ',
                    Icons.psychology,
                    Colors.purple.shade600,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NihssPage(),
                        ),
                      );
                    },
                  ),
                  _buildScoreCard(
                    context,
                    'TIMI Score - STEMI',
                    'Mortality Risk in STEMI',
                    'Nguy cơ tử vong trong nhồi máu ST chênh lên',
                    Icons.monitor_heart,
                    Colors.red.shade800,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TimiStemiPage(),
                        ),
                      );
                    },
                  ),
                  _buildScoreCard(
                    context,
                    'TIMI Score - UA/NSTEMI',
                    'Risk Assessment for ACS',
                    'Đánh giá nguy cơ hội chứng mạch vành không ST',
                    Icons.favorite_border,
                    Colors.orange.shade700,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TimiUaNstemiPage(),
                        ),
                      );
                    },
                  ),
                  _buildScoreCard(
                    context,
                    'ABCD2 Score',
                    'Stroke Risk after TIA',
                    'Nguy cơ đột quỵ sau thiếu máu não thoáng qua',
                    Icons.psychology_alt,
                    Colors.indigo.shade600,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Abcd2Page(),
                        ),
                      );
                    },
                  ),
                  _buildScoreCard(
                    context,
                    'Revised Cardiac Risk Index',
                    'Perioperative Cardiac Risk',
                    'Nguy cơ tim mạch chu phẫu thuật (Lee Index)',
                    Icons.monitor_heart_outlined,
                    Colors.red.shade700,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RevisedCardiacRiskIndexPage(),
                        ),
                      );
                    },
                  ),
                  _buildScoreCard(
                    context,
                    'MDRD GFR Equation',
                    'eGFR Calculation',
                    'Tính toán tốc độ lọc cầu thận ước tính',
                    Icons.water_drop_outlined,
                    Colors.blue.shade700,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MdrdGfrPage(),
                        ),
                      );
                    },
                  ),
                  _buildScoreCard(
                    context,
                    'IMPROVE Bleeding Risk',
                    'Bleeding Risk Assessment',
                    'Đánh giá nguy cơ chảy máu khi prophylaxis',
                    Icons.bloodtype,
                    Colors.red.shade600,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ImproveBleedingRiskPage(),
                        ),
                      );
                    },
                  ),
                  _buildScoreCard(
                    context,
                    'Wells DVT Score',
                    'DVT Probability',
                    'Đánh giá xác suất thuyên tắc tĩnh mạch sâu',
                    Icons.local_hospital,
                    Colors.blue.shade600,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WellsDvtScorePage(),
                        ),
                      );
                    },
                  ),
                  _buildScoreCard(
                    context,
                    'Padua Prediction Score',
                    'VTE Risk Assessment',
                    'Đánh giá nguy cơ thuyên tắc tĩnh mạch',
                    Icons.analytics,
                    Colors.purple.shade600,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaduaPredictionScorePage(),
                        ),
                      );
                    },
                  ),
                  _buildScoreCard(
                    context,
                    'HAS-BLED Score',
                    'Bleeding Risk on Anticoagulation',
                    'Nguy cơ chảy máu khi dùng thuốc chống đông',
                    Icons.water_drop,
                    Colors.red.shade700,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HasBledScorePage(),
                        ),
                      );
                    },
                  ),
                  _buildScoreCard(
                    context,
                    'CRUSADE Bleeding Risk',
                    'ACS Bleeding Risk',
                    'Nguy cơ chảy máu trong hội chứng mạch vành cấp',
                    Icons.favorite,
                    Colors.red.shade800,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CrusadeBleedingRiskPage(),
                        ),
                      );
                    },
                  ),
                  _buildScoreCard(
                    context,
                    'qSOFA Score',
                    'Quick Sepsis Assessment',
                    'Sàng lọc nhanh sepsis và suy đa tạng',
                    Icons.warning,
                    Colors.orange.shade700,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QsofaScorePage(),
                        ),
                      );
                    },
                  ),
                  _buildScoreCard(
                    context,
                    'PEWS Score',
                    'Pediatric Early Warning',
                    'Cảnh báo sớm bệnh nhi nguy kịch',
                    Icons.child_care,
                    Colors.pink.shade700,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PewsScorePage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildScoreCard(
                    context,
                    'Modified Sgarbossa Criteria',
                    'STEMI trong LBBB',
                    'Chẩn đoán STEMI khi có LBBB',
                    Icons.monitor_heart,
                    Colors.red.shade800,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ModifiedSgarbossaCriteriaPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildScoreCard(
                    context,
                    'RACE Scale',
                    'Rapid Arterial oCclusion Evaluation',
                    'Đánh giá nhanh đột quỵ LVO',
                    Icons.psychology,
                    Colors.purple.shade700,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RaceScalePage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildScoreCard(
                    context,
                    'MELD Score',
                    'Model for End-Stage Liver Disease',
                    'Đánh giá bệnh gan giai đoạn cuối',
                    Icons.local_hospital,
                    Colors.brown.shade700,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MeldScorePage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildScoreCard(
                    context,
                    'ASPECT Score',
                    'Alberta Stroke Program Early CT',
                    'Đánh giá thiếu máu não MCA',
                    Icons.psychology_outlined,
                    Colors.indigo.shade700,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AspectScorePage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildScoreCard(
                    context,
                    'Preoperative Mortality Prediction',
                    'Dự đoán tử vong phẫu thuật',
                    'Đánh giá nguy cơ tử vong trước mổ',
                    Icons.local_hospital_outlined,
                    Colors.deepPurple.shade700,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PreoperativeMortalityPredictionPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildScoreCard(
                    context,
                    'Surgical Apgar Score',
                    'Đánh giá hậu phẫu',
                    'Dự đoán biến chứng sau phẫu thuật',
                    Icons.healing,
                    Colors.teal.shade700,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SurgicalApgarScorePage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildScoreCard(
                    context,
                    'DAPT Score',
                    'Dual Antiplatelet Therapy',
                    'Quyết định tiếp tục DAPT',
                    Icons.medication,
                    Colors.cyan.shade700,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DaptScorePage(),
                        ),
                      );
                    },
                  ),
                ],
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
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.05)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
