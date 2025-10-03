import 'package:flutter_test/flutter_test.dart';
import 'package:dr_icu/features/lab_analysis/domain/entities/pleural_fluid_result.dart';

void main() {
  group('Pleural Fluid Analysis Tests', () {
    test('Transudate should be classified correctly', () {
      final transudate = PleuralFluidResult(
        protein: 2.5, // Low protein
        ldh: 100,     // Low LDH
        glucose: 80,
        ph: 7.45,
        cellCount: 500,
        neutrophils: 20,
        lymphocytes: 70,
        cholesterol: 45,
        triglycerides: 20,
        appearance: PleuralFluidAppearance.clear,
        timestamp: DateTime.now(),
        serumProtein: 7.0,  // Normal serum protein
        serumLdh: 200,      // Normal serum LDH
        serumGlucose: 100,
      );

      expect(transudate.fluidType, PleuralFluidType.transudate);
      expect(transudate.isExudateByProtein, false); // 2.5/7.0 = 0.36 < 0.5
      expect(transudate.isExudateByLdh, false);     // 100/200 = 0.5 < 0.6
      expect(transudate.likelyCauses, contains(PleuralFluidCause.heartFailure));
    });

    test('Exudate should be classified correctly', () {
      final exudate = PleuralFluidResult(
        protein: 4.0, // High protein
        ldh: 400,     // High LDH
        glucose: 60,
        ph: 7.35,
        cellCount: 2000,
        neutrophils: 60,
        lymphocytes: 30,
        cholesterol: 65,
        triglycerides: 25,
        appearance: PleuralFluidAppearance.turbid,
        timestamp: DateTime.now(),
        serumProtein: 7.0,
        serumLdh: 200,
        serumGlucose: 100,
      );

      expect(exudate.fluidType, PleuralFluidType.exudate);
      expect(exudate.isExudateByProtein, true);  // 4.0/7.0 = 0.57 > 0.5
      expect(exudate.isExudateByLdh, true);      // 400/200 = 2.0 > 0.6
      expect(exudate.likelyCauses, contains(PleuralFluidCause.pneumonia));
    });

    test('Empyema should be detected correctly', () {
      final empyema = PleuralFluidResult(
        protein: 5.0,
        ldh: 1200,    // Very high LDH
        glucose: 40,  // Very low glucose
        ph: 7.20,     // Low pH
        cellCount: 50000,
        neutrophils: 90,  // High neutrophils
        lymphocytes: 10,
        cholesterol: 70,
        triglycerides: 30,
        appearance: PleuralFluidAppearance.purulent,
        timestamp: DateTime.now(),
        serumProtein: 7.0,
        serumLdh: 200,
        serumGlucose: 100,
      );

      expect(empyema.suggestsEmpyema, true);
      expect(empyema.likelyCauses, contains(PleuralFluidCause.empyema));
    });

    test('Tuberculosis pattern should be identified', () {
      final tuberculosis = PleuralFluidResult(
        protein: 4.5,     // High protein
        ldh: 300,
        glucose: 40,      // Low glucose (glucose ratio < 0.5)
        ph: 7.40,
        cellCount: 3000,
        neutrophils: 20,  // Low neutrophils
        lymphocytes: 80,  // High lymphocytes
        cholesterol: 60,
        triglycerides: 25,
        appearance: PleuralFluidAppearance.clear,
        timestamp: DateTime.now(),
        serumProtein: 7.0,
        serumLdh: 200,
        serumGlucose: 100, // Glucose ratio = 40/100 = 0.4
      );

      expect(tuberculosis.suggestsTuberculosis, true);
      expect(tuberculosis.glucoseRatio, lessThan(0.5));
      expect(tuberculosis.likelyCauses, contains(PleuralFluidCause.tuberculosis));
    });

    test('Malignancy pattern should be identified', () {
      final malignancy = PleuralFluidResult(
        protein: 4.2,
        ldh: 350,
        glucose: 70,
        ph: 7.40,
        cellCount: 5000,
        neutrophils: 25,
        lymphocytes: 75,  // High lymphocytes
        cholesterol: 55,
        triglycerides: 20,
        appearance: PleuralFluidAppearance.bloody, // Bloody appearance
        timestamp: DateTime.now(),
        serumProtein: 7.0,
        serumLdh: 200,
        serumGlucose: 100,
      );

      expect(malignancy.suggestsMalignancy, true);
      expect(malignancy.likelyCauses, contains(PleuralFluidCause.malignancy));
    });

    test('Chylothorax should be detected', () {
      final chylothorax = PleuralFluidResult(
        protein: 3.5,
        ldh: 250,
        glucose: 80,
        ph: 7.42,
        cellCount: 1500,
        neutrophils: 10,
        lymphocytes: 90,
        cholesterol: 80,
        triglycerides: 150, // High triglycerides (>110)
        appearance: PleuralFluidAppearance.milky,
        timestamp: DateTime.now(),
        serumProtein: 7.0,
        serumLdh: 200,
        serumGlucose: 100,
      );

      expect(chylothorax.suggestsChylothorax, true);
      expect(chylothorax.triglycerides, greaterThan(110));
    });

    test('Pseudochylothorax should be detected', () {
      final pseudochylothorax = PleuralFluidResult(
        protein: 4.0,
        ldh: 300,
        glucose: 70,
        ph: 7.38,
        cellCount: 2000,
        neutrophils: 30,
        lymphocytes: 70,
        cholesterol: 250, // High cholesterol > triglycerides and > 200
        triglycerides: 80,
        appearance: PleuralFluidAppearance.milky,
        timestamp: DateTime.now(),
        serumProtein: 7.0,
        serumLdh: 200,
        serumGlucose: 100,
      );

      expect(pseudochylothorax.suggestsPseudochylothorax, true);
      expect(pseudochylothorax.cholesterol, greaterThan(pseudochylothorax.triglycerides));
      expect(pseudochylothorax.cholesterol, greaterThan(200));
    });

    test('Rheumatoid arthritis pattern should be identified', () {
      final rheumatoid = PleuralFluidResult(
        protein: 4.5,
        ldh: 400,
        glucose: 25,      // Very low glucose
        ph: 7.25,         // Low pH
        cellCount: 3000,
        neutrophils: 40,
        lymphocytes: 60,
        cholesterol: 70,  // High cholesterol
        triglycerides: 30,
        appearance: PleuralFluidAppearance.turbid,
        timestamp: DateTime.now(),
        serumProtein: 7.0,
        serumLdh: 200,
        serumGlucose: 100,
      );

      expect(rheumatoid.suggestsRheumatoid, true);
      expect(rheumatoid.likelyCauses, contains(PleuralFluidCause.rheumatoid));
    });

    test('Light\'s criteria ratios should be calculated correctly', () {
      final result = PleuralFluidResult(
        protein: 3.5,
        ldh: 150,
        glucose: 80,
        ph: 7.40,
        cellCount: 1000,
        neutrophils: 50,
        lymphocytes: 50,
        cholesterol: 50,
        triglycerides: 30,
        appearance: PleuralFluidAppearance.clear,
        timestamp: DateTime.now(),
        serumProtein: 7.0,
        serumLdh: 200,
        serumGlucose: 100,
      );

      // Protein ratio = 3.5/7.0 = 0.5
      expect((result.protein / result.serumProtein), equals(0.5));
      
      // LDH ratio = 150/200 = 0.75
      expect((result.ldh / result.serumLdh), equals(0.75));
      
      // Glucose ratio = 80/100 = 0.8
      expect(result.glucoseRatio, equals(0.8));
    });

    test('JSON serialization should work correctly', () {
      final result = PleuralFluidResult(
        protein: 3.5,
        ldh: 250,
        glucose: 80,
        ph: 7.40,
        cellCount: 1500,
        neutrophils: 60,
        lymphocytes: 40,
        cholesterol: 60,
        triglycerides: 40,
        appearance: PleuralFluidAppearance.turbid,
        timestamp: DateTime.parse('2023-01-01T12:00:00Z'),
        serumProtein: 7.0,
        serumLdh: 200,
        serumGlucose: 100,
        notes: 'Test pleural fluid',
      );

      final json = result.toJson();
      final reconstructed = PleuralFluidResult.fromJson(json);

      expect(reconstructed.protein, equals(result.protein));
      expect(reconstructed.ldh, equals(result.ldh));
      expect(reconstructed.appearance, equals(result.appearance));
      expect(reconstructed.notes, equals(result.notes));
    });
  });
}
