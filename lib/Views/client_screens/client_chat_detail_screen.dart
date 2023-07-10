import 'package:beautyshot/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClientChatDetailScreen extends StatefulWidget {
  final String modelId;

  const ClientChatDetailScreen({Key? key, required this.modelId,}) : super(key: key);

  @override
  State<ClientChatDetailScreen> createState() => _ClientChatDetailScreenState();
}

class _ClientChatDetailScreenState extends State<ClientChatDetailScreen> {
  TextEditingController messageController = TextEditingController();
  late String messageText;

  String clientId = FirebaseAuth.instance.currentUser!.uid.toString();

  String modelIds= '';
  List<String> modelIdList = [];
  @override
  void initState() {
    modelIds = widget.modelId;
    super.initState();
  }

  Future getAllChats() async {
    modelIdList.clear();
    await FirebaseFirestore.instance
        .collection('chats')
        .where('clientId', isEqualTo: clientId).where('modelIds' ,isEqualTo: widget.modelId).orderBy('time')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        modelIdList.add(element.data()['modelIds']);
        setState(() {
          modelIds = modelIdList.elementAt(0);
        });
      });
    });
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
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('chats')
                        .where('clientId', isEqualTo: clientId).where('modelIds' ,isEqualTo: modelIds).orderBy('time')
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        if (streamSnapshot.data!.docs.isEmpty) {
                          return Text("No Chat Found",
                              style: KFontStyle.kTextStyle24Black);
                        }
                        else {
                          final massages = streamSnapshot.data?.docs;
                          List<MassageContainer> massagesWidgets = [];
                          for (var massage in massages!) {
                            final massageText = massage['message'];
                            final massageSender = massage['modelIds'].toString();
                            final currentUser = clientId;
                            if (clientId == massageSender) {}
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
                          'message': "c"+messageText,
                          'clientId': clientId,
                          'time': FieldValue.serverTimestamp(),
                          'modelIds': widget.modelId,
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
  void didChangeDependencies() {
     setState(() {
       check = widget.txet[0];
       message = widget.txet.substring(1);
     });
     super.didChangeDependencies();
  }

  @override
  void initState() {
   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        check != 'c' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: check != 'c'
                ? const BorderRadius.all(
              Radius.circular(14)
            )
                : const BorderRadius.all(
              Radius.circular(14)
            ),
            elevation: 5.0,
            color:  Colors.white,
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




InputDecoration kMessageTextFieldDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  hintStyle: KFontStyle.kTextStyle16BlackRegular,
  border: InputBorder.none,
);

 BoxDecoration kMessageContainerDecoration = const BoxDecoration(
  border: Border(
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
    borderRadius: BorderRadius.all(Radius.circular(14.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(KColors.kColorPrimary), width: 1.0),
    borderRadius: const BorderRadius.all(Radius.circular(14.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(KColors.kColorPrimary), width: 2.0),
    borderRadius: const BorderRadius.all(Radius.circular(14.0)),
  ),
);
