import 'dart:ffi';

import 'package:finance/lite/supa.dart';
import 'package:finance/model/category.model.dart';
import 'package:finance/service/category.service.dart';

class CategoryImpl extends Supa implements CategoryService {
  @override
  void delete(Category category) {}

  @override
  Future<List<Category>> findAll() async {
    try {
      var response = await client.from('category').select();
      List jsonResponse = response as List;
      return jsonResponse.map((data) => Category.fromMap(data)).toList();
    } catch (e) {
      print(e);
      throw new UnimplementedError();
    }
  }

  @override
  Future<Category> findOne() {
    throw UnimplementedError();
  }

  @override
  Future<Category> save(Category category) async {
    try {
      var response = await client
          .from('category')
          .insert(category.toMapWithoutId())
          .select();
      List jsonResponse = response as List;
      Category t =
          jsonResponse.map((data) => Category.fromMap(data)).toList().first;
      return t;
    } catch (e) {
      print(e);
      throw UnimplementedError();
    }
  }
}
