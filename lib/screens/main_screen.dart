import 'package:budjet_x/constants/colors.dart';
import 'package:budjet_x/models/expense_model.dart';
import 'package:budjet_x/models/income_model.dart';
import 'package:budjet_x/screens/add_new_screen.dart';
import 'package:budjet_x/screens/budget_screen.dart';
import 'package:budjet_x/screens/home_screen.dart';
import 'package:budjet_x/screens/profile_screen.dart';
import 'package:budjet_x/screens/transactions_screen.dart';
import 'package:budjet_x/services/expense_service.dart';
import 'package:budjet_x/services/income_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  //current page index...
  int _currentPageIndex = 0;

  List<Expense> expenseList = [];
  List<Income> incomeList = [];

  //Function to fetch expenses...
  void fetchAllExpenses() async{
    List<Expense> loadedExpenses = await ExpenseService().loadExpenses();
    setState(() {
      expenseList = loadedExpenses;
    });
  }

  //Function to fetch incomes...
  void fetchAllIncomes() async{
    List<Income> loadedIncomes = await IncomeService().loadIncomes();
    setState(() {
      incomeList = loadedIncomes;
    });
  }

  //Function to add new expenses...
  void addNewExpenses(Expense newExpense) {
    ExpenseService().saveExpense(newExpense, context);

    //update the list of expenses...
    setState(() {
      expenseList.add(newExpense);
    });
  }

  //Function to add new income...
  void addNewIncome(Income newIncome) {
    IncomeService().saveIncome(newIncome, context);

    //update the list of incomes...
    setState(() {
      incomeList.add(newIncome);
    });
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      fetchAllExpenses();
      fetchAllIncomes();
    });
  }

  @override
  Widget build(BuildContext context) {

    //screen list...
    final List<Widget> pages = [
      
      HomeScreen(),
      TransactionsScreen(),
      AddNewScreen(
        addExpense: addNewExpenses,
        addIncome: addNewIncome,
      ),
      BudgetScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600
        ),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            label: "Home"
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded), 
            label: "Transactions"
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: kWhite, size: 30,)),
              label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket), 
            label: "Budget"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), 
            label: "Profile"
          ),
        ],
      ),
      body: pages[_currentPageIndex],
    );
  }
}
