import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import 'hypertensive_crisis_protocol_page.dart';
import 'hypoglycemia_crisis_protocol_page.dart';

class EmergencyProtocolsPage extends StatelessWidget {
  const EmergencyProtocolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Sơ đồ xử lý cấp cứu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withValues(alpha: 0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.emergency,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Protocols Cấp Cứu',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Sơ đồ xử lý nhanh các tình huống cấp cứu thường gặp',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Protocols Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
                children: [
                  _buildProtocolCard(
                    context,
                    title: 'Cơn Tăng Huyết Áp',
                    subtitle: 'Hypertensive Crisis',
                    description: 'Xử lý cấp cứu THA ≥180/120 mmHg',
                    icon: Icons.favorite,
                    color: Colors.red.shade400,
                    isAvailable: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HypertensiveCrisisProtocolPage(),
                        ),
                      );
                    },
                  ),
                  _buildProtocolCard(
                    context,
                    title: 'Sốc Tim',
                    subtitle: 'Cardiogenic Shock',
                    description: 'Xử lý sốc do tim',
                    icon: Icons.monitor_heart,
                    color: Colors.orange.shade400,
                    isAvailable: false,
                  ),
                  _buildProtocolCard(
                    context,
                    title: 'Cơn Hạ Đường Huyết',
                    subtitle: 'Hypoglycemia Crisis',
                    description: 'Xử lý cấp cứu glucose <70mg/dL',
                    icon: Icons.water_drop,
                    color: Colors.blue.shade400,
                    isAvailable: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HypoglycemiaCrisisProtocolPage(),
                        ),
                      );
                    },
                  ),
                  _buildProtocolCard(
                    context,
                    title: 'Ngộ Độc Cấp',
                    subtitle: 'Acute Poisoning',
                    description: 'Xử lý ngộ độc cấp tính',
                    icon: Icons.warning,
                    color: Colors.purple.shade400,
                    isAvailable: false,
                  ),
                  _buildProtocolCard(
                    context,
                    title: 'Sốc Phản Vệ',
                    subtitle: 'Anaphylactic Shock',
                    description: 'Xử lý sốc phản vệ',
                    icon: Icons.healing,
                    color: Colors.green.shade400,
                    isAvailable: false,
                  ),
                  _buildProtocolCard(
                    context,
                    title: 'Nhồi Máu Cơ Tim',
                    subtitle: 'Myocardial Infarction',
                    description: 'Xử lý NMCT cấp',
                    icon: Icons.local_hospital,
                    color: Colors.teal.shade400,
                    isAvailable: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProtocolCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String description,
    required IconData icon,
    required Color color,
    required bool isAvailable,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Availability overlay
            if (!isAvailable)
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon and status
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isAvailable 
                            ? color.withValues(alpha: 0.1)
                            : Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          icon,
                          color: isAvailable ? color : Colors.grey,
                          size: 28,
                        ),
                      ),
                      const Spacer(),
                      if (!isAvailable)
                        Icon(
                          Icons.lock,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Title
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isAvailable ? Colors.black87 : Colors.grey.shade600,
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Subtitle
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isAvailable ? color : Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Description
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: isAvailable ? Colors.grey.shade600 : Colors.grey.shade500,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const Spacer(),
                  
                  // Status indicator
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isAvailable ? Colors.green : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isAvailable ? 'Sẵn sàng' : 'Đang phát triển',
                        style: TextStyle(
                          fontSize: 12,
                          color: isAvailable ? Colors.green : Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
