import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../main.dart';
import '../../../clinical_scores/presentation/clinical_scores_page.dart';
import '../../../unit_converter/presentation/pages/unit_converter_page.dart';
import '../../../lab_analysis/presentation/lab_analysis_home_page.dart';
import '../../../calculation_tools/presentation/calculation_tools_page.dart';
import '../../../emergency_protocols/presentation/emergency_protocols_page.dart';
import '../../../bookmarks/presentation/bookmarks_page.dart';
import '../../../notifications/presentation/notifications_page.dart';
import '../../../settings/presentation/language_selection_page.dart';
import '../../../references/presentation/medical_references_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/icons/app_icon.png',
          height: 36,
          width: 36,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookmarksPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.library_books),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MedicalReferencesPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LanguageSelectionPage(),
                ),
              );
              // Restart app if language changed
              if (result == true && mounted) {
                // Force rebuild the entire app with new locale
                DrIcuApp.restartApp();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: _buildCurrentPage(),
    );
  }

  Widget _buildCurrentPage() {
    return _buildHomePage();
  }

  Widget _buildHomePage() {
    final l10n = AppLocalizations.of(context)!;
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Medical Disclaimer Banner - CRITICAL for App Store compliance
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              border: Border.all(color: Colors.red.shade300, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(Icons.medical_services, color: Colors.red.shade600, size: 32),
                const SizedBox(height: 8),
                Text(
                  l10n.medical_disclaimer_professional_only,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.medical_disclaimer_home_text,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.red.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          Text(
            l10n.welcomeMessage,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryBlue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.welcomeSubtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.darkGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: [
                _buildFeatureCard(
                  l10n.clinicalScores,
                  l10n.clinicalScoresDescription,
                  Icons.calculate_rounded,
                  Colors.blue.shade400,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ClinicalScoresPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _buildFeatureCard(
                  l10n.unitConverter,
                  l10n.unitConverterDescription,
                  Icons.swap_horiz_rounded,
                  Colors.green.shade400,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UnitConverterPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _buildFeatureCard(
                  l10n.labAnalysis,
                  l10n.labAnalysisDescription,
                  Icons.science_rounded,
                  Colors.purple.shade400,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LabAnalysisHomePage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _buildFeatureCard(
                  l10n.calculationTools,
                  l10n.calculationToolsDescription,
                  Icons.functions_rounded,
                  Colors.indigo.shade400,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculationToolsPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _buildFeatureCard(
                  l10n.emergencyProtocols,
                  l10n.emergencyProtocolsDescription,
                  Icons.medical_services_rounded,
                  Colors.red.shade400,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EmergencyProtocolsPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                
                // Medical Disclaimer
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: Colors.orange.shade700, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l10n.medical_disclaimer,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.05)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppTheme.mediumGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
