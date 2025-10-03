// ignore_for_file: constant_identifier_names

enum UrineColor {
  pale_yellow,
  yellow,
  dark_yellow,
  amber,
  red,
  brown,
  green,
  blue,
  colorless,
}

enum UrineClarity {
  clear,
  slightly_cloudy,
  cloudy,
  turbid,
}

enum UrineProtein {
  negative,
  trace,
  plus_1,
  plus_2,
  plus_3,
  plus_4,
}

enum UrineGlucose {
  negative,
  trace,
  plus_1,
  plus_2,
  plus_3,
  plus_4,
}

enum UrineKetones {
  negative,
  trace,
  small,
  moderate,
  large,
}

enum UrineBlood {
  negative,
  trace,
  plus_1,
  plus_2,
  plus_3,
}

enum UrineLeukocytes {
  negative,
  trace,
  plus_1,
  plus_2,
  plus_3,
}

enum UrineNitrites {
  negative,
  positive,
}

enum UrineBilirubin {
  negative,
  plus_1,
  plus_2,
  plus_3,
}

enum UrineUrobilinogen {
  normal,
  plus_1,
  plus_2,
  plus_3,
  plus_4,
}

// Clinical interpretations
enum UrinalysisType {
  normal,
  uti, // Urinary tract infection
  kidney_disease,
  diabetes,
  liver_disease,
  dehydration,
  hematuria,
  proteinuria,
  glycosuria,
  ketonuria,
}

enum UrinalysisCause {
  normal,
  bacterial_uti,
  viral_uti,
  fungal_uti,
  acute_cystitis,
  pyelonephritis,
  urethritis,
  diabetic_nephropathy,
  glomerulonephritis,
  nephrotic_syndrome,
  acute_kidney_injury,
  chronic_kidney_disease,
  diabetes_mellitus,
  diabetic_ketoacidosis,
  starvation_ketosis,
  alcoholic_ketoacidosis,
  hepatitis,
  cirrhosis,
  biliary_obstruction,
  hemolytic_anemia,
  rhabdomyolysis,
  kidney_stones,
  bladder_cancer,
  kidney_cancer,
  prostate_disease,
  menstruation,
  exercise_induced,
  dehydration_concentrated,
  overhydration,
}

class UrinalysisResult {
  // Physical properties
  final UrineColor color;
  final UrineClarity clarity;
  final double specificGravity;
  final double ph;
  
  // Chemical analysis
  final UrineProtein protein;
  final UrineGlucose glucose;
  final UrineKetones ketones;
  final UrineBlood blood;
  final UrineLeukocytes leukocytes;
  final UrineNitrites nitrites;
  final UrineBilirubin bilirubin;
  final UrineUrobilinogen urobilinogen;
  
  // Microscopic analysis (optional)
  final int? rbcCount; // per hpf
  final int? wbcCount; // per hpf
  final int? epithelialCells; // per hpf
  final int? bacteria; // per hpf
  final int? casts; // per lpf
  final int? crystals; // per hpf
  
  final DateTime timestamp;
  final String? notes;

  UrinalysisResult({
    required this.color,
    required this.clarity,
    required this.specificGravity,
    required this.ph,
    required this.protein,
    required this.glucose,
    required this.ketones,
    required this.blood,
    required this.leukocytes,
    required this.nitrites,
    required this.bilirubin,
    required this.urobilinogen,
    this.rbcCount,
    this.wbcCount,
    this.epithelialCells,
    this.bacteria,
    this.casts,
    this.crystals,
    required this.timestamp,
    this.notes,
  });

  // Main urinalysis type classification
  UrinalysisType get urinalysisType {
    // UTI - highest priority for infection
    if (suggestsUTI) {
      return UrinalysisType.uti;
    }
    
    // Kidney disease
    if (suggestsKidneyDisease) {
      return UrinalysisType.kidney_disease;
    }
    
    // Diabetes
    if (suggestsDiabetes) {
      return UrinalysisType.diabetes;
    }
    
    // Liver disease
    if (suggestsLiverDisease) {
      return UrinalysisType.liver_disease;
    }
    
    // Specific conditions
    if (hasSignificantHematuria) {
      return UrinalysisType.hematuria;
    }
    
    if (hasSignificantProteinuria) {
      return UrinalysisType.proteinuria;
    }
    
    if (hasGlycosuria) {
      return UrinalysisType.glycosuria;
    }
    
    if (hasKetonuria) {
      return UrinalysisType.ketonuria;
    }
    
    if (suggestsDehydration) {
      return UrinalysisType.dehydration;
    }
    
    // Normal
    if (isNormal) {
      return UrinalysisType.normal;
    }
    
    return UrinalysisType.normal;
  }

