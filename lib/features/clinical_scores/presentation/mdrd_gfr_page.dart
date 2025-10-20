import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class MdrdGfrPage extends StatefulWidget {
  const MdrdGfrPage({super.key});

  @override
  State<MdrdGfrPage> createState() => _MdrdGfrPageState();
}

class _MdrdGfrPageState extends State<MdrdGfrPage> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _creatinineController = TextEditingController();
  bool _isFemale = false;
  bool _isAfricanAmerican = false;

  // Unit variable
  String _creatinineUnit = 'mg/dL';

  double _gfr = 0.0;

  @override
  void initState() {
    super.initState();
    _ageController.addListener(_calculateGFR);
    _creatinineController.addListener(_calculateGFR);
  }

  // Unit conversion function
  double convertCreatinineToMgDL(double value, String unit) {
    if (unit == 'umol/L') {
      return value / 88.42; // Convert umol/L to mg/dL
    }
    return value; // Already in mg/dL
  }

  void _calculateGFR() {
    final age = double.tryParse(_ageController.text) ?? 0;
    final creatinineInput = double.tryParse(_creatinineController.text) ?? 0;
    final creatinine = convertCreatinineToMgDL(creatinineInput, _creatinineUnit);

    if (age > 0 && creatinine > 0) {
      // MDRD GFR = 175 × (Scr)^-1.154 × (Age)^-0.203 × (0.742 if female) × (1.212 if African American)
      double gfr = (175 * 
                   math.pow(creatinine, -1.154) * 
                   math.pow(age, -0.203)).toDouble();
      
      if (_isFemale) {
        gfr *= 0.742;
      }
      
      if (_isAfricanAmerican) {
        gfr *= 1.212;
      }
      
      setState(() {
        _gfr = gfr;
      });
    } else {
      setState(() {
        _gfr = 0.0;
      });
    }
  }

  Color get gfrColor {
    if (_gfr >= 90) {
      return Colors.green;
    }
    if (_gfr >= 60) {
      return Colors.blue;
    }
    if (_gfr >= 45) {
      return Colors.yellow.shade700;
    }
    if (_gfr >= 30) {
      return Colors.orange;
    }
    if (_gfr >= 15) {
      return Colors.red;
    }
    if (_gfr > 0) {
      return Colors.red.shade800;
    }
    return Colors.grey;
  }

  String kidneyFunction(BuildContext context) {
    if (_gfr >= 90) {
      return AppLocalizations.of(context)!.mdrd_gfr_function_normal;
    }
    if (_gfr >= 60) {
      return AppLocalizations.of(context)!.mdrd_gfr_function_mild;
    }
    if (_gfr >= 45) {
      return AppLocalizations.of(context)!.mdrd_gfr_function_mild_moderate;
    }
    if (_gfr >= 30) {
      return AppLocalizations.of(context)!.mdrd_gfr_function_moderate_severe;
    }
    if (_gfr >= 15) {
      return AppLocalizations.of(context)!.mdrd_gfr_function_severe;
    }
    if (_gfr > 0) {
      return AppLocalizations.of(context)!.mdrd_gfr_function_esrd;
    }
    return '';
  }

  String ckdStage(BuildContext context) {
    if (_gfr >= 90) {
      return AppLocalizations.of(context)!.mdrd_gfr_stage_1;
    }
    if (_gfr >= 60) {
      return AppLocalizations.of(context)!.mdrd_gfr_stage_2;
    }
    if (_gfr >= 45) {
      return AppLocalizations.of(context)!.mdrd_gfr_stage_3a;
    }
    if (_gfr >= 30) {
      return AppLocalizations.of(context)!.mdrd_gfr_stage_3b;
    }
    if (_gfr >= 15) {
      return AppLocalizations.of(context)!.mdrd_gfr_stage_4;
    }
    if (_gfr > 0) {
      return AppLocalizations.of(context)!.mdrd_gfr_stage_5;
    }
    return '';
  }

  String clinicalAction(BuildContext context) {
    if (_gfr >= 90) {
      return AppLocalizations.of(context)!.mdrd_gfr_action_normal;
    }
    if (_gfr >= 60) {
      return AppLocalizations.of(context)!.mdrd_gfr_action_mild;
    }
    if (_gfr >= 45) {
      return AppLocalizations.of(context)!.mdrd_gfr_action_mild_moderate;
    }
    if (_gfr >= 30) {
      return AppLocalizations.of(context)!.mdrd_gfr_action_moderate_severe;
    }
    if (_gfr >= 15) {
      return AppLocalizations.of(context)!.mdrd_gfr_action_severe;
    }
    if (_gfr > 0) {
      return AppLocalizations.of(context)!.mdrd_gfr_action_esrd;
    }
    return '';
  }

  String drugDosing(BuildContext context) {
    if (_gfr >= 60) {
      return AppLocalizations.of(context)!.mdrd_gfr_dosing_normal;
    }
    if (_gfr >= 30) {
      return AppLocalizations.of(context)!.mdrd_gfr_dosing_reduce_25_50;
    }
    if (_gfr >= 15) {
      return AppLocalizations.of(context)!.mdrd_gfr_dosing_reduce_50_75;
    }
    if (_gfr > 0) {
      return AppLocalizations.of(context)!.mdrd_gfr_dosing_avoid;
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
            title: Text(AppLocalizations.of(context)!.mdrd_gfr_title),
            backgroundColor: Colors.teal.shade700,
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
                    border: Border.all(color: gfrColor),
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
                              AppLocalizations.of(context)!.mdrd_gfr_result,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: gfrColor,
                              ),
                            ),
                            if (_gfr > 0)
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
                        _gfr > 0 
                          ? '${_gfr.toStringAsFixed(1)} ${AppLocalizations.of(context)!.mdrd_gfr_unit}'
                          : '0 ${AppLocalizations.of(context)!.mdrd_gfr_unit}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: gfrColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Medical Disclaimer Banner
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade300),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.red.shade600, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Localizations.localeOf(context).languageCode == 'vi' 
                            ? 'DÀNH CHO CÁN BỘ Y TẾ'
                            : 'FOR HEALTHCARE PROFESSIONALS ONLY',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          Localizations.localeOf(context).languageCode == 'vi'
                            ? 'Ước tính chức năng thận. Cân nhắc bối cảnh lâm sàng và xác nhận bằng các xét nghiệm bổ sung.'
                            : 'Kidney function estimation. Consider clinical context and confirm with additional tests.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Result Display (when not in sticky header)
                if (_gfr > 0) ...[
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: gfrColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: gfrColor.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          ckdStage(context),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: gfrColor,
                          ),
                          textAlign: TextAlign.center,
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
                          AppLocalizations.of(context)!.mdrd_gfr_input_prompt,
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

                // Comparison with other methods
                if (_gfr > 0) _buildComparisonSection(),

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
                            AppLocalizations.of(context)!.mdrd_gfr_reference_title,
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
                        AppLocalizations.of(context)!.mdrd_gfr_reference_text,
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: gfrColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: gfrColor.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.medical_services, color: gfrColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.mdrd_gfr_clinical_action,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: gfrColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  clinicalAction(context),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.darkGrey,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.medication, color: gfrColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.mdrd_gfr_drug_dosing,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: gfrColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  drugDosing(context),
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
        border: Border.all(color: Colors.teal.shade300),
        color: Colors.teal.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.mdrd_gfr_input_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.mdrd_gfr_age,
                    suffixText: AppLocalizations.of(context)!.mdrd_gfr_age_unit,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildLabInputWithUnit(
                  AppLocalizations.of(context)!.mdrd_gfr_creatinine,
                  AppLocalizations.of(context)!.mdrd_gfr_creatinine_example,
                  _creatinineController,
                  _creatinineUnit,
                  ['mg/dL', 'umol/L'],
                  (value) {
                    setState(() {
                      _creatinineUnit = value;
                    });
                    _calculateGFR();
                  },
                  (value) => _calculateGFR(),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Gender and Race
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
                  AppLocalizations.of(context)!.mdrd_gfr_demographics,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                
                CheckboxListTile(
                  title: Text(AppLocalizations.of(context)!.mdrd_gfr_female),
                  subtitle: Text(AppLocalizations.of(context)!.mdrd_gfr_female_factor),
                  value: _isFemale,
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    setState(() {
                      _isFemale = value!;
                    });
                    _calculateGFR();
                  },
                  contentPadding: EdgeInsets.zero,
                ),
                
                CheckboxListTile(
                  title: Text(AppLocalizations.of(context)!.mdrd_gfr_african_american),
                  subtitle: Text(AppLocalizations.of(context)!.mdrd_gfr_african_american_factor),
                  value: _isAfricanAmerican,
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    setState(() {
                      _isAfricanAmerican = value!;
                    });
                    _calculateGFR();
                  },
                  contentPadding: EdgeInsets.zero,
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

  Widget _buildComparisonSection() {
    // Tính Cockcroft-Gault để so sánh (cần cân nặng giả định 70kg)
    double estimatedWeight = 70.0;
    double age = double.tryParse(_ageController.text) ?? 0;
    double creatinineInput = double.tryParse(_creatinineController.text) ?? 0;
    double creatinine = convertCreatinineToMgDL(creatinineInput, _creatinineUnit);
    
    double cockcroftGault = 0;
    if (age > 0 && creatinine > 0) {
      cockcroftGault = ((140 - age) * estimatedWeight) / (72 * creatinine);
      if (_isFemale) {
        cockcroftGault *= 0.85;
      }
    }

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
            AppLocalizations.of(context)!.mdrd_gfr_comparison_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.mdrd_gfr_result,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.purple.shade700,
                        ),
                      ),
                      Text(
                        _gfr.toStringAsFixed(1),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: gfrColor,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.mdrd_gfr_unit,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.mdrd_gfr_cockcroft_gault,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.purple.shade700,
                        ),
                      ),
                      Text(
                        cockcroftGault.toStringAsFixed(1),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.mdrd_gfr_estimated_unit,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.mdrd_gfr_weight_note,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
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
            AppLocalizations.of(context)!.mdrd_gfr_reference_values,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildReferenceItem(AppLocalizations.of(context)!.mdrd_gfr_range_90_plus, 
            '${AppLocalizations.of(context)!.mdrd_gfr_function_normal} (${AppLocalizations.of(context)!.mdrd_gfr_stage_1})', Colors.green),
          _buildReferenceItem(AppLocalizations.of(context)!.mdrd_gfr_range_60_89, 
            '${AppLocalizations.of(context)!.mdrd_gfr_function_mild} (${AppLocalizations.of(context)!.mdrd_gfr_stage_2})', Colors.blue),
          _buildReferenceItem(AppLocalizations.of(context)!.mdrd_gfr_range_45_59, 
            '${AppLocalizations.of(context)!.mdrd_gfr_function_mild_moderate} (${AppLocalizations.of(context)!.mdrd_gfr_stage_3a})', Colors.yellow.shade700),
          _buildReferenceItem(AppLocalizations.of(context)!.mdrd_gfr_range_30_44, 
            '${AppLocalizations.of(context)!.mdrd_gfr_function_moderate_severe} (${AppLocalizations.of(context)!.mdrd_gfr_stage_3b})', Colors.orange),
          _buildReferenceItem(AppLocalizations.of(context)!.mdrd_gfr_range_15_29, 
            '${AppLocalizations.of(context)!.mdrd_gfr_function_severe} (${AppLocalizations.of(context)!.mdrd_gfr_stage_4})', Colors.red),
          _buildReferenceItem(AppLocalizations.of(context)!.mdrd_gfr_range_under_15, 
            '${AppLocalizations.of(context)!.mdrd_gfr_function_esrd} (${AppLocalizations.of(context)!.mdrd_gfr_stage_5})', Colors.red.shade800),
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
                AppLocalizations.of(context)!.mdrd_gfr_clinical_info,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.mdrd_gfr_clinical_text,
            style: const TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
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

extension Pow on double {
  double pow(double exponent) {
    return math.pow(this, exponent).toDouble();
  }
}
