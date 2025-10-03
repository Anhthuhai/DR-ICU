enum AsciticFluidType {
  transudate,
  exudate,
  indeterminate,
}

enum AsciticFluidCause {
  // Transudate causes
  cirrhosis,
  heartFailure,
  nephrotic,
  hypoalbuminemia,
  
  // Exudate causes
  peritonitis,
  malignancy,
  tuberculosis,
  pancreatitis,
  nephrogenicAscites,
  
  // Special conditions
  spontaneousBacterialPeritonitis,
  secondaryBacterialPeritonitis,
  chylousAscites,
  hemorrhagicAscites,
}

enum AsciticFluidAppearance {
  clear,
  turbid,
  bloody,
  milky,
  purulent,
}

class AsciticFluidResult {
  final double protein;
  final double albumin;
  final double ldh;
  final double glucose;
  final double amylase;
  final int cellCount;
  final int neutrophils;
  final int lymphocytes;
  final int redBloodCells;
  final double triglycerides;
  final AsciticFluidAppearance appearance;
  final DateTime timestamp;
  
  // Serum values for comparison
  final double serumProtein;
  final double serumAlbumin;
  final double serumLdh;
  final double serumGlucose;
  
  final String? notes;

  AsciticFluidResult({
    required this.protein,
    required this.albumin,
    required this.ldh,
    required this.glucose,
    required this.amylase,
    required this.cellCount,
    required this.neutrophils,
    required this.lymphocytes,
    required this.redBloodCells,
    required this.triglycerides,
    required this.appearance,
    required this.timestamp,
    required this.serumProtein,
    required this.serumAlbumin,
    required this.serumLdh,
    required this.serumGlucose,
    this.notes,
  });

  // SAAG (Serum-Ascites Albumin Gradient) calculation
  double get saag => serumAlbumin - albumin;

  // Main classification based on SAAG
  AsciticFluidType get fluidType {
    if (saag >= 1.1) {
      return AsciticFluidType.transudate; // Portal hypertension
    } else if (saag < 1.1) {
      return AsciticFluidType.exudate; // Non-portal hypertension
    } else {
      return AsciticFluidType.indeterminate;
    }
  }

  // Protein ratio (AF/S)
  double get proteinRatio => protein / serumProtein;

  // LDH ratio (AF/S)
  double get ldhRatio => ldh / serumLdh;

  // Glucose ratio (AF/S)
  double get glucoseRatio => glucose / serumGlucose;

  // Neutrophil percentage
  double get neutrophilPercentage => (neutrophils / cellCount) * 100;

  // Check for Spontaneous Bacterial Peritonitis (SBP)
  bool get suggestsSbp {
    return cellCount >= 250 && neutrophilPercentage >= 50;
  }

  // Check for Secondary Bacterial Peritonitis
  bool get suggestsSecondaryPeritonitis {
    return cellCount > 1000 && 
           neutrophilPercentage > 70 && 
           (glucose < 50 || glucoseRatio < 0.5) &&
           (protein > 2.5 || ldh > 225);
  }

  // Check for Tuberculous Peritonitis
  bool get suggestsTuberculousPeritonitis {
    return cellCount > 500 &&
           lymphocytes > neutrophils &&
           protein > 2.5 &&
           glucose < 60;
  }

  // Check for Malignant Ascites
  bool get suggestsMalignancy {
    return saag < 1.1 &&
           protein > 2.5 &&
           (appearance == AsciticFluidAppearance.bloody ||
            appearance == AsciticFluidAppearance.turbid) &&
           cellCount > 1000;
  }

  // Check for Pancreatic Ascites
  bool get suggestsPancreaticAscites {
    return saag < 1.1 &&
           amylase > 1000 &&
           protein > 2.5;
  }

  // Check for Chylous Ascites
  bool get suggestsChylousAscites {
    return triglycerides > 200 &&
           appearance == AsciticFluidAppearance.milky;
  }

  // Check for Hemorrhagic Ascites
  bool get suggestsHemorrhagicAscites {
    return redBloodCells > 50000 &&
           appearance == AsciticFluidAppearance.bloody;
  }

