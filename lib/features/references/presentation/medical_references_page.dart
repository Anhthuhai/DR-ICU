import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class MedicalReferencesPage extends StatelessWidget {
  const MedicalReferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.medical_references_title),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDisclaimer(l10n),
            const SizedBox(height: 24),
            _buildReferencesSection(l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildDisclaimer(AppLocalizations l10n) {
    return Card(
      color: Colors.orange.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning, color: Colors.orange.shade700),
                const SizedBox(width: 8),
                Text(
                  l10n.medical_disclaimer_title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              l10n.medical_disclaimer_content,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReferencesSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.medical_references_title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryBlue,
          ),
        ),
        const SizedBox(height: 16),
        
        _buildReferenceCategory(
          'Clinical Scoring Systems',
          [
            'Glasgow Coma Scale: Teasdale G, Jennett B. Assessment of coma and impaired consciousness. Lancet. 1974;2(7872):81-84.',
            'APACHE II Score: Knaus WA, et al. APACHE II: a severity of disease classification system. Crit Care Med. 1985;13(10):818-829.',
            'SOFA Score: Vincent JL, et al. The SOFA (Sepsis-related Organ Failure Assessment) score. Intensive Care Med. 1996;22(7):707-710.',
            'SAPS II: Le Gall JR, et al. A new Simplified Acute Physiology Score (SAPS II). JAMA. 1993;270(24):2957-2963.',
          ],
        ),
        
        _buildReferenceCategory(
          'Emergency Protocols',
          [
            'American Heart Association Guidelines for CPR and ECC. Circulation. 2020;142(16_suppl_2):S337-S357.',
            'Surviving Sepsis Campaign Guidelines. Intensive Care Med. 2021;47(11):1181-1247.',
            'Advanced Cardiac Life Support (ACLS) Provider Manual. American Heart Association. 2020.',
          ],
        ),
        
        _buildReferenceCategory(
          'Laboratory Analysis',
          [
            'Clinical Chemistry: Principles, Techniques, and Correlations. 8th Edition. Wolters Kluwer. 2017.',
            'Henry\'s Clinical Diagnosis and Management by Laboratory Methods. 23rd Edition. Elsevier. 2016.',
            'Arterial Blood Gas Analysis: Clinical Application and Case Studies. Respiratory Care. 2019;64(10):1288-1295.',
          ],
        ),
        
        const SizedBox(height: 24),
        
        Card(
          color: Colors.blue.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Professional Organizations',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryBlue,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '• Society of Critical Care Medicine (SCCM)\n'
                  '• American College of Emergency Physicians (ACEP)\n'
                  '• European Society of Intensive Care Medicine (ESICM)\n'
                  '• American Heart Association (AHA)\n'
                  '• World Health Organization (WHO)',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReferenceCategory(String title, List<String> references) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...references.map((ref) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Text(
                      ref,
                      style: const TextStyle(fontSize: 13, height: 1.4),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
