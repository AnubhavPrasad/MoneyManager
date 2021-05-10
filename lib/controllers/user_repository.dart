import 'package:flutter/cupertino.dart';
import 'package:money_manager/models/rewards.dart';
import 'package:money_manager/models/transactions.dart';
import 'package:money_manager/models/user.dart';

class UserRepository extends ChangeNotifier {
  static List<Reward> rewardList = [
    Reward("1", "First Reward"),
    Reward("2", "Second Reward"),
    Reward("3", "Third Reward"),
  ];
  static List<Transaction> transactionList = [
    Transaction("1", 55.0, 2, true),
    Transaction("2", 980, 3, false),
    Transaction("3", 1050.0, 2, true)
  ];
  static List<String> userFriends = ['2', '3', '4', '7'];
  static User user = new User(1, 1975,
      rewards: rewardList,
      transactions: transactionList,
      userFriends: userFriends);

  User getUserDetails() {
    return user;
  }

  void addUserFriend(String friendId) {
    userFriends.add(friendId);
    notifyListeners();
  }

  void addTransaction(Transaction transaction) {
    if (transaction.isDebit) {
      user.accountBalance -= transaction.amount.toDouble();
    } else {
      user.accountBalance += transaction.amount.toDouble();
    }
    transactionList.add(transaction);
    if (transaction.rewardReceived != null)
      rewardList.add(transaction.rewardReceived);
    notifyListeners();
  }

  void addReward(Reward reward) {
    rewardList.add(reward);
    notifyListeners();
  }

  int totalAmount() {
    int sum = 0;
    for (var i in transactionList) {
      if (i.isDebit) {
        sum -= i.amount.toInt();
      } else {
        sum += i.amount.toInt();
      }
    }
    return sum;
  }
}
