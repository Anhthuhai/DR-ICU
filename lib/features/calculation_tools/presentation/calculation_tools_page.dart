import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import 'bmi_calculator_page.dart';
import 'bsa_calculator_page.dart';
import 'ibw_calculator_page.dart';
import 'creatinine_calculator_page.dart';
import 'fluid_balance_calculator_page.dart';
import 'dosage_calculator_page.dart';
import 'sodium_correction_calculator_page.dart';

class CalculationToolsPage extends StatelessWidget {
  const CalculationToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Công cụ tính toán'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chọn công cụ tính toán',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Các công cụ tính toán y khoa hỗ trợ thực hành lâm sàng',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildCalculatorListItem(
                    context,
                    title: 'BMI Calculator',
                    subtitle: 'Body Mass Index',
                    description: 'Tính chỉ số khối cơ thể',
                    icon: Icons.accessibility_new,
                    color: Colors.green.shade400,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BMICalculatorPage(),
                        ),
                      );
                    },
                  ),
                  _buildCalculatorListItem(
                    context,
                    title: 'BSA Calculator',
                    subtitle: 'Body Surface Area',
                    description: 'Tính diện tích bề mặt cơ thể',
                    icon: Icons.person_outline,
                    color: Colors.blue.shade400,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BSACalculatorPage(),
                        ),
                      );
                    },
                  ),
                  _buildCalculatorListItem(
                    context,
                    title: 'Ideal Body Weight',
                    subtitle: 'IBW Calculator',
                    description: 'Tính cân nặng lý tưởng',
                    icon: Icons.monitor_weight_outlined,
                    color: Colors.purple.shade400,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const IBWCalculatorPage(),
                        ),
                      );
                    },
                  ),
                  _buildCalculatorListItem(
                    context,
                    title: 'Creatinine Clearance',
                    subtitle: 'CrCl Calculator',
                    description: 'Tính độ thanh thải creatinine',
                    icon: Icons.water_drop,
                    color: Colors.orange.shade400,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreatinineCalculatorPage(),
                        ),
                      );
                    },
                  ),
                  _buildCalculatorListItem(
                    context,
                    title: 'Fluid Balance',
                    subtitle: 'I/O Calculator',
                    description: 'Tính cân bằng dịch',
                    icon: Icons.invert_colors,
                    color: Colors.teal.shade400,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FluidBalanceCalculatorPage(),
                        ),
                      );
                    },
                  ),
                  _buildCalculatorListItem(
                    context,
                    title: 'Dosage Calculator',
                    subtitle: 'Drug Dosing',
                    description: 'Tính liều thuốc',
                    icon: Icons.medication,
                    color: Colors.red.shade400,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DosageCalculatorPage(),
                        ),
                      );
                    },
                  ),
                  _buildCalculatorListItem(
                    context,
                    title: 'Sodium Correction',
                    subtitle: 'Na+ Calculator',
                    description: 'Tính bù natri máu',
                    icon: Icons.balance,
                    color: Colors.indigo.shade400,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SodiumCorrectionCalculatorPage(),
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

  Widget _buildCalculatorListItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: color.withValues(alpha: 0.3),
              width: 1,
            ),
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
            color: Colors.black87,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ],
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
