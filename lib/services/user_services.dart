import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  //method to store the user name and user email in shared preferences...
  static Future<void> storeUserDetails({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    //if the users password and confirm password are same then store the users name and email...
    try {
      //check weather the user entered password and the confirm password are the same...
      if (password != confirmPassword) {
        //show a message to the user...
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password and confirm password do not match"),
          ),
        );

        return;
      }

      //create an instance from shared preferences...
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //show the user name and email as key value pairs...
      await prefs.setString("username", userName);
      await prefs.setString("email", email);

      //show the message to the user...
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User details stored successfuly")),
      );
    } catch (err) {
      err.toString();
    }
  }

  //method to check weather the username is saved in the shared preferences...
  static Future<bool> checkUsername() async {
    //create an instance for shared preference...
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('username');
    return userName != null;
  }
}
