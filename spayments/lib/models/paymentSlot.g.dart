// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentSlot.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentSlotAdapter extends TypeAdapter<PaymentSlot> {
  @override
  final int typeId = 0;

  @override
  PaymentSlot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentSlot(
      fields[0] as String,
      fields[2] as double,
      fields[3] as bool,
    )
      ..totalMoneySpent = fields[1] as double
      ..paymentsList = (fields[4] as List).cast<Payment>();
  }

  @override
  void write(BinaryWriter writer, PaymentSlot obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.totalMoneySpent)
      ..writeByte(2)
      ..write(obj.limit)
      ..writeByte(3)
      ..write(obj.limitFlag)
      ..writeByte(4)
      ..write(obj.paymentsList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentSlotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
