// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
part 'add.g.dart';

@HiveType(typeId: 1)
class AddData extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String explain;

  @HiveField(2)
  String amount;
  @HiveField(3)
  String IN;
  @HiveField(4)
  DateTime datetime;

  AddData({
    required this.name,
    required this.explain,
    required this.amount,
    required this.IN,
    required this.datetime,
  });
}