  // Check for normal urine
  bool get isNormal {
    return color == UrineColor.pale_yellow || color == UrineColor.yellow &&
           clarity == UrineClarity.clear &&
           specificGravity >= 1.003 && specificGravity <= 1.030 &&
           ph >= 4.5 && ph <= 8.0 &&
           protein == UrineProtein.negative || protein == UrineProtein.trace &&
           glucose == UrineGlucose.negative &&
           ketones == UrineKetones.negative &&
           blood == UrineBlood.negative || blood == UrineBlood.trace &&
           leukocytes == UrineLeukocytes.negative || leukocytes == UrineLeukocytes.trace &&
           nitrites == UrineNitrites.negative &&
           bilirubin == UrineBilirubin.negative &&
           urobilinogen == UrineUrobilinogen.normal;
  }

  // Check for UTI
  bool get suggestsUTI {
    bool hasLeukocytes = leukocytes == UrineLeukocytes.plus_2 || 
                        leukocytes == UrineLeukocytes.plus_3;
    bool hasNitrites = nitrites == UrineNitrites.positive;
    bool hasWBC = wbcCount != null && wbcCount! > 5;
    bool hasBacteria = bacteria != null && bacteria! > 2;
    
    // Nitrites + leukocytes = strong UTI indicator
    if (hasNitrites && hasLeukocytes) return true;
    
    // High WBC + bacteria
    if (hasWBC && hasBacteria) return true;
    
    // Moderate indicators
    return (hasLeukocytes && hasBacteria) || 
           (hasNitrites && hasWBC);
  }

  // Check for kidney disease
  bool get suggestsKidneyDisease {
    bool hasProteinuria = protein == UrineProtein.plus_2 || 
                         protein == UrineProtein.plus_3 || 
                         protein == UrineProtein.plus_4;
    bool hasHematuria = blood == UrineBlood.plus_2 || 
                       blood == UrineBlood.plus_3;
    bool hasCasts = casts != null && casts! > 0;
    bool hasRBC = rbcCount != null && rbcCount! > 3;
    
    return (hasProteinuria && hasHematuria) || 
           (hasProteinuria && hasCasts) ||
           (hasHematuria && hasCasts) ||
           (hasRBC && hasProteinuria);
  }

  // Check for diabetes
  bool get suggestsDiabetes {
    bool hasGlycosuria = glucose == UrineGlucose.plus_2 || 
                        glucose == UrineGlucose.plus_3 || 
                        glucose == UrineGlucose.plus_4;
    bool hasKetonuria = ketones == UrineKetones.moderate || 
                       ketones == UrineKetones.large;
    
    return hasGlycosuria || (hasKetonuria && hasGlycosuria);
  }

  // Check for liver disease
  bool get suggestsLiverDisease {
    bool hasBilirubin = bilirubin == UrineBilirubin.plus_2 || 
                       bilirubin == UrineBilirubin.plus_3;
    bool hasUrobilinogen = urobilinogen == UrineUrobilinogen.plus_3 || 
                          urobilinogen == UrineUrobilinogen.plus_4;
    
    return hasBilirubin || hasUrobilinogen;
  }

  // Check for dehydration
  bool get suggestsDehydration {
    return specificGravity > 1.025 && 
           (color == UrineColor.dark_yellow || color == UrineColor.amber);
  }

  // Specific conditions
  bool get hasSignificantHematuria {
    return blood == UrineBlood.plus_2 || blood == UrineBlood.plus_3 ||
           (rbcCount != null && rbcCount! > 5);
  }

  bool get hasSignificantProteinuria {
    return protein == UrineProtein.plus_3 || protein == UrineProtein.plus_4;
  }

  bool get hasGlycosuria {
    return glucose != UrineGlucose.negative && glucose != UrineGlucose.trace;
  }

  bool get hasKetonuria {
    return ketones != UrineKetones.negative && ketones != UrineKetones.trace;
  }

