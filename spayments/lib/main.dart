import 'package:flutter/material.dart';
import 'package:spayments/pages/home.dart';
import 'package:spayments/pages/loading.dart';
import 'package:spayments/pages/login.dart';
import 'package:spayments/pages/register.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spayments/models/paymentSlot.dart';

void main() async {
  List<PaymentSlot> slots = [PaymentSlot("lol", 50, true),
    PaymentSlot("lol222", -1, false),
    PaymentSlot("lol2", -1, false)];
  //initialize Hive 
  await Hive.initFlutter();
  //open the box
  var box = await Hive.openBox("localStorage");
  await box.delete("Slots");
  await box.delete("Name");
  if(box.get("Slots") == null) {
    await box.put("Slots",slots);
  }
  print(Hive.box("localStorage").get("Slots"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final localStorage = Hive.box("localStorage");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //initialRoute: localStorage.get("Name") != null ? '/loading' : '/login',
      initialRoute:'/login',
      routes: {
      '/home': (context) =>  const Home(),
      '/login': (context) => const Login(),
      '/register':(context) => const Register(),
      '/loading': ((context) => const Loading())
    });     
  }
}




