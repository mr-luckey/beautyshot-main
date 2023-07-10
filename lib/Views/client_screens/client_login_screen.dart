import 'package:beautyshot/Views/client_screens/client_signup_screen.dart';
import 'package:beautyshot/Views/talent_screens/talent_signup_screen.dart';
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/email_rect_text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import '../../components/constants.dart';
import '../../components/password_rect_text_field.dart';
import '../../controller/auth_controller.dart';

class ClientLoginScreen extends StatefulWidget {
  const ClientLoginScreen({Key? key}) : super(key: key);

  @override
  State<ClientLoginScreen> createState() => _ClientLoginScreenState();
}

class _ClientLoginScreenState extends State<ClientLoginScreen> {

  var obscure_text = true;
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
    Get.to(()=>TalentSignUpScreen());
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
                      EmailRectTextField(emailController,Strings.email),
                      //Password
                      PasswordRectTextField(obscure_text,passwordController,Strings.password),
                      //SizedBox
                      SizedBox(height: 30,),
                      //Login and Signup Button
                      Row(children: [
                        //Login Button
                        Expanded(
                          child: Buttons.blueRectangularButton("LOGIN", validateLoginInputs),
                        ),
                        // Signup Button
                      ],),
                      //Sized Box
                      SizedBox(height: 50,),
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>ClientSignUpScreen());
                        },
                        child: Container(
                            height:22,child: Text("Don't have an Account? CREATE NEW",style: KFontStyle.kTextStyle18Black,)),
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








