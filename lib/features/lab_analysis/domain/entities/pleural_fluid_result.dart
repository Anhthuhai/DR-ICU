enum PleuralFluidType {
  transudate,
  exudate,
  indeterminate,
}

enum PleuralFluidAppearance {
  clear,
  turbid,
  bloody,
  purulent,
  milky,
  cholesterol,
}

enum PleuralFluidCause {
  // Transudates
  heartFailure,
  cirrhosis,
  nephrotic,
  hypoalbuminemia,
  
  // Exudates
  pneumonia,
  malignancy,
  tuberculosis,
  pulmonaryEmbolism,
  pancreatitis,
  rheumatoid,
  lupus,
  empyema,
  
  // Other
  unknown,
}

class PleuralFluidResult {
  final double protein; // g/dL
  final double ldh; // U/L
  final double glucose; // mg/dL
  final double ph;
  final int cellCount; // cells/μL
  final int neutrophils; // %
  final int lymphocytes; // %
  final double cholesterol; // mg/dL
  final double triglycerides; // mg/dL
  final PleuralFluidAppearance appearance;
  final DateTime timestamp;
  final String? notes;

  // Serum values for comparison
  final double serumProtein; // g/dL
  final double serumLdh; // U/L
  final double serumGlucose; // mg/dL

  const PleuralFluidResult({
    required this.protein,
    required this.ldh,
    required this.glucose,
    required this.ph,
    required this.cellCount,
    required this.neutrophils,
    required this.lymphocytes,
    required this.cholesterol,
    required this.triglycerides,
    required this.appearance,
    required this.timestamp,
    required this.serumProtein,
    required this.serumLdh,
    required this.serumGlucose,
    this.notes,
  });

  // Light's Criteria for exudate
  bool get isExudateByProtein => (protein / serumProtein) > 0.5;
  bool get isExudateByLdh => (ldh / serumLdh) > 0.6;
  bool get isExudateByAbsoluteLdh => ldh > (2/3 * 200); // Normal upper limit ~200

  // Classification by Light's Criteria
  PleuralFluidType get fluidType {
    if (isExudateByProtein || isExudateByLdh || isExudateByAbsoluteLdh) {
      return PleuralFluidType.exudate;
    } else {
      return PleuralFluidType.transudate;
    }
  }

  // Glucose ratio
  double get glucoseRatio => glucose / serumGlucose;

  // Specific diagnostic criteria
  bool get suggestsPneumonia => 
      fluidType == PleuralFluidType.exudate && 
      neutrophils > 50 && 
      ph > 7.30;

  bool get suggestsEmpyema => 
      appearance == PleuralFluidAppearance.purulent || 
      (ph < 7.30 && glucose < 60 && ldh > 1000);

  bool get suggestsTuberculosis => 
      fluidType == PleuralFluidType.exudate && 
      lymphocytes > 50 && 
      protein > 4.0 && 
      glucoseRatio < 0.5;

  bool get suggestsMalignancy => 
      fluidType == PleuralFluidType.exudate && 
      lymphocytes > 50 && 
      appearance == PleuralFluidAppearance.bloody;

  bool get suggestsChylothorax => 
      triglycerides > 110 || 
      (triglycerides > 50 && cholesterol < triglycerides);

  bool get suggestsPseudochylothorax => 
      appearance == PleuralFluidAppearance.milky && 
      cholesterol > triglycerides && 
      cholesterol > 200;

  bool get suggestsRheumatoid => 
      fluidType == PleuralFluidType.exudate && 
      ph < 7.35 && 
      glucose < 30 && 
      cholesterol > 60;

