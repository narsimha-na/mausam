import 'dart:developer';

import 'package:mosam/core/constants/string_constants.dart';
import 'package:mosam/core/env/env.dart';
import 'package:mosam/features/search/repository/models/search_city_model.dart';
import 'package:mosam/features/search/repository/search_repositoy.dart';
import 'package:mosam/service/network.dart';

class SearchRepositoryImpl extends SearchRepository {
  final NetworkService networkService;

  SearchRepositoryImpl({required this.networkService});

  @override
  Future<SearchCityModel> searchByCity({required String cityName}) async {
    try {
      log(UrlConstants.searchCityName(
          cityName: cityName, apiId: Env.weatherApiKey));
      final response = await networkService.get(
        UrlConstants.searchCityName(
          cityName: cityName,
          apiId: Env.weatherApiKey,
        ),
      );

      if (response.statusCode == 200) {
        return SearchCityModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather forcast');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
