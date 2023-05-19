class Temp {
  double? day;
  double? min;
  double? max;
  double? night;
  double? eve;
  double? morn;

  Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  Temp.fromJson(Map<String, dynamic> json) {
    day = json['day']+0.0;
    min = json['min']+0.0;
    max = json['max']+0.0;
    night = json['night']+0.0;
    eve = json['eve']+0.0;
    morn = json['morn']+0.0;
  }

}