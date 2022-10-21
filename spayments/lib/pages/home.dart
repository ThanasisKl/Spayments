import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title:  Text('Σpayments',
          style: TextStyle(color:Colors.amber[900],letterSpacing: 5.0,),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
      ),
      body: const Center(
        child: Text(
          'hello, bitches!',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.amber,
            fontFamily: 'IndieFlower',
          ),
        ),
      ),
      floatingActionButton:   FloatingActionButton(
        onPressed: () {  },
        backgroundColor: Colors.amber[900],
        child: const Icon(Icons.add),
      ),
    );
  }
}//Exception: Unable to find suitable Visual Studio toolchain. Please run `flutter doctor` for more details.