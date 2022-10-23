import 'package:flutter/material.dart';
import 'package:spayments/pages/home.dart';
import 'package:spayments/pages/loading.dart';
import 'package:spayments/pages/login.dart';
import 'package:spayments/pages/register.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //initialize Hive 
  await Hive.initFlutter();
  //open the box
  await Hive.openBox("localStorage");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final localStorage = Hive.box("localStorage");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: localStorage.get("Name") != null ? '/loading' : 'login',
      routes: {
      '/': (context) => const Loading(),
      '/home': (context) => const Home(),
      '/login': (context) => const Login(),
      '/register':(context) => const Register(),
      '/loading': ((context) => const Loading())
    });     
  }
}




