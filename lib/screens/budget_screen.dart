import 'package:budjet_x/constants/colors.dart';
import 'package:budjet_x/constants/constants.dart';
import 'package:budjet_x/models/expense_model.dart';
import 'package:budjet_x/models/income_model.dart';
import 'package:budjet_x/widgets/category_card.dart';
import 'package:budjet_x/widgets/pie_chart.dart';
import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCategoryTotals;
  final Map<IncomeCategory, double> incomeCategoryTotals;
  const BudgetScreen({
    super.key,
    required this.expenseCategoryTotals,
    required this.incomeCategoryTotals,
  });

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  int _selectedOption = 0;

  //method to find the category color from the category....
  Color getCategoryColor(dynamic category) {
    if (category is ExpenseCategory) {
      return expenseCategoriesColor[category]!;
    } else {
      return incomeCategoryColor[category]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _selectedOption == 0
        ? widget.expenseCategoryTotals
        : widget.incomeCategoryTotals;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Financial Screen",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: kBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: kWhite,
                    boxShadow: [
                      BoxShadow(color: kBlack.withOpacity(0.1), blurRadius: 20),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedOption = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: _selectedOption == 0 ? kRed : kWhite,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 60,
                            ),
                            child: Text(
                              "Expense",
                              style: TextStyle(
                                color: _selectedOption == 0 ? kWhite : kBlack,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedOption = 1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: _selectedOption == 0 ? kWhite : kGreen,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 60,
                            ),
                            child: Text(
                              "Income",
                              style: TextStyle(
                                color: _selectedOption == 0 ? kBlack : kWhite,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //Pie chart...
              Chart(
                expenseCategoryTotals: widget.expenseCategoryTotals,
                incomeCategoryTotals: widget.incomeCategoryTotals,
                isExpense: _selectedOption == 0,
              ),
              SizedBox(height: 20),

              //List of categories...
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final category = data.keys.toList()[index];
                    final total = data.values.toList()[index];
                    return CategoryCard(
                      title: category.name,
                      amount: total,
                      isExpense: _selectedOption == 0,
                      progressColor: getCategoryColor(category),
                      total: data.values.reduce((value, element) => value + element),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
