// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// To parse this JSON data, do
//
//     final UserProfile = StocksFromJson(jsonString);

List<UserProfile> userProfileFromJson(String str) => List<UserProfile>.from(
    json.decode(str).map((x) => UserProfile.fromJson(x)));

String userProfileToJson(List<UserProfile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserProfile {
  UserProfile({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.imageUrl,
    this.created,
  });

  final String? id;
  final String firstName;
  final String lastName;
  final String address;
  final String imageUrl;
  DateTime? created;

  UserProfile copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? address,
    String? imageUrl,
    DateTime? created,
  }) =>
      UserProfile(
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          address: address ?? this.address,
          created: created ?? this.created,
          imageUrl: imageUrl ?? this.imageUrl,
          id: id ?? this.id);

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        address: json["address"] ?? "",
        imageUrl: json["imageUrl"] ?? "",

        created: DateTime.parse(json["created"]),

        // steps: List<Steps>.from(json["steps"].map((x) => Steps.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "firstName": firstName,
        "lastName": lastName,
        "address": address,
        "imageUrl": imageUrl,

        "created": created?.toIso8601String(),

        // "steps": List<dynamic>.from(steps!.map((x) => x.toJson())),
      };
}
