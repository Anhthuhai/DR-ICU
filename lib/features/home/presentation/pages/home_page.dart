import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../clinical_scores/presentation/clinical_scores_page.dart';
import '../../../unit_converter/presentation/pages/unit_converter_page.dart';
import '../../../lab_analysis/presentation/lab_analysis_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<BottomNavigationBarItem> _navItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_rounded),
      label: 'Trang chủ',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.calculate_rounded),
      label: 'Thang điểm',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.swap_horiz_rounded),
      label: 'Chuyển đổi',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science_rounded),
      label: 'Xét nghiệm',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.more_horiz),
      label: 'Khác',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DR ICU'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
        ],
      ),
      body: _buildCurrentPage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: _navItems,
        selectedItemColor: AppTheme.primaryBlue,
        unselectedItemColor: AppTheme.mediumGrey,
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return _buildScoringPage();
      case 2:
        return _buildConverterPage();
      case 3:
        return _buildLabAnalysisPage();
      case 4:
        return _buildMorePage();
      default:
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chào mừng đến với DR ICU',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryBlue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Công cụ hỗ trợ cho bác sĩ và sinh viên thực hành tại khoa hồi sức tích cực',
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
                  'Thang điểm lâm sàng',
                  'Glasgow, APACHE, SOFA...',
                  Icons.calculate_rounded,
                  Colors.blue.shade400,
                  () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                ),
                const SizedBox(height: 12),
                _buildFeatureCard(
                  'Chuyển đổi đơn vị',
                  'mg/dl ↔ mmol/l',
                  Icons.swap_horiz_rounded,
                  Colors.green.shade400,
                  () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                ),
                const SizedBox(height: 12),
                _buildFeatureCard(
                  'Phân tích xét nghiệm',
                  'Dịch màng, khí máu...',
                  Icons.science_rounded,
                  Colors.purple.shade400,
                  () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                ),
                const SizedBox(height: 12),
                _buildFeatureCard(
                  'Hướng dẫn cấp cứu',
                  'Sơ đồ xử lý nhanh',
                  Icons.medical_services_rounded,
                  Colors.red.shade400,
                  () {
                    // TODO: Navigate to emergency protocols
                  },
                ),
                const SizedBox(height: 12),
                _buildFeatureCard(
                  'Cập nhật mới',
                  'Guidelines & Research',
                  Icons.article_rounded,
                  Colors.orange.shade400,
                  () {
                    // TODO: Navigate to guidelines
                  },
                ),
                const SizedBox(height: 12),
                _buildFeatureCard(
                  'Giải trí',
                  'Thư giãn & giảm stress',
                  Icons.music_note_rounded,
                  Colors.teal.shade400,
                  () {
                    setState(() {
                      _selectedIndex = 4;
                    });
                  },
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

  Widget _buildScoringPage() {
    return const ClinicalScoresPage();
  }

  Widget _buildConverterPage() {
    return const UnitConverterPage();
  }

  Widget _buildLabAnalysisPage() {
    return const LabAnalysisHomePage();
  }

  Widget _buildMorePage() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.more_horiz, size: 64, color: AppTheme.mediumGrey),
          SizedBox(height: 16),
          Text('Tính năng khác'),
          Text('Hướng dẫn, giải trí...'),
        ],
      ),
    );
  }
}
