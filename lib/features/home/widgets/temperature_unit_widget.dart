import 'package:flutter/cupertino.dart';
import 'package:mosam/core/constants/color_constants.dart';
import 'package:mosam/core/constants/font_constants.dart';
import 'package:mosam/features/home/provider/home_provider.dart';

class TemperatureUnitWidget extends StatelessWidget {
  final WeatherProvider weatherProvider;

  const TemperatureUnitWidget({
    super.key,
    required this.weatherProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          '°F\t',
          style: TextStyle(
            fontFamily: FontConstants.snigletRegular,
            fontSize: 24,
            color: ColorConstants.primaryColor,
          ),
        ),
        CupertinoSwitch(
          activeColor: ColorConstants.primaryColor,
          thumbColor: ColorConstants.greenColor,
          trackColor: ColorConstants.primaryColor,
          focusColor: ColorConstants.whiteColor,
          value: weatherProvider.isCelsius,
          onChanged: (value) {
            weatherProvider.setIsCelsius(value);
          },
        ),
        const Text(
          '\t°C',
          style: TextStyle(
            fontFamily: FontConstants.snigletRegular,
            fontSize: 24,
            color: ColorConstants.primaryColor,
          ),
        ),
      ],
    );
  }
}
