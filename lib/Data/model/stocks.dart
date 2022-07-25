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
