enum CsfType {
  normal,
  bacterial,
  viral,
  tuberculous,
  fungal,
  malignant,
  hemorrhagic,
  traumatic,
}

enum CsfCause {
  // Normal
  normal,
  
  // Bacterial meningitis
  bacterialMeningitis,
  pyogenicMeningitis,
  
  // Viral meningitis
  viralMeningitis,
  asepticMeningitis,
  
  // Tuberculous
  tuberculousMeningitis,
  
  // Fungal
  fungalMeningitis,
  cryptococcalMeningitis,
  
  // Malignant
  malignantMeningitis,
  carcinomatousMeningitis,
  
  // Hemorrhagic
  subarachnoidHemorrhage,
  intracerebralHemorrhage,
  traumaticTap,
  
  // Others
  encephalitis,
  brain_abscess,
  guillainBarre,
  multipleSclerosis,
}

// ignore_for_file: constant_identifier_names

enum CsfAppearance {
  clear,
  turbid,
  purulent,
  bloody,
  xanthochromic,
}

class CsfResult {
  final double protein;
  final double glucose;
  final int cellCount;
  final int neutrophils;
  final int lymphocytes;
  final int redBloodCells;
  final double pressure;
  final CsfAppearance appearance;
  final DateTime timestamp;
  
  // Serum values for comparison
  final double serumGlucose;
  
  // Additional biomarkers
  final double? lactate; // mmol/L
  
  final String? notes;

  CsfResult({
    required this.protein,
    required this.glucose,
    required this.cellCount,
    required this.neutrophils,
    required this.lymphocytes,
    required this.redBloodCells,
    required this.pressure,
    required this.appearance,
    required this.timestamp,
    required this.serumGlucose,
    this.lactate,
    this.notes,
  });

  // CSF/Serum glucose ratio
  double get glucoseRatio => glucose / serumGlucose;

  // Neutrophil percentage
  double get neutrophilPercentage => cellCount > 0 ? (neutrophils / cellCount) * 100 : 0;

  // Lymphocyte percentage
  double get lymphocytePercentage => cellCount > 0 ? (lymphocytes / cellCount) * 100 : 0;

  // Main CSF type classification
  CsfType get csfType {
    // Special cases first - hemorrhage and traumatic tap
    if (suggestsHemorrhage) {
      return CsfType.hemorrhagic;
    }
    
    if (suggestsTraumaticTap) {
      return CsfType.traumatic;
    }
    
    // Bacterial meningitis - highest priority for infections (check before normal)
    if (suggestsBacterialMeningitis) {
      return CsfType.bacterial;
    }
    
    // Malignant meningitis - check before viral/TB due to overlapping features
    if (suggestsMalignantMeningitis) {
      return CsfType.malignant;
    }
    
    // Tuberculous meningitis
    if (suggestsTuberculousMeningitis) {
      return CsfType.tuberculous;
    }
    
    // Fungal meningitis
    if (suggestsFungalMeningitis) {
      return CsfType.fungal;
    }
    
    // Viral meningitis - lower priority
    if (suggestsViralMeningitis) {
      return CsfType.viral;
    }
    
    // Check if normal last (for truly normal cases)
    if (isNormal) {
      return CsfType.normal;
    }
    
    return CsfType.normal;
  }

  // Check for normal CSF
  bool get isNormal {
    return cellCount <= 5 &&
           protein >= 15 && protein <= 45 &&
           glucoseRatio >= 0.6 &&
           pressure >= 70 && pressure <= 180 &&
           redBloodCells <= 5 &&
           appearance == CsfAppearance.clear;
  }

  // Check for bacterial meningitis
  bool get suggestsBacterialMeningitis {
    bool basicCriteria = cellCount > 100 && // Lowered from 500
           neutrophilPercentage > 50 && // Lowered from 60
           protein > 100 && // Lowered from 150
           glucoseRatio < 0.5; // Remove appearance requirement for more sensitivity
    
    // Lactate > 3.5 mmol/L strongly suggests bacterial meningitis
    if (lactate != null && lactate! > 3.5) {
      return true;
    }
    
    return basicCriteria;
  }

  // Check for viral meningitis
  bool get suggestsViralMeningitis {
    bool basicCriteria = cellCount >= 50 && cellCount <= 500 &&
           lymphocytePercentage >= 60 &&
           protein >= 50 && protein <= 150 &&
           glucoseRatio >= 0.5 &&
           appearance == CsfAppearance.clear;
    
    // Lactate < 3.5 mmol/L supports viral meningitis
    if (lactate != null && lactate! < 3.5 && basicCriteria) {
      return true;
    }
    
    return basicCriteria;
  }

  // Check for tuberculous meningitis
  bool get suggestsTuberculousMeningitis {
    return cellCount >= 100 && cellCount <= 500 &&
           lymphocytePercentage >= 60 &&
           protein > 150 && // Higher protein than fungal
           glucoseRatio < 0.5 &&
           appearance == CsfAppearance.clear;
  }

  // Check for fungal meningitis
  bool get suggestsFungalMeningitis {
    return cellCount >= 50 && cellCount <= 300 &&
           lymphocytePercentage >= 50 &&
           protein >= 100 && protein <= 200 && // Lower protein than TB
           glucoseRatio < 0.35 && // Lower glucose than TB
           appearance == CsfAppearance.clear &&
           !suggestsTuberculousMeningitis; // Differentiate from TB
  }

  // Check for malignant meningitis
  bool get suggestsMalignantMeningitis {
    return cellCount >= 50 && cellCount <= 200 &&
           protein > 200 &&
           glucoseRatio < 0.3 &&
           (lymphocytePercentage >= 70 || appearance == CsfAppearance.turbid);
  }

