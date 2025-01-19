import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mosam/core/db/db.dart';
import 'package:mosam/core/router/app_router.dart';
import 'package:mosam/features/home/provider/home_provider.dart';
import 'package:mosam/features/home/respository/models/search_model.dart';
import 'dart:async';

import 'package:mosam/features/search/repository/models/search_city_model.dart';
import 'package:mosam/features/search/repository/search_repositoy.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/src/shared_preferences_legacy.dart';

class SearchProvider with ChangeNotifier {
  List<SearchList> _results = [];
  bool _loading = false;
  Timer? _debounce;
  final SearchRepository searchRepository;
  final Db db;

  List<SearchList> get results => _results;
  bool get loading => _loading;

  SearchProvider({
    required this.searchRepository,
    required this.db,
  });

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (query.length > 3) {
        _fetchData(query);
      } else {
        emptyResultsList();
      }
    });
  }

  Future<void> _fetchData(String query) async {
    setLoading(true);
    try {
      await searchRepository.searchByCity(cityName: query).then((value) {
        setSearchList(value);
        setLoading(false);
      }).catchError((e) {});
    } catch (e) {
      setLoading(false);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setSearchList(SearchCityModel value) {
    _results = value.searchList ?? [];
  }

  void saveSearchResult(
      {required BuildContext context, required SearchList searchList}) {
    context.goNamed(RouterConstants.homePage);
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    emptyResultsList();

    weatherProvider.setCityName(searchList.name ?? "");
    weatherProvider.setCountryName(searchList.sys!.country ?? "");
    db.saveSearchModel(
      SearchModel(
        cityName: searchList.name ?? "Hyderabad",
        countryName: searchList.sys!.country ?? "IN",
        latitude: (searchList.coord!.lat ?? 17.3753).toDouble(),
        longitude: (searchList.coord!.lon ?? 78.4744).toDouble(),
        isCelsius: true,
      ),
    );
    weatherProvider.fetchWeather(
        searchList.coord!.lat!.toDouble(), searchList.coord!.lon!.toDouble());
  }

  void emptyResultsList() {
    _results = [];
    notifyListeners();
  }
}
