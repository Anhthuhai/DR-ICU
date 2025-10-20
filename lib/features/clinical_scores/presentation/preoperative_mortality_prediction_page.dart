import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class PreoperativeMortalityPredictionPage extends StatefulWidget {
  const PreoperativeMortalityPredictionPage({super.key});

  @override
  State<PreoperativeMortalityPredictionPage> createState() => _PreoperativeMortalityPredictionPageState();
}

class _PreoperativeMortalityPredictionPageState extends State<PreoperativeMortalityPredictionPage> {
  final TextEditingController _ageController = TextEditingController();
  
  int _selectedASA = 1;
  String _selectedSurgeryRisk = 'low';
  bool _emergencySurgery = false;
  bool _cardiacRiskFactors = false;
  bool _pulmonaryDisease = false;
  bool _renalDisease = false;
  bool _hepaticDisease = false;
  bool _neurologicDisease = false;
  bool _diabetes = false;
  bool _immunosuppression = false;

  double _mortalityRisk = 0.0;

  @override
  void initState() {
    super.initState();
    _ageController.addListener(_calculateRisk);
  }

  void _calculateRisk() {
    final age = int.tryParse(_ageController.text) ?? 0;
    
    if (age > 0) {
      double risk = 0.1; // Base risk
      
      // Age factor
      if (age >= 80) {
        risk += 0.15;
      } else if (age >= 70) {
        risk += 0.10;
      } else if (age >= 60) {
        risk += 0.05;
      }
      
      // ASA classification
      switch (_selectedASA) {
        case 1:
          risk += 0.0;
          break;
        case 2:
          risk += 0.02;
          break;
        case 3:
          risk += 0.08;
          break;
        case 4:
          risk += 0.25;
          break;
        case 5:
          risk += 0.50;
          break;
      }
      
      // Surgery risk
      switch (_selectedSurgeryRisk) {
        case 'low':
          risk += 0.0;
          break;
        case 'intermediate':
          risk += 0.05;
          break;
        case 'high':
          risk += 0.15;
          break;
      }
      
      // Emergency surgery
      if (_emergencySurgery) {
        risk += 0.12;
      }
      
      // Comorbidities
      if (_cardiacRiskFactors) {
        risk += 0.08;
      }
      if (_pulmonaryDisease) {
        risk += 0.06;
      }
      if (_renalDisease) {
        risk += 0.10;
      }
      if (_hepaticDisease) {
        risk += 0.12;
      }
      if (_neurologicDisease) {
        risk += 0.05;
      }
      if (_diabetes) {
        risk += 0.03;
      }
      if (_immunosuppression) {
        risk += 0.08;
      }
      
      // Cap at 99%
      risk = math.min(risk, 0.99);
      
      setState(() {
        _mortalityRisk = risk * 100;
      });
    } else {
      setState(() {
        _mortalityRisk = 0.0;
      });
    }
  }

  Color get riskColor {
    if (_mortalityRisk < 1) {
      return Colors.green;
    }
    if (_mortalityRisk < 5) {
      return Colors.yellow.shade700;
    }
    if (_mortalityRisk < 15) {
      return Colors.orange;
    }
    if (_mortalityRisk < 30) {
      return Colors.red.shade600;
    }
    return Colors.red.shade900;
  }

  String riskLevel(BuildContext context) {
    if (_mortalityRisk < 1) {
      return AppLocalizations.of(context)!.preop_mortality_risk_very_low;
    }
    if (_mortalityRisk < 5) {
      return AppLocalizations.of(context)!.preop_mortality_risk_low;
    }
    if (_mortalityRisk < 15) {
      return AppLocalizations.of(context)!.preop_mortality_risk_moderate;
    }
    if (_mortalityRisk < 30) {
      return AppLocalizations.of(context)!.preop_mortality_risk_high;
    }
    return AppLocalizations.of(context)!.preop_mortality_risk_very_high;
  }

