import 'package:expences_calculator/chart/chart.dart';
import 'package:expences_calculator/modals/expence.dart';
import 'package:expences_calculator/widgets/expences_list.dart';
import 'package:expences_calculator/widgets/new_expences.dart';
import 'package:flutter/material.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() {
    return _ExpencesState();
  }
}

class _ExpencesState extends State<Expences> {
  final List<Expense> _registeredExpenses = [];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addexpence),
    );
  }

  void _addexpence(Expense expense) {
    setState(
      () {
        _registeredExpenses.add(expense);
      },
    );
  }

  void _removeExpence(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });

    final expenceIndex = _registeredExpenses.indexOf(expense);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('You have Deleated the expence'),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(
              () {
                _registeredExpenses.insert(expenceIndex, expense);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget maincontent =
        const Center(child: Text('No expences founr Try adding some expences'));

    if (_registeredExpenses.isNotEmpty) {
      maincontent = ExpencesLlist(
        expenses: _registeredExpenses,
        onRemoveExpence: _removeExpence,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expence Tracker"),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: maincontent)
        ],
      ),
    );
  }
}
