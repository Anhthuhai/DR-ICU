enum ABGInterpretation {
  normal,
  respiratoryAcidosis,
  respiratoryAlkalosis,
  metabolicAcidosis,
  metabolicAlkalosis,
  mixedDisorder,
  compensatedRespiratoryAcidosis,
  compensatedRespiratoryAlkalosis,
  compensatedMetabolicAcidosis,
  compensatedMetabolicAlkalosis,
}

enum OxygenationStatus {
  normal,
  mildHypoxemia,
  moderateHypoxemia,
  severeHypoxemia,
  normalWithSupplementalO2,
}

class ABGResult {
  final double ph;
  final double pco2; // mmHg
  final double po2; // mmHg
  final double hco3; // mEq/L
  final double baseExcess; // mEq/L
  final double sao2; // %
  final double fio2; // Fraction (0.21 = 21%)
  final DateTime timestamp;
  final String? notes;

  const ABGResult({
    required this.ph,
    required this.pco2,
    required this.po2,
    required this.hco3,
    required this.baseExcess,
    required this.sao2,
    required this.fio2,
    required this.timestamp,
    this.notes,
  });

  // Tính P/F ratio (PaO2/FiO2)
  double get pfRatio => po2 / fio2;

  // Tính A-a gradient (estimated)
  double get aaGradient {
    // Simplified calculation: A-a gradient = (150 - 1.25 * PCO2) - PO2
    // Assumes barometric pressure 760 mmHg, water vapor 47 mmHg
    final pao2 = (760 - 47) * fio2 - (pco2 / 0.8);
    return pao2 - po2;
  }

  // Phân tích acid-base
  ABGInterpretation get acidBaseInterpretation {
    // Bước 1: Xác định pH
    if (ph < 7.35) {
      // Acidemia
      if (pco2 > 45) {
        // Primary respiratory acidosis
        if (hco3 > 26) {
          return ABGInterpretation.compensatedRespiratoryAcidosis;
        }
        return ABGInterpretation.respiratoryAcidosis;
      } else if (hco3 < 22) {
        // Primary metabolic acidosis
        if (pco2 < 35) {
          return ABGInterpretation.compensatedMetabolicAcidosis;
        }
        return ABGInterpretation.metabolicAcidosis;
      }
      return ABGInterpretation.mixedDisorder;
    } else if (ph > 7.45) {
      // Alkalemia
      if (pco2 < 35) {
        // Primary respiratory alkalosis
        if (hco3 < 22) {
          return ABGInterpretation.compensatedRespiratoryAlkalosis;
        }
        return ABGInterpretation.respiratoryAlkalosis;
      } else if (hco3 > 26) {
        // Primary metabolic alkalosis
        if (pco2 > 45) {
          return ABGInterpretation.compensatedMetabolicAlkalosis;
        }
        return ABGInterpretation.metabolicAlkalosis;
      }
      return ABGInterpretation.mixedDisorder;
    } else {
      // pH normal (7.35-7.45)
      if (pco2 >= 35 && pco2 <= 45 && hco3 >= 22 && hco3 <= 26) {
        return ABGInterpretation.normal;
      }
      return ABGInterpretation.mixedDisorder;
    }
  }

  // Đánh giá oxygenation
  OxygenationStatus get oxygenationStatus {
    if (fio2 > 0.21) {
      // Đang thở oxygen bổ sung
      if (pfRatio >= 300) {
        return OxygenationStatus.normalWithSupplementalO2;
      } else if (pfRatio >= 200) {
        return OxygenationStatus.mildHypoxemia;
      } else if (pfRatio >= 100) {
        return OxygenationStatus.moderateHypoxemia;
      } else {
        return OxygenationStatus.severeHypoxemia;
      }
    } else {
      // Thở không khí thường
      if (po2 >= 80) {
        return OxygenationStatus.normal;
      } else if (po2 >= 60) {
        return OxygenationStatus.mildHypoxemia;
      } else if (po2 >= 40) {
        return OxygenationStatus.moderateHypoxemia;
      } else {
        return OxygenationStatus.severeHypoxemia;
      }
    }
  }

