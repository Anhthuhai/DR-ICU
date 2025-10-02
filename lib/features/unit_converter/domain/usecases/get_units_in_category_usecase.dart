import '../entities/conversion_unit.dart';
import '../repositories/unit_converter_repository.dart';

class GetUnitsInCategoryUseCase {
  final UnitConverterRepository repository;

  const GetUnitsInCategoryUseCase(this.repository);

  Future<List<ConversionUnit>> call(String categoryId) async {
    try {
      if (categoryId.isEmpty) {
        throw Exception('Category ID cannot be empty');
      }

      return await repository.getUnitsInCategory(categoryId);
    } catch (e) {
      throw Exception('Failed to get units in category: $e');
    }
  }
}
