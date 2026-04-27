import 'package:budjet_x/constants/colors.dart';
import 'package:budjet_x/constants/constants.dart';
import 'package:budjet_x/models/expense_model.dart';
import 'package:budjet_x/models/income_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCategoryTotals;
  final Map<IncomeCategory, double> incomeCategoryTotals;
  final bool isExpense;
  const Chart({
    super.key,
    required this.expenseCategoryTotals,
    required this.incomeCategoryTotals,
    required this.isExpense,
  });

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  //section data...
  List<PieChartSectionData> getSections() {
    if (widget.isExpense) {
      return [
        PieChartSectionData(
          color: expenseCategoriesColor[ExpenseCategory.food],
          value: widget.expenseCategoryTotals[ExpenseCategory.food] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoriesColor[ExpenseCategory.health],
          value: widget.expenseCategoryTotals[ExpenseCategory.health] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoriesColor[ExpenseCategory.shopping],
          value: widget.expenseCategoryTotals[ExpenseCategory.shopping] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoriesColor[ExpenseCategory.subscriptions],
          value:
              widget.expenseCategoryTotals[ExpenseCategory.subscriptions] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoriesColor[ExpenseCategory.transport],
          value: widget.expenseCategoryTotals[ExpenseCategory.transport] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
    } else {
      return [
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.freelance],
          value: widget.incomeCategoryTotals[IncomeCategory.freelance] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.passive],
          value: widget.incomeCategoryTotals[IncomeCategory.passive] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.salary],
          value: widget.incomeCategoryTotals[IncomeCategory.salary] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.sales],
          value: widget.incomeCategoryTotals[IncomeCategory.sales] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final PieChartData pieChartData = PieChartData(
      sectionsSpace: 0,
      centerSpaceRadius: 70,
      startDegreeOffset: -90,
      sections: getSections(),
      borderData: FlBorderData(show: false),
    );
    return Container(
      height: 250,
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(pieChartData),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "70%",
                style: TextStyle(color: kBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text("of 100%", style: TextStyle(color: kGreen)),
            ],
          ),
        ],
      ),
    );
  }
}
