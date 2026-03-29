//enum for expense categories...
import 'dart:ui';

enum ExpenseCategory{
  food,
  transport,
  health,
  shopping,
  subscriptions,
}

//category images...
final Map<ExpenseCategory, String> expenseCategoriesImages = {
  ExpenseCategory.food: "assets/images/restaurant.png",
  ExpenseCategory.transport: "assets/images/car.png",
  ExpenseCategory.health: "assets/images/health.png",
  ExpenseCategory.shopping: "assets/images/bag.png",
  ExpenseCategory.subscriptions: "assets/images/bill.png",
};

//category Colors...
final Map<ExpenseCategory, Color> expenseCategoriesColor = {
   ExpenseCategory.food: const Color(0xFFE57373),
  ExpenseCategory.transport: const Color(0xFF81C784),
  ExpenseCategory.health: const Color(0xFF64B5F6),
  ExpenseCategory.shopping: const Color(0xFFFFD54F),
  ExpenseCategory.subscriptions: const Color(0xFF9575CD),
};

class Expense {
  final int id;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;
  final DateTime time;
  final String description;


  Expense({
    required this.id, 
    required this.title, 
    required this.amount, 
    required this.category, 
    required this.date, 
    required this.time, 
    required this.description});
}