import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
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

  String getRiskLevel(BuildContext context) {
    if (_totalScore < 4) {
      return AppLocalizations.of(context)!.padua_low_risk;
    }
    return AppLocalizations.of(context)!.padua_high_risk;
  }

  String get vteProbability {
    if (_totalScore < 4) {
      return '0.3%';
    }
    return '11%';
  }

  String getRecommendations(BuildContext context) {
    if (_totalScore < 4) {
      return AppLocalizations.of(context)!.padua_no_prophylaxis;
    }
    return AppLocalizations.of(context)!.padua_pharmacological_prophylaxis;
  }

  String getProphylaxisStrategy(BuildContext context) {
    if (_totalScore < 4) {
      return AppLocalizations.of(context)!.padua_mechanical_prophylaxis;
    }
    return AppLocalizations.of(context)!.padua_pharmacological_mechanical;
  }

  List<Map<String, dynamic>> getRiskFactors(BuildContext context) {
    return [
      {
        'factor': AppLocalizations.of(context)!.padua_cancer,
        'description': AppLocalizations.of(context)!.padua_cancer_desc,
        'points': 3,
        'active': _cancer,
      },
      {
        'factor': AppLocalizations.of(context)!.padua_previous_vte,
        'description': AppLocalizations.of(context)!.padua_previous_vte_desc,
        'points': 3,
        'active': _previousVte,
      },
      {
        'factor': AppLocalizations.of(context)!.padua_reduced_mobility,
        'description': AppLocalizations.of(context)!.padua_reduced_mobility_desc,
        'points': 3,
        'active': _reducedMobility,
      },
      {
        'factor': AppLocalizations.of(context)!.padua_thrombophilia,
        'description': AppLocalizations.of(context)!.padua_thrombophilia_desc,
        'points': 3,
        'active': _thrombophilia,
      },
      {
        'factor': AppLocalizations.of(context)!.padua_recent_trauma,
        'description': AppLocalizations.of(context)!.padua_recent_trauma_desc,
        'points': 2,
        'active': _recentTrauma,
      },
      {
        'factor': AppLocalizations.of(context)!.padua_elderly,
        'description': AppLocalizations.of(context)!.padua_elderly_desc,
        'points': 1,
        'active': _elderlyCareHome,
      },
      {
        'factor': AppLocalizations.of(context)!.padua_heart_failure,
        'description': AppLocalizations.of(context)!.padua_heart_failure_desc,
        'points': 1,
        'active': _heartFailure,
      },
      {
        'factor': AppLocalizations.of(context)!.padua_respiratory_failure,
        'description': AppLocalizations.of(context)!.padua_respiratory_failure_desc,
        'points': 1,
        'active': _respiratoryFailure,
      },
      {
        'factor': AppLocalizations.of(context)!.padua_acute_infection,
        'description': AppLocalizations.of(context)!.padua_acute_infection_desc,
        'points': 1,
        'active': _acuteInfection,
      },
      {
        'factor': AppLocalizations.of(context)!.padua_rheumatic_disease,
        'description': AppLocalizations.of(context)!.padua_rheumatic_disease_desc,
        'points': 1,
        'active': _acuteRheumatic,
      },
      {
        'factor': AppLocalizations.of(context)!.padua_ibd_stroke,
        'description': AppLocalizations.of(context)!.padua_ibd_stroke_desc,
        'points': 1,
        'active': _ibdStroke,
      },
      {
        'factor': AppLocalizations.of(context)!.padua_acute_mi,
        'description': AppLocalizations.of(context)!.padua_acute_mi_desc,
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
            title: Text(AppLocalizations.of(context)!.padua_prediction_score_title),
            backgroundColor: Colors.purple.shade700,
            foregroundColor: Colors.white,
          ),
          
          // Score Display Header (sticky)
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 56,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  bottom: BorderSide(color: riskColor.withValues(alpha: 0.3)),
                ),
              ),
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
                          AppLocalizations.of(context)!.padua_prediction_score,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: riskColor,
                          ),
                        ),
                        Text(
                          getRiskLevel(context),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.darkGrey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '$_totalScore',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: riskColor,
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
                              ? 'LƯU Ý Y KHOA HUYẾT KHỐI: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ chuyên khoa tim mạch hoặc huyết học trước khi đưa ra quyết định điều trị.'
                              : 'THROMBOSIS MEDICAL DISCLAIMER: Results are for reference only. Always consult with cardiologist or hematologist before making treatment decisions.',
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.padua_vte_risk,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                        fontSize: 12,
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
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.padua_prophylaxis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      getProphylaxisStrategy(context),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: riskColor,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
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
                      AppLocalizations.of(context)!.padua_recommendations,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  getRecommendations(context),
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
            AppLocalizations.of(context)!.padua_risk_factors_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.padua_cancer),
            subtitle: Text(AppLocalizations.of(context)!.padua_cancer_desc),
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
            title: Text(AppLocalizations.of(context)!.padua_previous_vte),
            subtitle: Text(AppLocalizations.of(context)!.padua_previous_vte_desc),
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
            title: Text(AppLocalizations.of(context)!.padua_reduced_mobility),
            subtitle: Text(AppLocalizations.of(context)!.padua_reduced_mobility_desc),
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
            title: Text(AppLocalizations.of(context)!.padua_thrombophilia),
            subtitle: Text(AppLocalizations.of(context)!.padua_thrombophilia_desc),
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
            title: Text(AppLocalizations.of(context)!.padua_recent_trauma),
            subtitle: Text(AppLocalizations.of(context)!.padua_recent_trauma_desc),
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
            title: Text(AppLocalizations.of(context)!.padua_elderly),
            subtitle: Text(AppLocalizations.of(context)!.padua_elderly_desc),
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
            title: Text(AppLocalizations.of(context)!.padua_heart_failure),
            subtitle: Text(AppLocalizations.of(context)!.padua_heart_failure_desc),
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
            title: Text(AppLocalizations.of(context)!.padua_respiratory_failure),
            subtitle: Text(AppLocalizations.of(context)!.padua_respiratory_failure_desc),
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
            title: Text(AppLocalizations.of(context)!.padua_acute_infection),
            subtitle: Text(AppLocalizations.of(context)!.padua_acute_infection_desc),
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
            title: Text(AppLocalizations.of(context)!.padua_rheumatic_disease),
            subtitle: Text(AppLocalizations.of(context)!.padua_rheumatic_disease_desc),
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
            title: Text(AppLocalizations.of(context)!.padua_ibd_stroke),
            subtitle: Text(AppLocalizations.of(context)!.padua_ibd_stroke_desc),
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
            title: Text(AppLocalizations.of(context)!.padua_acute_mi),
            subtitle: Text(AppLocalizations.of(context)!.padua_acute_mi_desc),
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
    List<Map<String, dynamic>> activeFactors = getRiskFactors(context).where((factor) => factor['active']).toList();
    
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
            AppLocalizations.of(context)!.padua_current_risk_factors(activeFactors.length),
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
            AppLocalizations.of(context)!.padua_risk_stratification,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('<4', AppLocalizations.of(context)!.padua_low_risk, '0.3%', AppLocalizations.of(context)!.padua_mechanical_prophylaxis, Colors.green),
          _buildRiskItem('≥4', AppLocalizations.of(context)!.padua_high_risk, '11%', AppLocalizations.of(context)!.padua_pharmacological_mechanical, Colors.red),
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
            AppLocalizations.of(context)!.padua_prophylaxis_recommendations,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildProphylaxisCard(
            AppLocalizations.of(context)!.padua_mechanical_prophylaxis_title,
            [
              AppLocalizations.of(context)!.padua_graduated_compression,
              AppLocalizations.of(context)!.padua_intermittent_compression,
              AppLocalizations.of(context)!.padua_early_mobilization,
              AppLocalizations.of(context)!.padua_leg_elevation,
            ],
            Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildProphylaxisCard(
            AppLocalizations.of(context)!.padua_pharmacological_prophylaxis_title,
            [
              AppLocalizations.of(context)!.padua_lmwh,
              AppLocalizations.of(context)!.padua_ufh,
              AppLocalizations.of(context)!.padua_fondaparinux,
              AppLocalizations.of(context)!.padua_doac,
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
                AppLocalizations.of(context)!.padua_clinical_information,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.padua_clinical_info_text,
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
                AppLocalizations.of(context)!.padua_reference_title,
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
            AppLocalizations.of(context)!.padua_reference_text,
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
