import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../calculation_tools/presentation/calculation_tools_page.dart';
import '../../calculation_tools/presentation/bmi_calculator_page.dart';
import '../../calculation_tools/presentation/ibw_calculator_page.dart';
import '../../calculation_tools/presentation/creatinine_calculator_page.dart';
import '../../calculation_tools/presentation/sodium_correction_calculator_page.dart';
import '../../emergency_protocols/presentation/emergency_protocols_page.dart';
import '../../emergency_protocols/presentation/hypertensive_crisis_protocol_page.dart';
import '../../emergency_protocols/presentation/hypoglycemia_crisis_protocol_page.dart';
import '../../clinical_scores/presentation/clinical_scores_page.dart';
import '../../unit_converter/presentation/pages/unit_converter_page.dart';
import '../../lab_analysis/presentation/lab_analysis_home_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchResult> _searchResults = [];
  bool _isSearching = false;
  SearchType? _selectedFilter;

  final List<SearchItem> _allItems = [
    // Calculation Tools
    SearchItem(
      id: 'bmi_calculator',
      title: 'Tính BMI',
      subtitle: 'Body Mass Index',
      category: 'Công cụ tính toán',
      type: SearchType.calculation,
      icon: Icons.scale,
      color: Colors.blue,
    ),
    SearchItem(
      id: 'ibw_calculator',
      title: 'Tính cân nặng lý tưởng',
      subtitle: 'Ideal Body Weight',
      category: 'Công cụ tính toán',
      type: SearchType.calculation,
      icon: Icons.fitness_center,
      color: Colors.green,
    ),
    SearchItem(
      id: 'creatinine_calculator',
      title: 'Tính độ thanh thải Creatinine',
      subtitle: 'Creatinine Clearance',
      category: 'Công cụ tính toán',
      type: SearchType.calculation,
      icon: Icons.biotech,
      color: Colors.purple,
    ),
    SearchItem(
      id: 'sodium_correction',
      title: 'Tính bù Natri máu',
      subtitle: 'Sodium Correction',
      category: 'Công cụ tính toán',
      type: SearchType.calculation,
      icon: Icons.balance,
      color: Colors.indigo,
    ),
    
    // Emergency Protocols
    SearchItem(
      id: 'hypertensive_crisis',
      title: 'Cơn Tăng Huyết Áp',
      subtitle: 'Hypertensive Crisis Protocol',
      category: 'Hướng dẫn cấp cứu',
      type: SearchType.protocol,
      icon: Icons.favorite,
      color: Colors.red,
    ),
    SearchItem(
      id: 'hypoglycemia_crisis',
      title: 'Cơn Hạ Đường Huyết',
      subtitle: 'Hypoglycemia Crisis Protocol',
      category: 'Hướng dẫn cấp cứu',
      type: SearchType.protocol,
      icon: Icons.water_drop,
      color: Colors.blue,
    ),
    SearchItem(
      id: 'cardiogenic_shock',
      title: 'Sốc Tim',
      subtitle: 'Cardiogenic Shock',
      category: 'Hướng dẫn cấp cứu',
      type: SearchType.protocol,
      icon: Icons.monitor_heart,
      color: Colors.red,
    ),
    SearchItem(
      id: 'respiratory_failure',
      title: 'Suy Hô Hấp Cấp',
      subtitle: 'Acute Respiratory Failure',
      category: 'Hướng dẫn cấp cứu',
      type: SearchType.protocol,
      icon: Icons.air,
      color: Colors.blue,
    ),
    
    // Clinical Scores
    SearchItem(
      id: 'glasgow_coma_scale',
      title: 'Glasgow Coma Scale',
      subtitle: 'GCS - Đánh giá ý thức',
      category: 'Thang điểm lâm sàng',
      type: SearchType.score,
      icon: Icons.psychology,
      color: Colors.orange,
    ),
    SearchItem(
      id: 'apache_ii',
      title: 'APACHE II',
      subtitle: 'Dự đoán tử vong ICU',
      category: 'Thang điểm lâm sàng',
      type: SearchType.score,
      icon: Icons.assessment,
      color: Colors.teal,
    ),
    
    // Unit Converter
    SearchItem(
      id: 'unit_converter',
      title: 'Chuyển đổi đơn vị',
      subtitle: 'Đơn vị khối lượng, thể tích',
      category: 'Chuyển đổi',
      type: SearchType.converter,
      icon: Icons.swap_horiz,
      color: Colors.indigo,
    ),
    
    // Lab Analysis
    SearchItem(
      id: 'lab_analysis',
      title: 'Phân tích xét nghiệm',
      subtitle: 'Giải thích kết quả XN',
      category: 'Xét nghiệm',
      type: SearchType.lab,
      icon: Icons.science,
      color: Colors.cyan,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _isSearching = _searchController.text.isNotEmpty;
      if (_isSearching) {
        _performSearch(_searchController.text);
      } else {
        _searchResults.clear();
      }
    });
  }

  void _performSearch(String query) {
    final results = <SearchResult>[];
    final lowerQuery = query.toLowerCase();

    for (final item in _allItems) {
      // Apply filter if selected
      if (_selectedFilter != null && item.type != _selectedFilter) {
        continue;
      }
      
      int score = 0;
      
      // Exact title match
      if (item.title.toLowerCase().contains(lowerQuery)) {
        score += 100;
      }
      
      // Subtitle match
      if (item.subtitle.toLowerCase().contains(lowerQuery)) {
        score += 50;
      }
      
      // Category match
      if (item.category.toLowerCase().contains(lowerQuery)) {
        score += 25;
      }
      
      if (score > 0) {
        results.add(SearchResult(item: item, score: score));
      }
    }
    
    // Sort by score (highest first)
    results.sort((a, b) => b.score.compareTo(a.score));
    
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Tìm kiếm công cụ, hướng dẫn...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
              },
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        // Filter buttons
        _buildFilterButtons(),
        // Search results
        Expanded(
          child: _isSearching ? 
            (_searchResults.isEmpty ? _buildNoResults() : _buildSearchResults())
            : _buildSearchSuggestions(),
        ),
      ],
    );
  }

  Widget _buildFilterButtons() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildFilterChip('Tất cả', null),
          const SizedBox(width: 8),
          _buildFilterChip('Tính toán', SearchType.calculation),
          const SizedBox(width: 8),
          _buildFilterChip('Hướng dẫn', SearchType.protocol),
          const SizedBox(width: 8),
          _buildFilterChip('Điểm số', SearchType.score),
          const SizedBox(width: 8),
          _buildFilterChip('Đơn vị', SearchType.converter),
          const SizedBox(width: 8),
          _buildFilterChip('Xét nghiệm', SearchType.lab),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, SearchType? type) {
    final isSelected = _selectedFilter == type;
    
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppTheme.primaryBlue,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? type : null;
          // Re-trigger search if there's a query
          if (_searchController.text.isNotEmpty) {
            _onSearchChanged();
          }
        });
      },
      selectedColor: AppTheme.primaryBlue,
      backgroundColor: Colors.grey[100],
      checkmarkColor: Colors.white,
      elevation: isSelected ? 2 : 0,
    );
  }

  Widget _buildSearchSuggestions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gợi ý tìm kiếm',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSuggestionChip('BMI'),
              _buildSuggestionChip('Tăng huyết áp'),
              _buildSuggestionChip('Glasgow'),
              _buildSuggestionChip('Creatinine'),
              _buildSuggestionChip('Sốc tim'),
              _buildSuggestionChip('Xét nghiệm'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String text) {
    return ActionChip(
      label: Text(text),
      onPressed: () {
        _searchController.text = text;
      },
      backgroundColor: Colors.blue.shade50,
      labelStyle: TextStyle(color: Colors.blue.shade700),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Không tìm thấy kết quả',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Thử tìm kiếm với từ khóa khác',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final result = _searchResults[index];
        return _buildResultCard(result.item);
      },
    );
  }

  Widget _buildResultCard(SearchItem item) {
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
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: item.color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            item.icon,
            color: item.color,
            size: 28,
          ),
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                item.category,
                style: TextStyle(
                  fontSize: 12,
                  color: item.color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey[400],
          size: 16,
        ),
        onTap: () {
          // Navigate to the appropriate page based on item type
          Navigator.pop(context);
          _navigateToItem(item);
        },
      ),
    );
  }

  void _navigateToItem(SearchItem item) {
    Widget targetPage;
    
    switch (item.type) {
      case SearchType.calculation:
        switch (item.id) {
          case 'bmi_calculator':
            targetPage = const BMICalculatorPage();
            break;
          case 'ibw_calculator':
            targetPage = const IBWCalculatorPage();
            break;
          case 'creatinine_calculator':
            targetPage = const CreatinineCalculatorPage();
            break;
          case 'sodium_correction':
            targetPage = const SodiumCorrectionCalculatorPage();
            break;
          default:
            // For other calculation tools, go to main calculation page
            targetPage = const CalculationToolsPage();
        }
        break;
        
      case SearchType.protocol:
        switch (item.id) {
          case 'hypertensive_crisis':
            targetPage = const HypertensiveCrisisProtocolPage();
            break;
          case 'hypoglycemia_crisis':
            targetPage = const HypoglycemiaCrisisProtocolPage();
            break;
          case 'cardiogenic_shock':
          case 'respiratory_failure':
            // These protocols are not implemented yet, show main protocols page
            targetPage = const EmergencyProtocolsPage();
            break;
          default:
            targetPage = const EmergencyProtocolsPage();
        }
        break;
        
      case SearchType.score:
        targetPage = const ClinicalScoresPage();
        break;
        
      case SearchType.converter:
        targetPage = const UnitConverterPage();
        break;
        
      case SearchType.lab:
        targetPage = const LabAnalysisHomePage();
        break;
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }
}

enum SearchType { calculation, protocol, score, converter, lab }

class SearchItem {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final SearchType type;
  final IconData icon;
  final Color color;

  SearchItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.type,
    required this.icon,
    required this.color,
  });
}

class SearchResult {
  final SearchItem item;
  final int score;

  SearchResult({required this.item, required this.score});
}
