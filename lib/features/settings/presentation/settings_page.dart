import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import 'language_selection_page.dart';
import 'privacy_policy_page.dart';

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
          
          // Privacy & Legal Section
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.privacy_tip, color: Colors.green),
                  title: const Text('Privacy Policy'),
                  subtitle: const Text('View our privacy policy'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyPage(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.description, color: Colors.blue),
                  title: const Text('Terms of Service'),
                  subtitle: const Text('View terms and conditions'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => _showTermsDialog(context),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Medical Disclaimer Section
          Card(
            color: Colors.red.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, color: Colors.red.shade600, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        'MEDICAL DISCLAIMER',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'FOR HEALTHCARE PROFESSIONALS ONLY\n\n'
                    'This application is intended exclusively for licensed healthcare professionals. '
                    'All medical information is provided for reference purposes only and should not '
                    'replace clinical judgment, institutional protocols, or direct patient care.\n\n'
                    'Users assume full responsibility for any clinical applications of this information.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.red.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
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

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Terms of Service'),
          content: const SingleChildScrollView(
            child: Text(
              'DR ICU - Terms of Service\n\n'
              '1. PROFESSIONAL USE ONLY\n'
              'This application is intended exclusively for licensed healthcare professionals '
              'for educational and reference purposes.\n\n'
              '2. NO WARRANTY\n'
              'All medical information is provided "as is" without warranty of any kind.\n\n'
              '3. LIMITATION OF LIABILITY\n'
              'The developers assume no responsibility for any clinical decisions made using this app.\n\n'
              '4. CLINICAL JUDGMENT\n'
              'Always use your clinical judgment and follow institutional protocols.\n\n'
              '5. ACCURACY\n'
              'While we strive for accuracy, users must verify all information independently.\n\n'
              'By using this app, you agree to these terms.',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
