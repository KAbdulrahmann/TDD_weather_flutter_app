class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = '9b1e3a1b5f764cf42647f7f5829b8c4c';

  static String currentWeatherByName(String city) =>
      '$baseUrl/weather?q=$city&appid=$apiKey';

  static String weatherIcon(String iconCode) =>
      'https://openweathermap.org/img/wn/$iconCode.png';
}
