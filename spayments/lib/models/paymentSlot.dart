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
  
  void newPayment(double amount){
    totalMoneySpent += amount;
  }
}