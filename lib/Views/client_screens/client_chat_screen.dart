import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/client_chat_item.dart';
import '../../components/constants.dart';

class ClientChatScreen extends StatefulWidget {
  const ClientChatScreen({Key? key}) : super(key: key);

  @override
  State<ClientChatScreen> createState() => _ClientChatScreenState();
}

class _ClientChatScreenState extends State<ClientChatScreen> {
  String clientId = FirebaseAuth.instance.currentUser!.uid.toString();
  String dropDownValue = 'Recent';
  var modelData = [];
  // final bool _enabled = true;
  var modId = [];
  // List of items in our dropdown menu
  var items = [
    'Recent',
    'Project',
  ];

  bool isDidChangeRunningOnce = true;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isDidChangeRunningOnce) {
      debugPrint('did change dependencies');
      getAllChats();
      isDidChangeRunningOnce = false;
    }
  }

  Future getAllChats() async {
    modelData.clear();
    FirebaseFirestore.instance
        .collection('chats')
        .where('clientId', isEqualTo: clientId).snapshots().listen((event) {
      modelData.clear();
      event.docs.forEach((element) {
        modelData.add(element.data()['modelIds']);
        // modelData.add(element.data()['projectName']);
      });
      setState(() {
        modId = modelData.toSet().toList();
        debugPrint(modId.toString());
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Messages",style: KFontStyle.kTextStyle24Black,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0,right: 25,top: 15,bottom: 15),
            child: Container(
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
                padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                child: DropdownButton(
                  underline: const SizedBox(),
                  // Initial Value
                  value: dropDownValue,
                  // Down Arrow Icon
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Icon(Icons.keyboard_arrow_down_rounded,color: Colors.black,),
                  ),
                  //Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items,style: KFontStyle.kTextStyle16BlackRegular,),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropDownValue = newValue!;
                    });
                  },
                ),
              ),
            ),
          )
        ],
        toolbarHeight: 80,
        centerTitle: false,
        backgroundColor: Color(KColors.kColorWhite),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: (modId.isNotEmpty)
            ? ListView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: modId.length,
                itemBuilder: (BuildContext context, int index) {
                  return ClientChatItem(
                    modelIds: modId.elementAt(index),
                  );
                },
              )
            : Center(child: Text("No Chat",style: KFontStyle.newYorkSemiBold22,))
        // Column(
        //   children: [
        //     Expanded(
        //       child: Shimmer.fromColors(
        //         baseColor: Colors.grey[300]!,
        //         highlightColor: Colors.grey[100]!,
        //         enabled: _enabled,
        //         child: ListView.builder(
        //           itemBuilder: (_, __) => Padding(
        //             padding: const EdgeInsets.only(bottom: 8.0),
        //             child: Row(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: <Widget>[
        //                 Container(
        //                   width: 48.0,
        //                   height: 48.0,
        //                   color: Colors.white,
        //                 ),
        //                 const Padding(
        //                   padding: EdgeInsets.symmetric(horizontal: 8.0),
        //                 ),
        //                 Expanded(
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: <Widget>[
        //                       Container(
        //                         width: double.infinity,
        //                         height: 8.0,
        //                         color: Colors.white,
        //                       ),
        //                       const Padding(
        //                         padding: EdgeInsets.symmetric(vertical: 2.0),
        //                       ),
        //                       Container(
        //                         width: double.infinity,
        //                         height: 8.0,
        //                         color: Colors.white,
        //                       ),
        //                       const Padding(
        //                         padding: EdgeInsets.symmetric(vertical: 2.0),
        //                       ),
        //                       Container(
        //                         width: 40.0,
        //                         height: 8.0,
        //                         color: Colors.white,
        //                       ),
        //                     ],
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ),
        //           itemCount: 6,
        //         ),
        //       ),
        //     ),
        //   ],
        // )
        ,

        // child: StreamBuilder(
        //    stream: FirebaseFirestore.instance
        //        .collection('chats')
        //        .where('clientId', isEqualTo : clientId)
        //        .snapshots(),
        //    builder: (context,
        //        AsyncSnapshot<QuerySnapshot>
        //        streamSnapshot) {
        //      if (streamSnapshot.hasData) {
        //        if(streamSnapshot
        //            .data!.docs.isEmpty){
        //          return Center(child: Text("No Chat",style: KFontStyle.kTextStyle24Black));
        //        }
        //        else {
        //          return ListView.builder(
        //            keyboardDismissBehavior:
        //            ScrollViewKeyboardDismissBehavior
        //                .onDrag,
        //            itemCount: streamSnapshot
        //                .data?.docs.length,
        //            itemBuilder: (BuildContext context,
        //                int index) {
        //              return ClientChatItem(
        //                modelIds: streamSnapshot.data?.docs[index]['modelIds'],
        //                 // message: streamSnapshot.data?.docs[index]['message'],
        //              );
        //            },
        //          );
        //        }
        //      }
        //      else {
        //        return const CircularProgressIndicator();
        //      }
        //    }),

      ),
    );
  }
}


