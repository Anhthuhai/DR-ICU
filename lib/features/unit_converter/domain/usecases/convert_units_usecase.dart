import '../entities/conversion_result.dart';
import '../repositories/unit_converter_repository.dart';

class ConvertUnitsUseCase {
  final UnitConverterRepository repository;

  const ConvertUnitsUseCase(this.repository);

  Future<ConversionResult> call({
    required double value,
    required String fromUnitId,
    required String toUnitId,
    required String categoryId,
  }) async {
    try {
      // Validate input
      if (value.isNaN || value.isInfinite) {
        throw Exception('Invalid input value');
      }

      if (value < 0) {
        throw Exception('Value cannot be negative');
      }

      final result = await repository.convertUnits(
        categoryId: categoryId,
        fromUnitId: fromUnitId,
        toUnitId: toUnitId,
        inputValue: value,
      );

      return result;
    } catch (e) {
      throw Exception('Failed to convert units: $e');
    }
  }
}
