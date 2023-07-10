import 'package:beautyshot/Views/client_screens/client_chat_detail_screen.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ClientChatItem extends StatefulWidget {
  final String modelIds;


  ClientChatItem({Key? key, required this.modelIds,}) : super(key: key);

  @override
  State<ClientChatItem> createState() => _ClientChatItemState();
}

class _ClientChatItemState extends State<ClientChatItem> {
  bool _enabled = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 70,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('models')
                .where('userId', isEqualTo: widget.modelIds)
                .snapshots(),
            builder:
                (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {

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
                            GestureDetector(
                              onTap: (){
                                Get.to(()=>ClientChatDetailScreen(modelId: widget.modelIds,));
                              },
                              child: Row(
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
                            ),

                          ],
                        );
                      },
                    ),
                  );

              }
              else if (!streamSnapshot.hasData ||
                  streamSnapshot.data!.docs.isEmpty) {
                return Column(
                  children: [
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        enabled: _enabled,
                        child: ListView.builder(
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 48.0,
                                  height: 48.0,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: 40.0,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemCount: 6,
                        ),
                      ),
                    ),
                  ],
                );
                // return  Text("No Model",style: KFontStyle.kTextStyle24Black);
              }
              else {
                return Column(
                  children: [
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[100]!,
                        highlightColor: Colors.grey[200]!,
                        enabled: _enabled,
                        child: ListView.builder(
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 48.0,
                                  height: 48.0,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: 40.0,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemCount: 6,
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
      );
  }
}