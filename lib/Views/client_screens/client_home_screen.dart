import 'package:beautyshot/Views/client_screens/client_chat_screen.dart';
import 'package:beautyshot/Views/client_screens/client_main_screen.dart';
import 'package:beautyshot/Views/client_screens/client_pending_offers_screen.dart';
import 'package:beautyshot/Views/client_screens/client_project_folder_screen.dart';
import 'package:beautyshot/Views/client_screens/client_settings_screen.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClientHome extends StatefulWidget {
  const ClientHome({Key? key}) : super(key: key);

  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  int selectedIndex = 0;
  final widgetOptions = [ const ClientMainScreen(),  const ClientProjectFolderScreen(), const ClientChatScreen(),  const ClientPendingOffersScreen(),  const ClientSettingsScreen(), ];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  Future<bool> _willPopCallback() async {

    if(selectedIndex == 0){
      // exit(0);
      SystemNavigator.pop();
      return true;
    }
    else if(selectedIndex == 1){
      setState(() {
        selectedIndex = 0;
      });
    }else if(selectedIndex == 2){
      setState(() {
        selectedIndex = 0;
      });
    }else if(selectedIndex == 3){
      setState(() {
        selectedIndex = 0;
      });
    }else if(selectedIndex == 4){
      setState(() {
        selectedIndex = 0;
      });
    }
    // await showDialog or Show add banners or whatever
    // then
    return false;
    // return true if the route to be popped
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: widgetOptions.elementAt(selectedIndex)),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          // decoration: const BoxDecoration(
          //   boxShadow: <BoxShadow>[
          //     BoxShadow(
          //       color: Colors.grey,
          //       blurRadius: 5,
          //     ),
          //   ],
          // ),
          child: BottomNavigationBar(
            items:  <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  activeIcon: Container(
                  height: 62,
                  width: 62,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 3.0), //(x,y)
                        blurRadius: 5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                    // border: Border.all(
                    //   color: Colors.grey,
                    // ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ImageIcon(AssetImage("assets/images/home_inactive.png"),size: 24,color: Color(KColors.kColorDarkGrey),),
                  )),
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: ImageIcon(AssetImage("assets/images/home_inactive.png",),size: 32,color: Color(KColors.kColorLightGrey),
                    ),
                  ), label: ''),
              BottomNavigationBarItem(activeIcon: Container(
                  height: 62,
                  width: 62,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 3.0), //(x,y)
                        blurRadius: 5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                    // border: Border.all(
                    //   color: Colors.grey,
                    // ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ImageIcon(AssetImage("assets/images/project.png"),size: 32,color: Color(KColors.kColorDarkGrey),),
                  )),
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: ImageIcon(AssetImage("assets/images/project.png",),size: 32,color: Color(KColors.kColorLightGrey),
                    ),
                  ), label: ''),
              BottomNavigationBarItem(activeIcon: Container(
                  height: 62,
                  width: 62,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 3.0), //(x,y)
                        blurRadius: 5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                    // border: Border.all(
                    //   color: Colors.grey,
                    // ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ImageIcon(AssetImage("assets/images/chat_inactive.png"),size: 32,color: Color(KColors.kColorDarkGrey),),
                  )),
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: ImageIcon(AssetImage("assets/images/chat_inactive.png",),size: 32,color: Color(KColors.kColorLightGrey),
                    ),
                  ), label: ''),
              BottomNavigationBarItem(activeIcon: Container(
                  height: 62,
                  width: 62,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 3.0), //(x,y)
                        blurRadius: 5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                    // border: Border.all(
                    //   color: Colors.grey,
                    // ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ImageIcon(AssetImage("assets/images/dollar.png"),size: 32,color: Color(KColors.kColorDarkGrey),),
                  )),
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: ImageIcon(AssetImage("assets/images/dollar.png",),size: 32,color: Color(KColors.kColorLightGrey),
                    ),
                  ), label: ''),
              BottomNavigationBarItem(activeIcon: Container(
                  height: 62,
                  width: 62,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 3.0), //(x,y)
                        blurRadius: 5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                    // border: Border.all(
                    //   color: Colors.grey,
                    // ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ImageIcon(AssetImage("assets/images/settings_inactive.png"),size: 32,color: Color(KColors.kColorDarkGrey),),
                  )),
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: ImageIcon(AssetImage("assets/images/settings_inactive.png",),size: 32,color: Color(KColors.kColorLightGrey),
                    ),
                  ), label: ''),
            ],

            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            fixedColor: Color(KColors.kColorPrimary),
            unselectedItemColor: Colors.black,
            // selectedLabelStyle: KFontStyle.kTextStyleSmall,
            // unselectedLabelStyle: FontStyles.kTextStyleSmall,
            onTap: onItemTapped,
          ),
        ),
      ),
    );
  }
}