  // Check for subarachnoid hemorrhage
  bool get suggestsHemorrhage {
    return redBloodCells > 1000 &&
           (appearance == CsfAppearance.bloody || appearance == CsfAppearance.xanthochromic);
  }

  // Check for traumatic tap
  bool get suggestsTraumaticTap {
    return redBloodCells >= 100 && redBloodCells <= 10000 &&
           appearance == CsfAppearance.bloody &&
           cellCount < 100 &&
           protein < 100 &&
           glucoseRatio >= 0.6 &&
           !suggestsHemorrhage; // Not true hemorrhage
  }

  // Check for elevated pressure
  bool get hasElevatedPressure {
    return pressure > 180;
  }

  // Check for low glucose
  bool get hasLowGlucose {
    return glucoseRatio < 0.6;
  }

  // Check for high protein
  bool get hasHighProtein {
    return protein > 45;
  }

  // Check lactate levels
  bool get hasHighLactate {
    return lactate != null && lactate! > 3.5;
  }

  bool get hasNormalLactate {
    return lactate == null || (lactate! >= 1.5 && lactate! <= 2.1);
  }

  String get lactateInterpretation {
    if (lactate == null) return 'Không xét nghiệm';
    if (lactate! > 3.5) return 'Tăng cao (>3.5) - Nghi viêm màng não vi khuẩn';
    if (lactate! >= 2.1 && lactate! <= 3.5) return 'Tăng nhẹ (2.1-3.5) - Có thể vi khuẩn hoặc virus';
    if (lactate! >= 1.5 && lactate! <= 2.1) return 'Bình thường (1.5-2.1)';
    return 'Thấp (<1.5)';
  }

  // Get likely causes based on analysis
  List<CsfCause> get likelyCauses {
    List<CsfCause> causes = [];

    switch (csfType) {
      case CsfType.normal:
        causes.add(CsfCause.normal);
        break;
        
      case CsfType.bacterial:
        causes.add(CsfCause.bacterialMeningitis);
        if (neutrophilPercentage > 90) {
          causes.add(CsfCause.pyogenicMeningitis);
        }
        break;
        
      case CsfType.viral:
        causes.add(CsfCause.viralMeningitis);
        causes.add(CsfCause.asepticMeningitis);
        if (cellCount < 100) {
          causes.add(CsfCause.encephalitis);
        }
        break;
        
      case CsfType.tuberculous:
        causes.add(CsfCause.tuberculousMeningitis);
        break;
        
      case CsfType.fungal:
        causes.add(CsfCause.fungalMeningitis);
        if (pressure > 250) {
          causes.add(CsfCause.cryptococcalMeningitis);
        }
        break;
        
      case CsfType.malignant:
        causes.add(CsfCause.malignantMeningitis);
        causes.add(CsfCause.carcinomatousMeningitis);
        break;
        
      case CsfType.hemorrhagic:
        causes.add(CsfCause.subarachnoidHemorrhage);
        if (pressure > 300) {
          causes.add(CsfCause.intracerebralHemorrhage);
        }
        break;
        
      case CsfType.traumatic:
        causes.add(CsfCause.traumaticTap);
        break;
    }

    return causes;
  }

  // Risk assessment
  String get riskLevel {
    if (suggestsBacterialMeningitis || suggestsHemorrhage || pressure > 350) {
      return 'Cấp cứu'; // Emergency - bacterial meningitis, hemorrhage, or very high pressure
    } else if (suggestsTuberculousMeningitis || suggestsMalignantMeningitis || pressure > 250) {
      return 'Cao'; // High risk
    } else if (suggestsViralMeningitis || suggestsFungalMeningitis || pressure > 200) {
      return 'Trung bình'; // Medium risk
    } else {
      return 'Thấp'; // Low risk
    }
  }

  // Urgency level for treatment
  String get urgencyLevel {
    if (suggestsBacterialMeningitis) {
      return 'Khẩn cấp - Kháng sinh ngay lập tức';
    } else if (suggestsHemorrhage) {
      return 'Khẩn cấp - Phẫu thuật thần kinh';
    } else if (suggestsTuberculousMeningitis) {
      return 'Cấp tính - Điều trị chống lao';
    } else if (suggestsMalignantMeningitis) {
      return 'Cấp tính - Tham khảo oncology';
    } else if (suggestsViralMeningitis) {
      return 'Theo dõi - Điều trị hỗ trợ';
    } else {
      return 'Bình thường - Theo dõi định kỳ';
    }
  }

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'protein': protein,
      'glucose': glucose,
      'cellCount': cellCount,
      'neutrophils': neutrophils,
      'lymphocytes': lymphocytes,
      'redBloodCells': redBloodCells,
      'pressure': pressure,
      'appearance': appearance.index,
      'timestamp': timestamp.toIso8601String(),
      'serumGlucose': serumGlucose,
      'lactate': lactate,
      'notes': notes,
    };
  }

  factory CsfResult.fromJson(Map<String, dynamic> json) {
    return CsfResult(
      protein: json['protein'].toDouble(),
      glucose: json['glucose'].toDouble(),
      cellCount: json['cellCount'],
      neutrophils: json['neutrophils'],
      lymphocytes: json['lymphocytes'],
      redBloodCells: json['redBloodCells'],
      pressure: json['pressure'].toDouble(),
      appearance: CsfAppearance.values[json['appearance']],
      timestamp: DateTime.parse(json['timestamp']),
      serumGlucose: json['serumGlucose'].toDouble(),
      lactate: json['lactate']?.toDouble(),
      notes: json['notes'],
    );
  }
}
