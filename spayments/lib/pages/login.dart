import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:spayments/models/paymentSlot.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final localStorage = Hive.box("localStorage");
  String name = '';
  String error = '';
  List<PaymentSlot> slots = [PaymentSlot("lol", 50, true),
    PaymentSlot("lol222", -1, false),
    PaymentSlot("lol2", -1, false)];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Login Page'),
              backgroundColor: const Color.fromARGB(255, 7, 60, 103),
            ),
            body:
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [Text("Σ",style:TextStyle(fontSize: 45,letterSpacing: 4,fontWeight: FontWeight.w600,color:Color.fromARGB(255, 255, 111, 0))),
                            Text("payments",style:TextStyle(fontSize: 39,letterSpacing: 4,color: Color.fromARGB(255, 7, 60, 103),fontWeight: FontWeight.w500,))],
                        ),
                        ),
                      const SizedBox(height: 50.0,),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            labelText: 'Name',
                          ),
                          onChanged: (val) {
                            setState(() => name = val);
                          },
                        ),
                      ),
  
                      Container(
                          height: 80,
                          padding: const EdgeInsets.all(20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              backgroundColor: const Color.fromARGB(255, 7, 60, 103),
                            ),
                            child: const Text('Start Using the App',style: TextStyle(fontWeight: FontWeight.w600,letterSpacing: 0.8),),
                            onPressed: () {
                              signIn();
                            },
                          )),
                      Text(error,style: const TextStyle(color:Colors.red),),
                    ],
                  ),
                ),
              
            
          ),
        );
  }

  Future<void> signIn() async{
    if(name.trim() == ""){
      setState(() {
        error = "Please Enter your Name";
      });
    }else{
      await localStorage.put('Name', name);
      Navigator.pushReplacementNamed(context, "/loading");
      //await localStorage.put('Slots',slots);
    }
  }

  

}


Future<void> checkUser() async{
    var box = await Hive.openBox('localStorage');
    String name = box.get('Name');
    print(name);
}