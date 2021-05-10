import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/controllers/transaction_repository.dart';
import 'package:money_manager/controllers/user_repository.dart';
import 'package:money_manager/models/transactions.dart';
import 'package:money_manager/utilities/TransactionButton.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String newUserId;
  String selectedUser = 'Not Selected';
  String amount;
  String details;
  bool isDebit = true;

  void CustomDialogShow(bool isSuccess) {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      headerAnimationLoop: false,
      dialogType: isSuccess ? DialogType.SUCCES : DialogType.ERROR,
      title: isSuccess ? 'Successful' : 'Unsuccessful',
      padding: EdgeInsets.all(30),
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payments'),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
        child: Container(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              kToolbarHeight,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isDebit = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isDebit
                                ? Colors.teal.shade200
                                : Colors.teal.shade50,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                          ),
                          padding: EdgeInsets.all(20),
                          child: Center(child: Text('SEND')),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isDebit = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: !isDebit
                                ? Colors.teal.shade200
                                : Colors.teal.shade50,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                          ),
                          padding: EdgeInsets.all(20),
                          child: Center(child: Text('RECEIVE')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Consumer<UserRepository>(
                builder: (_, user, child) => DropdownSearch(
                  label: 'Menu',
                  mode: Mode.MENU,
                  items: user.getUserDetails().userFriends,
                  showSearchBox: true,
                  selectedItem: selectedUser,
                  onChanged: (value) {
                    selectedUser = value;
                  },
                  showSelectedItem: true,
                ),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                      contentPadding: EdgeInsets.all(20),
                      title: Text('Enter UserFriend ID'),
                      children: [
                        TextField(
                          onChanged: (value) {
                            newUserId = value;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Consumer<UserRepository>(
                          builder: (_, user, child) => TextButton(
                              onPressed: () {
                                user.addUserFriend(newUserId);
                                setState(() {
                                  selectedUser = newUserId;
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Ok',
                                style:
                                    TextStyle(color: Colors.teal, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  );
                },
                child: Text(
                  'Want to add new User ?',
                  style: TextStyle(color: Colors.teal),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                    side: MaterialStateProperty.all(BorderSide(
                      width: 2,
                      color: Colors.teal.shade100,
                    ))),
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Amount',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    )),
                onChanged: (value) {
                  amount = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Details',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    )),
                onChanged: (value) {
                  details = value;
                },
              ),
              Consumer<UserRepository>(
                builder: (_, user, child) => TransactionButton(
                  onPressed: () {
                    try {
                      Transaction transaction = isDebit
                          ? TransactionsRepository().payMoney(
                              double.parse(amount),
                              details,
                              int.parse(selectedUser))
                          : TransactionsRepository().requestMoney(
                              double.parse(amount),
                              details,
                              int.parse(selectedUser));
                      user.addTransaction(transaction);
                      CustomDialogShow(true);
                    } catch (e) {
                      CustomDialogShow(false);
                      print(e);
                    }
                  },
                  text: 'PAY',
                  color: Colors.teal,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
