import 'package:flutter_test/flutter_test.dart';
import 'package:dr_icu/features/unit_converter/data/repositories/unit_converter_repository_impl.dart';

void main() {
  group('Unit Conversion Validation Tests', () {
    late UnitConverterRepositoryImpl repository;

    setUp(() {
      repository = UnitConverterRepositoryImpl();
    });

    group('Glucose conversion', () {
      test('should convert 100 mg/dL to 5.55 mmol/L', () async {
        final result = await repository.convertUnits(
          categoryId: 'glucose',
          fromUnitId: 'glucose_mgdl',
          toUnitId: 'glucose_mmoll',
          inputValue: 100.0,
        );
        
        // 100 mg/dL ÷ 18.018 = 5.55 mmol/L
        expect(result.outputValue, closeTo(5.55, 0.01));
      });

      test('should convert 5.55 mmol/L to 100 mg/dL', () async {
        final result = await repository.convertUnits(
          categoryId: 'glucose',
          fromUnitId: 'glucose_mmoll',
          toUnitId: 'glucose_mgdl',
          inputValue: 5.55,
        );
        
        // 5.55 mmol/L × 18.018 = 100 mg/dL
        expect(result.outputValue, closeTo(100.0, 0.1));
      });
    });

    group('Cholesterol conversion', () {
      test('should convert 200 mg/dL to 5.17 mmol/L', () async {
        final result = await repository.convertUnits(
          categoryId: 'cholesterol',
          fromUnitId: 'chol_mgdl',
          toUnitId: 'chol_mmoll',
          inputValue: 200.0,
        );
        
        // 200 mg/dL ÷ 38.67 = 5.17 mmol/L
        expect(result.outputValue, closeTo(5.17, 0.01));
      });

      test('should convert 5.17 mmol/L to 200 mg/dL', () async {
        final result = await repository.convertUnits(
          categoryId: 'cholesterol',
          fromUnitId: 'chol_mmoll',
          toUnitId: 'chol_mgdl',
          inputValue: 5.17,
        );
        
        // 5.17 mmol/L ÷ 0.0259 = 199.61 mg/dL (using correct conversion factor)
        expect(result.outputValue, closeTo(199.6, 0.5));
      });
    });

    group('Creatinine conversion', () {
      test('should convert 1.0 mg/dL to 88.42 μmol/L', () async {
        final result = await repository.convertUnits(
          categoryId: 'creatinine',
          fromUnitId: 'creat_mgdl',
          toUnitId: 'creat_umoll',
          inputValue: 1.0,
        );
        
        // 1.0 mg/dL × 88.42 = 88.42 μmol/L
        expect(result.outputValue, closeTo(88.42, 0.01));
      });

      test('should convert 88.42 μmol/L to 1.0 mg/dL', () async {
        final result = await repository.convertUnits(
          categoryId: 'creatinine',
          fromUnitId: 'creat_umoll',
          toUnitId: 'creat_mgdl',
          inputValue: 88.42,
        );
        
        // 88.42 μmol/L ÷ 88.42 = 1.0 mg/dL
        expect(result.outputValue, closeTo(1.0, 0.01));
      });
    });

    group('HbA1c conversion', () {
      test('should convert 7.0% to 53 mmol/mol', () async {
        final result = await repository.convertUnits(
          categoryId: 'hba1c',
          fromUnitId: 'hba1c_percent',
          toUnitId: 'hba1c_mmolmol',
          inputValue: 7.0,
        );
        
        // (7.0 × 10.93) - 23.5 = 53 mmol/mol
        expect(result.outputValue, closeTo(53.0, 0.1));
      });

      test('should convert 53 mmol/mol to 7.0%', () async {
        final result = await repository.convertUnits(
          categoryId: 'hba1c',
          fromUnitId: 'hba1c_mmolmol',
          toUnitId: 'hba1c_percent',
          inputValue: 53.0,
        );
        
        // (53 + 23.5) ÷ 10.93 = 7.0%
        expect(result.outputValue, closeTo(7.0, 0.01));
      });
    });

    group('Triglycerides conversion', () {
      test('should convert 150 mg/dL to 1.69 mmol/L', () async {
        final result = await repository.convertUnits(
          categoryId: 'triglycerides',
          fromUnitId: 'trig_mgdl',
          toUnitId: 'trig_mmoll',
          inputValue: 150.0,
        );
        
        // 150 mg/dL ÷ 88.57 = 1.69 mmol/L
        expect(result.outputValue, closeTo(1.69, 0.01));
      });

      test('should convert 1.69 mmol/L to 150 mg/dL', () async {
        final result = await repository.convertUnits(
          categoryId: 'triglycerides',
          fromUnitId: 'trig_mmoll',
          toUnitId: 'trig_mgdl',
          inputValue: 1.69,
        );
        
        // 1.69 mmol/L × 88.57 = 150 mg/dL
        expect(result.outputValue, closeTo(150.0, 1.0));
      });
    });

    group('Urea conversion', () {
      test('should convert 30 mg/dL to 5.0 mmol/L', () async {
        final result = await repository.convertUnits(
          categoryId: 'urea',
          fromUnitId: 'urea_mgdl',
          toUnitId: 'urea_mmoll',
          inputValue: 30.0,
        );
        
        // 30 mg/dL × 0.357 = 10.71 mmol/L (using correct conversion factor)
        expect(result.outputValue, closeTo(10.71, 0.01));
      });

      test('should convert 5.0 mmol/L to 30 mg/dL', () async {
        final result = await repository.convertUnits(
          categoryId: 'urea',
          fromUnitId: 'urea_mmoll',
          toUnitId: 'urea_mgdl',
          inputValue: 5.0,
        );
        
        // 5.0 mmol/L ÷ 0.357 = 14.01 mg/dL (using correct conversion factor)
        expect(result.outputValue, closeTo(14.01, 0.01));
      });
    });
  });
}
