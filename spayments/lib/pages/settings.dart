import 'package:flutter/material.dart';
import 'package:spayments/models/paymentSlot.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String  slotName = "";
  String name_input = '';
  String error = '';
  bool renameFlag = false;
  final localStorage = Hive.box("localStorage");

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)?.settings.arguments as Map;
    slotName = data["slotName"];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:  const Text("Settings"),
        backgroundColor: const Color.fromARGB(255, 7, 60, 103),
        elevation: 0.0,
      ),
      body: Column(
          children: <Widget>[
              Card(
                shadowColor: const Color.fromARGB(255, 7, 60, 103),
                child: ListTile(
                  leading: const Icon(
                      Icons.delete,
                      color:Color.fromARGB(255, 232, 23, 9)
                    ),
                  onTap: () {
                    showDialog(
                      context:context ,
                      builder: (context) => AlertDialog(
                        title: const Text("Warning"),
                        content:  Text('Are you sure you want to delete the payment category: $slotName'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context), 
                            child: const Text("NO")
                          ),
                          TextButton(
                            onPressed: () {
                              deleteCategory(slotName);
                              Navigator.pushReplacementNamed(context,'/loading');
                            }, 
                            child: const Text("YES")
                          )
                        ],
                      )
                    );
                  },
                  title:const Text("Delete Payment Category",
                    style: TextStyle(
                      color: Color.fromARGB(255, 232, 23, 9),
                    )
                  )
                )
              ),
              Card(
                shadowColor: const Color.fromARGB(255, 7, 60, 103),
                child: Column( 
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(
                          Icons.drive_file_rename_outline_outlined,
                          color:Color.fromARGB(255, 7, 60, 103)
                        ),
                      onTap: () {
                        setState(() {
                          renameFlag = !renameFlag;
                          error = "";
                        });
                      },
                      title:const Text("Rename Payment Category",
                        style: TextStyle(
                          color: Color.fromARGB(255, 7, 60, 103)
                        )
                      )
                    ),
                    Visibility(
                      visible: renameFlag,
                      child: Column(
                        children: <Widget> [
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: slotName,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(90.0),
                                ),
                                labelText: 'New Category Name',
                              ),
                              onChanged: (val) {
                                setState(() => name_input = val);
                              },
                            ),
                          ),

                          const SizedBox(height: 3.0),

                          Text(error,
                            style: const TextStyle(color:Colors.red)
                          ),

                          Container(
                            height: 80,
                            width: 200,
                            padding: const EdgeInsets.all(20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                backgroundColor: const Color.fromARGB(255, 7, 60, 103),
                              ),
                              child: const Text('Save',style: TextStyle(fontWeight: FontWeight.w600,letterSpacing: 0.8),),
                              onPressed: () {
                                renameCategory(slotName);
                              },
                            )
                          ),
                        ]
                      )
                    ),
                  ]
                )
              )
        ],
      )
    );
  }

  Future<void> deleteCategory(String categoryName) async{
    List<dynamic> paymentsSlots = localStorage.get("Slots");
    List<PaymentSlot> newPaymentsSlots = [];
    for(int i = 0; i < paymentsSlots.length; i++){
      if(paymentsSlots[i].name != categoryName) newPaymentsSlots.add(paymentsSlots[i]);
    }
    await localStorage.delete("Slots");
    await localStorage.put('Slots', newPaymentsSlots);
  }

  Future<void> renameCategory(String categoryName) async{
    if(validInputs()){
      List<dynamic> paymentsSlots = localStorage.get("Slots");
      for(int i = 0; i < paymentsSlots.length; i++){
        if(paymentsSlots[i].name == categoryName) {
          paymentsSlots[i].name = name_input;
        }
      }
      await localStorage.delete("Slots");
      await localStorage.put('Slots', paymentsSlots);
      Navigator.pushReplacementNamed(context,'/loading');
    };
  }

  bool validInputs(){
    if(name_input.trim() == ""){
      setState(() {
        error = 'Please give a name that is not empty ';
      });
      return false;
    }else{
      List<dynamic> paymentsSlots = localStorage.get("Slots");
      for(int i = 0; i < paymentsSlots.length; i++){
        if(paymentsSlots[i].name == name_input.trim() && name_input.trim() != slotName){
          setState(() {
            error = 'Category Name already exists';
          });
          return false;
        }
      }
      return true;
    }
  }
}