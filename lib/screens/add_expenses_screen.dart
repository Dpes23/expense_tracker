import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class AddExpensesScreen extends StatefulWidget {
  final Expense? expense;
  const AddExpensesScreen({super.key, this.expense});

  @override
  State<AddExpensesScreen> createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  String? selectedCategory;

  List<String> categories = [
    "Food",
    "Transport",
    "Shopping",
    "Entertainment",
    "Bills",
  ];

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      titleController.text = widget.expense!.title;
      amountController.text = widget.expense!.amount.toString();
      categoryController.text = widget.expense!.category;
    }
  }

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
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          width: 175,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blue,
          ),
          child: const Text(
            "Expense Details",
            style: TextStyle(color: Color.fromARGB(255, 7, 13, 15)),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Enter Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: "Enter Amount",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 40),

              DropdownButtonFormField<String>(
                //controller: categoryController,
                value: selectedCategory,
                decoration: InputDecoration(
                  labelText: "Enter Category",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  // Add expense logic here
                  if (titleController.text.isEmpty) {
                    print("Please enter a title");
                    return;
                  }

                  if (amountController.text.isEmpty) {
                    print("Please enter an amount");
                    return;
                  }

                  if (selectedCategory == null) {
                    print("Please enter a category");
                    return;
                  }

                  Expense newExpense = Expense(
                    titleController.text,
                    double.parse(amountController.text),
                    selectedCategory!,
                  );

                  Navigator.pop(context, newExpense);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                  foregroundColor: Color.fromARGB(255, 7, 13, 15),
                ),
                child: Text(
                  "Save",
                  //style: TextStyle(color: Color.fromARGB(255, 7, 13, 15))
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
