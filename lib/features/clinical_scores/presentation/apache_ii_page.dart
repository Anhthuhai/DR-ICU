import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

class ApacheIIPage extends StatefulWidget {
  const ApacheIIPage({super.key});

  @override
  State<ApacheIIPage> createState() => _ApacheIIPageState();
}

class _ApacheIIPageState extends State<ApacheIIPage> {
  // Age points
  int ageScore = 0;
  final TextEditingController ageController = TextEditingController();

  // Vital Signs
  int tempScore = 0;
  int mapScore = 0;
  int hrScore = 0;
  int rrScore = 0;

  // Lab Values
  int pHScore = 0;
  int naScore = 0;
  int kScore = 0;
  int creatScore = 0;
  int hctScore = 0;
  int wbcScore = 0;
  int gcsScore = 0;

  // Chronic Health
  int chronicHealthScore = 0;

  // Controllers for numeric inputs
  final TextEditingController tempController = TextEditingController();
  final TextEditingController mapController = TextEditingController();
  final TextEditingController hrController = TextEditingController();
  final TextEditingController rrController = TextEditingController();
  final TextEditingController pHController = TextEditingController();
  final TextEditingController naController = TextEditingController();
  final TextEditingController kController = TextEditingController();
  final TextEditingController creatController = TextEditingController();
  final TextEditingController hctController = TextEditingController();
  final TextEditingController wbcController = TextEditingController();

  int get totalScore => ageScore + tempScore + mapScore + hrScore + rrScore + 
                       pHScore + naScore + kScore + creatScore + hctScore + 
                       wbcScore + gcsScore + chronicHealthScore;

  double get mortalityRisk {
    if (totalScore == 0) {
      return 0.0;
    }
    
    // APACHE II mortality prediction formula (correct version)
    // Risk = e^(-3.517 + (APACHE II × 0.146)) / (1 + e^(-3.517 + (APACHE II × 0.146)))
    // Simplified version based on established ranges:
    
    if (totalScore <= 4) {
      return 4.0;
    } else if (totalScore <= 9) {
      return 8.0;
    } else if (totalScore <= 14) {
      return 15.0;
    } else if (totalScore <= 19) {
      return 24.0;
    } else if (totalScore <= 24) {
      return 40.0;
    } else if (totalScore <= 29) {
      return 55.0;
    } else if (totalScore <= 34) {
      return 73.0;
    } else {
      return 85.0;
    }
  }

  String interpretation(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (totalScore == 0) {
      return l10n.please_enter_parameters;
    }
    if (totalScore <= 4) {
      return l10n.very_low_mortality_risk;
    }
    if (totalScore <= 9) {
      return l10n.low_mortality_risk;
    }
    if (totalScore <= 14) {
      return l10n.moderate_mortality_risk;
    }
    if (totalScore <= 19) {
      return l10n.high_mortality_risk;
    }
    if (totalScore <= 24) {
      return l10n.very_high_mortality_risk;
    }
    return l10n.extremely_high_mortality_risk;
  }

  Color get scoreColor {
    if (totalScore == 0) {
      return Colors.grey;
    } else if (totalScore <= 4) {
      return Colors.green;
    } else if (totalScore <= 9) {
      return Colors.green.shade600;
    } else if (totalScore <= 14) {
      return Colors.orange;
    } else if (totalScore <= 19) {
      return Colors.red.shade400;
    } else if (totalScore <= 24) {
      return Colors.red;
    } else {
      return Colors.red.shade900;
    }
  }

