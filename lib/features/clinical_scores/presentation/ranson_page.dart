import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class RansonPage extends StatefulWidget {
  const RansonPage({super.key});

  @override
  State<RansonPage> createState() => _RansonPageState();
}

class _RansonPageState extends State<RansonPage> {
  // At admission criteria
  int age = 0;
  int wbc = 0;
  int glucose = 0;
  int ldh = 0;
  int ast = 0;

  // At 48 hours criteria
  int hematocritDrop = 0;
  int bunRise = 0;
  int calciumDrop = 0;
  int po2Drop = 0;
  int baseDeficit = 0;
  int fluidSequestration = 0;

  final TextEditingController ageController = TextEditingController();
  final TextEditingController wbcController = TextEditingController();
  final TextEditingController glucoseController = TextEditingController();
  final TextEditingController ldhController = TextEditingController();
  final TextEditingController astController = TextEditingController();
  final TextEditingController hctController = TextEditingController();
  final TextEditingController bunController = TextEditingController();
  final TextEditingController calciumController = TextEditingController();
  final TextEditingController po2Controller = TextEditingController();
  final TextEditingController baseDeficitController = TextEditingController();
  final TextEditingController fluidController = TextEditingController();

  // Unit variables
  String _glucoseUnit = 'mg/dL';
  String _bunUnit = 'mg/dL';

  int get totalScore => age + wbc + glucose + ldh + ast + hematocritDrop + 
                       bunRise + calciumDrop + po2Drop + baseDeficit + fluidSequestration;

  Color get scoreColor {
    if (totalScore <= 2) {
      return Colors.green;
    }
    if (totalScore <= 5) {
      return Colors.yellow.shade700;
    }
    return Colors.red;
  }

  String getSeverity(BuildContext context) {
    if (totalScore <= 2) {
      return AppLocalizations.of(context)!.ranson_severity_mild;
    }
    if (totalScore <= 5) {
      return AppLocalizations.of(context)!.ranson_severity_moderate;
    }
    return AppLocalizations.of(context)!.ranson_severity_severe;
  }

  String get mortalityRate {
    if (totalScore <= 2) {
      return '< 1%';
    }
    if (totalScore == 3) {
      return '15%';
    }
    if (totalScore == 4) {
      return '15%';
    }
    if (totalScore == 5) {
      return '40%';
    }
    if (totalScore == 6) {
      return '40%';
    }
    return '> 50%';
  }

  String getManagement(BuildContext context) {
    if (totalScore <= 2) {
      return AppLocalizations.of(context)!.ranson_management_mild;
    }
    if (totalScore <= 5) {
      return AppLocalizations.of(context)!.ranson_management_moderate;
    }
    return AppLocalizations.of(context)!.ranson_management_severe;
  }

  // Unit conversion functions
  double convertGlucoseToMgDL(double value, String unit) {
    if (unit == 'mmol/L') {
      return value * 18.0; // Convert mmol/L to mg/dL
    }
    return value; // Already in mg/dL
  }

