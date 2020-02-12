import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;
  TransactionList(this.transaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty ?
    LayoutBuilder(
      builder: (ctx,constraints){
        return Column(
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
              height: constraints.maxHeight*0.03,
            ),
            Container(
              height: constraints.maxHeight*0.7,
              child: Image.asset("assets/images/box.png",
              ),
            ),
          ],
        );
      },
    ) :ListView.builder(
      itemCount: transaction.length,
      itemBuilder: (ctx,index){
        return Card(
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:4.0),
              child: FittedBox(
                child: Text('\$'+ transaction[index].itemPrice.toString(),
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                 ),
                ),
              ),
            ),
        ),
          title: Text(transaction[index].itemName,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(DateFormat.yMMMd().format(transaction[index].itemDate),
            style: TextStyle(
              fontSize: 15,
              fontStyle: FontStyle.italic,
              color: Colors.black,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red[900],
            ),
            onPressed: (){
              deleteTx(transaction[index].id,);
            },
          ),
      ),
        );
      },
    );
  }
}

