import 'package:flutter/material.dart';
import 'package:spayments/models/paymentSlot.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String  slotName = '';
  String name_input = '';
  String limit_input = '';
  String renameError = '';
  String limitError = '';
  bool renameFlag = false;
  bool limitFlag = false;
  bool limitExists = false;
  final localStorage = Hive.box("localStorage");

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)?.settings.arguments as Map;
    slotName = data["slotName"];

    List<dynamic> paymentsSlots = localStorage.get("Slots");
    for(int i = 0; i < paymentsSlots.length; i++){
      if(paymentsSlots[i].name == slotName && paymentsSlots[i].limitFlag){
        setState(() {
          limitExists = true;
        });
      }
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:  const Text("Settings"),
        backgroundColor: const Color.fromARGB(255, 7, 60, 103),
        elevation: 0.0,
      ),
      body: SingleChildScrollView( child: Column(
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

              Visibility(
                visible: limitExists,
                child: Card(
                  shadowColor: const Color.fromARGB(255, 7, 60, 103),
                  child: Column( 
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(
                            Icons.stop_circle,
                            color:Color.fromARGB(255, 232, 23, 9)
                          ),
                        onTap: () {
                          showDialog(
                            context:context ,
                            builder: (context) => AlertDialog(
                              title: const Text("Warning"),
                              content:  Text('Are you sure you want to remove the limit from category: $slotName'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context), 
                                  child: const Text("NO")
                                ),
                                TextButton(
                                  onPressed: () {
                                    removeLimit(slotName);
                                    Navigator.pushReplacementNamed(context,'/loading');
                                  }, 
                                  child: const Text("YES")
                                )
                              ],
                            )
                          );
                        },
                        title:const Text("Remove Limit",
                          style: TextStyle(
                            color: Color.fromARGB(255, 232, 23, 9)
                          )
                        )
                      ),
                    ]
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
                          renameError = "";
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
                              maxLength: 18,
                              decoration: InputDecoration(
                                counterText: "",
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

                          Text(renameError,
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
              ),

              Visibility(
                visible: !limitExists,
                child: Card(
                  shadowColor: const Color.fromARGB(255, 7, 60, 103),
                  child: Column( 
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(
                            Icons.stop_circle,
                            color:Color.fromARGB(255, 7, 60, 103)
                          ),
                        onTap: () {
                          setState(() {
                            limitFlag = !limitFlag;
                            limitError = "";
                          });
                        },
                        title:const Text("Add a Limit",
                          style: TextStyle(
                            color: Color.fromARGB(255, 7, 60, 103)
                          )
                        )
                      ),
                      Visibility(
                        visible: limitFlag,
                        child: Column(
                          children: <Widget> [
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                maxLength: 18,
                                decoration: InputDecoration(
                                  counterText: "",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(90.0),
                                  ),
                                  labelText: 'Limit',
                                ),
                                onChanged: (val) {
                                  setState(() => limit_input = val);
                                },
                              ),
                            ),

                            const SizedBox(height: 3.0),

                            Text(limitError,
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
                                child: const Text('Add',style: TextStyle(fontWeight: FontWeight.w600,letterSpacing: 0.8),),
                                onPressed: () {
                                  addLimit(slotName);
                                },
                              )
                            ),
                          ]
                        )
                      ),
                    ]
                  )
                )
              ), 
          ],
        )
      )
    );
  }

  Future<void> deleteCategory(String categoryName) async{
    //deletes a payment category
    List<dynamic> paymentsSlots = localStorage.get("Slots");
    List<PaymentSlot> newPaymentsSlots = [];
    for(int i = 0; i < paymentsSlots.length; i++){
      if(paymentsSlots[i].name != categoryName) newPaymentsSlots.add(paymentsSlots[i]);
    }
    await localStorage.delete("Slots");
    await localStorage.put('Slots', newPaymentsSlots);
  }

  Future<void> renameCategory(String categoryName) async{
    //renames a payment category
    if(validStringInputs()){
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

  bool validStringInputs(){
    //checks if the new category name has the proper form
    if(name_input.trim() == ""){
      setState(() {
        renameError = 'Please give a name that is not empty ';
      });
      return false;
    }else{
      List<dynamic> paymentsSlots = localStorage.get("Slots");
      for(int i = 0; i < paymentsSlots.length; i++){
        if(paymentsSlots[i].name == name_input.trim() && name_input.trim() != slotName){
          setState(() {
            renameError = 'Category Name already exists';
          });
          return false;
        }
      }
      return true;
    }
  }

  Future<void> addLimit(String categoryName) async{
    // Adds Limit to not limit payment category
    if (validDoubleInputs()){
      List<dynamic> paymentsSlots = localStorage.get("Slots");
      for(int i = 0; i < paymentsSlots.length; i++){
        if(paymentsSlots[i].name == categoryName){
          paymentsSlots[i].addNewLimit(double.tryParse(limit_input));
        }
      }
      await localStorage.delete("Slots");
      await localStorage.put('Slots', paymentsSlots);
      Navigator.pushReplacementNamed(context,'/loading');
    }
  }

  bool validDoubleInputs(){
    //checks if the money inputs has double content in it
    if(double.tryParse(limit_input) == null || limit_input == ""){
       setState(() {
        limitError = "Please give a numeric value as a limit";
      });
      return false;
    }
    return true;
  }

  Future<void> removeLimit(String categoryName) async{
    //removes the Limit to a limit payment category
    List<dynamic> paymentsSlots = localStorage.get("Slots");
    for(int i = 0; i < paymentsSlots.length; i++){
      if(paymentsSlots[i].name == categoryName) paymentsSlots[i].removeLimit();
    }
    await localStorage.delete("Slots");
    await localStorage.put('Slots', paymentsSlots);
  }
}