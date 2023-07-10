import 'package:beautyshot/Views/talent_screens/done_screen.dart';
import 'package:beautyshot/Views/talent_screens/identity_screen.dart';
import 'package:beautyshot/components/title_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants.dart';
import '../../controller/talent_controller.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {

  final userController = Get.put(UserController());
  bool? _term1 = false;
  bool? _term2 = false;
  bool? _term3 = false;
  bool? _term4 = false;
  bool? _term5 = false;
  bool? _term6 = false;
  bool? _term7 = false;
  bool? _term8 = false;
  bool? _term9 = false;
  bool? _term10 = false;
  bool? _term11 = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  onForwardPress()async{
    if(_term1 != true || _term2 != true || _term3 != true || _term4 != true || _term5 != true || _term6 != true || _term7 != true || _term8 != true || _term9 != true || _term10 != true || _term11 != true){
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
      // userController.addUserData(userId, userType,firstName, lastName, email, profilePicture, dateOfBirth, gender, county, state, city, postalCode, drivingLicense, idCard, passport, otherId,isDrivingLicense,isIdCard,isPassport,isOtherId);
      Get.to(()=>const DoneScreen());
    }

  }
  void persistLastRoute(String routeName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(Strings.lastRouteKey, routeName);
  }

  @override
  void initState() {
    super.initState();
    persistLastRoute('/termsAndConditions');
  }
  Future<bool> _willPopCallback() async {
    Get.to(()=>const IdentityScreen());
    return false;
    // return true if the route to be popped
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Title Text
                TitleText(Strings.termsAndConditions),
                //Body
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Checkboxes
                      CheckboxListTile(
                        title: const Text("Lorem ipsum dolor sit amet, consectetur adipScing elit"),
                        value: _term1,
                        onChanged: (newValue) {
                          setState(() {
                            _term1 = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      CheckboxListTile(
                        title: const Text("Lorem ipsum dolor sit amet, consectetur adipScing elit"),
                        value: _term2,
                        onChanged: (newValue) {
                          setState(() {
                            _term2 = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      CheckboxListTile(
                        title: const Text("Lorem ipsum dolor sit amet, consectetur adipScing elit"),
                        value: _term3,
                        onChanged: (newValue) {
                          setState(() {
                            _term3 = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      CheckboxListTile(
                        title: const Text("Lorem ipsum dolor sit amet, consectetur adipScing elit"),
                        value: _term4,
                        onChanged: (newValue) {
                          setState(() {
                            _term4 = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      CheckboxListTile(
                        title: const Text("Lorem ipsum dolor sit amet, consectetur adipScing elit"),
                        value: _term5,
                        onChanged: (newValue) {
                          setState(() {
                            _term5 = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      CheckboxListTile(
                        title: const Text("Lorem ipsum dolor sit amet, consectetur adipScing elit"),
                        value: _term6,
                        onChanged: (newValue) {
                          setState(() {
                            _term6 = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      CheckboxListTile(
                        title: const Text("Lorem ipsum dolor sit amet, consectetur adipScing elit"),
                        value: _term7,
                        onChanged: (newValue) {
                          setState(() {
                            _term7 = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      CheckboxListTile(
                        title: const Text("Lorem ipsum dolor sit amet, consectetur adipScing elit"),
                        value: _term8,
                        onChanged: (newValue) {
                          setState(() {
                            _term8 = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      CheckboxListTile(
                        title: const Text("Lorem ipsum dolor sit amet, consectetur adipScing elit"),
                        value: _term9,
                        onChanged: (newValue) {
                          setState(() {
                            _term9 = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      CheckboxListTile(
                        title: const Text("Lorem ipsum dolor sit amet, consectetur adipScing elit"),
                        value: _term10,
                        onChanged: (newValue) {
                          setState(() {
                            _term10 = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      //SizedBox
                      const SizedBox(height: 20,),
                      //All terms and Conditions checkbox
                      CheckboxListTile(
                        title: const Text("I agree to all Terms & Conditions"),
                        value: _term11,
                        onChanged: (newValue) {
                          setState(() {
                            _term1 = newValue;
                            _term2 = newValue;
                            _term3 = newValue;
                            _term4 = newValue;
                            _term5 = newValue;
                            _term6 = newValue;
                            _term7 = newValue;
                            _term8 = newValue;
                            _term9 = newValue;
                            _term10 = newValue;
                            _term11 = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      //SizedBox
                      const SizedBox(height: 20,),
                      //Back and Forward Button
                      // BackForwardButton(onForwardPress),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back Button
                          GestureDetector(
                            onTap: (){
                              Get.to(()=>const IdentityScreen());
                            },
                            child: Container(
                              height: 56,
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: BoxDecoration(
                                color: Color(KColors.kColorWhite),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Color(KColors.kColorPrimary),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 40.0,right: 40,top: 20,bottom: 20),
                                child: Center(child: Text(Strings.back,style: KFontStyle.kTextStyle14Blue,)),
                              ),
                            ),
                          ),
                          //Forward Button
                          GestureDetector(
                            onTap: onForwardPress,
                            child: const Icon(Icons.navigate_next_rounded,size: 52,),
                          ),
                        ],),
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
