import 'package:flutter/material.dart';
import 'package:spayments/models/paymentSlot.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final localStorage = Hive.box("localStorage");

  //dynamic list = localStorage.get("Slots");
  List<PaymentSlot> list = [];
  void initState(){
    super.initState();
    list = localStorage.get("Slots").reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row( children: const <Widget>[
          Text("Σ",
            style:TextStyle(
              fontSize: 28,
              letterSpacing: 4,
              fontWeight: FontWeight.w600,
              color:Color.fromARGB(255, 255, 111, 0)
            )
          ),
          Text("payments",
            style:TextStyle(
              fontSize: 23,
              letterSpacing: 4,
              color: Colors.white,
              fontWeight: FontWeight.w500
            )
          )]
        ),
        backgroundColor: const Color.fromARGB(255, 7, 60, 103),
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
            child: Card(
              shadowColor: const Color.fromARGB(255, 7, 60, 103),
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/payments",arguments:{
                    'slotName':list[index].name
                  });
                },
                title: Text(list[index].name,style: const TextStyle(letterSpacing: 0.5)),
                leading: const  Icon(
                  Icons.circle,
                  color: Color.fromARGB(255, 7, 60, 103),
                  size: 20,
                ),
              ),
            ),
          );
        }
      ),
      floatingActionButton:   FloatingActionButton(
        onPressed: () { Navigator.pushNamed(context,"/addpaymentslot"); },
        backgroundColor: const Color.fromARGB(255, 7, 60, 103),
        child: const Icon(Icons.add),
      ),
    );
  }
}