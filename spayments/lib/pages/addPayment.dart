import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spayments/models/paymentSlot.dart';

class AddPayment extends StatefulWidget {
  const AddPayment({super.key});

  @override
  State<AddPayment> createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {

  final localStorage = Hive.box("localStorage");

  
  String slotName = '';
  String purchase_money = '';
  String error = '';
  String purchase_name = "";
  bool switchBtn = false;

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)?.settings.arguments as Map;
    String  slotName = data["slotName"];
    return MaterialApp(
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
          title: const Text('Add Payment'),
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Money',
                    ),
                    onChanged: (val) {
                      setState(() => purchase_money = val);
                    },
                  ),
                ),

                const SizedBox(height: 30.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Add a name to your purchase",
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: 'Purchase Name',
                      ),
                      onChanged: (val) {
                        setState(() => purchase_name = val);
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
                    child: const Text('Add Payment',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8
                      )
                    ),
                    onPressed: () {checkInputs();},
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

  Future<void> checkInputs() async{
    if (double.tryParse(purchase_money) == null || purchase_money == ""){
      setState(() {
        error = "Please put a numeric value for Money";
      });
    }else{
      List<PaymentSlot> slots = localStorage.get("Slots");
      List<PaymentSlot> newSlots =[];
      int index = 0;
      for(int i=0; i < slots.length; i++){
        newSlots.add(slots[i]);
        if (slots[i].name == slotName){
          index = i;
        }
      }
      newSlots[index].newPayment(double.tryParse(purchase_money)!, purchase_name.trim()=="" ? "unknown" : purchase_name);

      
      await localStorage.delete("Slots");

      await localStorage.put('Slots', newSlots);
      Navigator.pushReplacementNamed(context,'/loading');
    }
  }
}