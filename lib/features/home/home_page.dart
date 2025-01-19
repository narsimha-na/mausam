import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mosam/core/constants/assets_constants.dart';
import 'package:mosam/core/constants/color_constants.dart';
import 'package:mosam/core/constants/font_constants.dart';
import 'package:mosam/core/functions/general_functions.dart';
import 'package:mosam/core/router/app_router.dart';
import 'package:mosam/features/home/provider/home_provider.dart';
import 'package:mosam/features/home/respository/models/daily_weather_forecast.dart';
import 'package:mosam/features/home/widgets/temperature_unit_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgWhiteColor,
      body: Stack(
        children: [
          Consumer<WeatherProvider>(builder: (context, weatherProvider, child) {
            return CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 300.0,
                  floating: true,
                  snap: true,
                  backgroundColor: ColorConstants.bgWhiteColor,
                  collapsedHeight: 62,
                  flexibleSpace:
                      _headerWidget(weatherProvider: weatherProvider),
                ),
                SliverToBoxAdapter(
                  child: _bodyWidget(weatherProvider: weatherProvider),
                ),
              ],
              controller: ScrollController(),
            );
          }),
          _floatingActionButton(),
        ],
      ),
    );
  }

  _headerWidget({required WeatherProvider weatherProvider}) {
    return ListView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 56),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Mausam',
              style: TextStyle(
                fontFamily: FontConstants.snigletRegular,
                fontSize: 36,
                color: ColorConstants.primaryColor,
              ),
            ),
            TemperatureUnitWidget(weatherProvider: weatherProvider),
          ],
        ),
        const SizedBox(height: 36),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              weatherProvider.weatherTemp,
              style: const TextStyle(
                fontFamily: FontConstants.snigletRegular,
                fontSize: 64,
                color: ColorConstants.secondaryColor,
              ),
            ),
            Image.asset(
              weatherProvider.weatherIcon,
              height: 92,
              fit: BoxFit.cover,
            ),
          ],
        ),
        Text(
          weatherProvider.weatherDescription,
          style: const TextStyle(
            fontFamily: FontConstants.poppinsSemiBold,
            fontSize: 24,
            color: ColorConstants.primaryColor,
          ),
        ),
        const SizedBox(height: 26),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              ImageConstants.location,
              height: 28,
            ),
            const SizedBox(width: 4),
            Text(
              weatherProvider.cityName,
              style: const TextStyle(
                fontFamily: FontConstants.poppinsRegular,
                fontSize: 24,
                color: ColorConstants.blackColor,
                height: 1.0,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              weatherProvider.countryName,
              style: const TextStyle(
                fontFamily: FontConstants.poppinsRegular,
                fontSize: 14,
                color: ColorConstants.blackColor,
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Image.network(
                getCountryImagePath(weatherProvider.countryName),
                height: 16,
                width: 16,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 34.0),
          child: Text(
            weatherProvider.weatherFeelsLike,
            style: const TextStyle(
              fontFamily: FontConstants.poppinsRegular,
              fontSize: 14,
              color: ColorConstants.greyColor,
            ),
          ),
        ),
      ],
    );
  }

  _itemWidget(String title, String value, String imagePath) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorConstants.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              imagePath,
              height: 26,
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: const TextStyle(
                fontFamily: FontConstants.poppinsSemiBold,
                fontSize: 12,
                color: ColorConstants.purpuleColor,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              value,
              style: TextStyle(
                fontFamily: FontConstants.poppinsBold,
                fontSize: 12,
                color: ColorConstants.blackColor.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _itemHourlyWidget(DailyWeatherForecastDetails dailyWeatherForecastDetail) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Column(
        children: [
          Text(
            dailyWeatherForecastDetail.temperature.toString(),
            style: const TextStyle(
              fontFamily: FontConstants.snigletRegular,
              fontSize: 13,
              color: ColorConstants.blackColor,
            ),
          ),
          const SizedBox(height: 8),
          Image.asset(
            dailyWeatherForecastDetail.imgPath,
            height: 24,
          ),
          const SizedBox(height: 8),
          Text(
            dailyWeatherForecastDetail.date,
            style: const TextStyle(
              fontFamily: FontConstants.poppinsSemiBold,
              fontSize: 12,
              color: ColorConstants.greyColor,
            ),
          ),
        ],
      ),
    );
  }

  _bodyWidget({required WeatherProvider weatherProvider}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 64),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _itemWidget('Wind', weatherProvider.weatherWindSpeed,
                  ImageConstants.wind),
              const SizedBox(width: 12),
              _itemWidget('Humidity', weatherProvider.weatherHumidity,
                  ImageConstants.humidity),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _itemWidget('Sunrise', weatherProvider.weatherSunrise,
                  ImageConstants.sunRise),
              const SizedBox(width: 12),
              _itemWidget('Sunset', weatherProvider.weatherSunset,
                  ImageConstants.sunSet),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 24),
            itemCount: weatherProvider.dailyWeatherForecast.isNotEmpty
                ? weatherProvider.dailyWeatherForecast.length
                : 0,
            itemBuilder: (context, index) {
              return _itemDailyWidget(
                  weatherProvider.dailyWeatherForecast[index]);
            },
          ),
        ],
      ),
    );
  }

  _itemDailyWidget(DailyWeatherForecast dailyWeatherForecast) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: ColorConstants.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dailyWeatherForecast.date,
                style: const TextStyle(
                  fontFamily: FontConstants.poppinsSemiBold,
                  fontSize: 16,
                  color: ColorConstants.purpuleColor,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                dailyWeatherForecast.weatherDescription,
                style: const TextStyle(
                  fontFamily: FontConstants.poppinsSemiBold,
                  fontSize: 16,
                  color: ColorConstants.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: ColorConstants.greyColor,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 90,
            child: ListView.builder(
              itemCount:
                  dailyWeatherForecast.dailyWeatherForecastDetails.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _itemHourlyWidget(
                    dailyWeatherForecast.dailyWeatherForecastDetails[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  _floatingActionButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(36.0),
        child: FloatingActionButton(
          onPressed: () {
            context.pushNamed(RouterConstants.searchPage);
          },
          child: const Icon(Icons.search, color: ColorConstants.purpuleColor),
        ),
      ),
    );
  }
}
