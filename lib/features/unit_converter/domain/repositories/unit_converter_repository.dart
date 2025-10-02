import '../entities/conversion_category.dart';
import '../entities/conversion_result.dart';
import '../entities/conversion_unit.dart';

abstract class UnitConverterRepository {
  /// Get all available conversion categories
  Future<List<ConversionCategory>> getCategories();

  /// Get units in a specific category
  Future<List<ConversionUnit>> getUnitsInCategory(String categoryId);

  /// Convert value from one unit to another
  Future<ConversionResult> convertUnits({
    required String categoryId,
    required String fromUnitId,
    required String toUnitId,
    required double inputValue,
  });
}
