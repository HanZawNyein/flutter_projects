import 'package:http/http.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String flag;
  String url;
  String time = '';
  bool isDayTime=true;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      var URL = await Uri.https(
          'worldtimeapi.org', '/api/timezone/$url', {'q': '{http}'});
      Response response = await get(URL);
      // print(response);
      Map data = jsonDecode(response.body);
      // print(data);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(offset);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      // print(now);

      isDayTime = now.hour > 6 && now.hour < 20 ? true:false;
      time = DateFormat.jm().format(now); // now.toString();
      // print(time);
      // print(isDayTime);
    } catch (e) {
      // print('error  : $e');
      time = '00:00';
    }
  }
}
