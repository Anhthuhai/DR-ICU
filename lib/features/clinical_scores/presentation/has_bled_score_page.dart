import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

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
      return AppLocalizations.of(context)!.has_bled_risk_low;
    }
    if (_totalScore == 3) {
      return AppLocalizations.of(context)!.has_bled_risk_moderate;
    }
    return AppLocalizations.of(context)!.has_bled_risk_high;
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
      return AppLocalizations.of(context)!.has_bled_recommendation_low;
    }
    if (_totalScore == 3) {
      return AppLocalizations.of(context)!.has_bled_recommendation_moderate;
    }
    return AppLocalizations.of(context)!.has_bled_recommendation_high;
  }

  String get clinicalApproach {
    if (_totalScore <= 2) {
      return AppLocalizations.of(context)!.has_bled_approach_low;
    }
    if (_totalScore == 3) {
      return AppLocalizations.of(context)!.has_bled_approach_moderate;
    }
    return AppLocalizations.of(context)!.has_bled_approach_high;
  }

  List<Map<String, dynamic>> get riskFactors {
    return [
      {
        'factor': AppLocalizations.of(context)!.has_bled_factor_hypertension,
        'description': AppLocalizations.of(context)!.has_bled_hypertension_desc,
        'points': 1,
        'active': _hypertension,
      },
      {
        'factor': AppLocalizations.of(context)!.has_bled_factor_abnormal_renal,
        'description': AppLocalizations.of(context)!.has_bled_abnormal_renal_desc,
        'points': 1,
        'active': _abnormalRenal,
      },
      {
        'factor': AppLocalizations.of(context)!.has_bled_factor_abnormal_liver,
        'description': AppLocalizations.of(context)!.has_bled_abnormal_liver_desc,
        'points': 1,
        'active': _abnormalLiver,
      },
      {
        'factor': AppLocalizations.of(context)!.has_bled_factor_stroke,
        'description': AppLocalizations.of(context)!.has_bled_stroke_desc,
        'points': 1,
        'active': _stroke,
      },
      {
        'factor': AppLocalizations.of(context)!.has_bled_factor_bleeding,
        'description': AppLocalizations.of(context)!.has_bled_bleeding_desc,
        'points': 1,
        'active': _bleeding,
      },
      {
        'factor': AppLocalizations.of(context)!.has_bled_factor_labile_inr,
        'description': AppLocalizations.of(context)!.has_bled_labile_inr_desc,
        'points': 1,
        'active': _labileInr,
      },
      {
        'factor': AppLocalizations.of(context)!.has_bled_factor_elderly,
        'description': AppLocalizations.of(context)!.has_bled_elderly_desc,
        'points': 1,
        'active': _elderly,
      },
      {
        'factor': AppLocalizations.of(context)!.has_bled_factor_drugs,
        'description': AppLocalizations.of(context)!.has_bled_drugs_desc,
        'points': 1,
        'active': _drugs,
      },
      {
        'factor': AppLocalizations.of(context)!.has_bled_factor_alcohol,
        'description': AppLocalizations.of(context)!.has_bled_alcohol_desc,
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
            title: Text(AppLocalizations.of(context)!.has_bled_title),
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
                // Medical Disclaimer Banner
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
                              ? 'LƯU Ý Y KHOA: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ chuyên khoa tim mạch trước khi đưa ra quyết định điều trị.'
                              : 'MEDICAL DISCLAIMER: Results are for reference only. Always consult with a cardiologist before making treatment decisions.',
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
                    AppLocalizations.of(context)!.has_bled_bleeding_risk,
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
                    AppLocalizations.of(context)!.has_bled_clinical_approach,
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
                      AppLocalizations.of(context)!.has_bled_recommendations,
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
            AppLocalizations.of(context)!.has_bled_risk_factors,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.has_bled_hypertension),
            subtitle: Text(AppLocalizations.of(context)!.has_bled_hypertension_desc),
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
            title: Text(AppLocalizations.of(context)!.has_bled_abnormal_renal),
            subtitle: Text(AppLocalizations.of(context)!.has_bled_abnormal_renal_desc),
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
            title: Text(AppLocalizations.of(context)!.has_bled_abnormal_liver),
            subtitle: Text(AppLocalizations.of(context)!.has_bled_abnormal_liver_desc),
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
            title: Text(AppLocalizations.of(context)!.has_bled_stroke),
            subtitle: Text(AppLocalizations.of(context)!.has_bled_stroke_desc),
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
            title: Text(AppLocalizations.of(context)!.has_bled_bleeding),
            subtitle: Text(AppLocalizations.of(context)!.has_bled_bleeding_desc),
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
            title: Text(AppLocalizations.of(context)!.has_bled_labile_inr),
            subtitle: Text(AppLocalizations.of(context)!.has_bled_labile_inr_desc),
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
            title: Text(AppLocalizations.of(context)!.has_bled_elderly),
            subtitle: Text(AppLocalizations.of(context)!.has_bled_elderly_desc),
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
            title: Text(AppLocalizations.of(context)!.has_bled_drugs),
            subtitle: Text(AppLocalizations.of(context)!.has_bled_drugs_desc),
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
            title: Text(AppLocalizations.of(context)!.has_bled_alcohol),
            subtitle: Text(AppLocalizations.of(context)!.has_bled_alcohol_desc),
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
            AppLocalizations.of(context)!.has_bled_active_factors(activeFactors.length),
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
            AppLocalizations.of(context)!.has_bled_risk_stratification,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('0-2', AppLocalizations.of(context)!.has_bled_risk_low_range, '1.02-1.88%', AppLocalizations.of(context)!.has_bled_continue_anticoag, Colors.green),
          _buildRiskItem('3', AppLocalizations.of(context)!.has_bled_risk_moderate_range, '3.74%', AppLocalizations.of(context)!.has_bled_caution_monitor, Colors.orange),
          _buildRiskItem('≥4', AppLocalizations.of(context)!.has_bled_risk_high_range, '>8.70%', AppLocalizations.of(context)!.has_bled_consider_stop, Colors.red),
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
            AppLocalizations.of(context)!.has_bled_clinical_approach_title,
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
                      AppLocalizations.of(context)!.has_bled_approach_for_score(_totalScore),
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
                AppLocalizations.of(context)!.has_bled_clinical_info,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.has_bled_clinical_info_content,
            style: const TextStyle(height: 1.4),
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
                AppLocalizations.of(context)!.has_bled_references,
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
