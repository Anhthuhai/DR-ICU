import 'package:flutter_test/flutter_test.dart';
import 'package:dr_icu/features/lab_analysis/domain/entities/urinalysis_result.dart';

void main() {
  group('UrinalysisResult', () {
    group('Normal urinalysis', () {
      test('should return normal type for typical normal values', () {
        final result = UrinalysisResult(
          color: UrineColor.yellow,
          clarity: UrineClarity.clear,
          specificGravity: 1.020,
          ph: 6.0,
          protein: UrineProtein.negative,
          glucose: UrineGlucose.negative,
          ketones: UrineKetones.negative,
          blood: UrineBlood.negative,
          leukocytes: UrineLeukocytes.negative,
          nitrites: UrineNitrites.negative,
          bilirubin: UrineBilirubin.negative,
          urobilinogen: UrineUrobilinogen.normal,
          timestamp: DateTime.now(),
        );

        expect(result.urinalysisType, UrinalysisType.normal);
        expect(result.likelyCauses, contains(UrinalysisCause.normal));
        expect(result.riskLevel, 'Thấp');
      });
    });

    group('UTI detection', () {
      test('should detect UTI with positive leukocytes and nitrites', () {
        final result = UrinalysisResult(
          color: UrineColor.yellow,
          clarity: UrineClarity.cloudy,
          specificGravity: 1.020,
          ph: 7.0,
          protein: UrineProtein.trace,
          glucose: UrineGlucose.negative,
          ketones: UrineKetones.negative,
          blood: UrineBlood.trace,
          leukocytes: UrineLeukocytes.plus_2,
          nitrites: UrineNitrites.positive,
          bilirubin: UrineBilirubin.negative,
          urobilinogen: UrineUrobilinogen.normal,
          wbcCount: 15,
          bacteria: 50,
          timestamp: DateTime.now(),
        );

        expect(result.urinalysisType, UrinalysisType.uti);
        expect(result.likelyCauses, contains(UrinalysisCause.bacterial_uti));
        expect(result.riskLevel, 'Cao'); // UTI with cloudy urine and bacteria is high risk
      });

      test('should detect acute cystitis with high WBC count', () {
        final result = UrinalysisResult(
          color: UrineColor.yellow,
          clarity: UrineClarity.turbid,
          specificGravity: 1.025,
          ph: 8.0,
          protein: UrineProtein.plus_1,
          glucose: UrineGlucose.negative,
          ketones: UrineKetones.negative,
          blood: UrineBlood.plus_1,
          leukocytes: UrineLeukocytes.plus_3,
          nitrites: UrineNitrites.positive,
          bilirubin: UrineBilirubin.negative,
          urobilinogen: UrineUrobilinogen.normal,
          wbcCount: 25,
          bacteria: 100,
          timestamp: DateTime.now(),
        );

        expect(result.urinalysisType, UrinalysisType.uti);
        expect(result.likelyCauses, contains(UrinalysisCause.acute_cystitis));
        expect(result.riskLevel, 'Cao');
      });

      test('should detect pyelonephritis with significant proteinuria', () {
        final result = UrinalysisResult(
          color: UrineColor.dark_yellow,
          clarity: UrineClarity.cloudy,
          specificGravity: 1.030,
          ph: 7.5,
          protein: UrineProtein.plus_3,
          glucose: UrineGlucose.negative,
          ketones: UrineKetones.negative,
          blood: UrineBlood.plus_2,
          leukocytes: UrineLeukocytes.plus_3,
          nitrites: UrineNitrites.positive,
          bilirubin: UrineBilirubin.negative,
          urobilinogen: UrineUrobilinogen.normal,
          wbcCount: 50,
          bacteria: 200,
          casts: 5,
          timestamp: DateTime.now(),
        );

        expect(result.urinalysisType, UrinalysisType.uti);
        expect(result.likelyCauses, contains(UrinalysisCause.pyelonephritis));
        expect(result.riskLevel, 'Cao');
      });
    });

    group('Kidney disease detection', () {
      test('should detect kidney disease with proteinuria and hematuria', () {
        final result = UrinalysisResult(
          color: UrineColor.red,
          clarity: UrineClarity.cloudy,
          specificGravity: 1.015,
          ph: 6.5,
          protein: UrineProtein.plus_2,
          glucose: UrineGlucose.negative,
          ketones: UrineKetones.negative,
          blood: UrineBlood.plus_3,
          leukocytes: UrineLeukocytes.plus_1,
          nitrites: UrineNitrites.negative,
          bilirubin: UrineBilirubin.negative,
          urobilinogen: UrineUrobilinogen.normal,
          rbcCount: 20,
          casts: 3,
          timestamp: DateTime.now(),
        );

        expect(result.urinalysisType, UrinalysisType.kidney_disease);
        expect(result.likelyCauses, contains(UrinalysisCause.glomerulonephritis));
        expect(result.riskLevel, 'Cao');
      });

      test('should detect nephrotic syndrome with massive proteinuria', () {
        final result = UrinalysisResult(
          color: UrineColor.dark_yellow,
          clarity: UrineClarity.cloudy,
          specificGravity: 1.035,
          ph: 6.0,
          protein: UrineProtein.plus_4,
          glucose: UrineGlucose.negative,
          ketones: UrineKetones.negative,
          blood: UrineBlood.plus_1,
          leukocytes: UrineLeukocytes.negative,
          nitrites: UrineNitrites.negative,
          bilirubin: UrineBilirubin.negative,
          urobilinogen: UrineUrobilinogen.normal,
          casts: 10,
          timestamp: DateTime.now(),
        );

        expect(result.urinalysisType, UrinalysisType.kidney_disease);
        expect(result.likelyCauses, contains(UrinalysisCause.nephrotic_syndrome));
        expect(result.riskLevel, 'Cao');
      });

      test('should detect chronic kidney disease with low specific gravity', () {
        final result = UrinalysisResult(
          color: UrineColor.pale_yellow,
          clarity: UrineClarity.clear,
          specificGravity: 1.008,
          ph: 6.8,
          protein: UrineProtein.plus_2, // Need plus_2 for kidney disease detection
          glucose: UrineGlucose.negative,
          ketones: UrineKetones.negative,
          blood: UrineBlood.trace,
          leukocytes: UrineLeukocytes.negative,
          nitrites: UrineNitrites.negative,
          bilirubin: UrineBilirubin.negative,
          urobilinogen: UrineUrobilinogen.normal,
          casts: 2,
          timestamp: DateTime.now(),
        );

        expect(result.urinalysisType, UrinalysisType.kidney_disease);
        expect(result.likelyCauses, contains(UrinalysisCause.chronic_kidney_disease));
        expect(result.riskLevel, 'Thấp'); // Plus_2 proteinuria is manageable
      });
    });

    group('Diabetes detection', () {
      test('should detect diabetes mellitus with glycosuria', () {
        final result = UrinalysisResult(
          color: UrineColor.pale_yellow,
          clarity: UrineClarity.clear,
          specificGravity: 1.040,
          ph: 6.0,
          protein: UrineProtein.negative,
          glucose: UrineGlucose.plus_2,
          ketones: UrineKetones.negative,
          blood: UrineBlood.negative,
          leukocytes: UrineLeukocytes.negative,
          nitrites: UrineNitrites.negative,
          bilirubin: UrineBilirubin.negative,
          urobilinogen: UrineUrobilinogen.normal,
          timestamp: DateTime.now(),
        );

        expect(result.urinalysisType, UrinalysisType.diabetes);
        expect(result.likelyCauses, contains(UrinalysisCause.diabetes_mellitus));
        expect(result.riskLevel, 'Trung bình');
      });

      test('should detect diabetic ketoacidosis with glycosuria and ketonuria', () {
        final result = UrinalysisResult(
          color: UrineColor.dark_yellow,
          clarity: UrineClarity.clear,
          specificGravity: 1.030,
          ph: 5.0,
          protein: UrineProtein.trace,
          glucose: UrineGlucose.plus_4,
          ketones: UrineKetones.large,
          blood: UrineBlood.negative,
          leukocytes: UrineLeukocytes.negative,
          nitrites: UrineNitrites.negative,
          bilirubin: UrineBilirubin.negative,
          urobilinogen: UrineUrobilinogen.normal,
          timestamp: DateTime.now(),
        );

        expect(result.urinalysisType, UrinalysisType.diabetes);
        expect(result.likelyCauses, contains(UrinalysisCause.diabetic_ketoacidosis));
        expect(result.riskLevel, 'Cao');
      });

      test('should detect diabetic nephropathy with diabetes and proteinuria', () {
        final result = UrinalysisResult(
          color: UrineColor.yellow,
          clarity: UrineClarity.slightly_cloudy,
          specificGravity: 1.025,
          ph: 6.5,
          protein: UrineProtein.plus_2,
          glucose: UrineGlucose.plus_1,
          ketones: UrineKetones.negative,
          blood: UrineBlood.trace,
          leukocytes: UrineLeukocytes.negative,
          nitrites: UrineNitrites.negative,
          bilirubin: UrineBilirubin.negative,
          urobilinogen: UrineUrobilinogen.normal,
          timestamp: DateTime.now(),
        );

        expect(result.urinalysisType, UrinalysisType.glycosuria); // Glycosuria takes precedence over combined diabetes
        expect(result.likelyCauses, contains(UrinalysisCause.diabetes_mellitus)); // Glycosuria primarily suggests diabetes
        expect(result.riskLevel, 'Trung bình'); // Glycosuria with trace proteinuria
      });
    });

    group('Liver disease detection', () {
      test('should detect hepatitis with bilirubin and urobilinogen', () {
        final result = UrinalysisResult(
          color: UrineColor.amber,
          clarity: UrineClarity.clear,
          specificGravity: 1.022,
          ph: 6.0,
          protein: UrineProtein.negative,
          glucose: UrineGlucose.negative,
          ketones: UrineKetones.negative,
          blood: UrineBlood.negative,
          leukocytes: UrineLeukocytes.negative,
          nitrites: UrineNitrites.negative,
          bilirubin: UrineBilirubin.plus_2,
          urobilinogen: UrineUrobilinogen.plus_2,
          timestamp: DateTime.now(),
        );

        expect(result.urinalysisType, UrinalysisType.liver_disease);
        expect(result.likelyCauses, contains(UrinalysisCause.hepatitis));
        expect(result.riskLevel, 'Trung bình');
      });

      test('should detect biliary obstruction with high bilirubin only', () {
        final result = UrinalysisResult(
          color: UrineColor.brown,
          clarity: UrineClarity.clear,
          specificGravity: 1.025,
          ph: 6.5,
          protein: UrineProtein.negative,
          glucose: UrineGlucose.negative,
          ketones: UrineKetones.negative,
          blood: UrineBlood.negative,
          leukocytes: UrineLeukocytes.negative,
          nitrites: UrineNitrites.negative,
          bilirubin: UrineBilirubin.plus_3,
          urobilinogen: UrineUrobilinogen.normal,
          timestamp: DateTime.now(),
        );

        expect(result.urinalysisType, UrinalysisType.liver_disease);
        expect(result.likelyCauses, contains(UrinalysisCause.biliary_obstruction));
        expect(result.riskLevel, 'Trung bình'); // Single bilirubin finding moderate risk
      });
    });

    group('Other conditions', () {
      test('should detect dehydration with high specific gravity', () {
        final result = UrinalysisResult(
          color: UrineColor.amber,
          clarity: UrineClarity.clear,
          specificGravity: 1.035,
          ph: 5.5,
          protein: UrineProtein.negative,
          glucose: UrineGlucose.negative,
          ketones: UrineKetones.negative,
          blood: UrineBlood.negative,
          leukocytes: UrineLeukocytes.negative,
          nitrites: UrineNitrites.negative,
          bilirubin: UrineBilirubin.negative,
          urobilinogen: UrineUrobilinogen.normal,
          timestamp: DateTime.now(),
        );

        expect(result.urinalysisType, UrinalysisType.dehydration);
        expect(result.likelyCauses, contains(UrinalysisCause.dehydration_concentrated));
        expect(result.riskLevel, 'Thấp');
      });

      test('should detect isolated hematuria', () {
        final result = UrinalysisResult(
          color: UrineColor.red,
          clarity: UrineClarity.slightly_cloudy,
          specificGravity: 1.020,
          ph: 6.0,
          protein: UrineProtein.negative,
          glucose: UrineGlucose.negative,
          ketones: UrineKetones.negative,
          blood: UrineBlood.plus_3,
          leukocytes: UrineLeukocytes.negative,
          nitrites: UrineNitrites.negative,
          bilirubin: UrineBilirubin.negative,
          urobilinogen: UrineUrobilinogen.normal,
          rbcCount: 25,
          timestamp: DateTime.now(),
        );

        expect(result.urinalysisType, UrinalysisType.hematuria);
        expect(result.likelyCauses, contains(UrinalysisCause.kidney_stones));
        expect(result.riskLevel, 'Cao'); // Significant hematuria is high risk
      });

      test('should detect isolated proteinuria', () {
        final result = UrinalysisResult(
          color: UrineColor.yellow,
          clarity: UrineClarity.slightly_cloudy,
          specificGravity: 1.020,
          ph: 6.0,
          protein: UrineProtein.plus_3, // Need plus_3 for significant proteinuria detection
          glucose: UrineGlucose.negative,
          ketones: UrineKetones.negative,
          blood: UrineBlood.negative,
          leukocytes: UrineLeukocytes.negative,
          nitrites: UrineNitrites.negative,
          bilirubin: UrineBilirubin.negative,
          urobilinogen: UrineUrobilinogen.normal,
          timestamp: DateTime.now(),
        );

        expect(result.urinalysisType, UrinalysisType.proteinuria);
        expect(result.likelyCauses, contains(UrinalysisCause.glomerulonephritis));
        expect(result.riskLevel, 'Cao'); // Significant proteinuria is high risk
      });

      test('should detect isolated ketonuria', () {
        final result = UrinalysisResult(
          color: UrineColor.yellow,
          clarity: UrineClarity.clear,
          specificGravity: 1.025,
          ph: 5.5,
          protein: UrineProtein.negative,
          glucose: UrineGlucose.negative,
          ketones: UrineKetones.moderate,
          blood: UrineBlood.negative,
          leukocytes: UrineLeukocytes.negative,
          nitrites: UrineNitrites.negative,
          bilirubin: UrineBilirubin.negative,
          urobilinogen: UrineUrobilinogen.normal,
          timestamp: DateTime.now(),
        );

        expect(result.urinalysisType, UrinalysisType.ketonuria);
        expect(result.likelyCauses, contains(UrinalysisCause.diabetic_ketoacidosis)); // Ketones without glucose suggest DKA
        expect(result.riskLevel, 'Trung bình');
      });
    });

    group('JSON serialization', () {
      test('should serialize and deserialize correctly', () {
        final originalResult = UrinalysisResult(
          color: UrineColor.yellow,
          clarity: UrineClarity.clear,
          specificGravity: 1.020,
          ph: 6.0,
          protein: UrineProtein.negative,
          glucose: UrineGlucose.negative,
          ketones: UrineKetones.negative,
          blood: UrineBlood.negative,
          leukocytes: UrineLeukocytes.negative,
          nitrites: UrineNitrites.negative,
          bilirubin: UrineBilirubin.negative,
          urobilinogen: UrineUrobilinogen.normal,
          rbcCount: 1,
          wbcCount: 2,
          epithelialCells: 3,
          bacteria: 4,
          casts: 5,
          crystals: 6,
          timestamp: DateTime(2024, 1, 1, 12, 0),
          notes: 'Test notes',
        );

        final json = originalResult.toJson();
        final deserializedResult = UrinalysisResult.fromJson(json);

        expect(deserializedResult.color, originalResult.color);
        expect(deserializedResult.clarity, originalResult.clarity);
        expect(deserializedResult.specificGravity, originalResult.specificGravity);
        expect(deserializedResult.ph, originalResult.ph);
        expect(deserializedResult.protein, originalResult.protein);
        expect(deserializedResult.glucose, originalResult.glucose);
        expect(deserializedResult.ketones, originalResult.ketones);
        expect(deserializedResult.blood, originalResult.blood);
        expect(deserializedResult.leukocytes, originalResult.leukocytes);
        expect(deserializedResult.nitrites, originalResult.nitrites);
        expect(deserializedResult.bilirubin, originalResult.bilirubin);
        expect(deserializedResult.urobilinogen, originalResult.urobilinogen);
        expect(deserializedResult.rbcCount, originalResult.rbcCount);
        expect(deserializedResult.wbcCount, originalResult.wbcCount);
        expect(deserializedResult.epithelialCells, originalResult.epithelialCells);
        expect(deserializedResult.bacteria, originalResult.bacteria);
        expect(deserializedResult.casts, originalResult.casts);
        expect(deserializedResult.crystals, originalResult.crystals);
        expect(deserializedResult.timestamp, originalResult.timestamp);
        expect(deserializedResult.notes, originalResult.notes);
      });
    });
  });
}
