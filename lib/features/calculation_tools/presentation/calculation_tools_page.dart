import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import 'bmi_calculator_page.dart';
import 'bsa_calculator_page.dart';
import 'ibw_calculator_page.dart';
import 'creatinine_calculator_page.dart';
import 'fluid_balance_calculator_page.dart';
import 'dosage_calculator_page.dart';

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
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildCalculatorCard(
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
                  _buildCalculatorCard(
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
                  _buildCalculatorCard(
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
                  _buildCalculatorCard(
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
                  _buildCalculatorCard(
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
                  _buildCalculatorCard(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculatorCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String description,
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
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade500,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
