import 'package:spayments/models/payment.dart';
class PaymentSlot {

  String name;
  double totalMoneySpent = 0;
  double limit;
  bool limitFlag;
  List<Payment> paymentsList = [];
  
  PaymentSlot(this.name, this.limit, this.limitFlag);
  
  void newPayment(double amount){
    totalMoneySpent += amount;
  }
}