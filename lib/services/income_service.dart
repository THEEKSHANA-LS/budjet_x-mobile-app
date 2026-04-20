import 'dart:convert';

import 'package:budjet_x/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {
  //Define the key for storing incomes in shared preferences...
  static const String _incomeKey = "income";

  //save the income to shared preferences...(Function 1)
  Future<void> saveIncome(Income income, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      //Convert the existing Incomes to a list of Income objects...
      List<Income> existingIncomeObjects = [];

      if (existingIncomes != null) {
        existingIncomeObjects = existingIncomes
            .map((e) => Income.fromJSON(json.decode(e)))
            .toList();
      }

      //Add the new income to the list...
      existingIncomeObjects.add(income);

      //Convert the list of Income objects back to a list of strings...
      List<String> updatedIncome = existingIncomeObjects
          .map((e) => json.encode(e.toJSON()))
          .toList();

      //Save the updated list of incomes to shared preferences...
      await prefs.setStringList(_incomeKey, updatedIncome);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Income added successfully !"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error adding Income !"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //Load the income from shared preferences...(Function 2)
  Future<List<Income>> loadIncomes() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingIncomes = pref.getStringList(_incomeKey);

    //Convert the existing incomes to a list of income objects...
    List<Income> loadedIncomes = [];
    if (existingIncomes != null) {
      loadedIncomes = existingIncomes
          .map((e) => Income.fromJSON(json.decode(e)))
          .toList();
    }

    return loadedIncomes;
  }

  //Function for delete an income...
  Future<void> deleteIncome(int id, BuildContext context) async {

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingIncomes = prefs.getStringList(_incomeKey);

    //Convert the existing incomes to a list of Income objects...
    List<Income> existingIncomeObjects = [];
    if (existingIncomes != null) {
      existingIncomeObjects = existingIncomes
          .map((e) => Income.fromJSON(json.decode(e)))
          .toList();
    }

    //Remove the income with the given id from the list...
    existingIncomeObjects.removeWhere((income) => income.id == id);

    //Convert the list of Income objects back to list of strings...
    List<String> updatedIncomes = existingIncomeObjects
        .map((e) => json.encode(e.toJSON()))
        .toList();

    //Save the updated list of incomes to shared preferences...
    await prefs.setStringList(_incomeKey, updatedIncomes);

    //Show message...
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Income deleted successfully !"),
          duration: Duration(seconds: 2),
        ),
      );
    }
    } catch (error){
      //Show message...
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error deleteing Income !"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
}
