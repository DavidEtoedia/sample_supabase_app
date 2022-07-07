// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// To parse this JSON data, do
//
//     final Stocks = StocksFromJson(jsonString);

List<Stocks> stocksFromJson(String str) =>
    List<Stocks>.from(json.decode(str).map((x) => Stocks.fromJson(x)));

String stocksToJson(List<Stocks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stocks {
  Stocks({
    this.id,
    required this.itemName,
    required this.itemQuantity,
    required this.itemAmount,
    this.created,
  });

  final String? id;
  final String itemName;
  final int itemQuantity;
  final int itemAmount;
  DateTime? created;

  Stocks copyWith({
    String? id,
    String? itemName,
    int? itemQuantity,
    int? itemAmount,
    DateTime? created,
  }) =>
      Stocks(
          itemName: itemName ?? this.itemName,
          itemQuantity: itemQuantity ?? this.itemQuantity,
          itemAmount: itemAmount ?? this.itemAmount,
          created: created ?? this.created,
          id: id ?? this.id);

  factory Stocks.fromJson(Map<String, dynamic> json) => Stocks(
        id: json["id"] ?? "",
        itemName: json["itemName"] ?? "",
        itemQuantity: json["itemQuantity"] ?? 0,
        itemAmount: json["itemAmount"] ?? 0,

        created: DateTime.parse(json["created"]),

        // steps: List<Steps>.from(json["steps"].map((x) => Steps.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "itemName": itemName,
        "itemQuantity": itemQuantity,
        "itemAmount": itemAmount,

        "created": created!.toIso8601String(),

        // "steps": List<dynamic>.from(steps!.map((x) => x.toJson())),
      };
}


// class Stocks {
//   final String id;
//   final String itemName;
//   final int itemQuantity;
//   final int itemAmount;
//   final DateTime created;
//   Stocks({
//     required this.id,
//     required this.itemName,
//     required this.itemQuantity,
//     required this.itemAmount,
//     required this.created,
//   });

//   Stocks copyWith({
//     String? id,
//     String? itemName,
//     int? itemQuantity,
//     int? itemAmount,
//     DateTime? created,
//   }) {
//     return Stocks(
//       id: id ?? this.id,
//       itemName: itemName ?? this.itemName,
//       itemQuantity: itemQuantity ?? this.itemQuantity,
//       itemAmount: itemAmount ?? this.itemAmount,
//       created: created ?? this.created,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'itemName': itemName,
//       'itemQuantity': itemQuantity,
//       'itemAmount': itemAmount,
//       'created': created.millisecondsSinceEpoch,
//     };
//   }

//   factory Stocks.fromMap(Map<String, dynamic> map) {
//     return Stocks(
//       id: map['id'] as String,
//       itemName: map['itemName'] as String,
//       itemQuantity: map['itemQuantity'] as int,
//       itemAmount: map['itemAmount'] as int,
//       created: DateTime.fromMillisecondsSinceEpoch(map['created'] as int),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Stocks.fromJson(String source) =>
//       Stocks.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'Stocks(id: $id, itemName: $itemName, itemQuantity: $itemQuantity, itemAmount: $itemAmount, created: $created)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is Stocks &&
//         other.id == id &&
//         other.itemName == itemName &&
//         other.itemQuantity == itemQuantity &&
//         other.itemAmount == itemAmount &&
//         other.created == created;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         itemName.hashCode ^
//         itemQuantity.hashCode ^
//         itemAmount.hashCode ^
//         created.hashCode;
//   }
// }
