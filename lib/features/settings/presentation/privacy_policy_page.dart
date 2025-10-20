import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                border: Border.all(color: Colors.green.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(Icons.privacy_tip, color: Colors.green.shade600, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    'Privacy Summary',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'DR-ICU does not collect, store, or transmit any personal data. All information is stored locally on your device.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            _buildSection(
              context,
              '1. Information We Collect',
              'We do not collect any personal information.',
              [
                'DR-ICU operates completely offline and does not:',
                '• Collect personal information',
                '• Require user registration or accounts',
                '• Access contacts, photos, or other personal data',
                '• Track user behavior or usage patterns',
                '• Use cookies or similar tracking technologies',
                '• Send data to external servers',
              ],
            ),
            
            _buildSection(
              context,
              '2. How We Use Information',
              'Since we do not collect any personal information, we do not use, share, or process any user data.',
              [],
            ),
            
            _buildSection(
              context,
              '3. Data Storage',
              'All medical protocols, guidelines, and user preferences (such as bookmarks) are stored locally on your device only.',
              [
                'This data:',
                '• Remains on your device at all times',
                '• Is not transmitted to any servers',
                '• Is not shared with third parties',
                '• Can be deleted by uninstalling the app',
              ],
            ),
            
            _buildSection(
              context,
              '4. Third-Party Services',
              'DR-ICU does not integrate with any third-party services, analytics platforms, or advertising networks.',
              [],
            ),
            
            _buildSection(
              context,
              '5. Children\'s Privacy',
              'DR-ICU is designed for qualified healthcare professionals and is not intended for use by children under 13. We do not knowingly collect information from children.',
              [],
            ),
            
            _buildSection(
              context,
              '6. Medical Information Disclaimer',
              'The medical protocols and information provided in DR-ICU are for reference purposes only and intended for qualified healthcare professionals.',
              [
                'This information:',
                '• Should not replace clinical judgment',
                '• Should not replace institutional protocols',
                '• Is based on established medical literature',
                '• Is regularly updated for accuracy',
              ],
            ),
            
            _buildSection(
              context,
              '7. App Permissions',
              'DR-ICU may request minimal device permissions only for core functionality:',
              [
                '• Storage: To save bookmarks and user preferences locally',
                '• No network access required: App works completely offline',
              ],
            ),
            
            _buildSection(
              context,
              '8. Data Security',
              'Since all data remains on your device and no personal information is collected, your privacy is protected by your device\'s security measures.',
              [],
            ),
            
            _buildSection(
              context,
              '9. Contact Information',
              'If you have any questions about this Privacy Policy, please contact us:',
              [
                '• Email: privacy.dricu@gmail.com',
                '• Developer: Anh Luong Thi Ngoc',
                '• App: DR-ICU: Emergency Medical Protocols for Critical Care',
              ],
            ),
            
            _buildSection(
              context,
              '10. Compliance',
              'This Privacy Policy complies with:',
              [
                '• Apple App Store Privacy Requirements',
                '• General Data Protection Regulation (GDPR) principles',
                '• Healthcare information privacy standards',
              ],
            ),
            
            const SizedBox(height: 24),
            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    'Last Updated: October 19, 2025',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Effective Date: October 19, 2025',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.blue.shade600,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSection(BuildContext context, String title, String description, List<String> bulletPoints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
          ),
        ),
        const SizedBox(height: 8),
        if (description.isNotEmpty) ...[
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        if (bulletPoints.isNotEmpty) ...[
          ...bulletPoints.map((point) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              point,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )),
        ],
        const SizedBox(height: 16),
      ],
    );
  }
}
