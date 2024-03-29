import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  String? firstname;
  @HiveField(1)
  String? lastName;
  @HiveField(2)
  String? address;
}
