import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

class GuidelinesPage extends StatelessWidget {
  const GuidelinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.lightGrey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.primaryBlue,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                l10n.guidelines,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.primaryBlue,
                      AppTheme.primaryBlue.withValues(alpha: 0.8),
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.article_rounded,
                    size: 60,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildGuidelineCard(
                  context,
                  'Sepsis Guidelines',
                  'Early recognition and management of sepsis',
                  Icons.medical_services,
                  Colors.red.shade400,
                  () {
                    // Navigate to sepsis guidelines
                  },
                ),
                const SizedBox(height: 12),
                _buildGuidelineCard(
                  context,
                  'Cardiac Arrest Protocols',
                  'ACLS and resuscitation guidelines',
                  Icons.favorite,
                  Colors.pink.shade400,
                  () {
                    // Navigate to cardiac arrest protocols
                  },
                ),
                const SizedBox(height: 12),
                _buildGuidelineCard(
                  context,
                  'Mechanical Ventilation',
                  'Ventilator management protocols',
                  Icons.air,
                  Colors.blue.shade400,
                  () {
                    // Navigate to ventilation guidelines
                  },
                ),
                const SizedBox(height: 12),
                _buildGuidelineCard(
                  context,
                  'Fluid Management',
                  'Fluid resuscitation and balance',
                  Icons.water_drop,
                  Colors.cyan.shade400,
                  () {
                    // Navigate to fluid management
                  },
                ),
                const SizedBox(height: 12),
                _buildGuidelineCard(
                  context,
                  'Pain & Sedation',
                  'Analgesia and sedation protocols',
                  Icons.healing,
                  Colors.purple.shade400,
                  () {
                    // Navigate to pain management
                  },
                ),
                const SizedBox(height: 12),
                _buildGuidelineCard(
                  context,
                  'Nutrition Guidelines',
                  'Critical care nutrition protocols',
                  Icons.restaurant,
                  Colors.orange.shade400,
                  () {
                    // Navigate to nutrition guidelines
                  },
                ),
                const SizedBox(height: 12),
                _buildGuidelineCard(
                  context,
                  'Infection Control',
                  'Prevention and control measures',
                  Icons.shield,
                  Colors.green.shade400,
                  () {
                    // Navigate to infection control
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
                          'FOR HEALTHCARE PROFESSIONALS ONLY\nGuidelines are reference tools - Always use clinical judgment',
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
                const SizedBox(height: 20),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuidelineCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkGrey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.mediumGrey,
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
