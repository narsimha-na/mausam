import 'package:mosam/features/search/repository/models/search_city_model.dart';

abstract class SearchRepository {
  Future<SearchCityModel> searchByCity({required String cityName});
}
