import 'dart:convert';
import 'dart:developer';

import 'package:mosam/features/home/respository/models/search_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Db {
  final SharedPreferences sharedPreferences;

  Db({required this.sharedPreferences});

  Future<void> saveSearchModel(SearchModel model) async {
    log("model: ${model.toMap().toString()}");
    await sharedPreferences.setString(
        "searchModel", json.encode(model.toMap()));
    log("model saved");
    log("model after save: ${sharedPreferences.getString("searchModel")}");
  }

  Future<SearchModel> getSearchModel() async {
    String? searchModel = sharedPreferences.getString("searchModel");
    if (searchModel == null) {
      return SearchModel(
          cityName: "Hyderabad",
          countryName: "IN",
          latitude: 17.3753,
          longitude: 78.4744,
          isCelsius: true);
    }
    return SearchModel.fromMap(json.decode(searchModel));
  }
}
