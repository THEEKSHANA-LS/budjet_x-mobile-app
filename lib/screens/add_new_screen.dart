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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethod == 0 ? kRed : kGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(100)  
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){
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
                            padding: EdgeInsets.symmetric(horizontal: 55, vertical: 10),
                            child: Text("Expense", style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: _selectedMethod == 0 ? kWhite : kBlack,
                            ),),
                          ) 
                        ),
                      ),
                       GestureDetector(
                        onTap: (){
                          setState(() {
                            _selectedMethod = 1;
                            print(_selectedMethod);
                          });
                        },
                         child: Container(
                          decoration: BoxDecoration(
                            color: _selectedMethod == 1 ? kGreen : kWhite,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 55, vertical: 10),
                            child: Text("Income", style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color : _selectedMethod == 1 ? kWhite : kBlack
                            ),),
                          ) 
                                               ),
                       ),
                      
                    ],
                  ),
                )
              ],
            ),
            ),
          )
        )
      )
    );
  }
}