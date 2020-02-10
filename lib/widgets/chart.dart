import 'package:expenses_tracker/models/transaction.dart';
import 'package:expenses_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  List<Transaction> transaction=[];

  Chart(this.transaction);

  List<Map<String, Object>> get groupedExpenses{
    return List.generate(7, (index){
      final weekDay= DateTime.now().subtract(Duration(days: index));
      double totalSum=0.0;

      for(int i=0;i<transaction.length;i++){
        if(transaction[i].itemDate.day == weekDay.day &&
            transaction[i].itemDate.month == weekDay.month &&
            transaction[i].itemDate.year == weekDay.year){
          totalSum +=transaction[i].itemPrice;
        }
      }
      return{
        'day': DateFormat.E().format(weekDay).substring(0,2),
        'amount': totalSum};
    }).reversed.toList();
  }

    double get totalSpending{
    return groupedExpenses.fold(0.0, (sum,item){
      return sum + item['amount'];
    });
    }

  @override
  Widget build(BuildContext context) {
    return Card(

      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: groupedExpenses.map((data){
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(data['day'],
                            data['amount'],
                            totalSpending==0.0?0.0:(data['amount'] as double) / totalSpending),
          );
        }).toList(),
      ),
    );
  }
}
