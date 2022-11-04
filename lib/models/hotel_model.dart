// To parse this JSON data, do
//
//     final hotelModel = hotelModelFromJson(jsonString);

import 'dart:convert';

HotelModel hotelModelFromJson(String str) =>
    HotelModel.fromJson(json.decode(str));

String hotelModelToJson(HotelModel data) => json.encode(data.toJson());

class HotelModel {
  HotelModel({
    required this.id,
    required this.phone,
    required this.accountType,
    required this.profileCompletion,
    required this.isBlocked,
    required this.currentDeliveryAgentNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.geojson,
    required this.name,
    required this.donated,
    required this.orgVerified,
    required this.donatedItems,
  });

  String id;
  String phone;
  String accountType;
  int profileCompletion;
  bool isBlocked;
  int currentDeliveryAgentNumber;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  Geojson geojson;
  String name;
  bool donated;
  bool orgVerified;
  List<DonatedItem> donatedItems;

  factory HotelModel.fromJson(Map<String, dynamic> json) => HotelModel(
        id: json["_id"],
        phone: json["phone"],
        accountType: json["account_type"],
        profileCompletion: json["profile_completion"],
        isBlocked: json["is_blocked"],
        currentDeliveryAgentNumber: json["current_delivery_agent_number"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"],
        geojson: Geojson.fromJson(json["geojson"]),
        name: json["name"],
        donated: json["donated"],
        orgVerified: json["org_verified"],
        donatedItems: List<DonatedItem>.from(
            json["donated_items"].map((x) => DonatedItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "phone": phone,
        "account_type": accountType,
        "profile_completion": profileCompletion,
        "is_blocked": isBlocked,
        "current_delivery_agent_number": currentDeliveryAgentNumber,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
        "geojson": geojson.toJson(),
        "name": name,
        "donated": donated,
        "org_verified": orgVerified,
        "donated_items":
            List<dynamic>.from(donatedItems.map((x) => x.toJson())),
      };
}

class DonatedItem {
  DonatedItem({
    required this.geojson,
    required this.id,
    required this.createdAt,
    required this.owner,
    required this.image,
    required this.name,
    required this.foodType,
    required this.perDayQuantity,
    required this.price,
    required this.updatedAt,
    required this.v,
    required this.quantity,
    required this.donated,
  });

  Geojson geojson;
  String id;
  DateTime createdAt;
  String owner;
  String image;
  String name;
  String foodType;
  int perDayQuantity;
  double price;
  DateTime updatedAt;
  int v;
  int quantity;
  bool donated;

  factory DonatedItem.fromJson(Map<String, dynamic> json) => DonatedItem(
        geojson: Geojson.fromJson(json["geojson"]),
        id: json["_id"],
        createdAt: DateTime.parse(json["created_at"]),
        owner: json["owner"],
        image: json["image"],
        name: json["name"],
        foodType: json["food_type"],
        perDayQuantity: json["per_day_quantity"],
        price: json["price"].toDouble(),
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"],
        quantity: json["quantity"],
        donated: json["donated"],
      );

  Map<String, dynamic> toJson() => {
        "geojson": geojson.toJson(),
        "_id": id,
        "created_at": createdAt.toIso8601String(),
        "owner": owner,
        "image": image,
        "name": name,
        "food_type": foodType,
        "per_day_quantity": perDayQuantity,
        "price": price,
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
        "quantity": quantity,
        "donated": donated,
      };
}

class Geojson {
  Geojson({
    required this.type,
    required this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Geojson.fromJson(Map<String, dynamic> json) => Geojson(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}
