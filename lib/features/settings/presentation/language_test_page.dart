import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/services/language_service.dart';
import '../../../core/theme/app_theme.dart';

class LanguageTestPage extends StatefulWidget {
  const LanguageTestPage({super.key});

  @override
  State<LanguageTestPage> createState() => _LanguageTestPageState();
}

class _LanguageTestPageState extends State<LanguageTestPage> {
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Test'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Language Status',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        const Icon(Icons.language, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text('Stored Language: $_currentLanguage'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    Row(
                      children: [
                        const Icon(Icons.translate, color: Colors.green),
                        const SizedBox(width: 8),
                        Text('Active Locale: ${Localizations.localeOf(context).languageCode}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Localized Text Test',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    _buildTestRow('Welcome Message', l10n.welcomeMessage),
                    _buildTestRow('Clinical Scores', l10n.clinicalScores),
                    _buildTestRow('Unit Converter', l10n.unitConverter),
                    _buildTestRow('Lab Analysis', l10n.labAnalysis),
                    _buildTestRow('Language', l10n.language),
                    _buildTestRow('Settings', l10n.settings),
                    _buildTestRow('Home', l10n.home),
                    _buildTestRow('English', l10n.english),
                    _buildTestRow('Vietnamese', l10n.vietnamese),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: _loadCurrentLanguage,
              child: const Text('Refresh Language Status'),
            ),
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
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
