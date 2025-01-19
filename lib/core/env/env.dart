import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'WWEATHER_API_KEY', obfuscate: true)
  static final String weatherApiKey = _Env.weatherApiKey;
}
