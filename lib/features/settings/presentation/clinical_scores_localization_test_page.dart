import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/services/language_service.dart';
import '../../../core/theme/app_theme.dart';

class ClinicalScoresLocalizationTestPage extends StatefulWidget {
  const ClinicalScoresLocalizationTestPage({super.key});

  @override
  State<ClinicalScoresLocalizationTestPage> createState() => _ClinicalScoresLocalizationTestPageState();
}

class _ClinicalScoresLocalizationTestPageState extends State<ClinicalScoresLocalizationTestPage> {
  String _currentLanguage = '';

  @override
  void initState() {
    super.initState();
    _loadCurrentLanguage();
  }

  Future<void> _loadCurrentLanguage() async {
    final locale = await LanguageService.getLocale();
    setState(() {
      _currentLanguage = locale.languageCode;
    });
  }

  Future<void> _toggleLanguage() async {
    final newLanguage = _currentLanguage == 'en' ? 'vi' : 'en';
    await LanguageService.setLocale(newLanguage);
    setState(() {
      _currentLanguage = newLanguage;
    });
    
    // Show restart message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_currentLanguage == 'en' 
              ? 'Switched to English. Hot reload to see changes.' 
              : 'Đã chuyển sang Tiếng Việt. Hot reload để xem thay đổi.'),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Hot Reload',
            onPressed: () {
              // Hot reload trigger would be manual
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clinical Scores Localization Test'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _toggleLanguage,
            icon: const Icon(Icons.translate),
            tooltip: 'Toggle Language',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language Status
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Current Language: $_currentLanguage',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _toggleLanguage,
                      child: Text(_currentLanguage == 'en' ? 'Switch to VI' : 'Switch to EN'),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // qSOFA Score Test
            _buildScoreTestCard(
              'qSOFA Score Test',
              [
                _buildTestRow('Title', l10n.qsofa_score),
                _buildTestRow('Description', l10n.qsofa_description),
                _buildTestRow('Low Risk', l10n.low_risk),
                _buildTestRow('High Risk', l10n.high_risk),
                _buildTestRow('Mortality Low', l10n.mortality_low),
                _buildTestRow('Mortality High', l10n.mortality_high),
                _buildTestRow('Mortality Label', l10n.mortality),
                _buildTestRow('Action Label', l10n.action),
                _buildTestRow('Recommendations', l10n.recommendations),
                _buildTestRow('Routine Monitoring', l10n.routine_monitoring),
                _buildTestRow('Sepsis Evaluation', l10n.sepsis_evaluation),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // NIHSS Score Test
            _buildScoreTestCard(
              'NIHSS Score Test',
              [
                _buildTestRow('Title', l10n.nihss_score),
                _buildTestRow('Mild Stroke', l10n.nihss_mild_stroke),
                _buildTestRow('Moderate Stroke', l10n.nihss_moderate_stroke),
                _buildTestRow('Severe Stroke', l10n.nihss_severe_stroke),
                _buildTestRow('Very Severe Stroke', l10n.nihss_very_severe_stroke),
                _buildTestRow('Good Prognosis', l10n.nihss_good_prognosis),
                _buildTestRow('Fair Prognosis', l10n.nihss_fair_prognosis),
                _buildTestRow('Poor Prognosis', l10n.nihss_poor_prognosis),
                _buildTestRow('Very Poor Prognosis', l10n.nihss_very_poor_prognosis),
                _buildTestRow('Prognosis Label', l10n.prognosis),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Common Medical Terms Test
            _buildScoreTestCard(
              'Common Medical Terms Test',
              [
                _buildTestRow('Glasgow Coma Scale', l10n.glasgow_coma_scale),
                _buildTestRow('Apache II', l10n.apache2Score),
                _buildTestRow('SOFA Score', l10n.sofaScore),
                _buildTestRow('SAPS II', l10n.sapsScore),
                _buildTestRow('Clinical Scores', l10n.clinicalScores),
                _buildTestRow('Settings', l10n.settings),
                _buildTestRow('Language', l10n.language),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Instructions
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Testing Instructions:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('1. Tap "Toggle Language" button to switch between EN/VI'),
                    const Text('2. Use hot reload (r) in terminal to see language changes'),
                    const Text('3. Verify all clinical terms change correctly'),
                    const Text('4. Test actual qSOFA and NIHSS pages for complete functionality'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreTestCard(String title, List<Widget> tests) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(height: 12),
            ...tests,
          ],
        ),
      ),
    );
  }

  Widget _buildTestRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
