import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CompassUltis{
  static String degreeToCompassDirection(num degree){
    const List<String> directions = [
      'Bắc',
      'Đông Bắc',
      'Đông',
      'Đông Nam',
      'Nam',
      'Tây Nam',
      'Tây',
      'Tây Bắc'
    ];
    final int index = ((degree / 45) + 0.5).floor() % 8;
    return directions[index];
  }

  static String degreeToCompassUrlImage(int degree){
    const List<String> directions = [
      'north',
      'northeast',
      'east',
      'southeast',
      'south',
      'southwest',
      'west',
      'northwest'
    ];
    final int index = ((degree / 45) + 0.5).floor() % 8;
    return "assets/images/compass/${directions[index]}.png";
  }
}