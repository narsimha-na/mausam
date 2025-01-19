class SearchCityModel {
  String? message;
  String? cod;
  num? count;
  List<SearchList>? searchList;

  SearchCityModel({this.message, this.cod, this.count, this.searchList});

  SearchCityModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    cod = json['cod'];
    count = json['count'];
    if (json['list'] != null) {
      searchList = <SearchList>[];
      json['list'].forEach((v) {
        searchList!.add(SearchList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['cod'] = cod;
    data['count'] = count;
    if (searchList != null) {
      data['searchList'] = searchList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'SearchCityModel(message: $message, cod: $cod, count: $count, searchList: $searchList)';
  }
}

class SearchList {
  num? id;
  String? name;
  Coord? coord;
  Main? main;
  num? dt;
  Wind? wind;
  Sys? sys;

  Clouds? clouds;
  List<Weather>? weather;

  SearchList(
      {this.id,
      this.name,
      this.coord,
      this.main,
      this.dt,
      this.wind,
      this.sys,
      this.clouds,
      this.weather});

  SearchList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    dt = json['dt'];
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
    sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
    clouds = json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (coord != null) {
      data['coord'] = coord!.toJson();
    }
    if (main != null) {
      data['main'] = main!.toJson();
    }
    data['dt'] = dt;
    if (wind != null) {
      data['wind'] = wind!.toJson();
    }
    if (sys != null) {
      data['sys'] = sys!.toJson();
    }

    if (clouds != null) {
      data['clouds'] = clouds!.toJson();
    }
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'SearchList(id: $id, name: $name, coord: $coord, main: $main, dt: $dt, wind: $wind, sys: $sys, clouds: $clouds, weather: $weather)';
  }
}

class Coord {
  num? lat;
  num? lon;

  Coord({this.lat, this.lon});

  Coord.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }

  @override
  String toString() {
    return 'Coord(lat: $lat, lon: $lon)';
  }
}

class Main {
  num? temp;
  num? feelsLike;
  num? tempMin;
  num? tempMax;
  num? pressure;
  num? humidity;
  num? seaLevel;
  num? grndLevel;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity,
      this.seaLevel,
      this.grndLevel});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['sea_level'] = seaLevel;
    data['grnd_level'] = grndLevel;
    return data;
  }

  @override
  String toString() {
    return 'Main(temp: $temp, feelsLike: $feelsLike, tempMin: $tempMin, tempMax: $tempMax, pressure: $pressure, humidity: $humidity, seaLevel: $seaLevel, grndLevel: $grndLevel)';
  }
}

class Wind {
  num? speed;
  num? deg;

  Wind({this.speed, this.deg});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    return data;
  }

  @override
  String toString() {
    return 'Wind(speed: $speed, deg: $deg)';
  }
}

class Sys {
  String? country;

  Sys({this.country});

  Sys.fromJson(Map<String, dynamic> json) {
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    return data;
  }

  @override
  String toString() {
    return 'Sys(country: $country)';
  }
}

class Clouds {
  num? all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['all'] = all;
    return data;
  }

  @override
  String toString() {
    return 'Clouds(all: $all)';
  }
}

class Weather {
  num? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }

  @override
  String toString() {
    return 'Weather(id: $id, main: $main, description: $description, icon: $icon)';
  }
}
