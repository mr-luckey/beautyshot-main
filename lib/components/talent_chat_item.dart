import 'package:beautyshot/Views/talent_screens/talent_chat_detail_screen.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TalentChatItem extends StatefulWidget {
  final String clientId;


  TalentChatItem({Key? key, required this.clientId}) : super(key: key);

  @override
  State<TalentChatItem> createState() => _TalentChatItemState();
}

class _TalentChatItemState extends State<TalentChatItem> {


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: Column(
        children: [
          //Clients
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('clients')
                    .where('clientId', isEqualTo: widget.clientId)
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    if (streamSnapshot.data!.docs.isEmpty) {
                      return Text("No Chat Found",
                          style: KFontStyle.kTextStyle24Black);
                    } else {
                      return Container(
                        margin: const EdgeInsets.all(5),
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                          itemCount: streamSnapshot.data?.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Get.to(()=>TalentChatDetailScreen(clientId: widget.clientId ));
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        streamSnapshot.data?.docs[index]
                                        ['companyName'],
                                        style: KFontStyle.kTextStyle24Black,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }
                  } else if (!streamSnapshot.hasData ||
                      streamSnapshot.data!.docs.isEmpty) {
                    return Center(child: const CircularProgressIndicator());
                    // return  Text("No Model",style: KFontStyle.kTextStyle24Black);
                  } else {
                    return Center(child: const CircularProgressIndicator());
                  }
                }),
        ],
      ),
    );
  }
}