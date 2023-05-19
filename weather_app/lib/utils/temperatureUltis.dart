import 'dart:ffi';
import 'dart:ui';

class TemperatureUltis{
  static Color colorTemperature(num temperature){
    if (temperature > 50) {
      // Màu đỏ
      return Color.fromARGB(255, 255, 0, 0);}
    if (temperature >= 30 && temperature <= 50) {
      // Màu vàng cam đỏ
      int red = 255;
      int green = (255 * (50 - temperature)) ~/ 20;
      int blue = 0;
      return Color.fromARGB(255, red, green, blue);
    } else if (temperature >= 20 && temperature < 30) {
      int red = 0;
      int green = 0;
      int blue = 0;
      int diff = (temperature - 20).toInt();
      if (diff <= 5) {
        // Chuyển từ xanh dương nhẹ đến xanh lá cây
        red = 0;
        green = (255 * diff) ~/ 5;
        blue = 255 - green;
      } else {
        // Chuyển từ xanh lá cây đến vàng nhẹ
        red = (255 * (diff - 5)) ~/ 4;
        green = 255;
        blue = 0;
      }
      return Color.fromARGB(255, red, green, blue);
    } else {
      // Màu xanh dương đậm dần
      int red = 0;
      int green = (255 * ( temperature-19)) ~/ 19;
      int blue = 255;
      return Color.fromARGB(255, red, green, blue);
    }
  }
}