import 'package:flutter/material.dart';
import 'package:spayments/pages/addPaymentSlot.dart';
import 'package:spayments/pages/home.dart';
import 'package:spayments/pages/loading.dart';
import 'package:spayments/pages/login.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:spayments/models/paymentSlot.dart';
import 'package:spayments/models/payment.dart';
import 'package:spayments/pages/payments.dart';

void main() async {
  PaymentSlot x = PaymentSlot("γιτ", 50, true);
  x.newPayment(12);
  List<PaymentSlot> slots = [PaymentSlot("lol", 50, true),
    PaymentSlot("lol222", -1, false),
    PaymentSlot("lol2", -1, false),x];
  //initialize Hive 
  await Hive.initFlutter();

  Hive.registerAdapter(PaymentAdapter());
  Hive.registerAdapter(PaymentSlotAdapter());

  //open the box
  var box = await Hive.openBox("localStorage");
  await box.delete("Slots");
  await box.delete("Name");
  if(box.get("Slots") == null) {
    await box.put("Slots",/*<PaymentSlot>[]*/ slots);
  }
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
      '/loading': (context) => const Loading(),
      '/addpaymentslot': (context) => const AddPaymentSlot(),
      '/payments' : (context) => const Payments(),
    });     
  }
}