  // Get likely causes based on analysis
  List<UrinalysisCause> get likelyCauses {
    List<UrinalysisCause> causes = [];

    switch (urinalysisType) {
      case UrinalysisType.normal:
        causes.add(UrinalysisCause.normal);
        break;
        
      case UrinalysisType.uti:
        causes.add(UrinalysisCause.bacterial_uti);
        if (leukocytes == UrineLeukocytes.plus_3) {
          causes.add(UrinalysisCause.acute_cystitis);
        }
        if (protein != UrineProtein.negative) {
          causes.add(UrinalysisCause.pyelonephritis);
        }
        break;
        
      case UrinalysisType.kidney_disease:
        if (hasSignificantProteinuria) {
          causes.add(UrinalysisCause.nephrotic_syndrome);
          causes.add(UrinalysisCause.glomerulonephritis);
        }
        if (hasSignificantHematuria) {
          causes.add(UrinalysisCause.glomerulonephritis);
          causes.add(UrinalysisCause.kidney_stones);
        }
        causes.add(UrinalysisCause.chronic_kidney_disease);
        break;
        
      case UrinalysisType.diabetes:
        causes.add(UrinalysisCause.diabetes_mellitus);
        if (hasKetonuria) {
          causes.add(UrinalysisCause.diabetic_ketoacidosis);
        }
        if (hasSignificantProteinuria) {
          causes.add(UrinalysisCause.diabetic_nephropathy);
        }
        break;
        
      case UrinalysisType.liver_disease:
        if (bilirubin != UrineBilirubin.negative) {
          causes.add(UrinalysisCause.hepatitis);
          causes.add(UrinalysisCause.biliary_obstruction);
        }
        if (urobilinogen != UrineUrobilinogen.normal) {
          causes.add(UrinalysisCause.hemolytic_anemia);
          causes.add(UrinalysisCause.cirrhosis);
        }
        break;
        
      case UrinalysisType.hematuria:
        causes.add(UrinalysisCause.kidney_stones);
        causes.add(UrinalysisCause.bladder_cancer);
        causes.add(UrinalysisCause.kidney_cancer);
        if (blood == UrineBlood.plus_3) {
          causes.add(UrinalysisCause.rhabdomyolysis);
        }
        break;
        
      case UrinalysisType.proteinuria:
        causes.add(UrinalysisCause.nephrotic_syndrome);
        causes.add(UrinalysisCause.glomerulonephritis);
        causes.add(UrinalysisCause.diabetic_nephropathy);
        break;
        
      case UrinalysisType.glycosuria:
        causes.add(UrinalysisCause.diabetes_mellitus);
        break;
        
      case UrinalysisType.ketonuria:
        causes.add(UrinalysisCause.diabetic_ketoacidosis);
        causes.add(UrinalysisCause.starvation_ketosis);
        causes.add(UrinalysisCause.alcoholic_ketoacidosis);
        break;
        
      case UrinalysisType.dehydration:
        causes.add(UrinalysisCause.dehydration_concentrated);
        break;
    }

    return causes;
  }

  // Risk assessment
  String get riskLevel {
    if (suggestsUTI && (protein != UrineProtein.negative || hasSignificantHematuria)) {
      return 'Cao'; // Complicated UTI or pyelonephritis
    } else if (hasSignificantProteinuria || hasSignificantHematuria) {
      return 'Cao'; // Kidney disease
    } else if (suggestsDiabetes && hasKetonuria) {
      return 'Cao'; // DKA risk
    } else if (suggestsLiverDisease) {
      return 'Trung bình'; // Liver involvement
    } else if (suggestsUTI) {
      return 'Trung bình'; // Simple UTI
    } else if (hasGlycosuria || hasKetonuria) {
      return 'Trung bình'; // Metabolic issues
    } else {
      return 'Thấp'; // Normal or minor abnormalities
    }
  }

  // Urgency level for treatment
  String get urgencyLevel {
    if (suggestsUTI && protein != UrineProtein.negative) {
      return 'Cấp tính - Kháng sinh và đánh giá thận';
    } else if (hasSignificantProteinuria && hasSignificantHematuria) {
      return 'Cấp tính - Tham khảo thận';
    } else if (suggestsDiabetes && hasKetonuria) {
      return 'Cấp tính - Kiểm soát đường huyết';
    } else if (suggestsLiverDisease) {
      return 'Theo dõi - Đánh giá chức năng gan';
    } else if (suggestsUTI) {
      return 'Theo dõi - Kháng sinh đường uống';
    } else {
      return 'Bình thường - Theo dõi định kỳ';
    }
  }

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'color': color.index,
      'clarity': clarity.index,
      'specificGravity': specificGravity,
      'ph': ph,
      'protein': protein.index,
      'glucose': glucose.index,
      'ketones': ketones.index,
      'blood': blood.index,
      'leukocytes': leukocytes.index,
      'nitrites': nitrites.index,
      'bilirubin': bilirubin.index,
      'urobilinogen': urobilinogen.index,
      'rbcCount': rbcCount,
      'wbcCount': wbcCount,
      'epithelialCells': epithelialCells,
      'bacteria': bacteria,
      'casts': casts,
      'crystals': crystals,
      'timestamp': timestamp.toIso8601String(),
      'notes': notes,
    };
  }

  factory UrinalysisResult.fromJson(Map<String, dynamic> json) {
    return UrinalysisResult(
      color: UrineColor.values[json['color']],
      clarity: UrineClarity.values[json['clarity']],
      specificGravity: json['specificGravity'].toDouble(),
      ph: json['ph'].toDouble(),
      protein: UrineProtein.values[json['protein']],
      glucose: UrineGlucose.values[json['glucose']],
      ketones: UrineKetones.values[json['ketones']],
      blood: UrineBlood.values[json['blood']],
      leukocytes: UrineLeukocytes.values[json['leukocytes']],
      nitrites: UrineNitrites.values[json['nitrites']],
      bilirubin: UrineBilirubin.values[json['bilirubin']],
      urobilinogen: UrineUrobilinogen.values[json['urobilinogen']],
      rbcCount: json['rbcCount'],
      wbcCount: json['wbcCount'],
      epithelialCells: json['epithelialCells'],
      bacteria: json['bacteria'],
      casts: json['casts'],
      crystals: json['crystals'],
      timestamp: DateTime.parse(json['timestamp']),
      notes: json['notes'],
    );
  }
}
