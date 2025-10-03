import 'package:flutter_test/flutter_test.dart';
import 'package:dr_icu/features/lab_analysis/domain/entities/abg_result.dart';

void main() {
  group('ABG Analysis Tests', () {
    test('Normal ABG should be interpreted correctly', () {
      final normalABG = ABGResult(
        ph: 7.40,
        pco2: 40.0,
        po2: 90.0,
        hco3: 24.0,
        baseExcess: 0.0,
        sao2: 98.0,
        fio2: 0.21,
        timestamp: DateTime.now(),
      );

      expect(normalABG.acidBaseInterpretation, ABGInterpretation.normal);
      expect(normalABG.oxygenationStatus, OxygenationStatus.normal);
      expect(normalABG.pfRatio, closeTo(428.6, 1.0));
    });

    test('Respiratory acidosis should be interpreted correctly', () {
      final respiratoryAcidosis = ABGResult(
        ph: 7.25,
        pco2: 60.0,
        po2: 85.0,
        hco3: 24.0,
        baseExcess: 0.0,
        sao2: 96.0,
        fio2: 0.21,
        timestamp: DateTime.now(),
      );

      expect(respiratoryAcidosis.acidBaseInterpretation, 
             ABGInterpretation.respiratoryAcidosis);
    });

    test('Metabolic acidosis should be interpreted correctly', () {
      final metabolicAcidosis = ABGResult(
        ph: 7.25,
        pco2: 30.0,
        po2: 90.0,
        hco3: 15.0,
        baseExcess: -8.0,
        sao2: 98.0,
        fio2: 0.21,
        timestamp: DateTime.now(),
      );

      expect(metabolicAcidosis.acidBaseInterpretation, 
             ABGInterpretation.compensatedMetabolicAcidosis);
    });

    test('Severe hypoxemia should be detected', () {
      final severeHypoxemia = ABGResult(
        ph: 7.40,
        pco2: 40.0,
        po2: 35.0, // Severe hypoxemia
        hco3: 24.0,
        baseExcess: 0.0,
        sao2: 70.0,
        fio2: 0.21,
        timestamp: DateTime.now(),
      );

      expect(severeHypoxemia.oxygenationStatus, 
             OxygenationStatus.severeHypoxemia);
    });

    test('P/F ratio calculation should be accurate', () {
      final abg = ABGResult(
        ph: 7.40,
        pco2: 40.0,
        po2: 150.0,
        hco3: 24.0,
        baseExcess: 0.0,
        sao2: 98.0,
        fio2: 0.5, // 50% oxygen
        timestamp: DateTime.now(),
      );

      expect(abg.pfRatio, equals(300.0)); // 150/0.5 = 300
    });

    test('Winter\'s formula for metabolic acidosis compensation', () {
      final metabolicAcidosis = ABGResult(
        ph: 7.30,
        pco2: 25.0,
        po2: 90.0,
        hco3: 15.0,
        baseExcess: -8.0,
        sao2: 98.0,
        fio2: 0.21,
        timestamp: DateTime.now(),
      );

      // Winter's formula: Expected PCO2 = 1.5 × [HCO3] + 8
      // 1.5 × 15 + 8 = 30.5
      expect(metabolicAcidosis.expectedPco2ForMetabolicCompensation, 
             closeTo(30.5, 1.0));
    });

    test('JSON serialization should work correctly', () {
      final abg = ABGResult(
        ph: 7.40,
        pco2: 40.0,
        po2: 90.0,
        hco3: 24.0,
        baseExcess: 0.0,
        sao2: 98.0,
        fio2: 0.21,
        timestamp: DateTime.parse('2023-01-01T12:00:00Z'),
        notes: 'Test ABG',
      );

      final json = abg.toJson();
      final reconstructed = ABGResult.fromJson(json);

      expect(reconstructed.ph, equals(abg.ph));
      expect(reconstructed.pco2, equals(abg.pco2));
      expect(reconstructed.po2, equals(abg.po2));
      expect(reconstructed.hco3, equals(abg.hco3));
      expect(reconstructed.notes, equals(abg.notes));
    });
  });
}
