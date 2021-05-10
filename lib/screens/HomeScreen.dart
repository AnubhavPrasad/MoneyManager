import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager/controllers/user_repository.dart';
import 'package:money_manager/screens/PaymentScreen.dart';
import 'package:money_manager/screens/TransactionListScreen.dart';
import 'package:money_manager/utilities/TransactionButton.dart';
import 'package:provider/provider.dart';
import 'package:scaled_list/scaled_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Money Manager'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransactionListScreen()));
                },
                child: Text(
                  'Recent Transactions ->',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        FontAwesomeIcons.wallet,
                        size: 40,
                        color: Colors.red.shade300,
                      ),
                      Consumer<UserRepository>(
                        builder: (_, user, child) => Text(
                          '\u20B9' +
                              user.getUserDetails().accountBalance.toString(),
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Consumer<UserRepository>(
                    builder: (_, user, child) => ScaledList(
                      itemBuilder: (index, selectedindex) {
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                user.getUserDetails().rewards[index].name,
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                user
                                    .getUserDetails()
                                    .rewards[index]
                                    .description,
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: user.getUserDetails().rewards.length,
                      itemColor: (index) => Color(0xffa3d6be),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(20),
                child: TransactionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentScreen()));
                  },
                  color: Colors.teal,
                  text: '+ ADD PAYMENT',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
