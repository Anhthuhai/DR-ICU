import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class QsofaScorePage extends StatefulWidget {
  const QsofaScorePage({super.key});

  @override
  State<QsofaScorePage> createState() => _QsofaScorePageState();
}

class _QsofaScorePageState extends State<QsofaScorePage> {
  final TextEditingController _respiratoryRateController = TextEditingController();
  final TextEditingController _systolicBpController = TextEditingController();

  String _alteredMentation = 'no';

  int _totalScore = 0;

  @override
  void initState() {
    super.initState();
    _respiratoryRateController.addListener(_calculateScore);
    _systolicBpController.addListener(_calculateScore);
  }

  void _calculateScore() {
    int score = 0;
    
    // Respiratory rate ≥22
    final respiratoryRate = int.tryParse(_respiratoryRateController.text) ?? 0;
    if (respiratoryRate >= 22) {
      score += 1;
    }
    
    // Altered mentation
    if (_alteredMentation == 'yes') {
      score += 1;
    }
    
    // Systolic BP ≤100
    final systolicBp = int.tryParse(_systolicBpController.text) ?? 0;
    if (systolicBp > 0 && systolicBp <= 100) {
      score += 1;
    }

    setState(() {
      _totalScore = score;
    });
  }

  Color get riskColor {
    if (_totalScore <= 1) {
      return Colors.green;
    }
    return Colors.red;
  }

  String riskLevel(AppLocalizations l10n) {
    if (_totalScore <= 1) {
      return l10n.low_risk;
    }
    return l10n.high_risk;
  }

  String mortalityRisk(AppLocalizations l10n) {
    if (_totalScore <= 1) {
      return l10n.mortality_low;
    }
    return l10n.mortality_high;
  }

  String recommendations(AppLocalizations l10n) {
    if (_totalScore <= 1) {
      return l10n.routine_monitoring;
    }
    return l10n.sepsis_evaluation;
  }

  String clinicalAction(AppLocalizations l10n) {
    if (_totalScore <= 1) {
      return l10n.continue_current_treatment;
    }
    return l10n.initiate_sepsis_bundle;
  }

  List<Map<String, dynamic>> criteria(AppLocalizations l10n) {
    return [
      {
        'criterion': l10n.qsofa_respiratory_rate_criterion,
        'description': l10n.qsofa_respiratory_rate_description,
        'points': 1,
        'active': (int.tryParse(_respiratoryRateController.text) ?? 0) >= 22,
      },
      {
        'criterion': l10n.qsofa_altered_mentation_criterion,
        'description': l10n.qsofa_altered_mentation_description,
        'points': 1,
        'active': _alteredMentation == 'yes',
      },
      {
        'criterion': l10n.qsofa_systolic_bp_criterion,
        'description': l10n.qsofa_systolic_bp_description,
        'points': 1,
        'active': (int.tryParse(_systolicBpController.text) ?? 0) > 0 && 
                  (int.tryParse(_systolicBpController.text) ?? 0) <= 100,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky App Bar
          SliverAppBar(
            title: Text(l10n.qsofa_score),
            backgroundColor: Colors.orange.shade700,
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
                      'qSOFA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: riskColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '$_totalScore/3',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: riskColor,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        riskLevel(l10n),
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
                // Risk Info
                _buildRiskInfo(l10n),

                // Input Parameters
                _buildInputSection(),

                // Active Criteria
                if (_totalScore > 0) _buildActiveCriteria(l10n),

            // Risk Stratification
            _buildRiskStratification(l10n),

            // Sepsis Bundle
            if (_totalScore >= 2) _buildSepsisBundle(),

            // Clinical Information
            _buildClinicalInfo(l10n),

            // Medical Citation
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildCitationWidget(l10n),
            ),

            const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskInfo(AppLocalizations l10n) {
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
                    l10n.mortality,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    mortalityRisk(l10n),
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
                    l10n.action,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    clinicalAction(l10n).split(' ').take(3).join(' '),
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
                      l10n.recommendations,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  recommendations(l10n),
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
    final l10n = AppLocalizations.of(context)!;
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
            l10n.qsofa_criteria,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          TextField(
            controller: _respiratoryRateController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: l10n.respiratory_rate,
              suffixText: 'breaths/min',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: l10n.respiratory_rate_helper,
            ),
          ),
          const SizedBox(height: 16),
          
          TextField(
            controller: _systolicBpController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: l10n.systolic_bp,
              suffixText: 'mmHg',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              helperText: l10n.systolic_bp_helper,
            ),
          ),
          const SizedBox(height: 16),
          
          Text(
            l10n.altered_mentation,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: Text(l10n.no),
                  value: 'no',
                  // ignore: deprecated_member_use
                  groupValue: _alteredMentation,
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    setState(() {
                      _alteredMentation = value!;
                    });
                    _calculateScore();
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: Text(l10n.yes_gcs_less_15),
                  value: 'yes',
                  // ignore: deprecated_member_use
                  groupValue: _alteredMentation,
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    setState(() {
                      _alteredMentation = value!;
                    });
                    _calculateScore();
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCriteria(AppLocalizations l10n) {
    List<Map<String, dynamic>> activeCriteria = criteria(l10n).where((criterion) => criterion['active']).toList();
    
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
            l10n.positive_criteria(activeCriteria.length),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 12),
          ...activeCriteria.map((criterion) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
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
                      '+${criterion['points']}',
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
                        criterion['criterion'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        criterion['description'],
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

  Widget _buildRiskStratification(AppLocalizations l10n) {
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
            l10n.sepsis_risk_stratification,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskItem('0-1', l10n.qsofa_low_risk, '< 10%', l10n.qsofa_routine_monitoring, Colors.green),
          _buildRiskItem('≥2', l10n.qsofa_high_risk, '≥ 10%', l10n.qsofa_immediate_sepsis_bundle, Colors.red),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String score, String risk, String mortality, String action, Color color) {
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
                  mortality,
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

  Widget _buildSepsisBundle() {
    final l10n = AppLocalizations.of(context)!;
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
          Row(
            children: [
              Icon(Icons.warning, color: Colors.red.shade700),
              const SizedBox(width: 8),
              Text(
                l10n.sepsis_bundle_hour_1,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildBundleItem(l10n.sepsis_bundle_lactate_title, l10n.sepsis_bundle_lactate_desc, Icons.science),
          _buildBundleItem(l10n.sepsis_bundle_blood_culture_title, l10n.sepsis_bundle_blood_culture_desc, Icons.biotech),
          _buildBundleItem(l10n.sepsis_bundle_antibiotics_title, l10n.sepsis_bundle_antibiotics_desc, Icons.medication),
          _buildBundleItem(l10n.sepsis_bundle_fluid_title, l10n.sepsis_bundle_fluid_desc, Icons.water_drop),
          _buildBundleItem(l10n.sepsis_bundle_vasopressor_title, l10n.sepsis_bundle_vasopressor_desc, Icons.favorite),
        ],
      ),
    );
  }

  Widget _buildBundleItem(String title, String description, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.red.shade600, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  description,
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
    );
  }

  Widget _buildClinicalInfo(AppLocalizations l10n) {
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
                l10n.clinical_information,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            l10n.qsofa_clinical_content,
            style: const TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _respiratoryRateController.dispose();
    _systolicBpController.dispose();
    super.dispose();
  }

  Widget _buildCitationWidget(AppLocalizations l10n) {
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
                l10n.reference_materials,
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
            'Singer M, et al. The Third International Consensus Definitions for Sepsis and Septic Shock (Sepsis-3). JAMA. 2016;315(8):801-10.',
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
