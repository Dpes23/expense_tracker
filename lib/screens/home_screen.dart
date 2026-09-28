import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/screens/add_expenses_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   List<Expense> expenses = [
      Expense("Food", 500, "Restaurant"),
      Expense("Movie", 300, "Entertainment"),
      Expense("Bus Fare", 50, "Transport"),
    ];
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Tracker')),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(expenses[index].title),
            subtitle: Text(expenses[index].category),
            trailing: Text("Rs. ${expenses[index].amount}"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newExpense = await Navigator.push<Expense>(
            context,
            MaterialPageRoute(builder: (context) => const AddExpensesScreen()),
          );

          if(newExpense != null) {
            setState(() {
              expenses.add(newExpense);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
