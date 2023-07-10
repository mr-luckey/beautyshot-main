
import 'package:beautyshot/Views/talent_screens/talent_signup_screen.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/email_text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import '../../components/constants.dart';
import '../../components/password_text_field.dart';
import '../../controller/auth_controller.dart';

class TalentLoginScreen extends StatefulWidget {
  const TalentLoginScreen({Key? key}) : super(key: key);

  @override
  State<TalentLoginScreen> createState() => _TalentLoginScreenState();
}

class _TalentLoginScreenState extends State<TalentLoginScreen> {

  bool obscureText = true;
  late String signInEmail;
  late String signInPassword;
  final authController = Get.put(AuthController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //Validate login inputs
  validateLoginInputs() {
    unFocus();
    signInEmail = emailController.text.toString();
    signInPassword = passwordController.text.toString();
    final bool isValid = EmailValidator.validate(signInEmail);
    if (isValid) {
      authController.signInWithEmail(signInEmail, signInPassword);
      debugPrint("Email Is Correct");
    } else {
      debugPrint("Email Incorrect");

      Fluttertoast.showToast(
          msg: "The email you have entered is incorrect",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
//unFocus method use to hide Keyboard after usage
  unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
  @override
  void initState() {
    super.initState();
  }

  signUp(){
    Get.to(()=>const TalentSignUpScreen());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Get.back();
        return true;
    },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Logo
                Expanded(child: Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                  child: Image.asset(KImages.logo),
                )),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Email
                      EmailTextField(controller:emailController,title:Strings.email),
                      //Password
                      PasswordTextField(obscureText:obscureText,controller:passwordController,title:Strings.password),
                      //SizedBox
                      const SizedBox(height: 30,),
                      //Login and Signup Button
                      Row(children: [
                        //Login Button
                        Expanded(
                          child: Buttons.blueButton(Strings.login, validateLoginInputs),
                        ),
                        // Signup Button
                        Expanded(
                          child: Buttons.whiteButton(Strings.signup, signUp),
                        ),
                      ],),
                      //Sized Box
                      const SizedBox(height: 30,),
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








