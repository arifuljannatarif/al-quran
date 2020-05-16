// To parse this JSON data, do
//
//     final metaInformationClass = metaInformationClassFromJson(jsonString);

import 'dart:convert';

MetaInformationClass metaInformationClassFromJson(String str) =>
    MetaInformationClass.fromJson(json.decode(str));

String metaInformationClassToJson(MetaInformationClass data) =>
    json.encode(data.toJson());

class MetaInformationClass {
  int code;
  String status;
  Data data;

  MetaInformationClass({
    this.code,
    this.status,
    this.data,
  });

  factory MetaInformationClass.fromJson(Map<String, dynamic> json) =>
      MetaInformationClass(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Ayahs ayahs;
  Surahs surahs;
  Sajdas sajdas;
  HizbQuarters rukus;
  HizbQuarters pages;
  HizbQuarters manzils;
  HizbQuarters hizbQuarters;
  HizbQuarters juzs;

  Data({
    this.ayahs,
    this.surahs,
    this.sajdas,
    this.rukus,
    this.pages,
    this.manzils,
    this.hizbQuarters,
    this.juzs,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ayahs: Ayahs.fromJson(json["ayahs"]),
        surahs: Surahs.fromJson(json["surahs"]),
        sajdas: Sajdas.fromJson(json["sajdas"]),
        rukus: HizbQuarters.fromJson(json["rukus"]),
        pages: HizbQuarters.fromJson(json["pages"]),
        manzils: HizbQuarters.fromJson(json["manzils"]),
        hizbQuarters: HizbQuarters.fromJson(json["hizbQuarters"]),
        juzs: HizbQuarters.fromJson(json["juzs"]),
      );

  Map<String, dynamic> toJson() => {
        "ayahs": ayahs.toJson(),
        "surahs": surahs.toJson(),
        "sajdas": sajdas.toJson(),
        "rukus": rukus.toJson(),
        "pages": pages.toJson(),
        "manzils": manzils.toJson(),
        "hizbQuarters": hizbQuarters.toJson(),
        "juzs": juzs.toJson(),
      };
}

class Ayahs {
  int count;

  Ayahs({
    this.count,
  });

  factory Ayahs.fromJson(Map<String, dynamic> json) => Ayahs(
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
      };
}

class HizbQuarters {
  int count;
  List<HizbQuartersReference> references;

  HizbQuarters({
    this.count,
    this.references,
  });

  factory HizbQuarters.fromJson(Map<String, dynamic> json) => HizbQuarters(
        count: json["count"],
        references: List<HizbQuartersReference>.from(
            json["references"].map((x) => HizbQuartersReference.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "references": List<dynamic>.from(references.map((x) => x.toJson())),
      };
}

class HizbQuartersReference {
  int surah;
  int ayah;

  HizbQuartersReference({
    this.surah,
    this.ayah,
  });

  factory HizbQuartersReference.fromJson(Map<String, dynamic> json) =>
      HizbQuartersReference(
        surah: json["surah"],
        ayah: json["ayah"],
      );

  Map<String, dynamic> toJson() => {
        "surah": surah,
        "ayah": ayah,
      };
}

class Sajdas {
  int count;
  List<SajdasReference> references;

  Sajdas({
    this.count,
    this.references,
  });

  factory Sajdas.fromJson(Map<String, dynamic> json) => Sajdas(
        count: json["count"],
        references: List<SajdasReference>.from(
            json["references"].map((x) => SajdasReference.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "references": List<dynamic>.from(references.map((x) => x.toJson())),
      };
}

class SajdasReference {
  int surah;
  int ayah;
  bool recommended;
  bool obligatory;

  SajdasReference({
    this.surah,
    this.ayah,
    this.recommended,
    this.obligatory,
  });

  factory SajdasReference.fromJson(Map<String, dynamic> json) =>
      SajdasReference(
        surah: json["surah"],
        ayah: json["ayah"],
        recommended: json["recommended"],
        obligatory: json["obligatory"],
      );

  Map<String, dynamic> toJson() => {
        "surah": surah,
        "ayah": ayah,
        "recommended": recommended,
        "obligatory": obligatory,
      };
}

class Surahs {
  int count;
  List<SurahsReference> references;

  Surahs({
    this.count,
    this.references,
  });

  factory Surahs.fromJson(Map<String, dynamic> json) => Surahs(
        count: json["count"],
        references: List<SurahsReference>.from(
            json["references"].map((x) => SurahsReference.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "references": List<dynamic>.from(references.map((x) => x.toJson())),
      };
}

class SurahsReference {
  int number;
  String name;
  String englishName;
  String englishNameTranslation;
  int numberOfAyahs;
  RevelationType revelationType;

  SurahsReference({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.numberOfAyahs,
    this.revelationType,
  });

  factory SurahsReference.fromJson(Map<String, dynamic> json) =>
      SurahsReference(
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
