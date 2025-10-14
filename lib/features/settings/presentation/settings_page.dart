import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import 'language_selection_page.dart';
import 'clinical_scores_localization_test_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.language),
              title: Text(l10n.language),
              subtitle: Text(l10n.languageSelection),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LanguageSelectionPage(),
                  ),
                );
                
                // If language was changed, we need to restart the app
                if (result == true && context.mounted) {
                  // Show a snackbar to inform user about restart
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Language changed. Please restart the app to see changes.'),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Clinical Scores Localization Test - Debug/Development
          Card(
            child: ListTile(
              leading: const Icon(Icons.science),
              title: const Text('Clinical Scores Localization Test'),
              subtitle: const Text('Test qSOFA, NIHSS localization'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ClinicalScoresLocalizationTestPage(),
                  ),
                );
              },
            ),
          ),
          
          // About Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: AppTheme.primaryBlue),
                      const SizedBox(width: 8),
                      Text(
                        'About DR-ICU',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'DR-ICU: Emergency Medical Protocols for Critical Care\n\n'
                    'Version 1.0.0\n\n'
                    'A comprehensive medical reference application designed for healthcare professionals working in intensive care units and emergency medicine.',
                    style: TextStyle(fontSize: 14, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
