import 'package:flutter_test/flutter_test.dart';
import 'package:dr_icu/features/lab_analysis/domain/entities/ascitic_fluid_result.dart';

void main() {
  group('Ascitic Fluid Analysis Tests', () {
    test('High SAAG should be classified as transudate (portal hypertension)', () {
      final highSaag = AsciticFluidResult(
        protein: 1.5,      // Low protein
        albumin: 0.8,      // Low albumin
        ldh: 100,
        glucose: 80,
        amylase: 50,
        cellCount: 150,    // Low cell count
        neutrophils: 50,
        lymphocytes: 100,
        redBloodCells: 100,
        triglycerides: 30,
        appearance: AsciticFluidAppearance.clear,
        timestamp: DateTime.now(),
        serumProtein: 7.0,
        serumAlbumin: 4.0, // High serum albumin
        serumLdh: 200,
        serumGlucose: 100,
      );

      expect(highSaag.saag, 3.2); // 4.0 - 0.8 = 3.2
      expect(highSaag.fluidType, AsciticFluidType.transudate);
      expect(highSaag.saag, greaterThanOrEqualTo(1.1));
      expect(highSaag.likelyCauses, contains(AsciticFluidCause.cirrhosis));
    });

    test('Low SAAG should be classified as exudate (non-portal hypertension)', () {
      final lowSaag = AsciticFluidResult(
        protein: 3.5,      // High protein
        albumin: 2.5,      // High albumin
        ldh: 300,
        glucose: 60,
        amylase: 100,
        cellCount: 1000,   // Higher cell count
        neutrophils: 300,
        lymphocytes: 700,
        redBloodCells: 500,
        triglycerides: 50,
        appearance: AsciticFluidAppearance.turbid,
        timestamp: DateTime.now(),
        serumProtein: 7.0,
        serumAlbumin: 3.0, // Lower serum albumin to get SAAG = 3.0 - 2.5 = 0.5
        serumLdh: 200,
        serumGlucose: 100,
      );

      expect(lowSaag.saag, 0.5); // 3.0 - 2.5 = 0.5
      expect(lowSaag.fluidType, AsciticFluidType.exudate);
      expect(lowSaag.saag, lessThan(1.1));
      expect(lowSaag.likelyCauses, contains(AsciticFluidCause.peritonitis));
    });

    test('SBP should be detected correctly', () {
      final sbp = AsciticFluidResult(
        protein: 2.0,
        albumin: 2.5,      // Higher albumin for low SAAG
        ldh: 200,
        glucose: 70,
        amylase: 50,
        cellCount: 300,    // ≥250 cells
        neutrophils: 200,  // ≥50% neutrophils
        lymphocytes: 100,
        redBloodCells: 100,
        triglycerides: 30,
        appearance: AsciticFluidAppearance.turbid,
        timestamp: DateTime.now(),
        serumProtein: 7.0,
        serumAlbumin: 3.0, // Low serum albumin for SAAG = 3.0 - 2.5 = 0.5
        serumLdh: 200,
        serumGlucose: 100,
      );

      expect(sbp.suggestsSbp, true);
      expect(sbp.cellCount, greaterThanOrEqualTo(250));
      expect(sbp.neutrophilPercentage, greaterThanOrEqualTo(50));
      expect(sbp.likelyCauses, contains(AsciticFluidCause.spontaneousBacterialPeritonitis));
    });

    test('Secondary bacterial peritonitis should be detected', () {
      final secondaryPeritonitis = AsciticFluidResult(
        protein: 3.0,      // High protein > 2.5
        albumin: 2.8,      // High albumin for low SAAG
        ldh: 300,          // High LDH > 225
        glucose: 40,       // Very low glucose < 50
        amylase: 100,
        cellCount: 1500,   // High cell count > 1000
        neutrophils: 1200, // High neutrophils > 70%
        lymphocytes: 300,
        redBloodCells: 200,
        triglycerides: 40,
        appearance: AsciticFluidAppearance.purulent,
        timestamp: DateTime.now(),
        serumProtein: 7.0,
        serumAlbumin: 3.0, // SAAG = 3.0 - 2.8 = 0.2 (low)
        serumLdh: 200,
        serumGlucose: 100,
      );

      expect(secondaryPeritonitis.suggestsSecondaryPeritonitis, true);
      expect(secondaryPeritonitis.cellCount, greaterThan(1000));
      expect(secondaryPeritonitis.neutrophilPercentage, greaterThan(70));
      expect(secondaryPeritonitis.glucose, lessThan(50));
      expect(secondaryPeritonitis.protein, greaterThan(2.5));
      expect(secondaryPeritonitis.ldh, greaterThan(225));
      expect(secondaryPeritonitis.likelyCauses, contains(AsciticFluidCause.secondaryBacterialPeritonitis));
    });

    test('Tuberculous peritonitis should be detected', () {
      final tuberculousPeritonitis = AsciticFluidResult(
        protein: 3.5,      // High protein
        albumin: 2.0,
        ldh: 250,
        glucose: 40,       // Low glucose
        amylase: 80,
        cellCount: 800,    // Moderate cell count > 500
        neutrophils: 300,  // Neutrophils < lymphocytes
        lymphocytes: 500,  // High lymphocytes
        redBloodCells: 200,
        triglycerides: 50,
        appearance: AsciticFluidAppearance.clear,
        timestamp: DateTime.now(),
        serumProtein: 7.0,
        serumAlbumin: 3.0,
        serumLdh: 200,
        serumGlucose: 100,
      );

      expect(tuberculousPeritonitis.suggestsTuberculousPeritonitis, true);
      expect(tuberculousPeritonitis.cellCount, greaterThan(500));
      expect(tuberculousPeritonitis.lymphocytes, greaterThan(tuberculousPeritonitis.neutrophils));
      expect(tuberculousPeritonitis.protein, greaterThan(2.5));
      expect(tuberculousPeritonitis.glucose, lessThan(60));
      expect(tuberculousPeritonitis.likelyCauses, contains(AsciticFluidCause.tuberculosis));
    });

    test('Malignant ascites should be detected', () {
      final malignantAscites = AsciticFluidResult(
        protein: 3.0,      // High protein
        albumin: 2.5,
        ldh: 300,
        glucose: 70,
        amylase: 60,
        cellCount: 1200,   // High cell count
        neutrophils: 400,
        lymphocytes: 800,
        redBloodCells: 5000,
        triglycerides: 40,
        appearance: AsciticFluidAppearance.bloody, // Bloody appearance
        timestamp: DateTime.now(),
        serumProtein: 7.0,
        serumAlbumin: 3.0, // Low SAAG
        serumLdh: 200,
        serumGlucose: 100,
      );

      expect(malignantAscites.suggestsMalignancy, true);
      expect(malignantAscites.saag, lessThan(1.1)); // Low SAAG
      expect(malignantAscites.protein, greaterThan(2.5));
      expect(malignantAscites.cellCount, greaterThan(1000));
      expect(malignantAscites.appearance, AsciticFluidAppearance.bloody);
      expect(malignantAscites.likelyCauses, contains(AsciticFluidCause.malignancy));
    });

    test('Pancreatic ascites should be detected', () {
      final pancreaticAscites = AsciticFluidResult(
        protein: 3.0,      // High protein
        albumin: 2.5,
        ldh: 250,
        glucose: 80,
        amylase: 1500,     // Very high amylase > 1000
        cellCount: 800,
        neutrophils: 300,
        lymphocytes: 500,
        redBloodCells: 200,
        triglycerides: 60,
        appearance: AsciticFluidAppearance.clear,
        timestamp: DateTime.now(),
        serumProtein: 7.0,
        serumAlbumin: 3.0, // Low SAAG
        serumLdh: 200,
        serumGlucose: 100,
      );

      expect(pancreaticAscites.suggestsPancreaticAscites, true);
      expect(pancreaticAscites.saag, lessThan(1.1));
      expect(pancreaticAscites.amylase, greaterThan(1000));
      expect(pancreaticAscites.protein, greaterThan(2.5));
      expect(pancreaticAscites.likelyCauses, contains(AsciticFluidCause.pancreatitis));
    });

    test('Chylous ascites should be detected', () {
      final chylousAscites = AsciticFluidResult(
        protein: 2.5,
        albumin: 2.5,      // High albumin for low SAAG
        ldh: 150,
        glucose: 80,
        amylase: 50,
        cellCount: 500,
        neutrophils: 200,
        lymphocytes: 300,
        redBloodCells: 100,
        triglycerides: 250, // High triglycerides > 200
        appearance: AsciticFluidAppearance.milky, // Milky appearance
        timestamp: DateTime.now(),
        serumProtein: 7.0,
        serumAlbumin: 3.0, // SAAG = 3.0 - 2.5 = 0.5 (low)
        serumLdh: 200,
        serumGlucose: 100,
      );

      expect(chylousAscites.suggestsChylousAscites, true);
      expect(chylousAscites.triglycerides, greaterThan(200));
      expect(chylousAscites.appearance, AsciticFluidAppearance.milky);
      expect(chylousAscites.likelyCauses, contains(AsciticFluidCause.chylousAscites));
    });

    test('Hemorrhagic ascites should be detected', () {
      final hemorrhagicAscites = AsciticFluidResult(
        protein: 3.0,
        albumin: 2.8,      // High albumin for low SAAG
        ldh: 300,
        glucose: 70,
        amylase: 80,
        cellCount: 2000,
        neutrophils: 600,
        lymphocytes: 1400,
        redBloodCells: 60000, // High RBC > 50000
        triglycerides: 50,
        appearance: AsciticFluidAppearance.bloody, // Bloody appearance
        timestamp: DateTime.now(),
        serumProtein: 7.0,
        serumAlbumin: 3.0, // SAAG = 3.0 - 2.8 = 0.2 (low)
        serumLdh: 200,
        serumGlucose: 100,
      );

      expect(hemorrhagicAscites.suggestsHemorrhagicAscites, true);
      expect(hemorrhagicAscites.redBloodCells, greaterThan(50000));
      expect(hemorrhagicAscites.appearance, AsciticFluidAppearance.bloody);
      expect(hemorrhagicAscites.likelyCauses, contains(AsciticFluidCause.hemorrhagicAscites));
    });

    test('Risk assessment should work correctly', () {
      // High risk - SBP
      final highRisk = AsciticFluidResult(
        protein: 2.0, albumin: 1.5, ldh: 200, glucose: 70, amylase: 50,
        cellCount: 300, neutrophils: 200, lymphocytes: 100, redBloodCells: 100,
        triglycerides: 30, appearance: AsciticFluidAppearance.turbid,
        timestamp: DateTime.now(), serumProtein: 7.0, serumAlbumin: 4.0,
        serumLdh: 200, serumGlucose: 100,
      );

      // Low risk - transudate
      final lowRisk = AsciticFluidResult(
        protein: 1.0, albumin: 0.5, ldh: 100, glucose: 80, amylase: 30,
        cellCount: 100, neutrophils: 30, lymphocytes: 70, redBloodCells: 50,
        triglycerides: 20, appearance: AsciticFluidAppearance.clear,
        timestamp: DateTime.now(), serumProtein: 7.0, serumAlbumin: 4.0,
        serumLdh: 200, serumGlucose: 100,
      );

      expect(highRisk.riskLevel, 'Cao');
      expect(lowRisk.riskLevel, 'Thấp');
    });

    test('SAAG calculation should be accurate', () {
      final result = AsciticFluidResult(
        protein: 2.0, albumin: 1.5, ldh: 200, glucose: 70, amylase: 50,
        cellCount: 200, neutrophils: 80, lymphocytes: 120, redBloodCells: 100,
        triglycerides: 30, appearance: AsciticFluidAppearance.clear,
        timestamp: DateTime.now(), serumProtein: 7.0, serumAlbumin: 3.8,
        serumLdh: 200, serumGlucose: 100,
      );

      // SAAG = Serum Albumin - Ascitic Albumin = 3.8 - 1.5 = 2.3
      expect(result.saag, 2.3);
      expect(result.proteinRatio, 2.0 / 7.0);
      expect(result.ldhRatio, 200.0 / 200.0);
      expect(result.glucoseRatio, 70.0 / 100.0);
    });

    test('JSON serialization should work correctly', () {
      final result = AsciticFluidResult(
        protein: 2.5, albumin: 1.8, ldh: 250, glucose: 75, amylase: 80,
        cellCount: 500, neutrophils: 200, lymphocytes: 300, redBloodCells: 150,
        triglycerides: 45, appearance: AsciticFluidAppearance.turbid,
        timestamp: DateTime.parse('2023-01-01T12:00:00Z'),
        serumProtein: 7.0, serumAlbumin: 3.5, serumLdh: 200, serumGlucose: 100,
        notes: 'Test ascitic fluid',
      );

      final json = result.toJson();
      final reconstructed = AsciticFluidResult.fromJson(json);

      expect(reconstructed.protein, equals(result.protein));
      expect(reconstructed.albumin, equals(result.albumin));
      expect(reconstructed.saag, equals(result.saag));
      expect(reconstructed.appearance, equals(result.appearance));
      expect(reconstructed.notes, equals(result.notes));
    });
  });
}
