import 'package:spayments/models/payment.dart';
import 'package:hive/hive.dart';
part 'paymentSlot.g.dart';

@HiveType(typeId: 0,adapterName: "PaymentSlotAdapter")
class PaymentSlot extends HiveObject{

  @HiveField(0)
  String name;

  @HiveField(1)
  double totalMoneySpent = 0;

  @HiveField(2)
  double limit;

  @HiveField(3)
  bool limitFlag;

  @HiveField(4)
  List<Payment> paymentsList = [];
  
  PaymentSlot(this.name, this.limit, this.limitFlag);
  
  void newPayment(double amount,String title){
    totalMoneySpent += amount;
    paymentsList.add(Payment(title, amount));
  }

  void removePayment(String title, double amount){
    totalMoneySpent -= amount;
    List<Payment> newPaymentsList = [];
    bool flag = false;
    for(int i = 0; i < paymentsList.length; i++){
      if(!(paymentsList[i].title == title && paymentsList[i].amount == amount) || flag){
        newPaymentsList.add(paymentsList[i]);
      }else{
        flag = true;
      }
    }
    paymentsList = newPaymentsList;
  }

  void addNewLimit(double newLimit){
    limitFlag = true;
    limit = newLimit;
  }

  void removeLimit(){
    limitFlag = false;
    limit = -1;
  }
}