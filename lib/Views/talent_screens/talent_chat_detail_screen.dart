import 'package:beautyshot/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TalentChatDetailScreen extends StatefulWidget {
  final String clientId;

  const TalentChatDetailScreen({Key? key, required this.clientId,}) : super(key: key);

  @override
  State<TalentChatDetailScreen> createState() => _TalentChatDetailScreenState();
}

class _TalentChatDetailScreenState extends State<TalentChatDetailScreen> {
  TextEditingController messageController = TextEditingController();
  late String messageText;

  String modelId = FirebaseAuth.instance.currentUser!.uid.toString();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(Strings.chat,style: KFontStyle.newYorkSemiBold22,),
        ),
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Color(KColors.kColorWhite),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Models
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('chats')
                      .where('clientId', isEqualTo: widget.clientId).where('modelIds' ,isEqualTo: modelId).orderBy('time')
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      if (streamSnapshot.data!.docs.isEmpty) {
                        return Text("No Chat Found",
                            style: KFontStyle.kTextStyle24Black);
                      } else {
                        final massages = streamSnapshot.data?.docs;
                        List<MassageContainer> massagesWidgets = [];
                        for (var massage in massages!) {
                          final massageText = massage['message'];
                          final massageSender = massage['modelIds'];
                          final currentUser = modelId;
                          if (currentUser == massageSender) {}
                          final massageWidget = MassageContainer(
                            txet: massageText,
                            sender: massageSender,
                            isMe: currentUser == massageSender,
                          );
                          massagesWidgets.add(massageWidget);
                        }
                        return Expanded(
                          child: ListView(
                            reverse: false,
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10.0),
                            children: massagesWidgets,
                          ),
                        );

                        // return Container(
                        //   margin: const EdgeInsets.all(5),
                        //   height: 50,
                        //   width: MediaQuery.of(context).size.width,
                        //   child: ListView.builder(
                        //     keyboardDismissBehavior:
                        //     ScrollViewKeyboardDismissBehavior.onDrag,
                        //     itemCount: streamSnapshot.data?.docs.length,
                        //     itemBuilder: (BuildContext context, int index) {
                        //       return Column(
                        //         children: [
                        //           Row(
                        //             children: [
                        //
                        //               Text(
                        //                 streamSnapshot.data?.docs[index]
                        //                 ['message'] ,
                        //                 style: KFontStyle.kTextStyle16Black,
                        //               ),
                        //               const SizedBox(
                        //                 width: 10,
                        //               ),
                        //               Text(
                        //                 streamSnapshot.data?.docs[index]
                        //                 ['time'] ,
                        //               ),
                        //
                        //             ],
                        //           ),
                        //
                        //         ],
                        //       );
                        //     },
                        //   ),
                        // );

                      }
                    } else if (!streamSnapshot.hasData ||
                        streamSnapshot.data!.docs.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                      // return  Text("No Model",style: KFontStyle.kTextStyle24Black);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        style: KFontStyle.kTextStyle16BlackRegular,
                        textCapitalization: TextCapitalization.sentences,
                        controller: messageController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    //Send Button
                    TextButton(
                      onPressed: () {
                        messageController.clear();
                        FirebaseFirestore.instance.collection('chats').add({
                          'message': "m"+ messageText,
                          'clientId': widget.clientId,
                          'time': FieldValue.serverTimestamp(),
                          'modelIds': modelId,
                        });
                      },
                      child:  Text(
                        'Send',
                        style: KFontStyle.kTextStyle18Blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class MassageContainer extends StatefulWidget {
  const MassageContainer({
    Key? key,
    required this.txet,
    required this.sender,
    required this.isMe,
  }) : super(key: key);

  final String txet;
  final String sender;
  final bool isMe;

  @override
  State<MassageContainer> createState() => _MassageContainerState();
}

class _MassageContainerState extends State<MassageContainer> {
  String message = '';
  String check = '';

  @override
  void initState() {
    super.initState();
    check = widget.txet[0];
    message = widget.txet.substring(1);
    debugPrint(check);
    debugPrint(message);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        check != 'm' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: check != 'm'
                ? const BorderRadius.all(
                Radius.circular(14)
            )
                : const BorderRadius.all(
                Radius.circular(14)
            ),
            elevation: 5.0,
            color: Colors.white,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                message,
                style:  KFontStyle.kTextStyle16BlackRegular
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// InputDecoration kMessageTextFieldDecoration = InputDecoration(
//   contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//   hintText: 'Type your message here...',
//   hintStyle: KFontStyle.kTextStyle16Black,
//   border: InputBorder.none,
// );
//
// BoxDecoration kMessageContainerDecoration = BoxDecoration(
//   border: Border(
//     top: BorderSide(color: Colors.black, width: 2.0),
//   ),
// );
//
// const kMainText = TextStyle(
//   fontFamily: 'NewYork',
//   color: Colors.black,
//   fontSize: 70.0,
// );
//
// InputDecoration kTextFieldDecoration = InputDecoration(
//   hintText: ' ',
//   contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//   border: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
//   enabledBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: Color(KColors.kColorPrimary), width: 1.0),
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: Color(KColors.kColorPrimary), width: 2.0),
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
// );


InputDecoration kMessageTextFieldDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  hintStyle: KFontStyle.kTextStyle16BlackRegular,
  border: InputBorder.none,
);

BoxDecoration kMessageContainerDecoration = const BoxDecoration(
  border:  Border(
    top: BorderSide(color: Colors.black, width: 2.0),
  ),
);

const kMainText = TextStyle(
  fontFamily: 'NewYork',
  color: Colors.black,
  fontSize: 70.0,
);

InputDecoration kTextFieldDecoration = InputDecoration(
  hintText: ' ',
  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: const OutlineInputBorder(
    borderRadius: BorderRadius.all( Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(KColors.kColorPrimary), width: 1.0),
    borderRadius:  const BorderRadius.all( Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(KColors.kColorPrimary), width: 2.0),
    borderRadius: const BorderRadius.all( Radius.circular(32.0)),
  ),
);
