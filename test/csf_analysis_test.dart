import 'package:flutter_test/flutter_test.dart';
import 'package:dr_icu/features/lab_analysis/domain/entities/csf_result.dart';

void main() {
  group('CSF Analysis Tests', () {
    test('Normal CSF', () {
      final result = CsfResult(
        protein: 30.0,
        glucose: 60.0,
        cellCount: 2,
        neutrophils: 0,
        lymphocytes: 2,
        redBloodCells: 0,
        pressure: 120.0,
        appearance: CsfAppearance.clear,
        timestamp: DateTime.now(),
        serumGlucose: 90.0,
      );

      expect(result.csfType, CsfType.normal);
      expect(result.glucoseRatio, closeTo(0.67, 0.01));
      expect(result.riskLevel, 'Thấp');
      expect(result.likelyCauses, contains(CsfCause.normal));
    });

    test('Bacterial Meningitis', () {
      final result = CsfResult(
        protein: 500.0,
        glucose: 20.0,
        cellCount: 2000,
        neutrophils: 1800,
        lymphocytes: 200,
        redBloodCells: 5,
        pressure: 350.0,
        appearance: CsfAppearance.turbid,
        timestamp: DateTime.now(),
        serumGlucose: 100.0,
        lactate: 4.2, // High lactate confirms bacterial
      );

      expect(result.csfType, CsfType.bacterial);
      expect(result.glucoseRatio, closeTo(0.20, 0.01));
      expect(result.riskLevel, 'Cấp cứu');
      expect(result.hasHighLactate, true);
      expect(result.likelyCauses, contains(CsfCause.bacterialMeningitis));
    });

    test('Viral Meningitis', () {
      final result = CsfResult(
        protein: 80.0,
        glucose: 50.0,
        cellCount: 100,
        neutrophils: 10,
        lymphocytes: 90,
        redBloodCells: 2,
        pressure: 200.0,
        appearance: CsfAppearance.clear,
        timestamp: DateTime.now(),
        serumGlucose: 90.0,
        lactate: 2.8, // Normal lactate supports viral
      );

      expect(result.csfType, CsfType.viral);
      expect(result.glucoseRatio, closeTo(0.56, 0.01));
      expect(result.riskLevel, 'Trung bình');
      expect(result.hasNormalLactate, false); // 2.8 is elevated but not high
      expect(result.likelyCauses, contains(CsfCause.viralMeningitis));
    });

    test('Tuberculous Meningitis', () {
      final result = CsfResult(
        protein: 200.0,
        glucose: 30.0,
        cellCount: 300,
        neutrophils: 30,
        lymphocytes: 270,
        redBloodCells: 5,
        pressure: 300.0,
        appearance: CsfAppearance.clear,
        timestamp: DateTime.now(),
        serumGlucose: 100.0,
      );

      expect(result.csfType, CsfType.tuberculous);
      expect(result.glucoseRatio, closeTo(0.30, 0.01));
      expect(result.riskLevel, 'Cao');
      expect(result.likelyCauses, contains(CsfCause.tuberculousMeningitis));
    });

    test('Fungal Meningitis', () {
      final result = CsfResult(
        protein: 150.0,
        glucose: 25.0,
        cellCount: 200,
        neutrophils: 30,
        lymphocytes: 170,
        redBloodCells: 3,
        pressure: 250.0,
        appearance: CsfAppearance.clear,
        timestamp: DateTime.now(),
        serumGlucose: 90.0,
      );

      expect(result.csfType, CsfType.fungal);
      expect(result.glucoseRatio, closeTo(0.28, 0.01));
      expect(result.riskLevel, 'Trung bình'); // Fungal meningitis is medium risk
      expect(result.likelyCauses, contains(CsfCause.fungalMeningitis));
    });

    test('Subarachnoid Hemorrhage', () {
      final result = CsfResult(
        protein: 100.0,
        glucose: 65.0,
        cellCount: 500,
        neutrophils: 50,
        lymphocytes: 50,
        redBloodCells: 10000,
        pressure: 400.0,
        appearance: CsfAppearance.bloody,
        timestamp: DateTime.now(),
        serumGlucose: 90.0,
      );

      expect(result.csfType, CsfType.hemorrhagic);
      expect(result.riskLevel, 'Cấp cứu');
      expect(result.likelyCauses, contains(CsfCause.subarachnoidHemorrhage));
    });

    test('Traumatic Tap', () {
      final result = CsfResult(
        protein: 60.0,
        glucose: 55.0,
        cellCount: 50,
        neutrophils: 5,
        lymphocytes: 10,
        redBloodCells: 800,
        pressure: 150.0,
        appearance: CsfAppearance.bloody,
        timestamp: DateTime.now(),
        serumGlucose: 90.0,
      );

      expect(result.csfType, CsfType.traumatic);
      expect(result.riskLevel, 'Thấp');
      expect(result.likelyCauses, contains(CsfCause.traumaticTap));
    });

    test('Malignant Meningitis', () {
      final result = CsfResult(
        protein: 300.0,
        glucose: 20.0,
        cellCount: 150,
        neutrophils: 15,
        lymphocytes: 135,
        redBloodCells: 10,
        pressure: 280.0,
        appearance: CsfAppearance.clear,
        timestamp: DateTime.now(),
        serumGlucose: 100.0,
      );

      expect(result.csfType, CsfType.malignant);
      expect(result.glucoseRatio, closeTo(0.20, 0.01));
      expect(result.riskLevel, 'Cao');
      expect(result.likelyCauses, contains(CsfCause.malignantMeningitis));
    });

    test('High Pressure - Increased ICP', () {
      final result = CsfResult(
        protein: 50.0,
        glucose: 60.0,
        cellCount: 5,
        neutrophils: 1,
        lymphocytes: 4,
        redBloodCells: 0,
        pressure: 400.0,
        appearance: CsfAppearance.clear,
        timestamp: DateTime.now(),
        serumGlucose: 90.0,
      );

      expect(result.pressure, greaterThan(300));
      expect(result.riskLevel, 'Cấp cứu');
    });

    test('Xanthochromic CSF', () {
      final result = CsfResult(
        protein: 120.0,
        glucose: 45.0,
        cellCount: 20,
        neutrophils: 2,
        lymphocytes: 18,
        redBloodCells: 2000,
        pressure: 250.0,
        appearance: CsfAppearance.xanthochromic,
        timestamp: DateTime.now(),
        serumGlucose: 90.0,
      );

      expect(result.appearance, CsfAppearance.xanthochromic);
      expect(result.csfType, CsfType.hemorrhagic);
    });

    test('Purulent CSF', () {
      final result = CsfResult(
        protein: 600.0,
        glucose: 15.0,
        cellCount: 5000,
        neutrophils: 4800,
        lymphocytes: 200,
        redBloodCells: 20,
        pressure: 400.0,
        appearance: CsfAppearance.purulent,
        timestamp: DateTime.now(),
        serumGlucose: 100.0,
      );

      expect(result.appearance, CsfAppearance.purulent);
      expect(result.csfType, CsfType.bacterial);
      expect(result.riskLevel, 'Cấp cứu');
    });

    test('Edge case - Very high cell count', () {
      final result = CsfResult(
        protein: 800.0,
        glucose: 10.0,
        cellCount: 10000,
        neutrophils: 9500,
        lymphocytes: 500,
        redBloodCells: 50,
        pressure: 500.0,
        appearance: CsfAppearance.purulent,
        timestamp: DateTime.now(),
        serumGlucose: 120.0,
      );

      expect(result.cellCount, greaterThan(1000));
      expect(result.csfType, CsfType.bacterial);
      expect(result.riskLevel, 'Cấp cứu');
      expect(result.likelyCauses, contains(CsfCause.pyogenicMeningitis));
    });

    test('Glucose ratio calculations', () {
      final result1 = CsfResult(
        protein: 40.0,
        glucose: 60.0,
        cellCount: 3,
        neutrophils: 0,
        lymphocytes: 3,
        redBloodCells: 0,
        pressure: 120.0,
        appearance: CsfAppearance.clear,
        timestamp: DateTime.now(),
        serumGlucose: 100.0,
      );

      expect(result1.glucoseRatio, 0.6);

      final result2 = CsfResult(
        protein: 40.0,
        glucose: 30.0,
        cellCount: 3,
        neutrophils: 0,
        lymphocytes: 3,
        redBloodCells: 0,
        pressure: 120.0,
        appearance: CsfAppearance.clear,
        timestamp: DateTime.now(),
        serumGlucose: 100.0,
      );

      expect(result2.glucoseRatio, 0.3);
    });

    test('Polymorphonuclear predominance', () {
      final result = CsfResult(
        protein: 200.0,
        glucose: 25.0,
        cellCount: 800,
        neutrophils: 700,
        lymphocytes: 100,
        redBloodCells: 10,
        pressure: 280.0,
        appearance: CsfAppearance.turbid,
        timestamp: DateTime.now(),
        serumGlucose: 90.0,
      );

      double neutrophilPercentage = result.neutrophils / result.cellCount;
      expect(neutrophilPercentage, greaterThan(0.5)); // >50% neutrophils
      expect(result.csfType, CsfType.bacterial);
    });

    test('Lactate interpretation', () {
      // High lactate - bacterial
      final bacterial = CsfResult(
        protein: 200.0,
        glucose: 30.0,
        cellCount: 800,
        neutrophils: 600,
        lymphocytes: 200,
        redBloodCells: 5,
        pressure: 280.0,
        appearance: CsfAppearance.clear,
        timestamp: DateTime.now(),
        serumGlucose: 100.0,
        lactate: 4.5,
      );

      expect(bacterial.hasHighLactate, true);
      expect(bacterial.csfType, CsfType.bacterial);
      expect(bacterial.lactateInterpretation, contains('vi khuẩn'));

      // Normal lactate
      final normal = CsfResult(
        protein: 35.0,
        glucose: 65.0,
        cellCount: 3,
        neutrophils: 1,
        lymphocytes: 2,
        redBloodCells: 0,
        pressure: 120.0,
        appearance: CsfAppearance.clear,
        timestamp: DateTime.now(),
        serumGlucose: 90.0,
        lactate: 1.8,
      );

      expect(normal.hasNormalLactate, true);
      expect(normal.lactateInterpretation, contains('Bình thường'));
    });
  });
}
