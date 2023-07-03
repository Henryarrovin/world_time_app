import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  WorldTime({required this.location, required this.flag, required this.url});

  late String location;   // location name for the UI
  late String time;    // time in that location
  late String flag;    // url to the asset flag icon
  late String url;  // location url for the api endpoint

  Future<void> getTime() async {

    try{
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      // print('$datetime and $offset');

      //Create a date time object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      // print(now);

      //set the time property
      time = DateFormat.jm().format(now);

    }catch(e){
      print(e);
      time = 'Could not get time data';
    }
  }
}
