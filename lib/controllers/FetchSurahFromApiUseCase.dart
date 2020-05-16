import 'dart:convert';

import 'package:alquran/Utils/Utility.dart';
import 'package:alquran/models/MetaInformation.dart';
import 'package:alquran/models/SuraListJsonModel.dart';
import 'package:alquran/models/SurahDetailsModel.dart';
import 'package:alquran/models/SurahListModel.dart';
import 'package:dio/dio.dart';

class FetchApiDataUseCase {
  Future<List<SurahsReference>> getMetaInformations() async {
    var response = await Dio().get(Utility().META_URL);
    final MetaInformationClass metaInformationClass =
        MetaInformationClass.fromJson(json.decode(response.toString()));

    if (response.statusCode == 200) {
      return metaInformationClass.data.surahs.references;
    } else {
      return null;
    }
  }

  Future<List<SingleSuraModel>> fetchSurahList() async {
    var response = await Dio().get(Utility().SURAH_LIST_URL);
    if (response.statusCode == 200) {
      final SurahListJsonModel model =
          SurahListJsonModel.fromJson(json.decode(response.toString()));
      return model.data;
    } else {
      return null;
    }
  }

  Future<SingleSurahDetailsWithAyah> fetchSurahDetails(int surahId) async {
    var response =
        await Dio().get(Utility().SURAH_DETAILS_BASE_URL + surahId.toString());
    if (response.statusCode == 200) {
      final SurahDetailsModel model =
          SurahDetailsModel.fromJson(json.decode(response.toString()));
      print(model.data.englishName);
      return model.data;
    } else {
      return null;
    }
  }
}
