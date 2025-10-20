import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class PewsScorePage extends StatefulWidget {
  const PewsScorePage({super.key});

  @override
  State<PewsScorePage> createState() => _PewsScorePageState();
}

class _PewsScorePageState extends State<PewsScorePage> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _respiratoryRateController = TextEditingController();
  final TextEditingController _systolicBpController = TextEditingController();

  String _consciousnessLevel = 'alert';
  String _oxygenTherapy = 'room_air';

  int _totalScore = 0;

  @override
  void initState() {
    super.initState();
    _ageController.addListener(_calculateScore);
    _heartRateController.addListener(_calculateScore);
    _respiratoryRateController.addListener(_calculateScore);
    _systolicBpController.addListener(_calculateScore);
  }

  void _calculateScore() {
    int score = 0;
    
    final age = int.tryParse(_ageController.text) ?? 0;
    final heartRate = int.tryParse(_heartRateController.text) ?? 0;
    final respiratoryRate = int.tryParse(_respiratoryRateController.text) ?? 0;
    final systolicBp = int.tryParse(_systolicBpController.text) ?? 0;
    
    // Heart Rate scoring based on age
    if (age > 0 && heartRate > 0) {
      if (age < 1) { // Infant
        if (heartRate < 90 || heartRate > 180) {
          score += 3;
        }
        else if (heartRate < 100 || heartRate > 170) {
   score += 2;
 }
        else if (heartRate < 110 || heartRate > 160) {
   score += 1;
 }
      } else if (age <= 5) { // 1-5 years
        if (heartRate < 80 || heartRate > 140) {
          score += 3;
        }
        else if (heartRate < 90 || heartRate > 130) {
   score += 2;
 }
        else if (heartRate < 100 || heartRate > 120) {
   score += 1;
 }
      } else if (age <= 12) { // 6-12 years
        if (heartRate < 70 || heartRate > 120) {
          score += 3;
        }
        else if (heartRate < 80 || heartRate > 110) {
   score += 2;
 }
        else if (heartRate < 90 || heartRate > 100) {
   score += 1;
 }
      } else { // >12 years
        if (heartRate < 60 || heartRate > 100) {
          score += 3;
        }
        else if (heartRate < 70 || heartRate > 90) {
   score += 2;
 }
        else if (heartRate < 80 || heartRate > 90) {
   score += 1;
 }
      }
    }
    
    // Respiratory Rate scoring based on age
    if (age > 0 && respiratoryRate > 0) {
      if (age < 1) { // Infant
        if (respiratoryRate < 20 || respiratoryRate > 60) {
          score += 3;
        }
        else if (respiratoryRate < 25 || respiratoryRate > 50) {
   score += 2;
 }
        else if (respiratoryRate < 30 || respiratoryRate > 45) {
   score += 1;
 }
      } else if (age <= 5) { // 1-5 years
        if (respiratoryRate < 15 || respiratoryRate > 40) {
          score += 3;
        }
        else if (respiratoryRate < 20 || respiratoryRate > 35) {
   score += 2;
 }
        else if (respiratoryRate < 25 || respiratoryRate > 30) {
   score += 1;
 }
      } else if (age <= 12) { // 6-12 years
        if (respiratoryRate < 12 || respiratoryRate > 30) {
          score += 3;
        }
        else if (respiratoryRate < 15 || respiratoryRate > 25) {
   score += 2;
 }
        else if (respiratoryRate < 18 || respiratoryRate > 22) {
   score += 1;
 }
      } else { // >12 years
        if (respiratoryRate < 10 || respiratoryRate > 25) {
          score += 3;
        }
        else if (respiratoryRate < 12 || respiratoryRate > 22) {
   score += 2;
 }
        else if (respiratoryRate < 15 || respiratoryRate > 20) {
   score += 1;
 }
      }
    }
    
    // Systolic BP scoring based on age
    if (age > 0 && systolicBp > 0) {
      if (age < 1) { // Infant
        if (systolicBp < 70) {
          score += 3;
        }
        else if (systolicBp < 80) {
   score += 2;
 }
        else if (systolicBp < 90) {
   score += 1;
 }
      } else if (age <= 5) { // 1-5 years
        if (systolicBp < 80) {
          score += 3;
        }
        else if (systolicBp < 90) {
   score += 2;
 }
        else if (systolicBp < 100) {
   score += 1;
 }
      } else if (age <= 12) { // 6-12 years
        if (systolicBp < 90) {
          score += 3;
        }
        else if (systolicBp < 100) {
   score += 2;
 }
        else if (systolicBp < 110) {
   score += 1;
 }
      } else { // >12 years
        if (systolicBp < 100) {
          score += 3;
        }
        else if (systolicBp < 110) {
   score += 2;
 }
        else if (systolicBp < 120) {
   score += 1;
 }
      }
    }
    
    // Consciousness level
    switch (_consciousnessLevel) {
      case 'voice':
        score += 1;
        break;
      case 'pain':
        score += 2;
        break;
      case 'unresponsive':
        score += 3;
        break;
    }
    
    // Oxygen therapy
    switch (_oxygenTherapy) {
      case 'nasal_cannula':
        score += 1;
        break;
      case 'face_mask':
        score += 2;
        break;
      case 'high_flow':
        score += 3;
        break;
    }

    setState(() {
      _totalScore = score;
    });
  }

  Color get riskColor {
    if (_totalScore <= 3) {
      return Colors.green;
    }
    if (_totalScore <= 6) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String getRiskLevel(AppLocalizations localizations) {
    if (_totalScore <= 3) {
      return localizations.pews_risk_low;
    }
    if (_totalScore <= 6) {
      return localizations.pews_risk_medium;
    }
    return localizations.pews_risk_high;
  }

  String getResponseLevel(AppLocalizations localizations) {
    if (_totalScore <= 3) {
      return localizations.pews_response_routine;
    }
    if (_totalScore <= 6) {
      return localizations.pews_response_increased;
    }
    return localizations.pews_response_active;
  }

  String getFrequency(AppLocalizations localizations) {
    if (_totalScore <= 3) {
      return localizations.pews_frequency_4_6_hours;
    }
    if (_totalScore <= 6) {
      return localizations.pews_frequency_1_hour;
    }
    return localizations.pews_frequency_continuous;
  }

  String getClinicalResponse(AppLocalizations localizations) {
    if (_totalScore <= 3) {
      return localizations.pews_action_continue_care;
    }
    if (_totalScore <= 6) {
      return localizations.pews_action_notify_doctor;
    }
    return localizations.pews_action_emergency_team;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky App Bar
          SliverAppBar(
            title: Text(localizations.pews_title),
            backgroundColor: Colors.pink.shade700,
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
                      Localizations.localeOf(context).languageCode == 'vi' 
                          ? 'Thang điểm PEWS' 
                          : 'PEWS Score',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: riskColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '$_totalScore',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: riskColor,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        _totalScore <= 3 ? localizations.pews_interp_low_risk :
                        _totalScore <= 6 ? localizations.pews_interp_moderate_risk :
                        localizations.pews_interp_high_risk,
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
                              ? 'LƯU Ý Y KHOA NHI: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ nhi khoa trước khi đưa ra quyết định điều trị.'
                              : 'PEDIATRIC MEDICAL DISCLAIMER: Results are for reference only. Always consult with a pediatric specialist before making treatment decisions.',
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
                _buildRiskInfo(localizations),

                // Input Parameters
                _buildInputSection(localizations),

                // Risk Stratification
                _buildRiskStratification(localizations),

                // Response Protocol
                _buildResponseProtocol(localizations),

                // Clinical Information
                _buildClinicalInfo(localizations),

                // Medical Citation
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildCitationWidget(localizations),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskInfo(AppLocalizations localizations) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      localizations.pews_response_level,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      getResponseLevel(localizations),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: riskColor,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      localizations.pews_monitoring_frequency,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      getFrequency(localizations),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: riskColor,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: riskColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: riskColor.withValues(alpha: 0.2)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.assignment, color: riskColor, size: 18),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        localizations.pews_recommendation_title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: riskColor,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  getClinicalResponse(localizations),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.darkGrey,
                    fontSize: 11,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection(AppLocalizations localizations) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.pink.shade300),
        color: Colors.pink.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.pews_vital_signs_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: localizations.pews_age_label,
              suffixText: localizations.pews_age_unit,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: localizations.pews_age_helper,
            ),
          ),
          const SizedBox(height: 12),
          
          TextField(
            controller: _heartRateController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: localizations.pews_heart_rate_label,
              suffixText: localizations.unit_per_minute,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: localizations.pews_heart_rate_helper,
            ),
          ),
          const SizedBox(height: 12),
          
          TextField(
            controller: _respiratoryRateController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: localizations.pews_respiratory_rate_label,
              suffixText: localizations.unit_per_minute,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: localizations.pews_respiratory_rate_helper,
            ),
          ),
          const SizedBox(height: 12),
          
          TextField(
            controller: _systolicBpController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: localizations.pews_systolic_bp_label,
              suffixText: 'mmHg',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: localizations.pews_systolic_bp_helper,
            ),
          ),
          const SizedBox(height: 16),
          
          Text(
            localizations.pews_consciousness_level,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Column(
            children: [
              RadioListTile<String>(
                title: Text(localizations.pews_consciousness_alert),
                value: 'alert',
                // ignore: deprecated_member_use
                groupValue: _consciousnessLevel,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _consciousnessLevel = value!;
                  });
                  _calculateScore();
                },
                contentPadding: EdgeInsets.zero,
              ),
              RadioListTile<String>(
                title: Text(localizations.pews_consciousness_voice),
                value: 'voice',
                // ignore: deprecated_member_use
                groupValue: _consciousnessLevel,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _consciousnessLevel = value!;
                  });
                  _calculateScore();
                },
                contentPadding: EdgeInsets.zero,
              ),
              RadioListTile<String>(
                title: Text(localizations.pews_consciousness_pain),
                value: 'pain',
                // ignore: deprecated_member_use
                groupValue: _consciousnessLevel,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _consciousnessLevel = value!;
                  });
                  _calculateScore();
                },
                contentPadding: EdgeInsets.zero,
              ),
              RadioListTile<String>(
                title: Text(localizations.pews_consciousness_unresponsive),
                value: 'unresponsive',
                // ignore: deprecated_member_use
                groupValue: _consciousnessLevel,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _consciousnessLevel = value!;
                  });
                  _calculateScore();
                },
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          Text(
            localizations.pews_oxygen_therapy,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Column(
            children: [
              RadioListTile<String>(
                title: Text(localizations.pews_oxygen_room_air),
                value: 'room_air',
                // ignore: deprecated_member_use
                groupValue: _oxygenTherapy,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _oxygenTherapy = value!;
                  });
                  _calculateScore();
                },
                contentPadding: EdgeInsets.zero,
              ),
              RadioListTile<String>(
                title: Text(localizations.pews_oxygen_nasal_cannula),
                value: 'nasal_cannula',
                // ignore: deprecated_member_use
                groupValue: _oxygenTherapy,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _oxygenTherapy = value!;
                  });
                  _calculateScore();
                },
                contentPadding: EdgeInsets.zero,
              ),
              RadioListTile<String>(
                title: Text(localizations.pews_oxygen_face_mask),
                value: 'face_mask',
                // ignore: deprecated_member_use
                groupValue: _oxygenTherapy,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _oxygenTherapy = value!;
                  });
                  _calculateScore();
                },
                contentPadding: EdgeInsets.zero,
              ),
              RadioListTile<String>(
                title: const Text('High flow/CPAP (+3)'),
                value: 'high_flow',
                // ignore: deprecated_member_use
                groupValue: _oxygenTherapy,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _oxygenTherapy = value!;
                  });
                  _calculateScore();
                },
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRiskStratification(AppLocalizations localizations) {
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
            localizations.pews_risk_stratification_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('0-3', localizations.pews_interp_low_risk, localizations.pews_interp_frequency_4_6h, localizations.pews_interp_routine_care, Colors.green),
          _buildRiskItem('4-6', localizations.pews_interp_moderate_risk, localizations.pews_interp_frequency_1_2h, localizations.pews_interp_notify_physician, Colors.orange),
          _buildRiskItem('≥7', localizations.pews_interp_high_risk, localizations.pews_interp_frequency_continuous, localizations.pews_interp_emergency_team, Colors.red),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String risk, String frequency, String action, Color color) {
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
                  frequency,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color,
                    fontSize: 12,
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

  Widget _buildResponseProtocol(AppLocalizations localizations) {
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
            localizations.pews_response_protocol_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildProtocolCard(
            localizations.pews_protocol_routine_title,
            [
              localizations.pews_protocol_routine_1,
              localizations.pews_protocol_routine_2,
              localizations.pews_protocol_routine_3,
              localizations.pews_protocol_routine_4,
            ],
            Colors.green,
          ),
          const SizedBox(height: 12),
          _buildProtocolCard(
            localizations.pews_protocol_increased_title,
            [
              localizations.pews_protocol_increased_1,
              localizations.pews_protocol_increased_2,
              localizations.pews_protocol_increased_3,
              localizations.pews_protocol_increased_4,
            ],
            Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildProtocolCard(
            localizations.pews_protocol_urgent_title,
            [
              localizations.pews_protocol_urgent_1,
              localizations.pews_protocol_urgent_2,
              localizations.pews_protocol_urgent_3,
              localizations.pews_protocol_urgent_4,
            ],
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildProtocolCard(String title, List<String> items, Color color) {
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

  Widget _buildClinicalInfo(AppLocalizations localizations) {
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
                localizations.pews_clinical_info_title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            localizations.pews_clinical_info_description,
            style: const TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heartRateController.dispose();
    _respiratoryRateController.dispose();
    _systolicBpController.dispose();
    super.dispose();
  }

  Widget _buildCitationWidget(AppLocalizations localizations) {
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
                localizations.pews_references_title,
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
            localizations.pews_references_text,
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
