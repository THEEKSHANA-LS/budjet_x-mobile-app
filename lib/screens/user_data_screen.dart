import 'package:budjet_x/constants/colors.dart';
import 'package:budjet_x/constants/constants.dart';
import 'package:budjet_x/screens/main_screen.dart';
import 'package:budjet_x/services/user_services.dart';
import 'package:budjet_x/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
 
  //for the check box...
  bool _rememberMe = false;

  //form key for form validation...
  final _formKey = GlobalKey<FormState>();

  //controller for the text from feilds...
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // this is use to remove garbage values after goes to new screen...
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter your \nPersonal Details",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 30),

                //Form...
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Form field for the user name...
                      TextFormField(
                        controller: _userNameController,
                        validator: (value) {
                          //check weather the user entered a valid name...
                          if(value!.isEmpty){
                            return "Please Enter Your Name";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 15),

                      //Form field for the user email...
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          //check weather the user entered a valid name...
                          if(value!.isEmpty){
                            return "Please Enter Your Email";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),

                      SizedBox(height: 15),
                      //form field for user password...
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          //check weather the user entered a valid name...
                          if(value!.isEmpty){
                            return "Please Enter a Valid Password";
                          }
                        },
                        obscureText:
                            true, //hide what user type in the text field...
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),

                      SizedBox(height: 15),
                      //form field for user confirm password...
                      TextFormField(
                        controller: _confirmPasswordController,
                        validator: (value) {
                          //check weather the user entered a valid name...
                          if(value!.isEmpty){
                            return "Please Enter a Same Password";
                          }
                        },
                        obscureText:
                            true, //hide what user type in the text field...
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),

                      SizedBox(height: 30),

                      //remember me for the next time...
                      Row(
                        children: [
                          const Text(
                            "Remember me for the next time",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kGrey,
                            ),
                          ),

                          Expanded(
                            child: CheckboxListTile(
                              activeColor: kMainColor,
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30
                      ),
                      //submit button...
                      GestureDetector(
                        onTap: () async{
                          if(_formKey.currentState!.validate()){
                            //form is valid, process data...
                            String userName = _userNameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            String confirmPassword = _confirmPasswordController.text;

                            //save the user name and email in the device storage using shared prferences...
                            await UserServices.storeUserDetails(
                               userName: userName,
                               email: email,
                               password: password,
                               confirmPassword: confirmPassword,
                               context: context,
                            );

                            //navigate to main screen...
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return const MainScreen();
                            }));
                          }
                        },
                        child: CustomButton(
                          buttonName: "Next", 
                          buttonColor: kMainColor
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
