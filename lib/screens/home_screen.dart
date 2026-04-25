import 'package:budjet_x/constants/colors.dart';
import 'package:budjet_x/constants/constants.dart';
import 'package:budjet_x/models/expense_model.dart';
import 'package:budjet_x/models/income_model.dart';
import 'package:budjet_x/services/user_services.dart';
import 'package:budjet_x/widgets/expense_card.dart';
import 'package:budjet_x/widgets/income_expence_card.dart';
import 'package:budjet_x/widgets/line_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<Expense> expenseList;
  final List<Income> incomeList;
  const HomeScreen({super.key, required this.expenseList, required this.incomeList});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //for store the username...
  String username = "";

  //for calculate expense total and income total...
  double expenseTotal = 0;
  double incomeTotal = 0;

  @override
  void initState() {
    //  this initstate run first when rendering....
    //get the username from shared preferences...
    UserServices.getUserData().then((value) {
      if (value["username"] != null) {
        setState(() {
          username = value["username"]!;
        });
      }
    });

    setState(() {
      //total amount of expenses...
      for(var i = 0; i < widget.expenseList.length; i++){
         expenseTotal += widget.expenseList[i].amount;
      }

      //total amount of incomes...
      for(var i = 0; i < widget.incomeList.length; i++){
        incomeTotal += widget.incomeList[i].amount;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          //main column...
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //bg color column...
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: kMainColor.withOpacity(0.15),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: kMainColor,
                              border: Border.all(color: kMainColor, width: 3),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "assets/images/user.jpg",
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Welcome $username",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 30),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.notifications,
                              color: kMainColor,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeExpenceCard(
                            title: "Income",
                            amount: incomeTotal,
                            bgColor: kGreen,
                            imageUrl: "assets/images/income.png",
                          ),
                          IncomeExpenceCard(
                            title: "Expense",
                            amount: expenseTotal,
                            bgColor: kRed,
                            imageUrl: "assets/images/expense.png",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              //Line chart...
              const Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Spend Frequency",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 20),

                    LineChartSample(),
                  ],
                ),
              ),

              //recent transactions...
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        widget.expenseList.isEmpty ? Text("No recent transactions added yet. add some expenses to see here.", style: TextStyle(fontSize: 16, color : kGrey),) :
                        ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.expenseList.length,
                        itemBuilder: (context, index) {
                          final expense = widget.expenseList[index];

                          return ExpenseCard(
                            title: expense.title,
                            date: expense.date,
                            amount: expense.amount,
                            category: expense.category,
                            description: expense.description,
                            time: expense.time,
                          );
                        },
                      ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
