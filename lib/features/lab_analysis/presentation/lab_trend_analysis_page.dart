import 'package:flutter/material.dart';
import '../domain/entities/lab_test.dart';
import '../data/repositories/lab_analysis_repository_impl.dart';

class LabTrendAnalysisPage extends StatefulWidget {
  const LabTrendAnalysisPage({super.key});

  @override
  State<LabTrendAnalysisPage> createState() => _LabTrendAnalysisPageState();
}

class _LabTrendAnalysisPageState extends State<LabTrendAnalysisPage> {
  final _repository = LabAnalysisRepositoryImpl();
  
  LabTest? _selectedTest;
  final List<LabTestEntry> _testEntries = [];
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phân tích xu hướng'),
        backgroundColor: Colors.teal.shade600,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (_testEntries.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _clearAll,
              tooltip: 'Xóa tất cả',
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Test Selection Section
            _buildTestSelectionSection(),
            
            // Data Entry Section
            if (_selectedTest != null) _buildDataEntrySection(),
            
            // Simple Analysis Results
            if (_testEntries.length >= 2) _buildSimpleAnalysisSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTestSelectionSection() {
    final availableTests = _repository.getAllAvailableTests();
    final filteredTests = _searchQuery.isEmpty 
        ? availableTests
        : availableTests.where((test) =>
            test.displayName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            test.name.toLowerCase().contains(_searchQuery.toLowerCase())
          ).toList();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chọn xét nghiệm để theo dõi',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          // Search field
          TextField(
            decoration: InputDecoration(
              hintText: 'Tìm kiếm xét nghiệm...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          
          const SizedBox(height: 16),
          
          // Test list
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              itemCount: filteredTests.length,
              itemBuilder: (context, index) {
                final test = filteredTests[index];
                final isSelected = _selectedTest?.id == test.id;
                
                return ListTile(
                  title: Text(
                    test.displayName,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.teal.shade700 : null,
                    ),
                  ),
                  subtitle: Text(
                    '${test.category} • Đơn vị: ${test.unit}',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  trailing: isSelected 
                    ? Icon(Icons.check_circle, color: Colors.teal.shade600)
                    : null,
                  selected: isSelected,
                  selectedTileColor: Colors.teal.shade50,
                  onTap: () {
                    setState(() {
                      _selectedTest = test;
                      _testEntries.clear();
                    });
                  },
                );
              },
            ),
          ),
          
          if (_selectedTest != null) ...[
            const SizedBox(height: 16),
            _buildSelectedTestInfo(),
          ],
        ],
      ),
    );
  }

  Widget _buildSelectedTestInfo() {
    if (_selectedTest == null) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _selectedTest!.displayName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Giá trị bình thường: ${_selectedTest!.normalRange}',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataEntrySection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Nhập dữ liệu theo thời gian',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Thêm'),
                onPressed: _addNewEntry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Existing entries
          if (_testEntries.isNotEmpty) ...[
            Text(
              'Dữ liệu đã nhập (${_testEntries.length} mẫu):',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),
            
            ..._testEntries.asMap().entries.map((entry) {
              final index = entry.key;
              final testEntry = entry.value;
              
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        '${testEntry.date.day}/${testEntry.date.month}/${testEntry.date.year}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${testEntry.value} ${_selectedTest!.unit}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _getValueColor(testEntry.value),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outline, 
                        color: Colors.red.shade400, size: 20),
                      onPressed: () => _removeEntry(index),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    ),
                  ],
                ),
              );
            }),
          ] else ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Chưa có dữ liệu. Nhấn "Thêm" để bắt đầu.',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSimpleAnalysisSection() {
    if (_testEntries.length < 2) return const SizedBox.shrink();
    
    final sortedEntries = List<LabTestEntry>.from(_testEntries)
      ..sort((a, b) => a.date.compareTo(b.date));
    
    final firstValue = sortedEntries.first.value;
    final lastValue = sortedEntries.last.value;
    final changePercentage = ((lastValue - firstValue) / firstValue) * 100;
    
    String trend = 'Ổn định';
    Color trendColor = Colors.blue.shade600;
    IconData trendIcon = Icons.trending_flat;
    
    if (changePercentage.abs() > 5) {
      if (changePercentage > 0) {
        trend = 'Tăng';
        trendColor = Colors.red.shade600;
        trendIcon = Icons.trending_up;
      } else {
        trend = 'Giảm';
        trendColor = Colors.green.shade600;
        trendIcon = Icons.trending_down;
      }
    }
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: trendColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: trendColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(trendIcon, color: trendColor, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Phân tích xu hướng đơn giản',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: trendColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: trendColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  trend,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Giá trị đầu',
                  '$firstValue ${_selectedTest!.unit}',
                  Icons.start,
                  Colors.blue.shade600,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Giá trị cuối',
                  '$lastValue ${_selectedTest!.unit}',
                  Icons.flag,
                  Colors.green.shade600,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Thay đổi',
                  '${changePercentage > 0 ? '+' : ''}${changePercentage.toStringAsFixed(1)}%',
                  changePercentage > 0 ? Icons.trending_up : Icons.trending_down,
                  changePercentage > 0 ? Colors.red.shade600 : Colors.green.shade600,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Số điểm dữ liệu',
                  '${_testEntries.length}',
                  Icons.data_array,
                  Colors.purple.shade600,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _getSimpleInterpretation(changePercentage, trend),
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Helper methods
  void _addNewEntry() {
    showDialog(
      context: context,
      builder: (context) => _AddEntryDialog(
        testName: _selectedTest!.displayName,
        unit: _selectedTest!.unit,
        onAdd: (date, value) {
          setState(() {
            _testEntries.add(LabTestEntry(date: date, value: value));
            _testEntries.sort((a, b) => a.date.compareTo(b.date));
          });
        },
      ),
    );
  }

  void _removeEntry(int index) {
    setState(() {
      _testEntries.removeAt(index);
    });
  }

  void _clearAll() {
    setState(() {
      _selectedTest = null;
      _testEntries.clear();
      _searchQuery = '';
    });
  }

  Color _getValueColor(double value) {
    if (_selectedTest == null) return Colors.black;
    
    final test = _selectedTest!;
    // Determine severity based on value and normal range
    LabSeverity severity;
    if (value >= test.normalMin && value <= test.normalMax) {
      severity = LabSeverity.normal;
    } else if (value < test.normalMin * 0.8 || value > test.normalMax * 1.2) {
      severity = LabSeverity.critical;
    } else if (value < test.normalMin * 0.9 || value > test.normalMax * 1.1) {
      severity = LabSeverity.moderate;
    } else {
      severity = LabSeverity.borderline;
    }
    
    switch (severity) {
      case LabSeverity.critical:
      case LabSeverity.severe:
        return Colors.red.shade600;
      case LabSeverity.moderate:
      case LabSeverity.mild:
        return Colors.orange.shade600;
      case LabSeverity.borderline:
        return Colors.yellow.shade700;
      case LabSeverity.normal:
        return Colors.green.shade600;
    }
  }

  String _getSimpleInterpretation(double changePercentage, String trend) {
    if (_selectedTest == null) return '';
    
    final testName = _selectedTest!.displayName;
    
    if (changePercentage.abs() < 5) {
      return 'Giá trị $testName tương đối ổn định trong khoảng thời gian theo dõi với biến động nhỏ hơn 5%.';
    } else if (changePercentage > 0) {
      return 'Giá trị $testName có xu hướng tăng ${changePercentage.toStringAsFixed(1)}% so với lần đo đầu tiên. Nên theo dõi và tham khảo ý kiến bác sĩ.';
    } else {
      return 'Giá trị $testName có xu hướng giảm ${changePercentage.abs().toStringAsFixed(1)}% so với lần đo đầu tiên. Điều này có thể là dấu hiệu tích cực tùy theo ngữ cảnh lâm sàng.';
    }
  }
}

// Data classes
class LabTestEntry {
  final DateTime date;
  final double value;

  LabTestEntry({required this.date, required this.value});
}

// Dialog for adding new entry
class _AddEntryDialog extends StatefulWidget {
  final String testName;
  final String unit;
  final Function(DateTime, double) onAdd;

  const _AddEntryDialog({
    required this.testName,
    required this.unit,
    required this.onAdd,
  });

  @override
  State<_AddEntryDialog> createState() => _AddEntryDialogState();
}

class _AddEntryDialogState extends State<_AddEntryDialog> {
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thêm kết quả ${widget.testName}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Date picker
          ListTile(
            title: const Text('Ngày xét nghiệm'),
            subtitle: Text(
              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
            ),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                setState(() {
                  _selectedDate = date;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          // Value input
          TextField(
            controller: _valueController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Giá trị',
              suffixText: widget.unit,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () {
            final value = double.tryParse(_valueController.text);
            if (value != null) {
              widget.onAdd(_selectedDate, value);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Thêm'),
        ),
      ],
    );
  }
}
