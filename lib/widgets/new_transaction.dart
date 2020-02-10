
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final itemNameController= new TextEditingController();
  final itemPriceController= new TextEditingController();
  DateTime _selectedDateTime;


  void submitData(){
    final enteredName= itemNameController.text;
    final enteredPrice= double.parse(itemPriceController.text);
    if (enteredName.isEmpty || enteredPrice<0||_selectedDateTime==null){
      return;
    }
    widget.addTx(enteredName,enteredPrice,_selectedDateTime);
    Navigator.pop(context);
//    itemNameController.clear();
//    itemPriceController.clear();
  }
  void _pickDate(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now()).then((pickedDate){
        setState(() {
          _selectedDateTime=pickedDate;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Item Name",
              labelStyle: Theme.of(context)
                  .textTheme.title
                  .copyWith(fontSize: 16,
                  color: Theme.of(context).primaryColor)),

              controller: itemNameController,
              onSubmitted: (_){
                submitData();
              },

            ),
            TextField(
              decoration: InputDecoration(labelText: "Item Price",
              labelStyle:Theme.of(context)
                  .textTheme.title
                  .copyWith(fontSize: 16,
                  color: Theme.of(context).primaryColor)),

              controller: itemPriceController,
              keyboardType:TextInputType.number,
              onSubmitted: (_){
                submitData();
              },

            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(_selectedDateTime==null
                      ?"No date entered"
                      : "Picked Date: ${DateFormat.yMd().format(_selectedDateTime)}",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(fontSize: 14,
                      color: Theme.of(context).primaryColor),),
                ),
                FlatButton(
                  child: Text("Choose a date",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                  ),
                  onPressed: (){
                    _pickDate();
                  },
                ),
              ],
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text("Add Transaction",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight:FontWeight.bold,
                ),),
              onPressed: (){
                submitData();
              },
              splashColor: Colors.greenAccent,
            ),
          ],
        ),
      ),
    );
  }
}