  // Get likely causes based on analysis
  List<AsciticFluidCause> get likelyCauses {
    List<AsciticFluidCause> causes = [];

    // Check for secondary peritonitis first (more specific criteria)
    if (suggestsSecondaryPeritonitis) {
      causes.add(AsciticFluidCause.secondaryBacterialPeritonitis);
      return causes; // Secondary peritonitis is priority diagnosis
    }
    
    // Check for SBP (less specific criteria)
    if (suggestsSbp) {
      causes.add(AsciticFluidCause.spontaneousBacterialPeritonitis);
      return causes; // SBP is priority diagnosis
    }
    
    if (suggestsChylousAscites) {
      causes.add(AsciticFluidCause.chylousAscites);
      return causes; // Chylous ascites is specific diagnosis
    }
    
    if (suggestsHemorrhagicAscites) {
      causes.add(AsciticFluidCause.hemorrhagicAscites);
      return causes; // Hemorrhagic ascites is specific diagnosis
    }

    // Then check by SAAG classification
    if (fluidType == AsciticFluidType.transudate) {
      // High SAAG (≥1.1) - Portal hypertension related
      causes.add(AsciticFluidCause.cirrhosis);
      if (cellCount < 250) causes.add(AsciticFluidCause.heartFailure);
      if (protein < 1.5) causes.add(AsciticFluidCause.nephrotic);
    } else if (fluidType == AsciticFluidType.exudate) {
      // Low SAAG (<1.1) - Non-portal hypertension
      if (suggestsTuberculousPeritonitis) {
        causes.add(AsciticFluidCause.tuberculosis);
      }
      
      if (suggestsMalignancy) {
        causes.add(AsciticFluidCause.malignancy);
      }
      
      if (suggestsPancreaticAscites) {
        causes.add(AsciticFluidCause.pancreatitis);
      }
      
      if (causes.isEmpty) {
        causes.add(AsciticFluidCause.peritonitis);
      }
    }

    return causes;
  }

  // Risk assessment
  String get riskLevel {
    if (suggestsSbp || suggestsSecondaryPeritonitis) {
      return 'Cao'; // High risk - infection
    } else if (suggestsMalignancy || suggestsTuberculousPeritonitis) {
      return 'Trung bình'; // Medium risk
    } else {
      return 'Thấp'; // Low risk
    }
  }

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'protein': protein,
      'albumin': albumin,
      'ldh': ldh,
      'glucose': glucose,
      'amylase': amylase,
      'cellCount': cellCount,
      'neutrophils': neutrophils,
      'lymphocytes': lymphocytes,
      'redBloodCells': redBloodCells,
      'triglycerides': triglycerides,
      'appearance': appearance.index,
      'timestamp': timestamp.toIso8601String(),
      'serumProtein': serumProtein,
      'serumAlbumin': serumAlbumin,
      'serumLdh': serumLdh,
      'serumGlucose': serumGlucose,
      'notes': notes,
    };
  }

  factory AsciticFluidResult.fromJson(Map<String, dynamic> json) {
    return AsciticFluidResult(
      protein: json['protein'].toDouble(),
      albumin: json['albumin'].toDouble(),
      ldh: json['ldh'].toDouble(),
      glucose: json['glucose'].toDouble(),
      amylase: json['amylase'].toDouble(),
      cellCount: json['cellCount'],
      neutrophils: json['neutrophils'],
      lymphocytes: json['lymphocytes'],
      redBloodCells: json['redBloodCells'],
      triglycerides: json['triglycerides'].toDouble(),
      appearance: AsciticFluidAppearance.values[json['appearance']],
      timestamp: DateTime.parse(json['timestamp']),
      serumProtein: json['serumProtein'].toDouble(),
      serumAlbumin: json['serumAlbumin'].toDouble(),
      serumLdh: json['serumLdh'].toDouble(),
      serumGlucose: json['serumGlucose'].toDouble(),
      notes: json['notes'],
    );
  }
}
