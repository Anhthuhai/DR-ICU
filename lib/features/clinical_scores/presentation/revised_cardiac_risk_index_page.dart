import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class RevisedCardiacRiskIndexPage extends StatefulWidget {
  const RevisedCardiacRiskIndexPage({super.key});

  @override
  State<RevisedCardiacRiskIndexPage> createState() => _RevisedCardiacRiskIndexPageState();
}

class _RevisedCardiacRiskIndexPageState extends State<RevisedCardiacRiskIndexPage> {
  bool _ihd = false; // Ischemic heart disease
  bool _chf = false; // Congestive heart failure
  bool _cvd = false; // Cerebrovascular disease
  bool _dminsulin = false; // Diabetes mellitus requiring insulin
  bool _creatinine = false; // Creatinine >2.0 mg/dL
  bool _highrisk = false; // High-risk surgery

  int get totalScore {
    int score = 0;
    if (_ihd) {
      score++;
    }
    if (_chf) {
      score++;
    }
    if (_cvd) {
      score++;
    }
    if (_dminsulin) {
      score++;
    }
    if (_creatinine) {
      score++;
    }
    if (_highrisk) {
      score++;
    }
    return score;
  }

  Color get riskColor {
    if (totalScore == 0) {
      return Colors.green;
    }
    if (totalScore == 1) {
      return Colors.blue;
    }
    if (totalScore == 2) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String riskLevel(BuildContext context) {
    if (totalScore == 0) {
      return AppLocalizations.of(context)!.rcri_risk_very_low;
    }
    if (totalScore == 1) {
      return AppLocalizations.of(context)!.rcri_risk_low;
    }
    if (totalScore == 2) {
      return AppLocalizations.of(context)!.rcri_risk_moderate;
    }
    return AppLocalizations.of(context)!.rcri_risk_high;
  }

  String get cardiacEventRisk {
    if (totalScore == 0) {
      return '0.4%';
    }
    if (totalScore == 1) {
      return '0.9%';
    }
    if (totalScore == 2) {
      return '7%';
    }
    if (totalScore >= 3) {
      return '11%';
    }
    return '0%';
  }

  String recommendations(BuildContext context) {
    if (totalScore == 0) {
      return AppLocalizations.of(context)!.rcri_recommendation_0;
    }
    if (totalScore == 1) {
      return AppLocalizations.of(context)!.rcri_recommendation_1;
    }
    if (totalScore == 2) {
      return AppLocalizations.of(context)!.rcri_recommendation_2;
    }
    return AppLocalizations.of(context)!.rcri_recommendation_3;
  }

  String perioperativeManagement(BuildContext context) {
    if (totalScore == 0) {
      return AppLocalizations.of(context)!.rcri_management_standard;
    }
    if (totalScore == 1) {
      return AppLocalizations.of(context)!.rcri_management_monitoring;
    }
    if (totalScore == 2) {
      return AppLocalizations.of(context)!.rcri_management_intensive;
    }
    return AppLocalizations.of(context)!.rcri_management_invasive;
  }

  List<Map<String, dynamic>> riskFactors(BuildContext context) {
    return [
      {
        'factor': AppLocalizations.of(context)!.rcri_ihd_title,
        'description': AppLocalizations.of(context)!.rcri_ihd_description,
        'active': _ihd,
        'variable': 'ihd',
      },
      {
        'factor': AppLocalizations.of(context)!.rcri_chf_title,
        'description': AppLocalizations.of(context)!.rcri_chf_description,
        'active': _chf,
        'variable': 'chf',
      },
      {
        'factor': AppLocalizations.of(context)!.rcri_cvd_title,
        'description': AppLocalizations.of(context)!.rcri_cvd_description,
        'active': _cvd,
        'variable': 'cvd',
      },
      {
        'factor': AppLocalizations.of(context)!.rcri_dm_title,
        'description': AppLocalizations.of(context)!.rcri_dm_description,
        'active': _dminsulin,
        'variable': 'dminsulin',
      },
      {
        'factor': AppLocalizations.of(context)!.rcri_renal_title,
        'description': AppLocalizations.of(context)!.rcri_renal_description,
        'active': _creatinine,
        'variable': 'creatinine',
      },
      {
        'factor': AppLocalizations.of(context)!.rcri_surgery_title,
        'description': AppLocalizations.of(context)!.rcri_surgery_description,
        'active': _highrisk,
        'variable': 'highrisk',
      },
    ];
  }

  List<String> highRiskSurgeries(BuildContext context) {
    return [
      AppLocalizations.of(context)!.rcri_surgery_aortic,
      AppLocalizations.of(context)!.rcri_surgery_peripheral,
      AppLocalizations.of(context)!.rcri_surgery_abdominal,
      AppLocalizations.of(context)!.rcri_surgery_thoracic,
      AppLocalizations.of(context)!.rcri_surgery_renal,
      AppLocalizations.of(context)!.rcri_surgery_hepatic,
      AppLocalizations.of(context)!.rcri_surgery_head_neck,
      AppLocalizations.of(context)!.rcri_surgery_orthopedic,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky AppBar
          SliverAppBar(
            title: Text(
              AppLocalizations.of(context)!.rcri_title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.blue.shade700,
            elevation: 4,
            pinned: true,
            floating: false,
            snap: false,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue.shade700,
                      Colors.blue.shade600,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cardiac Risk Assessment for Non-Cardiac Surgery',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Sticky Score Header
          SliverPersistentHeader(
            delegate: _StickyRcriScoreHeaderDelegate(
              totalScore: totalScore,
            ),
            pinned: true,
          ),
          
          // Main Content
          SliverPadding(
            padding: const EdgeInsets.only(top: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Medical Disclaimer Banner
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                              ? 'LƯU Ý Y KHOA PHẪU THUẬT: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ gây mê hồi sức và phẫu thuật viên trước khi đưa ra quyết định.'
                              : 'SURGICAL MEDICAL DISCLAIMER: Results are for reference only. Always consult with anesthesiologist and surgeon before making decisions.',
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
                
                // Risk Factors
                _buildRiskFactorsSection(),

                // Active Risk Factors
                if (totalScore > 0) _buildActiveFactors(),

                // High-Risk Surgery Examples
                _buildHighRiskSurgerySection(),

                // Risk Stratification
                _buildRiskStratification(),

                // Clinical Information
                _buildClinicalInfo(),

                // Medical Citation
                Container(
                  margin: const EdgeInsets.all(16),
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
                            AppLocalizations.of(context)!.rcri_references,
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
                        'Lee TH, Marcantonio ER, Mangione CM, et al. Derivation and prospective validation of a simple index for prediction of cardiac risk of major noncardiac surgery. Circulation. 1999;100(10):1043-9.',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.blue.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ]),
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
        border: Border.all(color: Colors.blue.shade300),
        color: Colors.blue.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.rcri_risk_factors_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          ...riskFactors(context).map((factor) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: CheckboxListTile(
              title: Text(
                factor['factor'],
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                factor['description'],
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  height: 1.3,
                ),
              ),
              value: factor['active'],
              // ignore: deprecated_member_use
              onChanged: (value) {
                setState(() {
                  switch (factor['variable']) {
                    case 'ihd': _ihd = value!; break;
                    case 'chf': _chf = value!; break;
                    case 'cvd': _cvd = value!; break;
                    case 'dminsulin': _dminsulin = value!; break;
                    case 'creatinine': _creatinine = value!; break;
                    case 'highrisk': _highrisk = value!; break;
                  }
                });
              },
              activeColor: Colors.blue.shade600,
              contentPadding: EdgeInsets.zero,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildActiveFactors() {
    List<Map<String, dynamic>> activeFactors = riskFactors(context).where((factor) => factor['active']).toList();
    
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
            AppLocalizations.of(context)!.rcri_current_risk_factors(activeFactors.length),
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
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: riskColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '+1',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    factor['factor'],
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildHighRiskSurgerySection() {
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
            AppLocalizations.of(context)!.rcri_high_risk_surgery_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
          ),
          const SizedBox(height: 12),
          ...highRiskSurgeries(context).map((surgery) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 8, right: 12),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade600,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    surgery,
                    style: const TextStyle(height: 1.4),
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
            AppLocalizations.of(context)!.rcri_risk_stratification_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem(0, AppLocalizations.of(context)!.rcri_risk_0_title, '0.4%', AppLocalizations.of(context)!.rcri_risk_0_desc, Colors.green),
          _buildRiskItem(1, AppLocalizations.of(context)!.rcri_risk_1_title, '0.9%', AppLocalizations.of(context)!.rcri_risk_1_desc, Colors.blue),
          _buildRiskItem(2, AppLocalizations.of(context)!.rcri_risk_2_title, '7%', AppLocalizations.of(context)!.rcri_risk_2_desc, Colors.orange),
          _buildRiskItem(3, AppLocalizations.of(context)!.rcri_risk_3_title, '≥11%', AppLocalizations.of(context)!.rcri_risk_3_desc, Colors.red),
        ],
      ),
    );
  }

  Widget _buildRiskItem(int score, String risk, String eventRate, String action, Color color) {
    String scoreText = score == 3 ? '≥3' : score.toString();
    
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
                width: 30,
                child: Text(
                  scoreText,
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
                  eventRate,
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

  Widget _buildClinicalInfo() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.indigo.shade50,
        border: Border.all(color: Colors.indigo.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.indigo.shade600),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.rcri_clinical_info_title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.rcri_clinical_info_text,
            style: const TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _StickyRcriScoreHeaderDelegate extends SliverPersistentHeaderDelegate {
  final int totalScore;

  _StickyRcriScoreHeaderDelegate({
    required this.totalScore,
  });

  Color get riskColor {
    if (totalScore == 0) return Colors.green;
    if (totalScore == 1) return Colors.blue;
    if (totalScore == 2) return Colors.orange;
    return Colors.red;
  }

  String riskLevel(BuildContext context) {
    if (totalScore == 0) {
      return AppLocalizations.of(context)!.rcri_risk_very_low;
    }
    if (totalScore == 1) {
      return AppLocalizations.of(context)!.rcri_risk_low;
    }
    if (totalScore == 2) {
      return AppLocalizations.of(context)!.rcri_risk_moderate;
    }
    return AppLocalizations.of(context)!.rcri_risk_high;
  }

  String get cardiacEventRisk {
    if (totalScore == 0) return '0.4%';
    if (totalScore == 1) return '0.9%';
    if (totalScore == 2) return '7%';
    if (totalScore >= 3) return '11%';
    return '0%';
  }

  @override
  double get minExtent => 70;
  
  @override
  double get maxExtent => 70;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: overlapsContent ? 4 : 2,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              // Score circle - fixed size
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: riskColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$totalScore/6',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Risk level - expanded
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Risk Level',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      riskLevel(context),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: riskColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // Cardiac event risk - compact
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: riskColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  cardiacEventRisk,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: riskColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    if (oldDelegate is _StickyRcriScoreHeaderDelegate) {
      return oldDelegate.totalScore != totalScore;
    }
    return true;
  }
}
