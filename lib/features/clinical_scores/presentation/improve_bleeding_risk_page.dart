import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

class ImproveBleedingRiskPage extends StatefulWidget {
  const ImproveBleedingRiskPage({super.key});

  @override
  State<ImproveBleedingRiskPage> createState() => _ImproveBleedingRiskPageState();
}

class _ImproveBleedingRiskPageState extends State<ImproveBleedingRiskPage> {
  final TextEditingController _ageController = TextEditingController();

  bool _female = false;
  bool _cancer = false;
  bool _dialysis = false;
  bool _liverDisease = false;
  bool _icuStay = false;
  bool _icu48h = false;
  bool _anticoagulants = false;

  int _totalScore = 0;

  @override
  void initState() {
    super.initState();
    _ageController.addListener(_calculateScore);
  }

  void _calculateScore() {
    int score = 0;
    
    // Age
    final age = int.tryParse(_ageController.text) ?? 0;
    if (age >= 40) {
      score += 1;
    }
    
    // Female gender
    if (_female) {
      score += 1;
    }
    
    // Cancer
    if (_cancer) {
      score += 2;
    }
    
    // Dialysis
    if (_dialysis) {
      score += 2;
    }
    
    // Liver disease
    if (_liverDisease) {
      score += 2;
    }
    
    // ICU stay
    if (_icuStay) {
      score += 2;
    }
    
    // ICU stay >48h
    if (_icu48h) {
      score += 1;
    }
    
    // Anticoagulants
    if (_anticoagulants) {
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
    if (_totalScore <= 6) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String get riskLevel {
    if (_totalScore <= 2) {
      return AppLocalizations.of(context)!.improve_low_risk;
    }
    if (_totalScore <= 6) {
      return AppLocalizations.of(context)!.improve_moderate_risk;
    }
    return AppLocalizations.of(context)!.improve_high_risk;
  }

  String get bleedingRisk {
    if (_totalScore <= 2) {
      return '0.4%';
    }
    if (_totalScore <= 6) {
      return '1.1%';
    }
    return '4.1%';
  }

  String get majorBleedingRisk {
    if (_totalScore <= 2) {
      return '< 1%';
    }
    if (_totalScore <= 6) {
      return '1-3%';
    }
    return '> 3%';
  }

  String get recommendations {
    if (_totalScore <= 2) {
      return AppLocalizations.of(context)!.improve_standard_anticoagulation;
    }
    if (_totalScore <= 6) {
      return AppLocalizations.of(context)!.improve_careful_consideration;
    }
    return AppLocalizations.of(context)!.improve_caution_anticoagulants;
  }

  String get prophylaxisStrategy {
    if (_totalScore <= 2) {
      return AppLocalizations.of(context)!.improve_standard_prophylaxis;
    }
    if (_totalScore <= 6) {
      return AppLocalizations.of(context)!.improve_careful_prophylaxis;
    }
    return AppLocalizations.of(context)!.improve_mechanical_prophylaxis;
  }

  List<Map<String, dynamic>> get riskFactors {
    return [
      {
        'factor': AppLocalizations.of(context)!.improve_age_factor,
        'description': AppLocalizations.of(context)!.improve_age_factor_desc,
        'points': 1,
        'active': (int.tryParse(_ageController.text) ?? 0) >= 40,
      },
      {
        'factor': AppLocalizations.of(context)!.improve_female_factor,
        'description': AppLocalizations.of(context)!.improve_female_desc,
        'points': 1,
        'active': _female,
      },
      {
        'factor': AppLocalizations.of(context)!.improve_cancer_factor,
        'description': AppLocalizations.of(context)!.improve_cancer_desc,
        'points': 2,
        'active': _cancer,
      },
      {
        'factor': AppLocalizations.of(context)!.improve_dialysis_factor,
        'description': AppLocalizations.of(context)!.improve_dialysis_desc,
        'points': 2,
        'active': _dialysis,
      },
      {
        'factor': AppLocalizations.of(context)!.improve_liver_disease_factor,
        'description': AppLocalizations.of(context)!.improve_liver_disease_desc,
        'points': 2,
        'active': _liverDisease,
      },
      {
        'factor': AppLocalizations.of(context)!.improve_icu_stay_factor,
        'description': AppLocalizations.of(context)!.improve_icu_stay_desc,
        'points': 2,
        'active': _icuStay,
      },
      {
        'factor': AppLocalizations.of(context)!.improve_icu_48h_factor,
        'description': AppLocalizations.of(context)!.improve_icu_48h_desc,
        'points': 1,
        'active': _icu48h,
      },
      {
        'factor': AppLocalizations.of(context)!.improve_anticoagulants_factor,
        'description': AppLocalizations.of(context)!.improve_anticoagulants_desc,
        'points': 1,
        'active': _anticoagulants,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky AppBar
          SliverAppBar(
            title: Text(AppLocalizations.of(context)!.improve_bleeding_risk_title),
            backgroundColor: Colors.red.shade700,
            foregroundColor: Colors.white,
            pinned: true,
            floating: false,
            snap: false,
            elevation: 4,
          ),
          
          // Sticky Score Header
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyScoreHeaderDelegate(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: riskColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: riskColor.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$_totalScore/12',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: riskColor,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        riskLevel,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.darkGrey,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Scrollable Content
          SliverList(
            delegate: SliverChildListDelegate([
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
                            ? 'LƯU Ý Y KHOA CHẢY MÁU: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ chuyên khoa huyết học trước khi đưa ra quyết định điều trị.'
                            : 'BLEEDING RISK MEDICAL DISCLAIMER: Results are for reference only. Always consult with hematologist before making treatment decisions.',
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
              // Risk Info Section (moved from sticky header)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: _buildRiskInfo(),
              ),

              // Input Parameters
              _buildInputSection(),

              // Risk Factors
              _buildRiskFactorsSection(),

              // Active Risk Factors
              if (_totalScore > 0) _buildActiveFactors(),

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
                          AppLocalizations.of(context)!.improve_reference_title,
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
                      AppLocalizations.of(context)!.improve_reference_text,
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
        ],
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
                    AppLocalizations.of(context)!.improve_bleeding_risk,
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
                    AppLocalizations.of(context)!.improve_major_bleeding,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    majorBleedingRisk,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: riskColor,
                    ),
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
                      AppLocalizations.of(context)!.improve_prophylaxis_strategy,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  prophylaxisStrategy,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkGrey,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.assignment, color: riskColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.improve_recommendations,
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

  Widget _buildInputSection() {
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
            AppLocalizations.of(context)!.improve_patient_information,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.improve_age,
              suffixText: AppLocalizations.of(context)!.improve_years,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: AppLocalizations.of(context)!.improve_age_helper,
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
            AppLocalizations.of(context)!.improve_bleeding_risk_factors,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.improve_female),
            subtitle: Text(AppLocalizations.of(context)!.improve_female_desc),
            value: _female,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _female = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.improve_cancer),
            subtitle: Text(AppLocalizations.of(context)!.improve_cancer_desc),
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
            title: Text(AppLocalizations.of(context)!.improve_dialysis),
            subtitle: Text(AppLocalizations.of(context)!.improve_dialysis_desc),
            value: _dialysis,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _dialysis = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.improve_liver_disease),
            subtitle: Text(AppLocalizations.of(context)!.improve_liver_disease_desc),
            value: _liverDisease,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _liverDisease = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.improve_icu_stay),
            subtitle: Text(AppLocalizations.of(context)!.improve_icu_stay_desc),
            value: _icuStay,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _icuStay = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.improve_icu_48h),
            subtitle: Text(AppLocalizations.of(context)!.improve_icu_48h_desc),
            value: _icu48h,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _icu48h = value!;
              });
              _calculateScore();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.improve_anticoagulants),
            subtitle: Text(AppLocalizations.of(context)!.improve_anticoagulants_desc),
            value: _anticoagulants,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _anticoagulants = value!;
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
            AppLocalizations.of(context)!.improve_current_risk_factors(activeFactors.length),
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
            AppLocalizations.of(context)!.improve_risk_stratification,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('0-2', AppLocalizations.of(context)!.improve_low_risk, '0.4%', AppLocalizations.of(context)!.improve_standard_prophylaxis, Colors.green),
          _buildRiskItem('3-6', AppLocalizations.of(context)!.improve_moderate_risk, '1.1%', AppLocalizations.of(context)!.improve_careful_prophylaxis, Colors.orange),
          _buildRiskItem('7-12', AppLocalizations.of(context)!.improve_high_risk, '4.1%', AppLocalizations.of(context)!.improve_mechanical_prophylaxis, Colors.red),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String risk, String bleedingRate, String strategy, Color color) {
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
            strategy,
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
        color: Colors.purple.shade50,
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.purple.shade600),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.improve_clinical_information,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.purple.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.improve_clinical_info_text,
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }
}

// Sticky Header Delegate for Score Section
class _StickyScoreHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyScoreHeaderDelegate({required this.child});

  @override
  double get minExtent => 84; // Minimum height when collapsed

  @override
  double get maxExtent => 84; // Maximum height when expanded

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 84,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
