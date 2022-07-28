import 'package:hive/hive.dart';

part 'items.g.dart';

@HiveType(typeId: 0)
class Items extends HiveObject {
  @HiveField(1)
  String? itemName;
  @HiveField(2)
  String? itmeAmount;
  @HiveField(3)
  String? itemQuantity;
  @HiveField(4)
  String? itemId;
}
