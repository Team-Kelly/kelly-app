class WeatherDO {
  static List<int> rainProb = [];
  static List<int> rainStatusCode = [];
}

// DO, DTO 구조

class WeatherDTO {
  static WeatherDO getData() {
    WeatherDO result = WeatherDO();

    result.rainProb = [
      123,
      2,
      31,
      23,
      2,
    ];

    return result;
  }
}
