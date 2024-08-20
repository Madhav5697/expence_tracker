import 'package:flutter/material.dart';
import 'package:expences_calculator/modals/expence.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpensestate();
  }
}

class _NewExpensestate extends State<NewExpense> {
  final _titlecontroller = TextEditingController();
  final _ammountController = TextEditingController();
  DateTime? _SelectedDate;
  Category _SelectedCategory = Category.lisure;

  @override
  void dispose() {
    _titlecontroller.dispose();
    _ammountController.dispose();
    super.dispose();
  }

  void _SubmitEpenceData() {
    final enteredAmount = double.tryParse(_ammountController.text);
    var _amountInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titlecontroller.text.trim().isEmpty ||
        _amountInvalid ||
        _SelectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content:
              const Text('Please make sure You entered everythig correctly'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
          amount: enteredAmount,
          date: _SelectedDate!,
          title: _titlecontroller.text,
          category: _SelectedCategory),
    );
    Navigator.pop(context);
  }

  void _prsentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(
      () {
        _SelectedDate = pickedDate;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titlecontroller,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ammountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text("Ammount"),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _SelectedDate == null
                          ? "no Date added"
                          : formatter.format(_SelectedDate!),
                    ),
                    IconButton(
                      onPressed: _prsentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                value: _SelectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (madhav) {
                  if (madhav == null) {
                    return;
                  }
                  setState(
                    () {
                      _SelectedCategory = madhav;
                    },
                  );
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _SubmitEpenceData,
                child: const Text("Save Expense"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Clear data"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
