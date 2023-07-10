import 'package:beautyshot/components/talent_chat_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String modelId = FirebaseAuth.instance.currentUser!.uid.toString();
  // bool _enabled = true;
  bool isDidChangeRunningOnce = true;
  var clientId = [];
  var projectName = [];
  var clientData = [];
  var projectData = [];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isDidChangeRunningOnce) {
      // print('did change dependencies');
      getAllChats();
      isDidChangeRunningOnce = false;
    }
  }

  Future getAllChats() async {
    clientData.clear();
    FirebaseFirestore.instance
        .collection('chats')
        .where('modelIds', isEqualTo: modelId).snapshots().listen((event) {
      clientData.clear();
      event.docs.forEach((element) {
        clientData.add(element.data()['clientId']);
      });
      setState(() {
        clientId = clientData.toSet().toList();
        // print(clientId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(Strings.chat,style: KFontStyle.newYorkSemiBold22,),
        ),
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Color(KColors.kColorWhite),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: (clientId.isNotEmpty)
            ? ListView.builder(
          keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: clientId.length,
          itemBuilder: (BuildContext context, int index) {
            return TalentChatItem(
              clientId: clientId.elementAt(index),
            );
          },
        )
            : Center(child: Text("No Chat",style: KFontStyle.kTextStyle24Black)),

        // child: StreamBuilder(
        //     stream: FirebaseFirestore.instance
        //         .collection('chats')
        //         .where('modelIds', isEqualTo : modelId)
        //         .snapshots(),
        //     builder: (context,
        //         AsyncSnapshot<QuerySnapshot>
        //         streamSnapshot) {
        //       if (streamSnapshot.hasData) {
        //         if(streamSnapshot
        //             .data!.docs.isEmpty){
        //           return Center(child: Text("No Chat",style: KFontStyle.kTextStyle24Black));
        //         }
        //         else {
        //           return ListView.builder(
        //             keyboardDismissBehavior:
        //             ScrollViewKeyboardDismissBehavior
        //                 .onDrag,
        //             itemCount: streamSnapshot
        //                 .data?.docs.length,
        //             itemBuilder: (BuildContext context,
        //                 int index) {
        //               return TalentChatItem(
        //                 clientId: streamSnapshot.data?.docs[index]['clientId'],
        //               );
        //             },
        //           );
        //         }
        //       }
        //       else {
        //         return Column(
        //           children: [
        //             Expanded(
        //               child: Shimmer.fromColors(
        //                 baseColor: Colors.grey[300]!,
        //                 highlightColor: Colors.grey[100]!,
        //                 enabled: _enabled,
        //                 child: ListView.builder(
        //                   itemBuilder: (_, __) => Padding(
        //                     padding: const EdgeInsets.only(bottom: 8.0),
        //                     child: Row(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: <Widget>[
        //                         Container(
        //                           width: 48.0,
        //                           height: 48.0,
        //                           color: Colors.white,
        //                         ),
        //                         const Padding(
        //                           padding: EdgeInsets.symmetric(horizontal: 8.0),
        //                         ),
        //                         Expanded(
        //                           child: Column(
        //                             crossAxisAlignment: CrossAxisAlignment.start,
        //                             children: <Widget>[
        //                               Container(
        //                                 width: double.infinity,
        //                                 height: 8.0,
        //                                 color: Colors.white,
        //                               ),
        //                               const Padding(
        //                                 padding: EdgeInsets.symmetric(vertical: 2.0),
        //                               ),
        //                               Container(
        //                                 width: double.infinity,
        //                                 height: 8.0,
        //                                 color: Colors.white,
        //                               ),
        //                               const Padding(
        //                                 padding: EdgeInsets.symmetric(vertical: 2.0),
        //                               ),
        //                               Container(
        //                                 width: 40.0,
        //                                 height: 8.0,
        //                                 color: Colors.white,
        //                               ),
        //                             ],
        //                           ),
        //                         )
        //                       ],
        //                     ),
        //                   ),
        //                   itemCount: 6,
        //                 ),
        //               ),
        //             ),
        //           ],
        //         );
        //       }
        //     }),

      ),
    );
  }
}


