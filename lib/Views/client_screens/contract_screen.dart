import 'dart:io';
import 'package:beautyshot/components/buttons.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:beautyshot/components/loading_widget.dart';
import 'package:beautyshot/controller/project_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:signature/signature.dart';
import 'package:path/path.dart' as path;


class ContractScreen extends StatefulWidget {
  String projectId, projectName;
  List<String> modelIds;

  ContractScreen(
      {Key? key,
      required this.projectId,
      required this.projectName,
      required this.modelIds})
      : super(key: key);

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
  final projectController = Get.put(ProjectController());
  //Signature Controller
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );

  String contractId = "";
  String clientId = "";
  String projectId = "";
  String projectName = "";
  String jobTitle = "";
  String amount = "";
  String notes = "";
  String pdfLink = "";
  List<String> modelIds = [];
  @override

  //Terms check value
  bool? _term = false;
   File? file;
  // TextEditing COntrollers
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  validateInputs(){
    if(file == null )
      {

        Fluttertoast.showToast(
            msg: "Please attach PDF contract file",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    else{
      if(jobTitleController.text.isEmpty || amountController.text.isEmpty || notesController.text.isEmpty){

        Fluttertoast.showToast(
            msg: "One or more field is empty",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      else{
        if(_controller.isEmpty){

          Fluttertoast.showToast(
              msg: "Please add signatures",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else{
          if(_term == false){

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
            uploadPDFToFirebase();
          }
        }
      }
    }
  }

  attachPDF()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });

      print(file);
    } else {
      // User canceled the picker
    }
  }

  Future uploadPDFToFirebase() async {

    Get.defaultDialog(title: "Uploading PDF",content:const LoadingWidget() ,titleStyle: KFontStyle.kTextStyle14Black );
    String fileName = path.basename(file!.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('Contracts/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(file!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    taskSnapshot.ref.getDownloadURL().then(
          (value) async{
            setState(() {
              pdfLink = value;
            });
            clientId = FirebaseAuth.instance.currentUser!.uid.toString();
            contractId = widget.projectId+DateTime.now().millisecondsSinceEpoch.toString();
            projectId = widget.projectId;
            projectName = widget.projectName;
            jobTitle = jobTitleController.text.toString();
            amount = amountController.text.toString();
            notes = notesController.text.toString();
            modelIds = widget.modelIds;

       projectController.addContract(contractId: contractId, projectId: projectId, jobTitle: jobTitle, amount: amount, notes: notes, clientPdf: pdfLink, modelIds: modelIds, projectName: projectName, clientId: clientId,status: 'pending',modelPdf: '');
        Get.back();

            Fluttertoast.showToast(
                msg: "Contract file uploaded successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );

      },
    );
  }
  @override
  void initState() {
super.initState();
    _controller.addListener(() {
      debugPrint('Value changed');
    });
    super.initState();
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
                      Icon(
                        Icons.arrow_back_ios,
                        color: Color(KColors.kColorPrimary),
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
                  //Job Title Field
                  Container(
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
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child:  Text("Job Title :",style: KFontStyle.kTextStyle16BlackRegular),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: TextField(
                              textCapitalization: TextCapitalization.words,
                              style:
                              KFontStyle.kTextStyle16BlackRegular,
                              autofocus: false,
                              controller: jobTitleController,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                // hintText: "First Name",
                                // hintStyle: FontStyles.kTextStyleSmallRed,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //amount field
                  Container(
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
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.words,
                              style:
                              KFontStyle.kTextStyle16BlackRegular,
                              autofocus: false,
                              controller: amountController,
                              maxLines: 1,
                              decoration:  InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter amount here",
                                hintStyle: KFontStyle.kTextStyle16BlackRegular,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Notes field
                  Container(
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
                              controller: notesController,
                              maxLines: 4,
                              decoration:  InputDecoration(
                                border: InputBorder.none,
                                hintText: "Notes:",
                                hintStyle: KFontStyle.kTextStyle16BlackRegular,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Attach PDF Button
                  GestureDetector(
                  onTap: attachPDF,
                    child: Container(
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
                         Padding(
                           padding: const EdgeInsets.all(20.0),

                           child: file == null?Text("Attach Contract (PDF)",style: KFontStyle.kTextStyle16BlackRegular,):Text("Contract Attached",style: KFontStyle.kTextStyle16BlackRegular,),
                         )
                        ],
                      ),
                    ),
                  ),

                  //Signature Canvas
                  Container(
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
                    child:  Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Signature(
                            controller: _controller,
                            height: 200,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 20,
                          child: Text("Sign here",style: KFontStyle.kTextStyle16BlackRegular,),),
                      ],
                    ),
                  ),

                  //Terms and Conditions
                  CheckboxListTile(
                    title: const Text("I agree to all Terms & Conditions"),
                    value: _term,
                    onChanged: (newValue) {
                      setState(() {
                        _term = newValue;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                  ),

                  //Send Offer Button
                  Buttons.blueRectangularButton(Strings.sendOffer, validateInputs),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
