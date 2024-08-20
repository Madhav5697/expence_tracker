import 'package:expences_calculator/main.dart';
import 'package:expences_calculator/widgets/expences_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:expences_calculator/modals/expence.dart';

class ExpencesLlist extends StatelessWidget {
  ExpencesLlist(
      {super.key, required this.expenses, required this.onRemoveExpence});
  final List<Expense> expenses;
  void Function(Expense expense) onRemoveExpence;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
              key: ValueKey(expenses[index]),
              background: Container(
                color: Theme.of(context).colorScheme.error,
              ),
              onDismissed: (direction) => onRemoveExpence(expenses[index]),
              child: ExpenseItem(
                expenses[index],
              ),
            ));
  }
}
