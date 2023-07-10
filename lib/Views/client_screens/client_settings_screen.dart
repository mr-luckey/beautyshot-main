import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../components/constants.dart';
import '../../controller/auth_controller.dart';

class ClientSettingsScreen extends StatefulWidget {
  const ClientSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ClientSettingsScreen> createState() => _ClientSettingsScreenState();
}

class _ClientSettingsScreenState extends State<ClientSettingsScreen> {
  final authController = Get.put(AuthController());
  String userId = FirebaseAuth.instance.currentUser!.uid.toString();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('clients');

  validateInputs() {
    unFocus();
    String email = emailController.text.toString();
    final bool isValid = EmailValidator.validate(email);
    if (isValid) {
      authentication();
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
  Future authentication() async {
    // Prompt the user to enter their email and password
    String email = emailController.text.toString();
    String password = passwordController.text.toString();

// Create a credential
    AuthCredential credential =
    EmailAuthProvider.credential(email: email, password: password);

// Reauthenticate
    try {
      await auth.currentUser!
          .reauthenticateWithCredential(credential);
      deleteUsers();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');

        Fluttertoast.showToast(
            msg: "User not found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');

        Fluttertoast.showToast(
            msg: "The password you have provided is incorrect",
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
  //Delete user From Firebase Authentication
  deleteUsers() async {
    Get.back();
    Get.defaultDialog(title: "Deleting User",content:LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    try {
      await auth.currentUser!.delete();
      deleteUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        // print(
        //     'The user must reauthenticate before this operation can be executed.');
      }
    }
  }
//Delete User from Firestore
  Future<void> deleteUser() {
    return users
        .doc(userId)
        .delete()
        .then((value) {
      Get.back();
      authController.signOut();
    })
        .catchError((error) {
      // print("Failed to delete user: $error");
    });
  }

  unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
  deleteAccount(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                content: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20),
                      child: const Text(
                        "Please Verify Your Credentials",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat",
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin:
                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(14),
                        border: Border.all(
                          color: Color(KColors.kColorPrimary),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          keyboardType: TextInputType
                              .emailAddress,
                          autofocus: false,
                          controller: emailController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal,
                              color: Color(0xff6F6F6E),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                      const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(14),
                        border: Border.all(
                          color: Color(KColors.kColorPrimary),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          autofocus: false,
                          controller:
                          passwordController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText:
                            "Password",
                            hintStyle: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal,
                              color: Color(0xff6F6F6E),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Buttons.whiteRectangularButton(Strings.deleteAccount, validateInputs),
                    Buttons.whiteRectangularButton(Strings.kBack, () { Get.back(); }),
                  ],
                ),
              ),
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(Strings.settings,style: KFontStyle.kTextStyle24Black,),
        toolbarHeight: 80,
        centerTitle: false,
        backgroundColor: Color(KColors.kColorWhite),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Buttons.plainWhiteButton(Strings.editProfile, () { }),
                  Buttons.plainWhiteButton(Strings.archiveProjects, () { }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children:  [
                  Buttons.plainWhiteButton(Strings.deleteAccount, deleteAccount),
                  Buttons.plainWhiteButton(Strings.logout, (){authController.signOut();}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
