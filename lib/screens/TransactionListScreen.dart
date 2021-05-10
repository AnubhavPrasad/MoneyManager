import 'package:flutter/material.dart';
import 'package:money_manager/controllers/user_repository.dart';
import 'package:provider/provider.dart';

class TransactionListScreen extends StatelessWidget {
  var userlist = UserRepository.transactionList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: Consumer<UserRepository>(
        builder: (_, user, child) => Container(
          child: ListView.separated(
            separatorBuilder: (_, index) {
              return Divider();
            },
            itemCount: userlist.length,
            itemBuilder: (_, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transaction ID:${userlist[index].id.toString()}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          userlist[index].amount.toString(),
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                      ],
                    ),
                    userlist[index].isDebit
                        ? Icon(
                            Icons.arrow_forward,
                            color: Colors.red,
                            size: 30,
                          )
                        : Icon(
                            Icons.arrow_back,
                            color: Colors.green,
                            size: 30,
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
