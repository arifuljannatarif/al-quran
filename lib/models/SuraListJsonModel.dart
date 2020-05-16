// To parse this JSON data, do
//
//     final surahListJsonModel = surahListJsonModelFromJson(jsonString);

import 'dart:convert';

import 'package:alquran/models/SurahListModel.dart';

SurahListJsonModel surahListJsonModelFromJson(String str) =>
    SurahListJsonModel.fromJson(json.decode(str));

String surahListJsonModelToJson(SurahListJsonModel data) =>
    json.encode(data.toJson());

class SurahListJsonModel {
  int code;
  String status;
  List<SingleSuraModel> data;

  SurahListJsonModel({
    this.code,
    this.status,
    this.data,
  });

  factory SurahListJsonModel.fromJson(Map<String, dynamic> json) =>
      SurahListJsonModel(
        code: json["code"],
        status: json["status"],
        data: List<SingleSuraModel>.from(
            json["data"].map((x) => SingleSuraModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
/*

class Datum {
  int number;
  String name;
  String englishName;
  String englishNameTranslation;
  int numberOfAyahs;
  RevelationType revelationType;

  Datum({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.numberOfAyahs,
    this.revelationType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        number: json["number"],
        name: json["name"],
        englishName: json["englishName"],
        englishNameTranslation: json["englishNameTranslation"],
        numberOfAyahs: json["numberOfAyahs"],
        revelationType: revelationTypeValues.map[json["revelationType"]],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "englishName": englishName,
        "englishNameTranslation": englishNameTranslation,
        "numberOfAyahs": numberOfAyahs,
        "revelationType": revelationTypeValues.reverse[revelationType],
      };
}
*/

enum RevelationType { MECCAN, MEDINAN }

final revelationTypeValues = EnumValues(
    {"Meccan": RevelationType.MECCAN, "Medinan": RevelationType.MEDINAN});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
