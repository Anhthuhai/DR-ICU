import '../entities/conversion_category.dart';
import '../repositories/unit_converter_repository.dart';

class GetConversionCategoriesUseCase {
  final UnitConverterRepository repository;

  const GetConversionCategoriesUseCase(this.repository);

  Future<List<ConversionCategory>> call() async {
    try {
      return await repository.getCategories();
    } catch (e) {
      throw Exception('Failed to get conversion categories: $e');
    }
  }
}
