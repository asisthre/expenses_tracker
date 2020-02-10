import 'package:expenses_tracker/widgets/chart.dart';
import 'package:expenses_tracker/widgets/new_transaction.dart';

import './models/transaction.dart';
import 'package:expenses_tracker/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
 class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown ,
        accentColor: Colors.teal,
        fontFamily: "Mont",
        textTheme: TextTheme(
          title: TextStyle(
            fontFamily: "Mont",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(
              fontFamily: "Lato",
              fontSize: 25,
              fontWeight: FontWeight.bold,
            )
          ),
        )
      ),
      home: ExpensePage(),
      title: "Expenses Tracker",
    );
  }
 }
 class ExpensePage extends StatefulWidget {
   @override
   _ExpensePageState createState() => _ExpensePageState();
 }

 class _ExpensePageState extends State<ExpensePage> {
   List<Transaction> _userTransaction=[
//     Transaction( itemName: "Groceries", itemPrice: 12.50, itemDate: DateTime.now()),
//     Transaction( itemName: "Watch", itemPrice: 100.50, itemDate: DateTime.now()),
//     Transaction( itemName: "Skirt", itemPrice: 42.50, itemDate: DateTime.now()),
   ];
   List<Transaction> get _recentTransaction {
   return _userTransaction.where((tx){
   return tx.itemDate.isAfter(DateTime.now().subtract(Duration(days: 7)));
   }).toList();
   }

   void _addNewTransaction(String txName, double txPrice, DateTime txDate){
     final  newTx = Transaction(
         itemName: txName,
         itemPrice: txPrice,
         itemDate: txDate,
     );
     setState(() {
       _userTransaction.add(newTx);
     });
   }
   void showAddTransaction(BuildContext bctx){
     showModalBottomSheet(context: bctx, builder: (ctx)
     {
       return NewTransaction(_addNewTransaction);
     });
   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("Expences tracker"),
         centerTitle: true,
         actions: <Widget>[
           IconButton(
               icon: Icon(
                 Icons.add,
                 color: Colors.white,
               ),
             onPressed: (){
                 showAddTransaction(context);
             },
           )

         ],
       ),

       body:SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Chart(_recentTransaction),
//             Container(
//               height: 100.0,
//               width: double.infinity,
//               child: Card(
//                 child:Text("Chart"),
//                 elevation: 5,
//               ),
//             ),
             TransactionList(_userTransaction),
           ],
         ),
       ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
       floatingActionButton: FloatingActionButton(
         onPressed: (){
           showAddTransaction(context);
         },
         splashColor: Colors.greenAccent,
         child: Icon(
           Icons.add,
         ),
       ),
     );
   }
 }




