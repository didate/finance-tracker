import 'package:finance/model/category.model.dart';

abstract class CategoryService {
  Future<Category> findOne();
  Future<List<Category>> findAll();
  Future<Category> save(Category category);
  void delete(Category category);
}
