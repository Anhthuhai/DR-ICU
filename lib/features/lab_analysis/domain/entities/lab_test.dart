enum LabSeverity { normal, mild, moderate, severe, critical, borderline }

class LabTest {
  final String id;
  final String name;
  final String unit;
  final double normalMin;
  final double normalMax;
  final String description;
  final String category;

  const LabTest({
    required this.id,
    required this.name,
    required this.unit,
    required this.normalMin,
    required this.normalMax,
    required this.description,
    this.category = 'General',
  });

  String get displayName => name;
  
  String get normalRange => '$normalMin - $normalMax $unit';

  LabTest copyWith({
    String? id,
    String? name,
    String? unit,
    double? normalMin,
    double? normalMax,
    String? description,
    String? category,
  }) {
    return LabTest(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      normalMin: normalMin ?? this.normalMin,
      normalMax: normalMax ?? this.normalMax,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }
}

class LabTestEntry {
  final String id;
  final String testId;
  final double value;
  final DateTime date;
  final String notes;

  const LabTestEntry({
    required this.id,
    required this.testId,
    required this.value,
    required this.date,
    this.notes = '',
  });

  LabSeverity get severity {
    // This should be implemented based on the test's normal range
    return LabSeverity.normal; // Placeholder
  }
}
