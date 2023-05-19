import 'package:intl/intl.dart';

class DatetimeUltis{
  static String showHourAndMinutes(DateTime ?dateTime){
    final df = new DateFormat('HH:mm');
    return df.format(dateTime!);
}

  static String showDayAndMonth(DateTime ?dateTime){
    final df = new DateFormat('dd/MM');
    return df.format(dateTime!);
  }
}