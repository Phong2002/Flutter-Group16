class WeatherState {
  int? id;
  String? main;
  String? description;
  String? icon;

  WeatherState({this.id, this.main, this.description, this.icon});

  WeatherState.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

}