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
              child: ListView(
                children: [
                  _buildAnalysisListItem(
                    context,
                    title: 'Khí máu động mạch',
                    subtitle: 'ABG Analysis - Phân tích khí máu động mạch, pH, CO2, O2',
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
                  _buildAnalysisListItem(
                    context,
                    title: 'Xu hướng xét nghiệm',
                    subtitle: 'Lab Trends - Theo dõi xu hướng thay đổi các chỉ số xét nghiệm',
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
                  _buildAnalysisListItem(
                    context,
                    title: 'Dịch màng phổi',
                    subtitle: 'Pleural Fluid - Phân tích dịch màng phổi, Light\'s criteria',
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
                  _buildAnalysisListItem(
                    context,
                    title: 'Dịch màng bụng',
                    subtitle: 'Ascitic Fluid - Phân tích dịch cổ trướng, SAAG gradient',
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
                  _buildAnalysisListItem(
                    context,
                    title: 'Dịch não tủy',
                    subtitle: 'CSF Analysis - Phân tích dịch não tủy, viêm màng não',
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
                  _buildAnalysisListItem(
                    context,
                    title: 'Phân tích nước tiểu',
                    subtitle: 'Urinalysis - Phân tích nước tiểu, protein, hồng cầu',
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

  Widget _buildAnalysisListItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 28,
            color: color,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              height: 1.3,
            ),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}
