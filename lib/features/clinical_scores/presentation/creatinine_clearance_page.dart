import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class CreatinineClearancePage extends StatefulWidget {
  const CreatinineClearancePage({super.key});

  @override
  State<CreatinineClearancePage> createState() => _CreatinineClearancePageState();
}

class _CreatinineClearancePageState extends State<CreatinineClearancePage> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _creatinineController = TextEditingController();
  bool _isFemale = false;

  // Unit variable
  String _creatinineUnit = 'mg/dL';

  double _clearance = 0.0;

  @override
  void initState() {
    super.initState();
    _ageController.addListener(_calculateClearance);
    _weightController.addListener(_calculateClearance);
    _creatinineController.addListener(_calculateClearance);
  }

  // Unit conversion function
  double convertCreatinineToMgDL(double value, String unit) {
    if (unit == 'umol/L') {
      return value / 88.42; // Convert umol/L to mg/dL
    }
    return value; // Already in mg/dL
  }

  void _calculateClearance() {
    final age = double.tryParse(_ageController.text) ?? 0;
    final weight = double.tryParse(_weightController.text) ?? 0;
    final creatinineInput = double.tryParse(_creatinineController.text) ?? 0;
    final creatinine = convertCreatinineToMgDL(creatinineInput, _creatinineUnit);

    if (age > 0 && weight > 0 && creatinine > 0) {
      // Cockcroft-Gault formula
      double clearance = ((140 - age) * weight) / (72 * creatinine);
      if (_isFemale) {
        clearance *= 0.85; // Correction factor for female
      }
      setState(() {
        _clearance = clearance;
      });
    } else {
      setState(() {
        _clearance = 0.0;
      });
    }
  }

  Color get clearanceColor {
    if (_clearance >= 90) {
      return Colors.green;
    }
    if (_clearance >= 60) {
      return Colors.blue;
    }
    if (_clearance >= 45) {
      return Colors.yellow.shade700;
    }
    if (_clearance >= 30) {
      return Colors.orange;
    }
    if (_clearance >= 15) {
      return Colors.red;
    }
    if (_clearance > 0) {
      return Colors.red.shade800;
    }
    return Colors.grey;
  }

  String kidneyFunction(BuildContext context) {
    if (_clearance >= 90) {
      return AppLocalizations.of(context)!.creatinine_clearance_function_normal;
    }
    if (_clearance >= 60) {
      return AppLocalizations.of(context)!.creatinine_clearance_function_mild;
    }
    if (_clearance >= 45) {
      return AppLocalizations.of(context)!.creatinine_clearance_function_mild_moderate;
    }
    if (_clearance >= 30) {
      return AppLocalizations.of(context)!.creatinine_clearance_function_moderate_severe;
    }
    if (_clearance >= 15) {
      return AppLocalizations.of(context)!.creatinine_clearance_function_severe;
    }
    if (_clearance > 0) {
      return AppLocalizations.of(context)!.creatinine_clearance_function_esrd;
    }
    return '';
  }

  String stage(BuildContext context) {
    if (_clearance >= 90) {
      return AppLocalizations.of(context)!.creatinine_clearance_stage_1;
    }
    if (_clearance >= 60) {
      return AppLocalizations.of(context)!.creatinine_clearance_stage_2;
    }
    if (_clearance >= 45) {
      return AppLocalizations.of(context)!.creatinine_clearance_stage_3a;
    }
    if (_clearance >= 30) {
      return AppLocalizations.of(context)!.creatinine_clearance_stage_3b;
    }
    if (_clearance >= 15) {
      return AppLocalizations.of(context)!.creatinine_clearance_stage_4;
    }
    if (_clearance > 0) {
      return AppLocalizations.of(context)!.creatinine_clearance_stage_5;
    }
    return '';
  }

  String drugDosing(BuildContext context) {
    if (_clearance >= 60) {
      return AppLocalizations.of(context)!.creatinine_clearance_dosing_normal;
    }
    if (_clearance >= 30) {
      return AppLocalizations.of(context)!.creatinine_clearance_dosing_reduce_25_50;
    }
    if (_clearance >= 15) {
      return AppLocalizations.of(context)!.creatinine_clearance_dosing_reduce_50_75;
    }
    if (_clearance > 0) {
      return AppLocalizations.of(context)!.creatinine_clearance_dosing_contraindicated;
    }
    return '';
  }

  String recommendations(BuildContext context) {
    if (_clearance >= 90) {
      return AppLocalizations.of(context)!.creatinine_clearance_recommendation_normal;
    }
    if (_clearance >= 60) {
      return AppLocalizations.of(context)!.creatinine_clearance_recommendation_mild;
    }
    if (_clearance >= 45) {
      return AppLocalizations.of(context)!.creatinine_clearance_recommendation_mild_moderate;
    }
    if (_clearance >= 30) {
      return AppLocalizations.of(context)!.creatinine_clearance_recommendation_moderate_severe;
    }
    if (_clearance >= 15) {
      return AppLocalizations.of(context)!.creatinine_clearance_recommendation_severe;
    }
    if (_clearance > 0) {
      return AppLocalizations.of(context)!.creatinine_clearance_recommendation_esrd;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky AppBar
          SliverAppBar(
            title: Text(AppLocalizations.of(context)!.creatinine_clearance_title),
            backgroundColor: Colors.indigo.shade700,
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
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: clearanceColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.creatinine_clearance_result,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: clearanceColor,
                              ),
                            ),
                            if (_clearance > 0)
                              Text(
                                kidneyFunction(context),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.darkGrey,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                      Text(
                        _clearance > 0 
                          ? '${_clearance.toStringAsFixed(1)} ${AppLocalizations.of(context)!.creatinine_clearance_unit}'
                          : '0 ${AppLocalizations.of(context)!.creatinine_clearance_unit}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: clearanceColor,
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
                              ? 'LƯU Ý Y KHOA THẬN: Kết quả chỉ mang tính tham khảo. Luôn tham khảo ý kiến bác sĩ chuyên khoa thận trước khi đưa ra quyết định điều trị dựa trên độ thanh thải creatinine.'
                              : 'NEPHROLOGY MEDICAL DISCLAIMER: Results are for reference only. Always consult with nephrologist before making treatment decisions based on creatinine clearance.',
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
                // Result Display (when not in sticky header)
                if (_clearance > 0) ...[
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: clearanceColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: clearanceColor.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          stage(context),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: clearanceColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildResultDetails(),
                      ],
                    ),
                  ),
                ] else ...[
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.calculate,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppLocalizations.of(context)!.creatinine_clearance_input_prompt,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Input Parameters
                _buildInputSection(),

                // Reference Values
                _buildReferenceSection(),

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
                            AppLocalizations.of(context)!.creatinine_clearance_reference_title,
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
                        AppLocalizations.of(context)!.creatinine_clearance_reference_text,
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

  Widget _buildResultDetails() {
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
                    AppLocalizations.of(context)!.creatinine_clearance_drug_dosing,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    drugDosing(context),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: clearanceColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: clearanceColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: clearanceColor.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.creatinine_clearance_clinical_recommendation,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: clearanceColor,
                  ),
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

  Widget _buildInputSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade300),
        color: Colors.indigo.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.creatinine_clearance_input_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          // Age
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.creatinine_clearance_age,
              suffixText: AppLocalizations.of(context)!.creatinine_clearance_age_unit,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          
          // Weight
          TextField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.creatinine_clearance_weight,
              suffixText: AppLocalizations.of(context)!.creatinine_clearance_weight_unit,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          
          // Creatinine with unit conversion
          _buildLabInputWithUnit(
            AppLocalizations.of(context)!.creatinine_clearance_creatinine,
            AppLocalizations.of(context)!.creatinine_clearance_creatinine_normal,
            _creatinineController,
            _creatinineUnit,
            ['mg/dL', 'umol/L'],
            (value) {
              setState(() {
                _creatinineUnit = value;
              });
              _calculateClearance();
            },
            (value) => _calculateClearance(),
          ),
          const SizedBox(height: 12),
          
          // Gender
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.creatinine_clearance_gender,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<bool>(
                        title: Text(AppLocalizations.of(context)!.creatinine_clearance_male),
                        value: false,
                        // ignore: deprecated_member_use
                        groupValue: _isFemale,
                        // ignore: deprecated_member_use
                        onChanged: (value) {
                          setState(() {
                            _isFemale = value!;
                          });
                          _calculateClearance();
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<bool>(
                        title: Text(AppLocalizations.of(context)!.creatinine_clearance_female),
                        value: true,
                        // ignore: deprecated_member_use
                        groupValue: _isFemale,
                        // ignore: deprecated_member_use
                        onChanged: (value) {
                          setState(() {
                            _isFemale = value!;
                          });
                          _calculateClearance();
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabInputWithUnit(
    String label,
    String helperText,
    TextEditingController controller,
    String currentUnit,
    List<String> units,
    ValueChanged<String> onUnitChanged,
    ValueChanged<String> onValueChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 5,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                onChanged: onValueChanged,
                decoration: InputDecoration(
                  labelText: label,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<String>(
                initialValue: currentUnit,
                onChanged: (value) => onUnitChanged(value!),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                ),
                items: units.map((unit) {
                  return DropdownMenuItem(
                    value: unit,
                    child: Text(
                      unit,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        if (helperText.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            helperText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildReferenceSection() {
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
            AppLocalizations.of(context)!.creatinine_clearance_reference_values,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildReferenceItem(AppLocalizations.of(context)!.creatinine_clearance_range_90, 
            AppLocalizations.of(context)!.creatinine_clearance_function_normal, Colors.green),
          _buildReferenceItem(AppLocalizations.of(context)!.creatinine_clearance_range_60_89, 
            '${AppLocalizations.of(context)!.creatinine_clearance_function_mild} (${AppLocalizations.of(context)!.creatinine_clearance_stage_2})', Colors.blue),
          _buildReferenceItem(AppLocalizations.of(context)!.creatinine_clearance_range_45_59, 
            '${AppLocalizations.of(context)!.creatinine_clearance_function_mild_moderate} (${AppLocalizations.of(context)!.creatinine_clearance_stage_3a})', Colors.yellow.shade700),
          _buildReferenceItem(AppLocalizations.of(context)!.creatinine_clearance_range_30_44, 
            '${AppLocalizations.of(context)!.creatinine_clearance_function_moderate_severe} (${AppLocalizations.of(context)!.creatinine_clearance_stage_3b})', Colors.orange),
          _buildReferenceItem(AppLocalizations.of(context)!.creatinine_clearance_range_15_29, 
            '${AppLocalizations.of(context)!.creatinine_clearance_function_severe} (${AppLocalizations.of(context)!.creatinine_clearance_stage_4})', Colors.red),
          _buildReferenceItem(AppLocalizations.of(context)!.creatinine_clearance_range_under_15, 
            '${AppLocalizations.of(context)!.creatinine_clearance_function_esrd} (${AppLocalizations.of(context)!.creatinine_clearance_stage_5})', Colors.red.shade800),
        ],
      ),
    );
  }

  Widget _buildReferenceItem(String range, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              range,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              description,
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
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
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.blue.shade600),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.creatinine_clearance_clinical_info,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.creatinine_clearance_clinical_text,
            style: const TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _creatinineController.dispose();
    super.dispose();
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  double get minExtent => 72.0; // Minimum height when collapsed

  @override
  double get maxExtent => 72.0; // Maximum height when expanded

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
