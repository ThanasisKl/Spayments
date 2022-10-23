import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Register Page'),
            backgroundColor: const Color.fromARGB(255, 7, 60, 103),
          ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Text("Σ",style:TextStyle(fontSize: 40,letterSpacing: 4,fontWeight: FontWeight.w600,color:Color.fromARGB(255, 255, 111, 0))),
                      Text("payments",style:TextStyle(fontSize: 30,letterSpacing: 4,color: Color.fromARGB(255, 7, 60, 103),fontWeight: FontWeight.w500,))],
                  ),
                ),
                  
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextFormField(
                    validator: (val)  {
                      if(val == null || val.isEmpty){
                        return 'Enter an email';
                      }else{
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Email',
                    ),
                  ),
                ),
                  
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (val) {
                      if(val == null || val.length < 6){
                        return 'Enter a password 6+ chars long';
                      }else{
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Password',
                    ),
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
                    child: const Text('Register'),
                      onPressed: () async {
                        if(_formKey.currentState != null){
                          // if(_formKey.currentState!.validate()){
                          //   dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                          //   const result = null;
                          //   if(result == null) {
                          //     setState(() {
                          //       error = 'Please supply a valid email';
                          //     });
                          //   }
                          // }
                        }else{
                          setState(() {
                            error = 'Please supply a valid email 2';
                          });
                        }
                      }),
                      
                ),
                
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Login here",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}