import 'dart:convert';

import 'package:budjet_x/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  //expense list
  List<Expense> expenseList = [];

  //Define the key for storing expense in shared preferences...
  static const String _expenseKey = 'expenses';

  //Save the expense to shared preferences...
  Future<void> saveExpense(Expense expense, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList(_expenseKey);

      //Convert the existing to a list of Expense objects...
      List<Expense> existingExpenseObjects = [];

      if (existingExpenses != null) {
        existingExpenseObjects = existingExpenses
            .map((e) => Expense.fromJSON(json.decode(e)))
            .toList();
      }

      //Add the new expense to the List...
      existingExpenseObjects.add(expense);

      //convert the list of expense objects back into list of strings...
      List<String> updatedExpenses = existingExpenseObjects
          .map((e) => json.encode(e.toJSON()))
          .toList();

      //save the updated list of expenses to shared preferences...
      await prefs.setStringList(_expenseKey, updatedExpenses);

      //show message...
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Expense added successfully !"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      //show message...
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error on adding Expense !"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //Load the expences from shared preferneces...
  Future<List<Expense>> loadExpenses() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingExpenses = pref.getStringList(_expenseKey);

    //Convert the existing expenses to a list of Expense objects...
    List<Expense> loadedExpenses = [];
    if (existingExpenses != null) {
      loadedExpenses = existingExpenses
          .map((e) => Expense.fromJSON(json.decode(e)))
          .toList();
    }

    return loadedExpenses;
  }
}
