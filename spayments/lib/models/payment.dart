import 'package:hive/hive.dart';
part 'payment.g.dart';

@HiveType(typeId: 1, adapterName: "PaymentAdapter")
class Payment extends HiveObject {

  @HiveField(0)
  String title;

  @HiveField(1)
  double amount;
  
  Payment(this.title,this.amount);

}