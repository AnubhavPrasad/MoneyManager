import 'package:equatable/equatable.dart';
import 'package:money_manager/models/rewards.dart';

class Transaction extends Equatable {
  String id;
  double amount;
  int receiverId;
  String description = "";
  Reward rewardReceived = null;
  bool isDebit;

  Transaction(this.id, this.amount, this.receiverId, this.isDebit,
      {this.description, this.rewardReceived});

  @override
  List<Object> get props => [id, amount, receiverId];

  @override
  String toString() {
    return 'Transaction { id: $id , amount: $amount , receiverId: $receiverId }';
  }
}
