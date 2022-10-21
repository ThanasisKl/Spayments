import 'package:flutter/material.dart';
import 'package:spayments/pages/home.dart';
import 'package:spayments/pages/loading.dart';
import 'package:spayments/pages/login.dart';
import 'package:spayments/pages/register.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/': (context) => const Loading(),
      '/home': (context) => const Home(),
      '/login': (context) => const Login(),
      '/register':(context) => const Register(),
      '/loading': ((context) => const Loading())
    }
));