  // Most likely causes based on analysis
  List<PleuralFluidCause> get likelyCauses {
    List<PleuralFluidCause> causes = [];

    if (fluidType == PleuralFluidType.transudate) {
      causes.addAll([
        PleuralFluidCause.heartFailure,
        PleuralFluidCause.cirrhosis,
        PleuralFluidCause.nephrotic,
        PleuralFluidCause.hypoalbuminemia,
      ]);
    } else {
      // Exudate
      if (suggestsEmpyema) {
        causes.add(PleuralFluidCause.empyema);
      }
      if (suggestsPneumonia) {
        causes.add(PleuralFluidCause.pneumonia);
      }
      if (suggestsTuberculosis) {
        causes.add(PleuralFluidCause.tuberculosis);
      }
      if (suggestsMalignancy) {
        causes.add(PleuralFluidCause.malignancy);
      }
      if (suggestsRheumatoid) {
        causes.add(PleuralFluidCause.rheumatoid);
      }
      
      // If no specific cause identified, add common exudate causes
      if (causes.isEmpty) {
        causes.addAll([
          PleuralFluidCause.pneumonia,
          PleuralFluidCause.malignancy,
          PleuralFluidCause.pulmonaryEmbolism,
          PleuralFluidCause.tuberculosis,
        ]);
      }
    }

    if (causes.isEmpty) {
      causes.add(PleuralFluidCause.unknown);
    }

    return causes;
  }

  Map<String, dynamic> toJson() {
    return {
      'protein': protein,
      'ldh': ldh,
      'glucose': glucose,
      'ph': ph,
      'cellCount': cellCount,
      'neutrophils': neutrophils,
      'lymphocytes': lymphocytes,
      'cholesterol': cholesterol,
      'triglycerides': triglycerides,
      'appearance': appearance.toString(),
      'timestamp': timestamp.toIso8601String(),
      'serumProtein': serumProtein,
      'serumLdh': serumLdh,
      'serumGlucose': serumGlucose,
      'notes': notes,
    };
  }

  factory PleuralFluidResult.fromJson(Map<String, dynamic> json) {
    return PleuralFluidResult(
      protein: json['protein']?.toDouble() ?? 0.0,
      ldh: json['ldh']?.toDouble() ?? 0.0,
      glucose: json['glucose']?.toDouble() ?? 0.0,
      ph: json['ph']?.toDouble() ?? 7.0,
      cellCount: json['cellCount']?.toInt() ?? 0,
      neutrophils: json['neutrophils']?.toInt() ?? 0,
      lymphocytes: json['lymphocytes']?.toInt() ?? 0,
      cholesterol: json['cholesterol']?.toDouble() ?? 0.0,
      triglycerides: json['triglycerides']?.toDouble() ?? 0.0,
      appearance: PleuralFluidAppearance.values.firstWhere(
        (e) => e.toString() == json['appearance'],
        orElse: () => PleuralFluidAppearance.clear,
      ),
      timestamp: DateTime.parse(json['timestamp']),
      serumProtein: json['serumProtein']?.toDouble() ?? 7.0,
      serumLdh: json['serumLdh']?.toDouble() ?? 200.0,
      serumGlucose: json['serumGlucose']?.toDouble() ?? 100.0,
      notes: json['notes'],
    );
  }

  PleuralFluidResult copyWith({
    double? protein,
    double? ldh,
    double? glucose,
    double? ph,
    int? cellCount,
    int? neutrophils,
    int? lymphocytes,
    double? cholesterol,
    double? triglycerides,
    PleuralFluidAppearance? appearance,
    DateTime? timestamp,
    double? serumProtein,
    double? serumLdh,
    double? serumGlucose,
    String? notes,
  }) {
    return PleuralFluidResult(
      protein: protein ?? this.protein,
      ldh: ldh ?? this.ldh,
      glucose: glucose ?? this.glucose,
      ph: ph ?? this.ph,
      cellCount: cellCount ?? this.cellCount,
      neutrophils: neutrophils ?? this.neutrophils,
      lymphocytes: lymphocytes ?? this.lymphocytes,
      cholesterol: cholesterol ?? this.cholesterol,
      triglycerides: triglycerides ?? this.triglycerides,
      appearance: appearance ?? this.appearance,
      timestamp: timestamp ?? this.timestamp,
      serumProtein: serumProtein ?? this.serumProtein,
      serumLdh: serumLdh ?? this.serumLdh,
      serumGlucose: serumGlucose ?? this.serumGlucose,
      notes: notes ?? this.notes,
    );
  }
}