  double convertBUNToMgDL(double value, String unit) {
    if (unit == 'mmol/L') {
      return value * 2.8; // Convert mmol/L to mg/dL
    }
    return value; // Already in mg/dL
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Main AppBar
          SliverAppBar(
            title: Text(l10n.ranson_title),
            backgroundColor: Colors.brown.shade700,
            foregroundColor: Colors.white,
            pinned: true,
            floating: false,
            snap: false,
            expandedHeight: 60,
          ),
          
          // Sticky Score Header
          SliverAppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            pinned: true,
            floating: false,
            snap: false,
            automaticallyImplyLeading: false,
            toolbarHeight: 56,
            title: Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      '$totalScore ${totalScore <= 1 ? "Point" : "Points"}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: scoreColor,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      getSeverity(context),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: scoreColor,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Medical Disclaimer Banner
          SliverToBoxAdapter(
            child: Container(
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
                          ? 'LƯU Ý Y KHOA TIÊU HÓA: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ chuyên khoa tiêu hóa trước khi đưa ra quyết định điều trị.'
                          : 'GASTROENTEROLOGY MEDICAL DISCLAIMER: Results are for reference only. Always consult with gastroenterologist before making treatment decisions.',
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
          ),
          
          // Score Display (Full)
          SliverToBoxAdapter(
            child: Container(
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
                    l10n.ranson_score_title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: scoreColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    totalScore.toString(),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: scoreColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    getSeverity(context),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.ranson_mortality_rate(mortalityRate),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    getManagement(context),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.darkGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // At admission criteria
          SliverToBoxAdapter(
            child: _buildSection(
              l10n.ranson_admission_criteria,
              Colors.blue.shade600,
              [
                _buildNumericInput(
                  l10n.ranson_age, 
                  ageController,
                  Icons.person,
                  (value) {
                    int ageValue = int.tryParse(value) ?? 0;
                    setState(() {
                      age = ageValue > 55 ? 1 : 0;
                    });
                  },
                  age,
                  context,
                ),
                _buildNumericInput(
                  l10n.ranson_wbc, 
                  wbcController,
                  Icons.water_drop,
                  (value) {
                    int wbcValue = int.tryParse(value) ?? 0;
                    setState(() {
                      wbc = wbcValue > 16000 ? 1 : 0;
                    });
                  },
                  wbc,
                  context,
                ),
                _buildLabInputWithUnit(
                  l10n.ranson_glucose, 
                  glucoseController,
                  Icons.bloodtype,
                  (value) {
                    double glucoseInput = double.tryParse(value) ?? 0;
                    double glucoseValue = convertGlucoseToMgDL(glucoseInput, _glucoseUnit);
                    setState(() {
                      glucose = glucoseValue > 200 ? 1 : 0;
                    });
                  },
                  glucose,
                  _glucoseUnit,
                  ['mg/dL', 'mmol/L'],
                  (value) {
                    setState(() {
                      _glucoseUnit = value;
                    });
                    // Recalculate score with new unit
                    if (glucoseController.text.isNotEmpty) {
                      double glucoseInput = double.tryParse(glucoseController.text) ?? 0;
                      double glucoseValue = convertGlucoseToMgDL(glucoseInput, _glucoseUnit);
                      setState(() {
                        glucose = glucoseValue > 200 ? 1 : 0;
                      });
                    }
                  },
                  context,
                ),
                _buildNumericInput(
                  l10n.ranson_ldh, 
                  ldhController,
                  Icons.science,
                  (value) {
                    double ldhValue = double.tryParse(value) ?? 0;
                    setState(() {
                      ldh = ldhValue > 350 ? 1 : 0;
                    });
                  },
                  ldh,
                  context,
                ),
                _buildNumericInput(
                  l10n.ranson_ast, 
                  astController,
                  Icons.local_hospital,
                  (value) {
                    double astValue = double.tryParse(value) ?? 0;
                    setState(() {
                      ast = astValue > 250 ? 1 : 0;
                    });
                  },
                  ast,
                  context,
                ),
              ],
            ),
          ),

          // At 48 hours criteria  
          SliverToBoxAdapter(
            child: _buildSection(
              l10n.ranson_48hour_criteria,
              Colors.red.shade600,
              [
                _buildNumericInput(
                  l10n.ranson_hematocrit_drop, 
                  hctController,
                  Icons.opacity,
                  (value) {
                    double hctValue = double.tryParse(value) ?? 0;
                    setState(() {
                      hematocritDrop = hctValue > 10 ? 1 : 0;
                    });
                  },
                  hematocritDrop,
                  context,
                ),
                _buildLabInputWithUnit(
                  l10n.ranson_bun_rise, 
                  bunController,
                  Icons.medical_services,
                  (value) {
                    double bunInput = double.tryParse(value) ?? 0;
                    double bunValue = convertBUNToMgDL(bunInput, _bunUnit);
                    setState(() {
                      bunRise = bunValue > 5 ? 1 : 0;
                    });
                  },
                  bunRise,
                  _bunUnit,
                  ['mg/dL', 'mmol/L'],
                  (value) {
                    setState(() {
                      _bunUnit = value;
                    });
                    // Recalculate score with new unit
                    if (bunController.text.isNotEmpty) {
                      double bunInput = double.tryParse(bunController.text) ?? 0;
                      double bunValue = convertBUNToMgDL(bunInput, _bunUnit);
                      setState(() {
                        bunRise = bunValue > 5 ? 1 : 0;
                      });
                    }
                  },
                  context,
                ),
                _buildNumericInput(
                  l10n.ranson_calcium_drop, 
                  calciumController,
                  Icons.calculate,
                  (value) {
                    double caValue = double.tryParse(value) ?? 0;
                    setState(() {
                      calciumDrop = caValue < 8 ? 1 : 0;
                    });
                  },
                  calciumDrop,
                  context,
                ),
                _buildNumericInput(
                  l10n.ranson_po2_drop, 
                  po2Controller,
                  Icons.air,
                  (value) {
                    double po2Value = double.tryParse(value) ?? 0;
                    setState(() {
                      po2Drop = po2Value < 60 ? 1 : 0;
                    });
                  },
                  po2Drop,
                  context,
                ),
                _buildNumericInput(
                  l10n.ranson_base_deficit, 
                  baseDeficitController,
                  Icons.add_chart,
                  (value) {
                    double deficitValue = double.tryParse(value) ?? 0;
                    setState(() {
                      baseDeficit = deficitValue > 4 ? 1 : 0;
                    });
                  },
                  baseDeficit,
                  context,
                ),
                _buildNumericInput(
                  l10n.ranson_fluid_sequestration, 
                  fluidController,
                  Icons.water,
                  (value) {
                    double fluidValue = double.tryParse(value) ?? 0;
                    setState(() {
                      fluidSequestration = fluidValue > 6 ? 1 : 0;
                    });
                  },
                  fluidSequestration,
                  context,
                ),
              ],
            ),
          ),

          // Medical Citation
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildCitationWidget(context),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Color color, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildLabInputWithUnit(
    String title,
    TextEditingController controller,
    IconData icon,
    Function(String) onChanged,
    int score,
    String currentUnit,
    List<String> units,
    ValueChanged<String> onUnitChanged,
    BuildContext context,
  ) {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: score > 0 ? Colors.red.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  l10n.ranson_points(score),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: score > 0 ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: l10n.ranson_enter_value,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
            onChanged: onChanged,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                l10n.ranson_unit,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(width: 4),
              DropdownButton<String>(
                value: currentUnit,
                onChanged: (value) => onUnitChanged(value!),
                items: units.map((unit) {
                  return DropdownMenuItem(
                    value: unit,
                    child: Text(
                      unit, 
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumericInput(
    String title,
    TextEditingController controller,
    IconData icon,
    Function(String) onChanged,
    int score,
    BuildContext context,
  ) {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: score > 0 ? Colors.red.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  l10n.ranson_points(score),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: score > 0 ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: l10n.ranson_enter_value,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildCitationWidget(BuildContext context) {
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
                l10n.ranson_reference_title,
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
            l10n.ranson_reference_text,
            style: TextStyle(
              fontSize: 11,
              color: Colors.blue.shade600,
            ),
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
