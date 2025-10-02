class ConversionUnit {
  final String id;
  final String name;
  final String symbol;
  final String description;
  final double conversionFactor; // Factor to convert to base unit
  final bool isBaseUnit; // True if this is the base unit for the category

  const ConversionUnit({
    required this.id,
    required this.name,
    required this.symbol,
    required this.description,
    required this.conversionFactor,
    this.isBaseUnit = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversionUnit &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => '$name ($symbol)';
}
