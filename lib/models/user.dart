import 'package:equatable/equatable.dart';
import 'package:money_manager/models/rewards.dart';
import 'package:money_manager/models/transactions.dart';

class User extends Equatable {
  final int id;
  double accountBalance;
  List<Reward> rewards = [];
  List<Transaction> transactions = [];
  List<String> userFriends = [];

  User(this.id, this.accountBalance,
      {this.rewards, this.transactions, this.userFriends});

  @override
  List<Object> get props => [id];

  @override
  String toString() {
    return 'User { id: $id , amount: $accountBalance }';
  }
}
