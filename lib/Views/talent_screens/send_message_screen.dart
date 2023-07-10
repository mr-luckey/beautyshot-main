import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:beautyshot/controller/chat_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

//This screen for sending Messages in bulk
class SendMessageScreen extends StatefulWidget {
 final String clientId,projectName;

  const SendMessageScreen(
      {Key? key,
        required this.clientId,required this.projectName,
      })
      : super(key: key);

  @override
  State<SendMessageScreen> createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  final chatController = Get.put(ChatController());
  String message = "";
  String modelId = "";
  String chatId = "";

  // TextEditing COntrollers
  TextEditingController messageController = TextEditingController();

  validateInput(){
    if(messageController.text.isEmpty){

      Fluttertoast.showToast(
          msg: "Please type message",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else{

      modelId = FirebaseAuth.instance.currentUser!.uid.toString();
      // chatId = widget.projectName+clientId+DateTime.now().millisecondsSinceEpoch.toString();
      message = "m"+messageController.text.toString();

        chatController.addTalentChat(widget.clientId, message, FieldValue.serverTimestamp(), modelId);

        Get.back();

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
                      Text(
                        widget.projectName,
                        style: KFontStyle.kTextStyle18Black,
                      ),
                      const SizedBox(
                        width: 5,
                      )
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

                  const SizedBox(height: 20,),

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
