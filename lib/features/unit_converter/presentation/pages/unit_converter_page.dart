import 'package:flutter/material.dart';
import '../../data/repositories/unit_converter_repository_impl.dart';
import '../../domain/entities/conversion_category.dart';
import '../../domain/entities/conversion_result.dart';
import '../../domain/entities/conversion_unit.dart';
import '../../domain/usecases/convert_units_usecase.dart';
import '../../domain/usecases/get_conversion_categories_usecase.dart';

class UnitConverterPage extends StatefulWidget {
  const UnitConverterPage({super.key});

  @override
  State<UnitConverterPage> createState() => _UnitConverterPageState();
}

class _UnitConverterPageState extends State<UnitConverterPage> {
  // Dependencies
  late final UnitConverterRepositoryImpl _repository;
  late final GetConversionCategoriesUseCase _getCategoriesUseCase;
  late final ConvertUnitsUseCase _convertUnitsUseCase;

  // State
  List<ConversionCategory> _categories = [];
  List<ConversionCategory> _filteredCategories = [];
  ConversionCategory? _selectedCategory;
  ConversionUnit? _fromUnit;
  ConversionUnit? _toUnit;
  ConversionResult? _result;
  bool _isLoading = false;
  String _errorMessage = '';
  String _searchQuery = '';

