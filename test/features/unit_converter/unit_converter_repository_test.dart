import 'package:flutter_test/flutter_test.dart';
import 'package:dr_icu/features/unit_converter/data/repositories/unit_converter_repository_impl.dart';

void main() {
  group('UnitConverterRepositoryImpl', () {
    late UnitConverterRepositoryImpl repository;

    setUp(() {
      repository = UnitConverterRepositoryImpl();
    });

    test('should convert cholesterol correctly', () async {
      // Test: 200 mg/dL = 5.17 mmol/L
      final result = await repository.convertUnits(
        categoryId: 'cholesterol',
        fromUnitId: 'chol_mgdl',
        toUnitId: 'chol_mmoll',
        inputValue: 200.0,
      );

      expect(result.outputValue, closeTo(5.17, 0.01));
    });

    test('should convert cholesterol reverse correctly', () async {
      // Test: 5.2 mmol/L = 200.77 mg/dL (using correct conversion factor)
      final result = await repository.convertUnits(
        categoryId: 'cholesterol',
        fromUnitId: 'chol_mmoll',
        toUnitId: 'chol_mgdl',
        inputValue: 5.2,
      );

      expect(result.outputValue, closeTo(200.77, 0.5));
    });

    test('should convert glucose correctly', () async {
      // Test: 100 mg/dL = 5.55 mmol/L
      final result = await repository.convertUnits(
        categoryId: 'glucose',
        fromUnitId: 'glucose_mgdl',
        toUnitId: 'glucose_mmoll',
        inputValue: 100.0,
      );

      expect(result.outputValue, closeTo(5.55, 0.01));
    });
  });
}
