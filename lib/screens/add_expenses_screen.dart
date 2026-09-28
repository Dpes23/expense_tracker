import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class AddExpensesScreen extends StatefulWidget {
  const AddExpensesScreen({super.key});

  @override
  State<AddExpensesScreen> createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final categoryController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Expense")),
      body: Column(
        children: [
          const Center(child: Text("Expenses Details")),

          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: "Title"),
          ),
          SizedBox(height: 20),

          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Amount"),
          ),
          SizedBox(height: 20),

          TextField(
            controller: categoryController,
            decoration: const InputDecoration(labelText: "Category"),
          ),
          SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              if (titleController.text.isEmpty) {
                print("Please enter a title");
                return;
              }

              if (amountController.text.isEmpty) {
                print("Please enter a amount");
                return;
              }

              if (categoryController.text.isEmpty) {
                print("Please enter a category");
                return;
              }
              Expense newExpense = Expense(
                titleController.text,
                double.parse(amountController.text),
                categoryController.text,
              );

              Navigator.pop(context, newExpense);
            },
            child: const Text("Add Expense"),
          ),
        ],
      ),
    );
  }
}
