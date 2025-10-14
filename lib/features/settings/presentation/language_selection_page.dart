import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/services/language_service.dart';
import '../../../core/theme/app_theme.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String _selectedLanguage = 'vi';

  @override
  void initState() {
    super.initState();
    _loadCurrentLanguage();
  }

  Future<void> _loadCurrentLanguage() async {
    final locale = await LanguageService.getLocale();
    setState(() {
      _selectedLanguage = locale.languageCode;
    });
  }

  Future<void> _changeLanguage(String languageCode) async {
    await LanguageService.setLocale(languageCode);
    setState(() {
      _selectedLanguage = languageCode;
    });
    
    // Show success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(languageCode == 'en' 
              ? 'Language changed to English. Please restart app.' 
              : 'Đã đổi sang Tiếng Việt. Vui lòng khởi động lại ứng dụng.'),
          duration: const Duration(seconds: 3),
        ),
      );
      
      // Return to previous screen with result
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.languageSelection),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.language,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(height: 16),
            
            // Vietnamese Option
            Card(
              elevation: 2,
              child: RadioListTile<String>(
                title: Text(
                  '🇻🇳 ${l10n.vietnamese}',
                  style: TextStyle(
                    fontWeight: _selectedLanguage == 'vi' 
                        ? FontWeight.bold 
                        : FontWeight.normal,
                  ),
                ),
                subtitle: const Text('Vietnamese'),
                value: 'vi',
                // ignore: deprecated_member_use
                groupValue: _selectedLanguage,
                // ignore: deprecated_member_use
                onChanged: (String? value) {
                  if (value != null) {
                    _changeLanguage(value);
                  }
                },
                activeColor: AppTheme.primaryBlue,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // English Option
            Card(
              elevation: 2,
              child: RadioListTile<String>(
                title: Text(
                  '🇺🇸 ${l10n.english}',
                  style: TextStyle(
                    fontWeight: _selectedLanguage == 'en' 
                        ? FontWeight.bold 
                        : FontWeight.normal,
                  ),
                ),
                subtitle: const Text('English'),
                value: 'en',
                // ignore: deprecated_member_use
                groupValue: _selectedLanguage,
                // ignore: deprecated_member_use
                onChanged: (String? value) {
                  if (value != null) {
                    _changeLanguage(value);
                  }
                },
                activeColor: AppTheme.primaryBlue,
              ),
            ),
            
            const Spacer(),
            
            // Information Card
            Card(
              color: Colors.blue.shade50,
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
                          'Language Information',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Changing the language will restart the app to apply the new language settings. All medical terms and protocols will be translated accordingly.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
