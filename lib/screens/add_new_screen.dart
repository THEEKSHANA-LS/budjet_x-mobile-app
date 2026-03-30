import 'package:budjet_x/models/expense_model.dart';
import 'package:budjet_x/models/income_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:budjet_x/constants/colors.dart';
import 'package:budjet_x/constants/constants.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  //state to track the expense or income...
  int _selectedMethod = 0;
  ExpenseCategory _expenseCategory = ExpenseCategory.health;
  IncomeCategory _incomeCategory = IncomeCategory.salary;

  //controllers...
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  //dispose for remove garbage values...
  @override
  void dispose() {
    _textEditingController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethod == 0 ? kRed : kGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
          child: Stack(
            children: [
              //expense and income toggle menu...
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMethod = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedMethod == 0 ? kRed : kWhite,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 55,
                              vertical: 10,
                            ),
                            child: Text(
                              "Expense",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: _selectedMethod == 0 ? kWhite : kBlack,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMethod = 1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedMethod == 1 ? kGreen : kWhite,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: 10,
                            ),
                            child: Text(
                              "Income",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: _selectedMethod == 1 ? kWhite : kBlack,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Amount field...
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How Much ?",
                        style: TextStyle(
                          color: kLightGrey,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextField(
                        style: TextStyle(
                          fontSize: 60,
                          color: kWhite,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: "0",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: kWhite,
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //user data form...
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3,
                ),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Form(
                    child: Column(
                      children: [
                        //category selector dropdown...
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding,
                              horizontal: 20,
                            ),
                          ),
                          items: _selectedMethod == 0
                              ? ExpenseCategory.values.map((category) {
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name),
                                  );
                                }).toList()
                              : IncomeCategory.values.map((category) {
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name),
                                  );
                                }).toList(),
                                value: _selectedMethod == 0 ? _expenseCategory : _incomeCategory,
                          onChanged: (value) {
                            setState(() {
                              _selectedMethod == 0
                                  ? _expenseCategory = value as ExpenseCategory
                                  : _incomeCategory = value as IncomeCategory;

                                  print(_selectedMethod == 0 ? _expenseCategory.name : _incomeCategory.name); 
                            });
                          },
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        //title field...
                        TextFormField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Title",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding,
                              horizontal: 20,
                            ),            
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        //description field...
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: "Description",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding,
                              horizontal: 20,
                            ),            
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        //amount field...
                        TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Amount",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding,
                              horizontal: 20,
                            ),            
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
