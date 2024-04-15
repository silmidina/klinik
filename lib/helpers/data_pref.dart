import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DataPref {
  static getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String savedData = pref.getString('fugi_key') ?? '[]';
    return json.decode(savedData);
  }

  static savedData(Data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('fugi_key', json.encode(Data));
  }
}
