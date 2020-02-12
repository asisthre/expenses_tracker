import 'package:expenses_tracker/widgets/chart.dart';
import 'package:expenses_tracker/widgets/new_transaction.dart';
import 'package:flutter/services.dart';
import './models/transaction.dart';
import 'package:expenses_tracker/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  //------this is to disable landscape mode and use portrait mode
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]).then((_){
//  runApp(MyApp());});
//}
  runApp(MyApp());
}
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
   List<Transaction> _userTransaction=[];
   bool _showChart = false;

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
         id: DateTime.now().toString(),
     );

     setState(() {
       _userTransaction.add(newTx);
     });
   }
   //this function helps to delete the transaction
   void _deleteTransaction(String id){
     setState(() {
       _userTransaction.removeWhere((tx){
         return tx.id==id;
       });
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
     final mediaQuery = MediaQuery.of(context);
     final isLandscape =mediaQuery.orientation == Orientation.landscape;

     final PreferredSizeWidget appBar = Platform.isIOS?CupertinoNavigationBar(
       middle: Text("Expences tracker"),
       trailing: Row(
         mainAxisSize: MainAxisSize.min,
         children: <Widget>[
           GestureDetector(
             child: Icon(CupertinoIcons.add),
             onTap: (){
               showAddTransaction(context);
             },
           )
         ],
       ),
     )

     :AppBar(
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
     );

     final pageBody=SingleChildScrollView(
       scrollDirection: Axis.vertical,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           if(isLandscape) Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Text("Show Chart"),
               Switch.adaptive(
                 value: _showChart,
                 onChanged: (value){
                   setState(() {
                     _showChart=value;
                   });
                 },
               ),
             ],
           ),
           if(!isLandscape)Container(
               height: (mediaQuery.size.height*0.3)-
                   appBar.preferredSize.height-
                   mediaQuery.padding.top,
               child: Chart(_recentTransaction)
           ),
           if(!isLandscape)
             Container(
                 height: (mediaQuery.size.height*0.7)-
                     appBar.preferredSize.height-
                     mediaQuery.padding.top,
                 child: TransactionList(_userTransaction,_deleteTransaction)
             ),
           if(isLandscape)_showChart ? Container(
               height: (mediaQuery.size.height*0.7)-
                   appBar.preferredSize.height-
                   mediaQuery.padding.top,
               child: Chart(_recentTransaction)
           )
               :Container(
               height: (mediaQuery.size.height*0.7)-
                   appBar.preferredSize.height-
                   mediaQuery.padding.top,
               child: TransactionList(_userTransaction,_deleteTransaction)
           ),
         ],
       ),
     );
     return Platform.isIOS
     ?CupertinoPageScaffold(
       child: pageBody,
       navigationBar: appBar,
     )
     :Scaffold(
       appBar: appBar,
       body:pageBody,
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
       floatingActionButton: Platform.isIOS
         ?Container(): FloatingActionButton(
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




