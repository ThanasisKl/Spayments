import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spayments/models/paymentSlot.dart';

class AddPaymentSlot extends StatefulWidget {
  const AddPaymentSlot({super.key});

  @override
  State<AddPaymentSlot> createState() => _AddPaymentSlotState();
}

class _AddPaymentSlotState extends State<AddPaymentSlot> {

  final localStorage = Hive.box("localStorage");

  String slotName = '';
  String error = '';
  bool switchBtn = false;
  String limit = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          elevation: 0.0,
          title: const Text('Add Payment Category'),
          backgroundColor: const Color.fromARGB(255, 7, 60, 103),
        ),
        body:
          Center(child: SingleChildScrollView(child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20.0,),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Text("Σ",
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
                    )],
                  ),
                ),

                const SizedBox(height: 30.0,),

                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    maxLength: 18,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Payment Category Name',
                    ),
                    onChanged: (val) {
                      setState(() => slotName = val);
                    },
                  ),
                ),

                const SizedBox(height: 30.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Add limit to the money you want to spend",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      )
                    ),
                    
                    Switch(
                      activeColor: const Color.fromARGB(255, 255, 111, 0),
                      activeTrackColor: const Color.fromARGB(255, 247, 157, 87),
                      inactiveThumbColor: const Color.fromARGB(255, 7, 60, 103),
                      inactiveTrackColor: Colors.grey.shade400,
                      splashRadius: 20.0,
                      value: switchBtn,
                      onChanged: (value) => setState(() { switchBtn = value;}),
                    ),
                  ]
                ),

                const SizedBox(height: 5.0,),

                Visibility(
                  visible: switchBtn,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: 'Limit',
                      ),
                      onChanged: (val) {
                        setState(() => limit = val);
                      },
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
                    child: const Text('Add Payment Category',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8
                      )
                    ),
                    onPressed: () {addPaymentCategory();},
                  )
                ),
                
                Center( child: 
                  Text(error,
                    style: const TextStyle(
                      color:Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 13
                    )
                  ),
                )
              ],
            ),
          ),
        )
      )
    );
  }

  Future<void> addPaymentCategory() async{
    //adds a new payment category to the local database
    if(slotName.trim() == ""){
      setState(() {
        error = "Please Enter a proper Name";
      });
    }else if(categoryAlreadyExists()){
      setState(() {
        error = "Category Name already in use, please select another one";
      });
    }else if(switchBtn && (double.tryParse(limit) == null || limit == "")){
      setState(() {
        error = "Please give a numeric value as a limit";
      });
    }else{
      List<dynamic> newSlots = localStorage.get("Slots");

      newSlots.add(
        PaymentSlot(slotName, switchBtn ? double.tryParse(limit)! : -1 , switchBtn)
      );
      await localStorage.delete("Slots");

      await localStorage.put('Slots', newSlots);

      Navigator.pushReplacementNamed(context, "/loading");
    }
  }

  bool categoryAlreadyExists(){
    //checks if the category already exist in the local database
    List<dynamic> slots = localStorage.get("Slots");
    for(int i = 0; i<slots.length;i++){
      if(slots[i].name == slotName){
        return true;
      }
    }
    return false;
  }
}