import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spayments/pages/home.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(milliseconds: 750), () {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const Home()));
    });
  }
    
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:const Color.fromARGB(255, 7, 60, 103),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          SpinKitDoubleBounce(
            color: Colors.white,
            size: 50.0,
          ),

          SizedBox(height: 80),
        
          Text("@_@",style: 
            TextStyle(
              color: Color.fromARGB(255, 16, 74, 122),
              fontSize: 30.0
            )
          )
        ]
      )
    );
  }
}