import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class CamIcuPage extends StatefulWidget {
  const CamIcuPage({super.key});

  @override
  State<CamIcuPage> createState() => _CamIcuPageState();
}

class _CamIcuPageState extends State<CamIcuPage> {
  bool _feature1Positive = false;
  bool _feature2Positive = false;
  bool _feature3Positive = false;
  bool _feature4Positive = false;
  
  bool get _isDeliriumPositive => _feature1Positive || _feature2Positive || _feature3Positive || _feature4Positive;
  
  String get _result {
    final l10n = AppLocalizations.of(context)!;
    if (_isDeliriumPositive) {
      return l10n.cam_icu_positive_delirium;
    } else {
      return l10n.cam_icu_negative_delirium;
    }
  }

  Color get _resultColor {
    return _isDeliriumPositive ? Colors.red : Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky App Bar
          SliverAppBar(
            title: Text(l10n.cam_icu_title),
            backgroundColor: Colors.purple.shade700,
            foregroundColor: Colors.white,
            centerTitle: true,
            floating: false,
            pinned: true,
            snap: false,
            expandedHeight: 0,
          ),
          
          // Sticky Result Header
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
                  color: _resultColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _resultColor.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Text(
                      'CAM-ICU',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _resultColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        _result,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: _resultColor,
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
                          AppLocalizations.of(context)!.medical_disclaimer_professional_only,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(context)!.medical_disclaimer_cam_icu_text,
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
                // CAM-ICU Features Assessment
                _buildCamIcuAssessment(),
                
                // Results Section
                _buildResultsSection(),
                
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
                            l10n.cam_icu_reference_title,
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
                        l10n.cam_icu_reference_text,
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

  Widget _buildCamIcuAssessment() {
    final l10n = AppLocalizations.of(context)!;
    
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
            l10n.cam_icu_assessment_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          // Feature 1: Acute Change or Fluctuating Course
          _buildFeatureAssessment(
            l10n.cam_icu_feature_1_title,
            l10n.cam_icu_feature_1_description,
            _feature1Positive,
            (value) => setState(() => _feature1Positive = value),
            1,
          ),
          
          const SizedBox(height: 12),
          
          // Feature 2: Inattention
          _buildFeatureAssessment(
            l10n.cam_icu_feature_2_title,
            l10n.cam_icu_feature_2_description,
            _feature2Positive,
            (value) => setState(() => _feature2Positive = value),
            2,
          ),
          
          const SizedBox(height: 12),
          
          // Feature 3: Altered Level of Consciousness
          _buildFeatureAssessment(
            l10n.cam_icu_feature_3_title,
            l10n.cam_icu_feature_3_description,
            _feature3Positive,
            (value) => setState(() => _feature3Positive = value),
            3,
          ),
          
          const SizedBox(height: 12),
          
          // Feature 4: Disorganized Thinking
          _buildFeatureAssessment(
            l10n.cam_icu_feature_4_title,
            l10n.cam_icu_feature_4_description,
            _feature4Positive,
            (value) => setState(() => _feature4Positive = value),
            4,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureAssessment(
    String title,
    String description,
    bool isPositive,
    ValueChanged<bool> onChanged,
    int featureNumber,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isPositive ? Colors.red.shade300 : Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Feature $featureNumber: $title',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: RadioListTile<bool>(
                  title: Text(
                    AppLocalizations.of(context)!.no,
                    style: const TextStyle(fontSize: 12),
                  ),
                  value: false,
                  // ignore: deprecated_member_use
                  groupValue: isPositive,
                  // ignore: deprecated_member_use
                  onChanged: (value) => onChanged(value!),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              Expanded(
                child: RadioListTile<bool>(
                  title: Text(
                    AppLocalizations.of(context)!.yes,
                    style: const TextStyle(fontSize: 12),
                  ),
                  value: true,
                  // ignore: deprecated_member_use
                  groupValue: isPositive,
                  // ignore: deprecated_member_use
                  onChanged: (value) => onChanged(value!),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultsSection() {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _resultColor.withValues(alpha: 0.3)),
        color: _resultColor.withValues(alpha: 0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.cam_icu_results_title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: _resultColor,
            ),
          ),
          const SizedBox(height: 12),
          
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.cam_icu_interpretation_label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _resultColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _result,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: _resultColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.cam_icu_algorithm_explanation,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
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

  Widget _buildClinicalInfo() {
    final l10n = AppLocalizations.of(context)!;
    
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
                l10n.cam_icu_clinical_info_title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            l10n.cam_icu_clinical_info_content.replaceAll('\\n', '\n'),
            style: const TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }
}
