import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final localStorage = Hive.box("localStorage");
  String name_input = '';
  String error = '';
  bool firstLogIn = false;
  dynamic name = "";
  
  @override
  void initState(){
    super.initState();
    if(localStorage.get("Name") ==  null){
      firstLogIn = true;
    }else{
      name = localStorage.get('Name');
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Main Page'),
          backgroundColor: const Color.fromARGB(255, 7, 60, 103),
        ),
        body:
          Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 80.0,),

                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Σ",
                        style:TextStyle(
                          fontSize: 45,
                          letterSpacing: 4,
                          fontWeight: FontWeight.w600,
                          color:Color.fromARGB(255, 255, 111, 0)
                        )
                      ),
                      Text("payments",
                        style:TextStyle(
                          fontSize: 39,
                          letterSpacing: 4,
                          color: Color.fromARGB(255, 7, 60, 103),
                          fontWeight: FontWeight.w500
                        )
                      )
                    ],
                  ),
                ),

                Visibility(
                  visible: name == "",
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                      maxLength: 18,
                      decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: "What's your name ?",
                      ),
                      onChanged: (val) {
                        setState(() => name_input = val);
                      },
                    ),
                  ),
                ),

                Visibility(
                  visible: name != "",
                  child: Column(
                    children:  <Widget>[
                      const Text("Welcome Back",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        )
                      ),

                      const SizedBox(height: 20.0),

                      Text(name,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          color: Color.fromARGB(255, 7, 60, 103),
                        )
                      )
                    ]
                  ) 
                ),
                      
                const SizedBox(height: 90.0,),
                      
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
                  )
                ),

                Text(error,
                  style: const TextStyle(
                    color:Colors.red
                  )
                ),
              ],
            ),
          ),
        ),
      );
  }

  Future<void> signIn() async{ 
    //if it is the first time opening the up stores the name of the user. 
    //In other case goes to the next screen
    if(!firstLogIn){
      Navigator.pushReplacementNamed(context, "/loading");
    }else if(name_input.trim() == ""){
      setState(() {
        error = "Please Enter your Name";
      });
    }else{
      await localStorage.put('Name', name_input);
      Navigator.pushReplacementNamed(context, "/loading");
    }
  }
}

Future<void> checkUser() async{
  var box = await Hive.openBox('localStorage');
  String name = box.get('Name');
}