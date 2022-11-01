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
  String  slotName = "";
 
  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)?.settings.arguments as Map;
    slotName = data["slotName"];

    List<dynamic> paymentsSlots = localStorage.get("Slots");
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
            onPressed: () {Navigator.pushNamed(context, '/settings',arguments: {
              'slotName': slotName
            });},
          )
        ],
      ),
      body: 
        SingleChildScrollView( child: Column(
          children:<Widget>[
            const SizedBox(height: 20.0),
            Text("Total money spent: ${slot.totalMoneySpent.toStringAsFixed(2)} €",style: 
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
              child: Column(
                children:<Widget> [
                  Text("Limit: ${slot.limit.toStringAsFixed(2)} €",style: 
                    const TextStyle(
                      color:Color.fromARGB(255, 211, 17, 3) ,
                      fontWeight: FontWeight.w600,
                      fontSize: 23,
                      letterSpacing: 1.0
                    )
                  ),

                  const SizedBox(height: 10.0),

                  Text(slot.limit >= slot.totalMoneySpent ? "Money left to spend: ${(slot.limit-slot.totalMoneySpent).toStringAsFixed(2)} €" : "Above the limit: ${(-slot.limit+slot.totalMoneySpent).toStringAsFixed(2)} €" ,style: 
                    TextStyle(
                      color: slot.limit >= slot.totalMoneySpent ?Colors.green :  const Color.fromARGB(255, 136, 11, 2),
                      fontWeight: FontWeight.w600,
                      fontSize: 23,
                      letterSpacing: 1.0
                    ),
                  ),

                  const SizedBox(height: 10.0),
                ]
              )
            ),

            Visibility(
              visible: paymentsList.isEmpty,
              child: const Padding(
                padding:  EdgeInsets.all(16.0),
                child: Text("Add a new payment (for example supermarket - 20.5€) by clicking the bottom right button",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18
                  ),
                )
              )
            ),
            
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
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

                            Expanded(
                              flex: 3,
                              child: Text(paymentsList[index].title,
                                style: const TextStyle(
                                  letterSpacing: 0.5
                                )
                              )
                            ),

                            Expanded(
                              flex: 2,
                              child: Text(paymentsList[index].amount.toStringAsFixed(2).toString()+" €",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 232, 23, 9),
                                )
                              )
                            ),

                            Expanded(
                              flex: 1,
                              child: IconButton( 
                                icon: const Icon(Icons.delete),
                                color: const Color.fromARGB(255, 211, 17, 3) ,
                                onPressed: () {
                                  showDialog(
                                    context:context ,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Warning"),
                                      content:  Text('Are you sure you want to delete the payment: ${paymentsList[index].title} ${paymentsList[index].amount.toString()} €"'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context), 
                                          child: const Text("NO")
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            deletePayment(paymentsList[index].title,paymentsList[index].amount);
                                            Navigator.pop(context);
                                          }, 
                                          child: const Text("YES")
                                        )
                                      ],
                                    )
                                  );
                                }
                              )
                            )  
                          ]
                        )
                    ),
                  ),
                );
              }
            )
          ])
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

  Future<void> deletePayment(String title, double amount) async{
    //deletes a payment from a specific payment category
    List<dynamic> paymentsSlots = localStorage.get("Slots");
    for(int i = 0; i < paymentsSlots.length; i++){
      if(paymentsSlots[i].name == slotName){
        paymentsSlots[i].removePayment(title,amount);
        await localStorage.delete("Slots");
        await localStorage.put('Slots', paymentsSlots);
        
        setState(() {
          paymentsList = paymentsSlots[i].paymentsList;
          slot = paymentsSlots[i];
        });
        break;
      }
    }
    
  }
}