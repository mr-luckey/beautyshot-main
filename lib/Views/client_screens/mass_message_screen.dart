import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:beautyshot/controller/chat_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

//This screen for sending Messages in bulk
class MassMessageScreen extends StatefulWidget {
  String projectId, projectName;
  double projectPrice;
  List<String> modelIds;

  MassMessageScreen(
      {Key? key,
        required this.projectId,
        required this.projectName,
        required this.modelIds,
        required this.projectPrice,
      })
      : super(key: key);

  @override
  State<MassMessageScreen> createState() => _MassMessageScreenState();
}

class _MassMessageScreenState extends State<MassMessageScreen> {
  final chatController = Get.put(ChatController());
  String message = "";
  String clientId = "";
  String chatId = "";
  String contract = "N/A";
  List<String> modelIds = [];
  // TextEditing COntrollers
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
      modelIds = widget.modelIds;
      for(var id in modelIds) {
        chatController.addChat(clientId, message, FieldValue.serverTimestamp(), id,widget.projectName,widget.projectPrice,contract);
      }
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
                  //Models
                  for (var ids in widget.modelIds)
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('models')
                            .where('userId', isEqualTo: ids)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            if (streamSnapshot.data!.docs.isEmpty) {
                              return Text("No Model Found",
                                  style: KFontStyle.kTextStyle24Black);
                            } else {
                              return Container(
                                margin: const EdgeInsets.all(5),
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                                  itemCount: streamSnapshot.data?.docs.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(0.0, 3.0),
                                                    //(x,y)
                                                    blurRadius: 5.0,
                                                  ),
                                                ],
                                                borderRadius:
                                                BorderRadius.circular(50),
                                                // border: Border.all(
                                                //   color: Colors.grey,
                                                // ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(50),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  width: 60,
                                                  height: 60,
                                                  imageUrl: streamSnapshot
                                                      .data?.docs[index]
                                                  ['profilePicture'],
                                                ),
                                              ),
                                              // child: Image.asset(streamSnapshot.data?.docs[index]['profilePicture'],height: 52,width: 52,)
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              streamSnapshot.data?.docs[index]
                                              ['firstName'] +
                                                  " " +
                                                  streamSnapshot.data?.docs[index]
                                                  ['lastName'],
                                              style: KFontStyle.kTextStyle16BlackRegular,
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            }
                          } else if (!streamSnapshot.hasData ||
                              streamSnapshot.data!.docs.isEmpty) {
                            return const CircularProgressIndicator();
                            // return  Text("No Model",style: KFontStyle.kTextStyle24Black);
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),


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
