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

    List<PaymentSlot> paymentsSlots = localStorage.get("Slots");
    for(int i = 0; i < paymentsSlots.length; i++){
      if(paymentsSlots[i].name == data['slotName']){
        paymentsList = paymentsSlots[i].paymentsList;
        slot = paymentsSlots[i];
        break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("New Payment"),
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
            Text("Total money spent: ${slot.totalMoneySpent} €"),
            const SizedBox(height: 10.0),
            Visibility(
              visible: slot.limitFlag,
              child:Text("Limit: ${slot.limit} €"), 
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
                      title: Text(paymentsList[index].title,style: const TextStyle(letterSpacing: 0.5)),
                      leading: const  Icon(
                        Icons.circle,
                        color: Color.fromARGB(255, 7, 60, 103),
                        size: 20,
                      ),
                    ),
                  ),
                );
              }
            )
          ]
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        backgroundColor: const Color.fromARGB(255, 7, 60, 103),
        child: const Icon(Icons.add),
      ),
    );
  }
}