  // Controllers
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeUseCases();
    _loadCategories();
    _inputController.addListener(_onInputChanged);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      _filterCategories();
    });
  }

  void _filterCategories() {
    if (_searchQuery.isEmpty) {
      _filteredCategories = List.from(_categories);
    } else {
      _filteredCategories = _categories.where((category) {
        final name = category.name.toLowerCase();
        final example = category.commonExample.toLowerCase();
        final description = category.description.toLowerCase();
        
        return name.contains(_searchQuery) ||
               example.contains(_searchQuery) ||
               description.contains(_searchQuery);
      }).toList();
    }
    
    // Reset selected category if it's not in filtered list
    if (_selectedCategory != null && 
        !_filteredCategories.contains(_selectedCategory)) {
      setState(() {
        _selectedCategory = null;
        _fromUnit = null;
        _toUnit = null;
        _result = null;
      });
    }
  }

  void _initializeUseCases() {
    _repository = UnitConverterRepositoryImpl();
    _getCategoriesUseCase = GetConversionCategoriesUseCase(_repository);
    _convertUnitsUseCase = ConvertUnitsUseCase(_repository);
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final categories = await _getCategoriesUseCase();
      setState(() {
        _categories = categories;
        _filteredCategories = List.from(categories);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _onCategoryChanged(ConversionCategory? category) {
    setState(() {
      _selectedCategory = category;
      _fromUnit = category?.units.first;
      _toUnit = category?.units.length == 1 ? category?.units.first : category?.units[1];
      _result = null;
    });
    _performConversion();
  }

  void _onFromUnitChanged(ConversionUnit? unit) {
    setState(() {
      _fromUnit = unit;
      _result = null;
    });
    _performConversion();
  }

  void _onToUnitChanged(ConversionUnit? unit) {
    setState(() {
      _toUnit = unit;
      _result = null;
    });
    _performConversion();
  }

  void _onInputChanged() {
    _performConversion();
  }

  Future<void> _performConversion() async {
    if (_selectedCategory == null || 
        _fromUnit == null || 
        _toUnit == null || 
        _inputController.text.isEmpty) {
      setState(() {
        _result = null;
      });
      return;
    }

    final inputValue = double.tryParse(_inputController.text);
    if (inputValue == null) {
      setState(() {
        _result = null;
      });
      return;
    }

    try {
      final result = await _convertUnitsUseCase(
        value: inputValue,
        fromUnitId: _fromUnit!.id,
        toUnitId: _toUnit!.id,
        categoryId: _selectedCategory!.id,
      );

      setState(() {
        _result = result;
      });
    } catch (e) {
      setState(() {
        _result = null;
      });
    }
  }

  void _swapUnits() {
    if (_fromUnit != null && _toUnit != null) {
      setState(() {
        final temp = _fromUnit;
        _fromUnit = _toUnit;
        _toUnit = temp;
        _result = null;
      });
      _performConversion();
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chuyển đổi đơn vị'),
        backgroundColor: Colors.green.shade400,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? _buildErrorWidget()
              : _buildContent(),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red.shade400),
          const SizedBox(height: 16),
          Text(
            'Đã xảy ra lỗi',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              _errorMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadCategories,
            child: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildCategorySelector(),
          if (_selectedCategory != null) ...[
            const SizedBox(height: 24),
            _buildConversionSection(),
            const SizedBox(height: 24),
            _buildResultSection(),
            if (_selectedCategory != null) _buildMedicalInfoSection(),
          ],
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chọn loại xét nghiệm',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // Search bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm xét nghiệm (ví dụ: glucose, protein, hemoglobin...)',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty 
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                      },
                    )
                  : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
            const SizedBox(height: 12),
            
            // Category dropdown
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: DropdownButton<ConversionCategory>(
                value: _selectedCategory,
                hint: Text(_filteredCategories.isEmpty 
                  ? 'Không tìm thấy xét nghiệm phù hợp...'
                  : 'Chọn loại xét nghiệm...'),
                isExpanded: true,
                underline: const SizedBox(),
                selectedItemBuilder: (BuildContext context) {
                  return _filteredCategories.map((category) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList();
                },
                items: _filteredCategories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            category.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            category.commonExample,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                onChanged: _filteredCategories.isEmpty ? null : _onCategoryChanged,
              ),
            ),
            
            // Search results count and suggestions
            if (_searchQuery.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Tìm thấy ${_filteredCategories.length} kết quả',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
              if (_filteredCategories.isEmpty) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '💡 Gợi ý tìm kiếm:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Thử tìm: glucose, protein, hemoglobin, cholesterol, creatinine, bilirubin, enzyme, hormone',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ] else ...[
              const SizedBox(height: 8),
              _buildQuickSearchChips(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildConversionSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chuyển đổi',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Input section
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _inputController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Giá trị',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Từ đơn vị',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        DropdownButton<ConversionUnit>(
                          value: _fromUnit,
                          hint: const Text('Chọn đơn vị'),
                          isExpanded: true,
                          underline: const SizedBox(),
                          selectedItemBuilder: (BuildContext context) {
                            return _selectedCategory?.units.map((unit) {
                              return Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  unit.symbol,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList() ?? [];
                          },
                          items: _selectedCategory?.units.map((unit) {
                            return DropdownMenuItem(
                              value: unit,
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  unit.symbol,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: _onFromUnitChanged,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Swap button
            Center(
              child: IconButton(
                onPressed: _swapUnits,
                icon: const Icon(Icons.swap_vert),
                iconSize: 32,
                tooltip: 'Hoán đổi đơn vị',
              ),
            ),

            const SizedBox(height: 16),

            // Output section
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey.shade50,
                    ),
                    child: Text(
                      _result?.outputValue.toStringAsFixed(2) ?? '-',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Sang đơn vị',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        DropdownButton<ConversionUnit>(
                          value: _toUnit,
                          hint: const Text('Chọn đơn vị'),
                          isExpanded: true,
                          underline: const SizedBox(),
                          selectedItemBuilder: (BuildContext context) {
                            return _selectedCategory?.units.map((unit) {
                              return Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  unit.symbol,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList() ?? [];
                          },
                          items: _selectedCategory?.units.map((unit) {
                            return DropdownMenuItem(
                              value: unit,
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  unit.symbol,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: _onToUnitChanged,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSection() {
    if (_result == null) return const SizedBox.shrink();

    return Card(
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green.shade600),
                const SizedBox(width: 8),
                Text(
                  'Kết quả',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _result!.fullConversion,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Chuyển đổi từ ${_result!.fromUnit.symbol} sang ${_result!.toUnit.symbol}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            
            // Result Analysis Section
            if (_result!.resultAnalysis != null) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _getAnalysisBackgroundColor(_result!.resultAnalysis!),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _getAnalysisBorderColor(_result!.resultAnalysis!)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _getAnalysisIcon(_result!.resultAnalysis!),
                          color: _getAnalysisTextColor(_result!.resultAnalysis!),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Ý nghĩa kết quả',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: _getAnalysisTextColor(_result!.resultAnalysis!),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _result!.resultAnalysis!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: _getAnalysisTextColor(_result!.resultAnalysis!),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalInfoSection() {
    if (_selectedCategory?.normalRange == null && _selectedCategory?.clinicalSignificance == null) {
      return const SizedBox.shrink();
    }

    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.medical_information, color: Colors.blue.shade600),
                const SizedBox(width: 8),
                Text(
                  'Thông tin y tế',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Normal Range
            if (_selectedCategory?.normalRange != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.straighten, size: 20, color: Colors.blue.shade600),
                        const SizedBox(width: 8),
                        Text(
                          'Giá trị tham khảo bình thường',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _selectedCategory!.normalRange!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Clinical Significance
            if (_selectedCategory?.clinicalSignificance != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.psychology, size: 20, color: Colors.blue.shade600),
                        const SizedBox(width: 8),
                        Text(
                          'Ý nghĩa lâm sàng',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _selectedCategory!.clinicalSignificance!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Helper methods for result analysis styling
  Color _getAnalysisBackgroundColor(String analysis) {
    if (analysis.contains('🔴')) {
      return Colors.red.shade50;
    } else if (analysis.contains('🟡') || analysis.contains('🟠')) {
      return Colors.orange.shade50;
    } else if (analysis.contains('🟢')) {
      return Colors.green.shade50;
    }
    return Colors.blue.shade50;
  }

  Color _getAnalysisBorderColor(String analysis) {
    if (analysis.contains('🔴')) {
      return Colors.red.shade200;
    } else if (analysis.contains('🟡') || analysis.contains('🟠')) {
      return Colors.orange.shade200;
    } else if (analysis.contains('🟢')) {
      return Colors.green.shade200;
    }
    return Colors.blue.shade200;
  }

  Color _getAnalysisTextColor(String analysis) {
    if (analysis.contains('🔴')) {
      return Colors.red.shade700;
    } else if (analysis.contains('🟡') || analysis.contains('🟠')) {
      return Colors.orange.shade700;
    } else if (analysis.contains('🟢')) {
      return Colors.green.shade700;
    }
    return Colors.blue.shade700;
  }

  IconData _getAnalysisIcon(String analysis) {
    if (analysis.contains('🔴')) {
      return Icons.warning;
    } else if (analysis.contains('🟡') || analysis.contains('🟠')) {
      return Icons.info;
    } else if (analysis.contains('🟢')) {
      return Icons.check_circle;
    }
    return Icons.analytics;
  }

  Widget _buildQuickSearchChips() {
    final quickSearchTerms = [
      'glucose', 'protein', 'hemoglobin', 'cholesterol', 
      'creatinine', 'bilirubin', 'enzyme', 'hormone'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tìm kiếm nhanh:',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: quickSearchTerms.map((term) {
            return ActionChip(
              label: Text(
                term,
                style: const TextStyle(fontSize: 11),
              ),
              onPressed: () {
                _searchController.text = term;
              },
              backgroundColor: Colors.green.shade50,
              side: BorderSide(color: Colors.green.shade200),
              labelStyle: TextStyle(color: Colors.green.shade700),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            );
          }).toList(),
        ),
      ],
    );
  }
}
