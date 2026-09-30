import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/screens/add_expenses_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double getTotalExpense() {
    double sum = 0;
    for (var expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }

  List<Expense> expenses = [
    Expense("Food", 500, "Restaurant"),
    Expense("Transport", 200, "Taxi"),
    Expense("Shopping", 1000, "Clothes"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expense Tracker")),

      body: Column(
        children: [
          Text(
            "Total Expense: Rs. ${getTotalExpense()}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    expenses[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  subtitle: Text(expenses[index].category),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Amount
                      Text(
                        "Rs. ${expenses[index].amount}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Edit Button
                      IconButton(
                        onPressed: () async {
                          final updatedExpense = await Navigator.push<Expense>(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddExpensesScreen(expense: expenses[index]),
                            ),
                          );

                          if (updatedExpense != null) {
                            setState(() {
                              expenses[index] = updatedExpense;
                            });
                          }
                        },
                        icon: Icon(Icons.edit, color: Colors.indigoAccent),
                      ),

                      // Delete Button
                      IconButton(
                        constraints: BoxConstraints(),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Center(child: Text("Delete Expense")),

                                content: Text(
                                  "Are you sure want to delete this expense?",
                                ),

                                actions: [
                                  // Cancel
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel"),
                                  ),

                                  // Delete
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: const Color.fromARGB(
                                        255,
                                        250,
                                        244,
                                        244,
                                      ),
                                      backgroundColor: const Color.fromARGB(
                                        255,
                                        116,
                                        91,
                                        184,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        expenses.removeAt(index);
                                      });

                                      Navigator.pop(context);
                                    },
                                    child: Text("Delete"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Add Expense Button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newExpense = await Navigator.push<Expense>(
            context,
            MaterialPageRoute(builder: (context) => AddExpensesScreen()),
          );

          if (newExpense != null) {
            setState(() {
              expenses.add(newExpense);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
