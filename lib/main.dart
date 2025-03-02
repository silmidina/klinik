import 'package:flutter/material.dart';
import '/helpers/user_info.dart';
import '/ui/beranda.dart';
import '/ui/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var token = await UserInfo().getToken();
  print(token);

  runApp(MaterialApp(
    title: "Klinik APP",
    debugShowCheckedModeBanner: false,
    home: token == null ? Login() : Beranda(),
  ));
}
