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
  String? amountError;
  String? titleError;
  String? categoryError;

  bool hasError = false;

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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: 190,
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
                onChanged: (value) {
                  setState(() {
                    titleError = null;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Enter Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorText: titleError,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: amountController,
                onChanged: (value) {
                  setState(() {
                    amountError = null;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Enter Amount",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorText: amountError,
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
                  errorText: categoryError,
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
                    categoryError = null;
                  });
                },
              ),
              SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  titleError = null;
                  amountError = null;
                  categoryError = null;

                  bool hasError = false;

                  if (titleController.text.isEmpty) {
                    titleError = "Please enter a title";
                    hasError = true;
                  }

                  double? amount = double.tryParse(amountController.text);

                  if (amountController.text.isEmpty) {
                    amountError = "Please enter an amount";
                    hasError = true;
                  } else if (amount == null) {
                    amountError = "Please enter a valid amount";
                    hasError = true;
                  }

                  if (selectedCategory == null) {
                    categoryError = "Please select a category";
                    hasError = true;
                  }

                  setState(() {});

                  if (hasError) {
                    return;
                  }

                  Expense newExpense = Expense(
                    titleController.text,
                    amount!,
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
