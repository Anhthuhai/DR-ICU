import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class DosageCalculatorPage extends StatelessWidget {
  const DosageCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dosage Calculator'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.medication_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Dosage Calculator'),
            Text('Coming soon...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
