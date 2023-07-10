
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/rectangular_text_field.dart';
import 'package:beautyshot/controller/client_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants.dart';
import '../../components/title_text.dart';
import '../../controller/auth_controller.dart';

class ClientSignUpScreen extends StatefulWidget {
  const ClientSignUpScreen({Key? key}) : super(key: key);

  @override
  State<ClientSignUpScreen> createState() => _ClientSignUpScreenState();
}

class _ClientSignUpScreenState extends State<ClientSignUpScreen> {

  var obscure_text = true;
  late String companyName;
  late String companyPhoneNumber;
  late String companyEmail;
  late String companyDunsNumber;
  late String companyTaxId;
  late String companyAddress;
  late String signUpPassword;
  late String confirmPassword;
  final authController = Get.put(AuthController());
  final clientController = Get.put(ClientController());
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyPhoneNumberController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController dunsController = TextEditingController();
  TextEditingController taxIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();

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

    companyName = companyNameController.text.toString();
    companyPhoneNumber = companyPhoneNumberController.text.toString();
    companyEmail = companyEmailController.text.toString();
    companyDunsNumber = dunsController.text.toString();
    companyTaxId = taxIdController.text.toString();
    signUpPassword = passwordController.text.toString();
    confirmPassword = confirmPasswordController.text.toString();
    companyAddress = addressController.text.toString();

    final bool isValid = EmailValidator.validate(companyEmail);

    if(signUpPassword != confirmPassword){

      Fluttertoast.showToast(
          msg: "Password does not match",
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
        if(companyName == "" || companyPhoneNumber == ""|| companyAddress == ""){

          Fluttertoast.showToast(
              msg: "Please fill all fields",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else{
          if(_term == false){

            Fluttertoast.showToast(
                msg: "Please accept terms and conditions",
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
            prefs.setString('companyName', companyName);
            prefs.setString('companyPhoneNumber', companyPhoneNumber);
            prefs.setString('companyEmail', companyEmail);
            prefs.setString('companyDunsNumber', companyDunsNumber);
            prefs.setString('companyTaxId', companyTaxId);
            prefs.setString('companyAddress', companyAddress);
            prefs.setString('userType', "client");
            authController.clientSignUpWithEmail(companyEmail, signUpPassword);
            debugPrint("Email Is Correct");
          }
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
    }
  }

  @override
  void dispose() {
    companyNameController.dispose();
    companyPhoneNumberController.dispose();
    companyEmailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
  bool? _term = false;
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  //Body
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Title Text
                        TitleText(Strings.createClientAccount),
                        //SizedBox
                        const SizedBox(height: 30,),
                        //Company Name
                        RectangularTextField(companyNameController,Strings.clientName),
                        //Company Phone Number
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
                            borderRadius: BorderRadius.circular(14),
                            // border: Border.all(
                            //   color: Colors.grey,
                            // ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20,top: 5,bottom: 5),
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              style: KFontStyle.kTextStyle16BlackRegular,
                              controller: companyPhoneNumberController,
                              autofocus: false,
                              maxLines: 1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: Strings.clientPhoneNumber,
                                hintStyle: KFontStyle.kTextStyle16BlackRegular,
                              ),
                            ),
                          ),
                        ),
                        //Company Email
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
                            borderRadius: BorderRadius.circular(14),
                            // border: Border.all(
                            //   color: Colors.grey,
                            // ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20,top: 5,bottom: 5),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              style: KFontStyle.kTextStyle16BlackRegular,
                              controller: companyEmailController,
                              autofocus: false,
                              maxLines: 1,
                              inputFormatters: [FilteringTextInputFormatter.deny( RegExp(r"\s\b|\b\s"))],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: Strings.companyEmail,
                                hintStyle: KFontStyle.kTextStyle16BlackRegular,
                              ),
                            ),
                          ),
                        ),
                        //DUNS Number
                        RectangularTextField(dunsController,Strings.dunsNumber),
                        //Tax ID
                        RectangularTextField(taxIdController,Strings.taxId),
                        //Password
                        RectangularTextField(passwordController,Strings.password),
                        //Confirm Password
                        RectangularTextField(confirmPasswordController,Strings.confirmPassword),
                        //Address
                        Container(
                          height: 120,
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
                            borderRadius: BorderRadius.circular(14),
                            // border: Border.all(
                            //   color: Colors.grey,
                            // ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20,top: 5,bottom: 5),
                            child: TextField(
                              style: KFontStyle.kTextStyle16BlackRegular,
                              textCapitalization: TextCapitalization.words,
                              controller: addressController,
                              autofocus: false,
                              maxLines: 5,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: Strings.address,
                                hintStyle: KFontStyle.kTextStyle16BlackRegular,
                              ),
                            ),
                          ),
                        ),
                        ///SizedBox
                        CheckboxListTile(
                          title: Text("I agree to Terms & Conditions",style: KFontStyle.kTextStyle16BlackRegular,),
                          value: _term,
                          onChanged: (newValue) {
                            setState(() {
                              _term = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                        ),

                        ///Create Account Button
                        Buttons.blueRectangularButton(Strings.createAccount, validateSignUpInputs),
                        ///SizedBox
                        SizedBox(height: 0,),
                        ///Text for terms and conditions

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}






