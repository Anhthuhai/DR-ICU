import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import 'abg_analysis_page.dart';
import 'pleural_fluid_analysis_page.dart';
import 'ascitic_fluid_analysis_page.dart';
import 'csf_analysis_page.dart';
import 'urinalysis_page.dart';
import 'lab_trend_analysis_page.dart';

class LabAnalysisHomePage extends StatelessWidget {
  const LabAnalysisHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phân tích cận lâm sàng'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chọn loại phân tích',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Công cụ hỗ trợ phân tích và diễn giải kết quả xét nghiệm',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildAnalysisCard(
                    context,
                    title: 'Khí máu động mạch',
                    subtitle: 'ABG Analysis',
                    icon: Icons.air,
                    color: Colors.red.shade400,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ABGAnalysisPage(),
                        ),
                      );
                    },
                  ),
                  _buildAnalysisCard(
                    context,
                    title: 'Xu hướng xét nghiệm',
                    subtitle: 'Lab Trends',
                    icon: Icons.trending_up,
                    color: Colors.blue.shade400,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LabTrendAnalysisPage(),
                        ),
                      );
                    },
                  ),
                  _buildAnalysisCard(
                    context,
                    title: 'Dịch màng phổi',
                    subtitle: 'Pleural Fluid',
                    icon: Icons.water_drop,
                    color: Colors.teal.shade400,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PleuralFluidAnalysisPage(),
                        ),
                      );
                    },
                  ),
                  _buildAnalysisCard(
                    context,
                    title: 'Dịch màng bụng',
                    subtitle: 'Ascitic Fluid',
                    icon: Icons.local_hospital,
                    color: Colors.orange.shade400,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AsciticFluidAnalysisPage(),
                        ),
                      );
                    },
                  ),
                  _buildAnalysisCard(
                    context,
                    title: 'Dịch não tủy',
                    subtitle: 'CSF Analysis',
                    icon: Icons.psychology,
                    color: Colors.purple.shade400,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CsfAnalysisPage(),
                        ),
                      );
                    },
                  ),
                  _buildAnalysisCard(
                    context,
                    title: 'Phân tích nước tiểu',
                    subtitle: 'Urinalysis',
                    icon: Icons.opacity,
                    color: Colors.amber.shade400,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UrinalysisPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withValues(alpha: 0.1),
                color.withValues(alpha: 0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
