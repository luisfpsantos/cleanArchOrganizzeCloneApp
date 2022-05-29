import 'package:organizze_app/app/categories/domain/entities/category_entity.dart';

class CategoryDto extends CategoryEntity {
  CategoryDto({
    required super.categoryType,
    required super.name,
    required super.iconPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryType': categoryType,
      'name': name,
      'iconPath': iconPath,
    };
  }
}
