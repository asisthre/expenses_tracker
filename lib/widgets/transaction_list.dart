import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  TransactionList(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: transaction.isEmpty ? Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text("No transaction added yet!",
              style: Theme.of(context).textTheme.title,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Image.asset("assets/images/box.png",
              height: 120,
              width: 180,
            ),
          ),
        ],
      ) :ListView.builder(
        itemCount: transaction.length,
        itemBuilder: (ctx,index){
          return Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: Text(
                  '\$'+ transaction[index].itemPrice.toString(),
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                  ),),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).accentColor,
                    width:2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow:[BoxShadow(color: Colors.transparent, offset:Offset(1,5))],
                ),
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                padding: EdgeInsets.all(5.0),
              ),
              Column(
                children: <Widget>[
                  Text(transaction[index].itemName,
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd().format(transaction[index].itemDate),
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),),
                ],
              )
            ],
          ),
        );
        },
      ),
    );
  }
}
