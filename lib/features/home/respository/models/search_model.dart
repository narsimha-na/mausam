class SearchModel {
  final String cityName;
  final String countryName;
  final double latitude;
  final double longitude;
  final bool isCelsius;

  SearchModel({
    required this.cityName,
    required this.countryName,
    required this.latitude,
    required this.longitude,
    required this.isCelsius,
  });
  @override
  String toString() {
    return 'SearchCityModel(cityName: $cityName, countryName: $countryName, latitude: $latitude, longitude: $longitude, isCelsius: $isCelsius)';
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cityName'] = cityName;
    data['countryName'] = countryName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['isCelsius'] = isCelsius;
    return data;
  }

  factory SearchModel.fromMap(Map<String, dynamic> map) {
    return SearchModel(
      cityName: map['cityName'] ?? "Hyderabad",
      countryName: map['countryName'] ?? "IN",
      latitude: map['latitude'] ?? 17.3753,
      longitude: map['longitude'] ?? 78.4744,
      isCelsius: map['isCelsius'] ?? true,
    );
  }
}