  String recommendations(BuildContext context) {
    if (_mortalityRisk < 1) {
      return AppLocalizations.of(context)!.preop_mortality_recommendation_very_low;
    }
    if (_mortalityRisk < 5) {
      return AppLocalizations.of(context)!.preop_mortality_recommendation_low;
    }
    if (_mortalityRisk < 15) {
      return AppLocalizations.of(context)!.preop_mortality_recommendation_moderate;
    }
    if (_mortalityRisk < 30) {
      return AppLocalizations.of(context)!.preop_mortality_recommendation_high;
    }
    return AppLocalizations.of(context)!.preop_mortality_recommendation_very_high;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky AppBar
          SliverAppBar(
            title: Text(AppLocalizations.of(context)!.preop_mortality_title),
            backgroundColor: Colors.deepPurple.shade700,
            foregroundColor: Colors.white,
            floating: true,
            pinned: true,
            snap: false,
            elevation: 4,
          ),
          
          // Sticky Score Header
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: riskColor),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            AppLocalizations.of(context)!.preop_mortality_risk_title,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: riskColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            _mortalityRisk > 0 ? '${_mortalityRisk.toStringAsFixed(1)}%' : '0%',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: riskColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${riskLevel(context)} Risk',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkGrey,
                            ),
                            textAlign: TextAlign.center,
                          ),
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
                              ? 'LƯU Ý Y KHOA PHẪU THUẬT: Kết quả chỉ mang tính tham khảo dự báo nguy cơ tử vong. Luôn tham khảo ý kiến bác sĩ gây mê hồi sức và phẫu thuật viên trước khi đưa ra quyết định.'
                              : 'SURGICAL MORTALITY DISCLAIMER: Results are for mortality risk reference only. Always consult with anesthesiologist and surgeon before making decisions.',
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
                
                // Risk Information (moved from sticky header)
                Container(
                  margin: const EdgeInsets.all(16),
                  child: _buildRiskInfo(),
                ),
                
                // Input Parameters
                _buildPatientFactors(),
                _buildSurgeryFactors(),
                _buildComorbidities(),

                // Risk Stratification
                _buildRiskStratification(),

                // Clinical Guidelines
                _buildClinicalGuidelines(),

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
                            AppLocalizations.of(context)!.preop_mortality_reference_title,
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
                        AppLocalizations.of(context)!.preop_mortality_reference_text,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.blue.shade600,
                        ),
                      ),
                    ],
                  ),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
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
                      AppLocalizations.of(context)!.preop_mortality_recommendations,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  recommendations(context),
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

  Widget _buildPatientFactors() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.shade300),
        color: Colors.deepPurple.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.preop_mortality_patient_factors,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.preop_mortality_age_label,
              suffixText: AppLocalizations.of(context)!.preop_mortality_age_unit,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          
          Text(
            AppLocalizations.of(context)!.preop_mortality_asa_label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple.shade700,
            ),
          ),
          const SizedBox(height: 8),
          
          ...List.generate(5, (index) {
            final asaClass = index + 1;
            final descriptions = [
              AppLocalizations.of(context)!.preop_mortality_asa_1,
              AppLocalizations.of(context)!.preop_mortality_asa_2,
              AppLocalizations.of(context)!.preop_mortality_asa_3,
              AppLocalizations.of(context)!.preop_mortality_asa_4,
              AppLocalizations.of(context)!.preop_mortality_asa_5,
            ];
            
            return RadioListTile<int>(
              title: Text(descriptions[index]),
              value: asaClass,
              // ignore: deprecated_member_use
              groupValue: _selectedASA,
              // ignore: deprecated_member_use
              onChanged: (value) {
                setState(() {
                  _selectedASA = value!;
                });
                _calculateRisk();
              },
              contentPadding: EdgeInsets.zero,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSurgeryFactors() {
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
            AppLocalizations.of(context)!.preop_mortality_surgery_factors,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          Text(
            AppLocalizations.of(context)!.preop_mortality_surgery_risk_label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 8),
          
          RadioListTile<String>(
            title: Text(AppLocalizations.of(context)!.preop_mortality_surgery_low),
            subtitle: Text(AppLocalizations.of(context)!.preop_mortality_surgery_low_desc),
            value: 'low',
            // ignore: deprecated_member_use
            groupValue: _selectedSurgeryRisk,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _selectedSurgeryRisk = value!;
              });
              _calculateRisk();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          RadioListTile<String>(
            title: Text(AppLocalizations.of(context)!.preop_mortality_surgery_intermediate),
            subtitle: Text(AppLocalizations.of(context)!.preop_mortality_surgery_intermediate_desc),
            value: 'intermediate',
            // ignore: deprecated_member_use
            groupValue: _selectedSurgeryRisk,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _selectedSurgeryRisk = value!;
              });
              _calculateRisk();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          RadioListTile<String>(
            title: Text(AppLocalizations.of(context)!.preop_mortality_surgery_high),
            subtitle: Text(AppLocalizations.of(context)!.preop_mortality_surgery_high_desc),
            value: 'high',
            // ignore: deprecated_member_use
            groupValue: _selectedSurgeryRisk,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _selectedSurgeryRisk = value!;
              });
              _calculateRisk();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          const SizedBox(height: 16),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.preop_mortality_emergency),
            subtitle: Text(AppLocalizations.of(context)!.preop_mortality_emergency_desc),
            value: _emergencySurgery,
            onChanged: (value) {
              setState(() {
                _emergencySurgery = value!;
              });
              _calculateRisk();
            },
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildComorbidities() {
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
            AppLocalizations.of(context)!.preop_mortality_comorbidities,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.preop_mortality_cardiac),
            subtitle: Text(AppLocalizations.of(context)!.preop_mortality_cardiac_desc),
            value: _cardiacRiskFactors,
            onChanged: (value) {
              setState(() {
                _cardiacRiskFactors = value!;
              });
              _calculateRisk();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.preop_mortality_pulmonary),
            subtitle: Text(AppLocalizations.of(context)!.preop_mortality_pulmonary_desc),
            value: _pulmonaryDisease,
            onChanged: (value) {
              setState(() {
                _pulmonaryDisease = value!;
              });
              _calculateRisk();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.preop_mortality_renal),
            subtitle: Text(AppLocalizations.of(context)!.preop_mortality_renal_desc),
            value: _renalDisease,
            onChanged: (value) {
              setState(() {
                _renalDisease = value!;
              });
              _calculateRisk();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.preop_mortality_hepatic),
            subtitle: Text(AppLocalizations.of(context)!.preop_mortality_hepatic_desc),
            value: _hepaticDisease,
            onChanged: (value) {
              setState(() {
                _hepaticDisease = value!;
              });
              _calculateRisk();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.preop_mortality_neurologic),
            subtitle: Text(AppLocalizations.of(context)!.preop_mortality_neurologic_desc),
            value: _neurologicDisease,
            onChanged: (value) {
              setState(() {
                _neurologicDisease = value!;
              });
              _calculateRisk();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.preop_mortality_diabetes),
            subtitle: Text(AppLocalizations.of(context)!.preop_mortality_diabetes_desc),
            value: _diabetes,
            onChanged: (value) {
              setState(() {
                _diabetes = value!;
              });
              _calculateRisk();
            },
            contentPadding: EdgeInsets.zero,
          ),
          
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.preop_mortality_immunosuppression),
            subtitle: Text(AppLocalizations.of(context)!.preop_mortality_immunosuppression_desc),
            value: _immunosuppression,
            onChanged: (value) {
              setState(() {
                _immunosuppression = value!;
              });
              _calculateRisk();
            },
            contentPadding: EdgeInsets.zero,
          ),
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
            AppLocalizations.of(context)!.preop_mortality_risk_stratification,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('<1%', AppLocalizations.of(context)!.preop_mortality_risk_very_low, 
            AppLocalizations.of(context)!.preop_mortality_action_safe, Colors.green),
          _buildRiskItem('1-5%', AppLocalizations.of(context)!.preop_mortality_risk_low, 
            AppLocalizations.of(context)!.preop_mortality_action_standard, Colors.yellow.shade700),
          _buildRiskItem('5-15%', AppLocalizations.of(context)!.preop_mortality_risk_moderate, 
            AppLocalizations.of(context)!.preop_mortality_action_optimize, Colors.orange),
          _buildRiskItem('15-30%', AppLocalizations.of(context)!.preop_mortality_risk_high, 
            AppLocalizations.of(context)!.preop_mortality_action_consider, Colors.red.shade600),
          _buildRiskItem('>30%', AppLocalizations.of(context)!.preop_mortality_risk_very_high, 
            AppLocalizations.of(context)!.preop_mortality_action_alternative, Colors.red.shade900),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String range, String level, String action, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            child: Text(
              range,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              level,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              action,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
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
        border: Border.all(color: Colors.teal.shade300),
        color: Colors.teal.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.preop_mortality_guidelines,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildGuidelineCard(
            AppLocalizations.of(context)!.preop_mortality_guideline_low_title,
            [
              AppLocalizations.of(context)!.preop_mortality_guideline_low_1,
              AppLocalizations.of(context)!.preop_mortality_guideline_low_2,
              AppLocalizations.of(context)!.preop_mortality_guideline_low_3,
              AppLocalizations.of(context)!.preop_mortality_guideline_low_4,
            ],
            Colors.green,
          ),
          const SizedBox(height: 12),
          _buildGuidelineCard(
            AppLocalizations.of(context)!.preop_mortality_guideline_moderate_title,
            [
              AppLocalizations.of(context)!.preop_mortality_guideline_moderate_1,
              AppLocalizations.of(context)!.preop_mortality_guideline_moderate_2,
              AppLocalizations.of(context)!.preop_mortality_guideline_moderate_3,
              AppLocalizations.of(context)!.preop_mortality_guideline_moderate_4,
            ],
            Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildGuidelineCard(
            AppLocalizations.of(context)!.preop_mortality_guideline_high_title,
            [
              AppLocalizations.of(context)!.preop_mortality_guideline_high_1,
              AppLocalizations.of(context)!.preop_mortality_guideline_high_2,
              AppLocalizations.of(context)!.preop_mortality_guideline_high_3,
              AppLocalizations.of(context)!.preop_mortality_guideline_high_4,
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
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.preop_mortality_clinical_info,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.preop_mortality_clinical_text,
            style: const TextStyle(height: 1.4),
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

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  double get minExtent => 60.0; // Minimum height when collapsed

  @override
  double get maxExtent => 60.0; // Maximum height when expanded

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
