import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String? location;
  String? time; // time at that location
  String? flag; //url to an assets flag icon
  String? link; //location url for api endpoint
  bool? isDaytime; //true or false if daytime or not

  WorldTime({
    this.location,
    this.flag,
    this.link
  });

  Future<void> getTime() async {

    try{
      final url=Uri.parse('http://worldtimeapi.org/api/timezone/$link');
      Response response=await get(url);
      Map data=jsonDecode(response.body);
      //print(data);

      //get properties
      String datetime=data['datetime'];
      String offset=data['utc_offset'].substring(1,3);
      //print(datetime);
      //print(offset);

      //create date time object
      DateTime now=DateTime.parse(datetime);
      now=now.add(Duration(hours: int.parse(offset)));
      //set the time property
      isDaytime= now.hour>6 && now.hour<20 ? true : false;
      time= DateFormat.jm().format(now);
    }
    catch(e){
      print('caught a error: $e');
      time='could not get time data';
    }

    //make the response

  }

}
