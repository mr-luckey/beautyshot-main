import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:beautyshot/controller/chat_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

//This screen for sending Message to Individual
class IndividualMessageScreen extends StatefulWidget {

  String modelId;


  IndividualMessageScreen(
      {Key? key,
        required this.modelId,
        
      })
      : super(key: key);

  @override
  State<IndividualMessageScreen> createState() => _IndividualMessageScreenState();
}

class _IndividualMessageScreenState extends State<IndividualMessageScreen> {
  final chatController = Get.put(ChatController());
  String message = "";
  String clientId = "";
  String chatId = "";
  String projectName = "Uncategorized";
  double price = 0.0;
  String contract = "N/A";
  // TextEditing Controllers
  TextEditingController messageController = TextEditingController();

  validateInput(){
    if(messageController.text.isEmpty){

      Fluttertoast.showToast(
          msg: "Please type message",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else{
      clientId = FirebaseAuth.instance.currentUser!.uid.toString();
      // chatId = widget.projectName+clientId+DateTime.now().millisecondsSinceEpoch.toString();
      message = "c"+messageController.text.toString();
        chatController.addChat(clientId, message, FieldValue.serverTimestamp(), widget.modelId,projectName,price,contract);
      }

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //TOPBAR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Color(KColors.kColorPrimary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //Message field
                  Container(
                    height: MediaQuery.of(context).size.height/2,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 3.0), //(x,y)
                          blurRadius: 5.0,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB( 20,8,20,8),
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              style:
                              KFontStyle.kTextStyle16BlackRegular,
                              autofocus: false,
                              controller: messageController,
                              maxLines: 20,
                              decoration:  InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type Message:",
                                hintStyle: KFontStyle.kTextStyle16BlackRegular,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  //Send Message Button
                  Buttons.blueRectangularButton(Strings.send, validateInput),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
