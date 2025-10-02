import 'conversion_unit.dart';

class ConversionResult {
  final String categoryId;
  final double inputValue;
  final ConversionUnit fromUnit;
  final ConversionUnit toUnit;
  final double outputValue;
  final String? formula;
  final DateTime? timestamp;
  final String? resultAnalysis; // Thêm phân tích ý nghĩa kết quả

  const ConversionResult({
    required this.categoryId,
    required this.inputValue,
    required this.fromUnit,
    required this.toUnit,
    required this.outputValue,
    this.formula,
    this.timestamp,
    this.resultAnalysis,
  });

  /// Get formatted input string
  String get formattedInput => '$inputValue ${fromUnit.symbol}';

  /// Get formatted output string
  String get formattedOutput => '${outputValue.toStringAsFixed(2)} ${toUnit.symbol}';

  /// Get full conversion string
  String get fullConversion => '$formattedInput = $formattedOutput';

  /// Check if conversion is valid (no NaN or infinite values)
  bool get isValid => 
      !inputValue.isNaN && 
      !inputValue.isInfinite && 
      !outputValue.isNaN && 
      !outputValue.isInfinite;

  @override
  String toString() => fullConversion;
}
