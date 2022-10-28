import 'package:flutter/material.dart';
import 'package:spayments/models/paymentSlot.dart';
import 'package:spayments/models/payment.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {

  final localStorage = Hive.box("localStorage");
  List<Payment> paymentsList = [];
  PaymentSlot slot = PaymentSlot("init", -1, false);
 
  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)?.settings.arguments as Map;
    String  slotName = data["slotName"];

    List<PaymentSlot> paymentsSlots = localStorage.get("Slots");
    for(int i = 0; i < paymentsSlots.length; i++){
      if(paymentsSlots[i].name == slotName){
        setState(() {
          paymentsList = paymentsSlots[i].paymentsList;
          slot = paymentsSlots[i];
        });
        break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:  Text(slotName),
        backgroundColor: const Color.fromARGB(255, 7, 60, 103),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
            },
          )
        ],
      ),
      body: 
        Column(
          children:<Widget>[
            const SizedBox(height: 20.0),
            Text("Total money spent: ${slot.totalMoneySpent} €",style: 
              const TextStyle(
                color:Color.fromARGB(255, 7, 60, 103) ,
                fontWeight: FontWeight.w600,
                fontSize: 23,
                letterSpacing: 1.0
              ),
            ),
            const SizedBox(height: 10.0),
            Visibility(
              visible: slot.limitFlag,
              child:Text("Limit: ${slot.limit} €",style: 
                const TextStyle(
                  color:Color.fromARGB(255, 211, 17, 3) ,
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                  letterSpacing: 1.0
                ),
              ), 
            ),
            
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: paymentsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                  child: Card(
                    shadowColor: const Color.fromARGB(255, 7, 60, 103),
                    child: ListTile(
                      onTap: () {},
                      title:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[ 
                            Text(paymentsList[index].title,
                              style: const TextStyle(letterSpacing: 0.5)
                            ),
                            Text(paymentsList[index].amount.toString()+" €",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 232, 23, 9),
                              )
                            ),
                            IconButton( 
                                icon: const Icon(Icons.delete),
                                color: const Color.fromARGB(255, 211, 17, 3) ,
                                onPressed: () {
                                  print("delete payment");
                                },
                            )
                            
                        ])
                    ),
                  ),
                );
              }
            )
          ]
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.pushNamed(context, '/addpayment', arguments: {
          'slotName': slotName
        });  },
        backgroundColor: const Color.fromARGB(255, 7, 60, 103),
        child: const Icon(Icons.add),
      ),
    );
  }
}