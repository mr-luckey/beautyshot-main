
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/top_row.dart';
import 'package:beautyshot/controller/api.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants.dart';
import '../../components/rounded_text_field.dart';
import '../../components/title_text.dart';
import '../../controller/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class TalentSignUpScreen extends StatefulWidget {
  const TalentSignUpScreen({Key? key}) : super(key: key);

  @override
  State<TalentSignUpScreen> createState() => _TalentSignUpScreenState();
}

class _TalentSignUpScreenState extends State<TalentSignUpScreen> {

  bool obscureText = true;
  bool obscureConfirmText = true;
  late String firstName;
  late String lastName;
  late String signUpEmail;
  late String signUpPassword;
  late String confirmPassword;
  final authController = Get.put(AuthController());
  final api = Get.put(Api());

  @override
  void initState() {
    super.initState();
    api.getHairColor();
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  _launchURL() async {
    const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //unFocus method use to hide Keyboard after usage
  unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
  //Validate Signup inputs
  validateSignUpInputs() async{

    unFocus();

    firstName = firstNameController.text.toString();
    lastName = lastNameController.text.toString();
    signUpEmail = emailController.text.toString();
    signUpPassword = passwordController.text.toString();
    confirmPassword = confirmPasswordController.text.toString();

    final bool isValid = EmailValidator.validate(signUpEmail);

    if(signUpPassword != confirmPassword){
      Fluttertoast.showToast(
          msg: "The password you have entered do not match",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
    else{
      if (isValid) {
        if(firstName == "" || lastName == ""){
          Fluttertoast.showToast(
              msg: "One or more field is empty",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );

        }
        else{

          final SharedPreferences prefs = await _prefs;
          prefs.setString('firstName', firstName);
          prefs.setString('lastName', lastName);
          prefs.setString('email', signUpEmail);
          prefs.setString('userType', "Model");
          prefs.setString('password', signUpPassword);
          debugPrint("Email Is Correct");

          authController.signUpWithEmail(signUpEmail, signUpPassword);

        }
      }
      else {
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
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileScreen()),
      // );
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    authController.dispose();
    api.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        unFocus();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,

        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Top Row
                    TopRow(1,5),
                    //Body
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Title Text
                          TitleText(Strings.createAccount+" (Model)"),
                          //SizedBox
                          const SizedBox(height: 30,),
                          //First Name
                          RoundedTextField(controller:firstNameController,title:Strings.firstName),
                          //Last Name
                          RoundedTextField(controller:lastNameController,title:Strings.lastName),
                          //Email
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 3.0), //(x,y)
                                  blurRadius: 5.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(50),
                              // border: Border.all(
                              //   color: Colors.grey,
                              // ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20,top: 5,bottom: 5),
                              child: TextField(
                                style: KFontStyle.kTextStyle16BlackRegular,
                                controller: emailController,
                                autofocus: false,
                                maxLines: 1,
                                inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: Strings.email,
                                  hintStyle: KFontStyle.kTextStyle16BlackRegular,
                                ),
                              ),
                            ),
                          ),
                          //Password
                          // RoundedTextField(controller:passwordController,title:Strings.password),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 3.0), //(x,y)
                                  blurRadius: 5.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(50),
                              // border: Border.all(
                              //   color: Colors.grey,
                              // ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20,top: 5,bottom: 5,right: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      style: KFontStyle.kTextStyle16BlackRegular,
                                      textCapitalization: TextCapitalization.words,
                                      controller: passwordController,
                                      obscureText: obscureText,
                                      autofocus: false,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: Strings.password,
                                        hintStyle: KFontStyle.kTextStyle16BlackRegular,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(obscureText == true)
                                          {
                                            obscureText = false;
                                          }
                                        else{
                                          obscureText = true;
                                        }
                                      });
                                    },
                                      child: Icon(obscureText?Icons.remove_red_eye:Icons.remove_red_eye_outlined,))
                                ],
                              ),
                            ),
                          ),
                          //Confirm Password
                          // RoundedTextField(controller:confirmPasswordController,title:Strings.confirmPassword),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 3.0), //(x,y)
                                  blurRadius: 5.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(50),
                              // border: Border.all(
                              //   color: Colors.grey,
                              // ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20,top: 5,bottom: 5,right: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      style: KFontStyle.kTextStyle16BlackRegular,
                                      textCapitalization: TextCapitalization.words,
                                      controller: confirmPasswordController,
                                      obscureText: obscureConfirmText,
                                      autofocus: false,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: Strings.confirmPassword,
                                        hintStyle: KFontStyle.kTextStyle16BlackRegular,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: (){
                                        setState(() {
                                          if(obscureConfirmText == true)
                                          {
                                            obscureConfirmText = false;
                                          }
                                          else{
                                            obscureConfirmText = true;
                                          }
                                        });
                                      },
                                      child: Icon(obscureConfirmText?Icons.remove_red_eye:Icons.remove_red_eye_outlined,))
                                ],
                              ),
                            ),
                          ),
                          //SizedBox
                          const SizedBox(height: 20,),
                          //Create Account Button
                          Buttons.blueButton(Strings.createAccount,validateSignUpInputs),
                          //SizedBox
                          const SizedBox(height: 20,),
                          //Text for terms and conditions
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(child: Text("By creating account, you agree to our",style: KFontStyle.kTextStyle16BlackRegular,)),
                              const SizedBox(height: 05,),
                              InkWell(
                                  onTap: (){
                                    _launchURL();
                                  },
                                  child: Center(child: Text("TERMS & CONDITIONS",style: KFontStyle.kTextStyle16BlackRegular,))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}