  @override
  void dispose() {
    ageController.dispose();
    tempController.dispose();
    mapController.dispose();
    hrController.dispose();
    rrController.dispose();
    pHController.dispose();
    naController.dispose();
    kController.dispose();
    creatController.dispose();
    hctController.dispose();
    wbcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.apache2Score),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetAll,
          ),
        ],
      ),
      body: Column(
        children: [
          // Score Display
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: scoreColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: scoreColor.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Text(
                  l10n.apache2Score,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.darkGrey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  totalScore.toString(),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: scoreColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  interpretation(context),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: scoreColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (totalScore > 0) ...[
                  const SizedBox(height: 8),
                  Text(
                    '${l10n.predicted_mortality_rate}: ${mortalityRisk.toStringAsFixed(1)}%',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scoreColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Input Sections
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildAgeSection(),
                const SizedBox(height: 16),
                _buildVitalSignsSection(),
                const SizedBox(height: 16),
                _buildLabValuesSection(),
                const SizedBox(height: 16),
                _buildChronicHealthSection(),
                const SizedBox(height: 16),
                _buildCitationWidget(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgeSection() {
    final l10n = AppLocalizations.of(context)!;
    return _buildSection(
      l10n.age,
      Colors.blue.shade600,
      [
        TextField(
          controller: ageController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: l10n.age_years,
            border: const OutlineInputBorder(),
            suffixText: l10n.years,
          ),
          // ignore: deprecated_member_use
          onChanged: (value) {
            int age = int.tryParse(value) ?? 0;
            setState(() {
              if (age < 45) {
                ageScore = 0;
              } else if (age < 55) {
                ageScore = 2;
              } else if (age < 65) {
                ageScore = 3;
              } else if (age < 75) {
                ageScore = 5;
              } else {
                ageScore = 6;
              }
            });
          },
        ),
        if (ageScore > 0) 
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('${l10n.age_score}: $ageScore', style: TextStyle(color: Colors.blue.shade600, fontWeight: FontWeight.w600)),
          ),
      ],
    );
  }

  Widget _buildVitalSignsSection() {
    final l10n = AppLocalizations.of(context)!;
    return _buildSection(
      l10n.vital_signs,
      Colors.red.shade600,
      [
        _buildVitalSignRow(l10n.temperature_celsius, tempController, (value) {
          double temp = double.tryParse(value) ?? 0;
          setState(() {
            if (temp < 30 || temp >= 41) {
              tempScore = 4;
            } else if (temp < 32 || temp >= 39) {
              tempScore = 3;
            } else if (temp >= 38.5) {
              tempScore = 1;
            } else if (temp < 34) {
              tempScore = 2;
            } else {
              tempScore = 0;
            }
          });
        }, tempScore),
        
        _buildVitalSignRow(l10n.map_mmhg, mapController, (value) {
          int map = int.tryParse(value) ?? 0;
          setState(() {
            if (map < 50 || map >= 160) {
              mapScore = 4;
            } else if (map < 70 || map >= 130) {
              mapScore = 2;
            } else if (map >= 110) {
              mapScore = 2;
            } else {
              mapScore = 0;
            }
          });
        }, mapScore),
        
        _buildVitalSignRow(l10n.heart_rate_per_min, hrController, (value) {
          int hr = int.tryParse(value) ?? 0;
          setState(() {
            if (hr < 40 || hr >= 180) {
              hrScore = 4;
            } else if (hr < 55 || hr >= 140) {
              hrScore = 2;
            } else if (hr >= 110) {
              hrScore = 1;
            } else {
              hrScore = 0;
            }
          });
        }, hrScore),
        
        _buildVitalSignRow(l10n.respiratory_rate_per_min, rrController, (value) {
          int rr = int.tryParse(value) ?? 0;
          setState(() {
            if (rr < 6 || rr >= 50) {
              rrScore = 4;
            } else if (rr < 10 || rr >= 35) {
              rrScore = 1;
            } else if (rr >= 25) {
              rrScore = 1;
            } else {
              rrScore = 0;
            }
          });
        }, rrScore),
      ],
    );
  }

  Widget _buildLabValuesSection() {
    final l10n = AppLocalizations.of(context)!;
    return _buildSection(
      l10n.laboratory_tests,
      Colors.purple.shade600,
      [
        _buildVitalSignRow(l10n.blood_ph, pHController, (value) {
          double ph = double.tryParse(value) ?? 0;
          setState(() {
            if (ph < 7.15 || ph >= 7.7) {
              pHScore = 4;
            } else if (ph < 7.25 || ph >= 7.6) {
              pHScore = 3;
            } else if (ph < 7.33 || ph >= 7.5) {
              pHScore = 1;
            } else {
              pHScore = 0;
            }
          });
        }, pHScore),
        
        _buildVitalSignRow(l10n.sodium_meq_l, naController, (value) {
          int na = int.tryParse(value) ?? 0;
          setState(() {
            if (na < 111 || na >= 180) {
              naScore = 4;
            } else if (na < 120 || na >= 160) {
              naScore = 3;
            } else if (na < 130 || na >= 150) {
              naScore = 2;
            } else {
              naScore = 0;
            }
          });
        }, naScore),
        
        _buildVitalSignRow(l10n.potassium_meq_l, kController, (value) {
          double k = double.tryParse(value) ?? 0;
          setState(() {
            if (k < 2.5 || k >= 7) {
              kScore = 4;
            } else if (k < 3.0 || k >= 6) {
              kScore = 2;
            } else if (k < 3.5 || k >= 5.5) {
              kScore = 1;
            } else {
              kScore = 0;
            }
          });
        }, kScore),
      ],
    );
  }

  Widget _buildChronicHealthSection() {
    final l10n = AppLocalizations.of(context)!;
    return _buildSection(
      l10n.chronic_health,
      Colors.orange.shade600,
      [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.chronic_disease_history, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            RadioListTile<int>(
              title: Text(l10n.none),
              value: 0,
              // ignore: deprecated_member_use
              groupValue: chronicHealthScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => chronicHealthScore = value!),
            ),
            RadioListTile<int>(
              title: Text(l10n.has_non_surgical_or_emergency),
              value: 5,
              // ignore: deprecated_member_use
              groupValue: chronicHealthScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => chronicHealthScore = value!),
            ),
            RadioListTile<int>(
              title: Text(l10n.has_elective_surgery),
              value: 2,
              // ignore: deprecated_member_use
              groupValue: chronicHealthScore,
              // ignore: deprecated_member_use
              onChanged: (value) => setState(() => chronicHealthScore = value!),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection(String title, Color color, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        color: color.withValues(alpha: 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildVitalSignRow(String label, TextEditingController controller, Function(String) onChanged, int score) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
                isDense: true,
              ),
              // ignore: deprecated_member_use
              onChanged: null,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: score > 0 ? Colors.red.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Điểm: $score',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: score > 0 ? Colors.red : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _resetAll() {
    setState(() {
      ageScore = tempScore = mapScore = hrScore = rrScore = 0;
      pHScore = naScore = kScore = creatScore = hctScore = wbcScore = gcsScore = 0;
      chronicHealthScore = 0;
    });
    
    ageController.clear();
    tempController.clear();
    mapController.clear();
    hrController.clear();
    rrController.clear();
    pHController.clear();
    naController.clear();
    kController.clear();
    creatController.clear();
    hctController.clear();
    wbcController.clear();
  }

  Widget _buildCitationWidget() {
    final l10n = AppLocalizations.of(context)!;
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
                l10n.references,
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
            'Knaus WA, Draper EA, Wagner DP, Zimmerman JE. APACHE II: a severity of disease classification system. Crit Care Med. 1985;13(10):818-29.',
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
