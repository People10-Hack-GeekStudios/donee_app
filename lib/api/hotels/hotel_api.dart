import 'package:fud_app/models/hotel_model.dart';

class HotelApi {
  static HotelModel getHotel() {
    HotelModel hotel = HotelModel.fromJson(hotelMap);
    return hotel;
  }
}

Map<String, dynamic> hotelMap = {
  "_id": "62ec121bb5fe5096f8a6405c",
  "phone": "9947451754",
  "account_type": "admin",
  "profile_completion": 1,
  "is_blocked": false,
  "current_delivery_agent_number": 2,
  "created_at": "2022-08-04T18:38:19.262Z",
  "updated_at": "2022-11-04T03:29:10.382Z",
  "__v": 40,
  "geojson": {
    "coordinates": [77.5520256, 12.976128],
    "type": "Point"
  },
  "name": "Fisat Canteen",
  "donated": true,
  "org_verified": false,
  "donated_items": [
    {
      "geojson": {
        "type": "Point",
        "coordinates": [76.2826562, 10.2466798]
      },
      "_id": "62ec12f7eca8c2e9d3ba5224",
      "created_at": "2022-08-04T18:41:59.881Z",
      "owner": "62ec121bb5fe5096f8a6405c",
      "image": "https://api.fud4.me/upload/v1/cdn/1659638519881.png",
      "name": "Burger",
      "food_type": "arabic",
      "per_day_quantity": 20,
      "price": 88.89,
      "updated_at": "2022-09-26T04:45:29.479Z",
      "__v": 26,
      "quantity": 20,
      "donated": true
    },
    {
      "geojson": {
        "type": "Point",
        "coordinates": [76.2826562, 10.2466798]
      },
      "_id": "62ec139c5d53e457481b4c05",
      "created_at": "2022-08-04T18:44:44.047Z",
      "owner": "62ec121bb5fe5096f8a6405c",
      "image": "https://api.fud4.me/upload/v1/cdn/1659638684045.png",
      "name": "Noodles",
      "food_type": "chinese",
      "per_day_quantity": 88,
      "price": 90,
      "updated_at": "2022-11-02T11:10:59.966Z",
      "__v": 13,
      "quantity": 88,
      "donated": true
    },
    {
      "geojson": {
        "type": "Point",
        "coordinates": [76.2826562, 10.2466798]
      },
      "_id": "62ec13c05d53e457481b4c08",
      "created_at": "2022-08-04T18:45:20.878Z",
      "owner": "62ec121bb5fe5096f8a6405c",
      "image": "https://api.fud4.me/upload/v1/cdn/1659638720878.png",
      "name": "Pizza",
      "food_type": "indian",
      "per_day_quantity": 18,
      "price": 199,
      "updated_at": "2022-11-02T06:56:01.062Z",
      "__v": 12,
      "quantity": 18,
      "donated": true
    },
    {
      "geojson": {
        "type": "Point",
        "coordinates": [76.2826562, 10.2466798]
      },
      "_id": "62ec13e05d53e457481b4c0b",
      "created_at": "2022-08-04T18:45:52.526Z",
      "owner": "62ec121bb5fe5096f8a6405c",
      "image": "https://api.fud4.me/upload/v1/cdn/1659638752526.png",
      "name": "Shawaya",
      "food_type": "arabic",
      "per_day_quantity": 4,
      "price": 299,
      "updated_at": "2022-09-24T17:37:38.968Z",
      "__v": 17,
      "quantity": 4,
      "donated": true
    },
    {
      "geojson": {
        "type": "Point",
        "coordinates": [76.2826562, 10.2466798]
      },
      "_id": "632ec42c5d53e457481b4c0e",
      "created_at": "2022-09-24T08:47:40.183Z",
      "owner": "62ec121bb5fe5096f8a6405c",
      "image": "https://api.fud4.me/upload/v1/cdn/1664009260182.png",
      "name": "Dosa",
      "food_type": "indian",
      "per_day_quantity": 32,
      "price": 99,
      "updated_at": "2022-09-26T04:43:02.671Z",
      "__v": 7,
      "quantity": 32,
      "donated": true
    },
    {
      "geojson": {
        "type": "Point",
        "coordinates": [76.2826562, 10.2466798]
      },
      "_id": "63624e549c5ea0d9d6f634a3",
      "created_at": "2022-11-02T11:02:44.252Z",
      "owner": "62ec121bb5fe5096f8a6405c",
      "image": "https://api.fud4.me/upload/v1/cdn/1667386964249.png",
      "name": "Fried Rice",
      "food_type": "chinese",
      "per_day_quantity": 9,
      "price": 99,
      "updated_at": "2022-11-02T11:06:21.369Z",
      "__v": 1,
      "quantity": 9,
      "donated": true
    },
    {
      "geojson": {
        "type": "Point",
        "coordinates": [76.2826562, 10.2466798]
      },
      "_id": "63625df09c5ea0d9d6f634a6",
      "created_at": "2022-11-02T12:09:20.956Z",
      "owner": "62ec121bb5fe5096f8a6405c",
      "image": "https://api.fud4.me/upload/v1/cdn/1667390960954.png",
      "name": "Biriyani",
      "food_type": "indian",
      "per_day_quantity": 52,
      "price": 100,
      "updated_at": "2022-11-02T12:09:57.543Z",
      "__v": 1,
      "quantity": 52,
      "donated": true
    }
  ]
};