  // Expected compensation for metabolic disorders
  double get expectedPco2ForMetabolicCompensation {
    if (acidBaseInterpretation == ABGInterpretation.metabolicAcidosis ||
        acidBaseInterpretation == ABGInterpretation.compensatedMetabolicAcidosis) {
      // Winter's formula: Expected PCO2 = 1.5 × [HCO3] + 8 (±2)
      return 1.5 * hco3 + 8;
    } else if (acidBaseInterpretation == ABGInterpretation.metabolicAlkalosis ||
               acidBaseInterpretation == ABGInterpretation.compensatedMetabolicAlkalosis) {
      // Expected PCO2 = 0.7 × [HCO3] + 21 (±2)
      return 0.7 * hco3 + 21;
    }
    return pco2; // Return actual if not applicable
  }

  // Expected HCO3 for respiratory compensation
  double get expectedHco3ForRespiratoryCompensation {
    if (acidBaseInterpretation == ABGInterpretation.respiratoryAcidosis ||
        acidBaseInterpretation == ABGInterpretation.compensatedRespiratoryAcidosis) {
      // Acute: HCO3 increases by 1 for every 10 mmHg increase in PCO2
      // Chronic: HCO3 increases by 3.5 for every 10 mmHg increase in PCO2
      final deltaPco2 = pco2 - 40;
      return 24 + (deltaPco2 * 0.35); // Assuming chronic for ICU patients
    } else if (acidBaseInterpretation == ABGInterpretation.respiratoryAlkalosis ||
               acidBaseInterpretation == ABGInterpretation.compensatedRespiratoryAlkalosis) {
      // Acute: HCO3 decreases by 2 for every 10 mmHg decrease in PCO2
      // Chronic: HCO3 decreases by 5 for every 10 mmHg decrease in PCO2
      final deltaPco2 = 40 - pco2;
      return 24 - (deltaPco2 * 0.5); // Assuming chronic
    }
    return hco3; // Return actual if not applicable
  }

  Map<String, dynamic> toJson() {
    return {
      'ph': ph,
      'pco2': pco2,
      'po2': po2,
      'hco3': hco3,
      'baseExcess': baseExcess,
      'sao2': sao2,
      'fio2': fio2,
      'timestamp': timestamp.toIso8601String(),
      'notes': notes,
    };
  }

  factory ABGResult.fromJson(Map<String, dynamic> json) {
    return ABGResult(
      ph: json['ph']?.toDouble() ?? 0.0,
      pco2: json['pco2']?.toDouble() ?? 0.0,
      po2: json['po2']?.toDouble() ?? 0.0,
      hco3: json['hco3']?.toDouble() ?? 0.0,
      baseExcess: json['baseExcess']?.toDouble() ?? 0.0,
      sao2: json['sao2']?.toDouble() ?? 0.0,
      fio2: json['fio2']?.toDouble() ?? 0.21,
      timestamp: DateTime.parse(json['timestamp']),
      notes: json['notes'],
    );
  }

  ABGResult copyWith({
    double? ph,
    double? pco2,
    double? po2,
    double? hco3,
    double? baseExcess,
    double? sao2,
    double? fio2,
    DateTime? timestamp,
    String? notes,
  }) {
    return ABGResult(
      ph: ph ?? this.ph,
      pco2: pco2 ?? this.pco2,
      po2: po2 ?? this.po2,
      hco3: hco3 ?? this.hco3,
      baseExcess: baseExcess ?? this.baseExcess,
      sao2: sao2 ?? this.sao2,
      fio2: fio2 ?? this.fio2,
      timestamp: timestamp ?? this.timestamp,
      notes: notes ?? this.notes,
    );
  }
}
