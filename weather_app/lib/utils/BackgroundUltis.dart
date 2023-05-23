class BackgroundUltis{
  static Map<int, String> idToUrlMapDay = {
    // Group 2xx: Thunderstorm
    200: 'assets/gif/broken-clouds.gif',
    201: 'assets/gif/broken-clouds.gif',
    202: 'assets/gif/broken-clouds.gif',
    210: 'assets/gif/broken-clouds.gif',
    211: 'assets/gif/broken-clouds.gif',
    212: 'assets/gif/broken-clouds.gif',
    221: 'assets/gif/broken-clouds.gif',
    230: 'assets/gif/broken-clouds.gif',
    231: 'assets/gif/broken-clouds.gif',
    232: 'assets/gif/broken-clouds.gif',
    //Group 3xx: Drizzle
    300: 'assets/gif/broken-clouds.gif',
    301: 'assets/gif/broken-clouds.gif',
    302: 'assets/gif/broken-clouds.gif',
    310: 'assets/gif/broken-clouds.gif',
    311: 'assets/gif/broken-clouds.gif',
    312: 'assets/gif/broken-clouds.gif',
    313: 'assets/gif/broken-clouds.gif',
    314: 'assets/gif/broken-clouds.gif',
    321: 'assets/gif/broken-clouds.gif',
    //Group 5xx: Rain
    500: 'assets/gif/rain.gif',
    501: 'assets/gif/rain.gif',
    502: 'assets/gif/rain.gif',
    503: 'assets/gif/rain.gif',
    504: 'assets/gif/rain.gif',
    511: 'assets/gif/rain.gif',
    520: 'assets/gif/rain.gif',
    521: 'assets/gif/rain.gif',
    522: 'assets/gif/rain.gif',
    531: 'assets/gif/rain.gif',
    //Group 6xx: Snow
    600: 'assets/gif/broken-clouds.gif',
    601: 'assets/gif/broken-clouds.gif',
    602: 'assets/gif/broken-clouds.gif',
    611: 'assets/gif/broken-clouds.gif',
    612: 'assets/gif/broken-clouds.gif',
    613: 'assets/gif/broken-clouds.gif',
    615: 'assets/gif/broken-clouds.gif',
    616: 'assets/gif/broken-clouds.gif',
    620: 'assets/gif/broken-clouds.gif',
    621: 'assets/gif/broken-clouds.gif',
    622: 'assets/gif/broken-clouds.gif',
    //Group 7xx: Atmosphere
    701: 'assets/gif/broken-clouds.gif',
    711: 'assets/gif/broken-clouds.gif',
    721: 'assets/gif/broken-clouds.gif',
    731: 'assets/gif/broken-clouds.gif',
    741: 'assets/gif/broken-clouds.gif',
    751: 'assets/gif/broken-clouds.gif',
    761: 'assets/gif/broken-clouds.gif',
    762: 'assets/gif/broken-clouds.gif',
    771: 'assets/gif/broken-clouds.gif',
    781: 'assets/gif/broken-clouds.gif',
    //Group 800: Clear
    800: 'assets/gif/clear-sky.gif',
    //Group 80x: Clouds
    801: 'assets/gif/few-clouds.gif',
    802: 'assets/gif/few-clouds.gif',
    803: 'assets/gif/broken-clouds.gif',
    804: 'assets/gif/overcast-clouds.gif',
  };
  static Map<int, String> idToUrlMapNight = {
    //Group 800: Clear
    800: 'assets/gif/clear-sky.gif',
    //Group 80x: Clouds
    801: 'assets/gif/few-clouds.gif',
    802: 'assets/gif/few-clouds.gif',
    803: 'assets/gif/broken-clouds.gif',
    804: 'assets/gif/overcast-clouds.gif',
  };

  static String? backgroundImageFromWeatherConditionCodes(int id,bool isDay){
    if (isDay) {
      if (idToUrlMapDay.containsKey(id)) {
        return idToUrlMapDay[id];
      } else {
        return 'assets/gif/clear-sky.gif';
      }
    } else {
      if (idToUrlMapNight.containsKey(id)) {
        return idToUrlMapNight[id];
      } else {
        return 'assets/gif/clear-sky.gif';
      }
    }
  }


}