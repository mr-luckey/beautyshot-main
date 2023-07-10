import 'package:badges/badges.dart';
import 'package:beautyshot/Views/talent_screens/availability_screen.dart';
import 'package:beautyshot/Views/talent_screens/chat_screen.dart';
import 'package:beautyshot/Views/talent_screens/job_proposals_screen.dart';
import 'package:beautyshot/Views/talent_screens/pending_offers_screen.dart';
import 'package:beautyshot/Views/talent_screens/settings_screen.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TalentHome extends StatefulWidget {
  const TalentHome({Key? key}) : super(key: key);

  @override
  State<TalentHome> createState() => _TalentHomeState();
}

class _TalentHomeState extends State<TalentHome> {
  int selectedIndex = 0;

  final widgetOptions = [const JobProposalsScreen(), const AvailabilityScreen(),const ChatScreen(), const PendingOffersScreen(), const SettingsScreen(), ];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  Future<bool> _willPopCallback() async {

    if(selectedIndex == 0){
      debugPrint("home");
      // exit(0);
      SystemNavigator.pop();
      return true;
    }
    else if(selectedIndex == 1){
      setState(() {
        selectedIndex = 0;
      });
      debugPrint("favorite");
    }else if(selectedIndex == 2){
      setState(() {
        selectedIndex = 0;
      });
      debugPrint("WishList");
    }else if(selectedIndex == 3){
      debugPrint("Settings");
      setState(() {
        selectedIndex = 0;
      });
    }else if(selectedIndex == 4){
      debugPrint("Settings");
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
        bottomNavigationBar: BottomNavigationBar(
          items:  <BottomNavigationBarItem>[
            //Home
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
                  child: ImageIcon(const AssetImage("assets/images/home_inactive.png"),size: 24,color: Color(KColors.kColorDarkGrey),),
                )),
                icon: ImageIcon(const AssetImage("assets/images/home_inactive.png",),size: 32,color: Color(KColors.kColorLightGrey),),
                label: ''),
            //Calender
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
                  child: ImageIcon(const AssetImage("assets/images/calendar_inactive.png"),size: 32,color: Color(KColors.kColorDarkGrey),),
                )),
                icon: ImageIcon(const AssetImage("assets/images/calendar_inactive.png",),size: 32,color: Color(KColors.kColorLightGrey),),
                label: ''),
            //Chat
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
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ImageIcon(const AssetImage("assets/images/chat_inactive.png"),size: 32,color: Color(KColors.kColorDarkGrey),),
                    //   Badge(
                    //     // badgeContent: Text('3'),
                    //     // child: Icon(Icons.settings),
                    //     badgeColor: Colors.blue,
                    //   ),
                    ],
                  ),
                )),
                icon: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ImageIcon(const AssetImage("assets/images/chat_inactive.png",),size: 32,color: Color(KColors.kColorLightGrey),),
                    // Badge(
                    //   // badgeContent: Text('3'),
                    //   // child: Icon(Icons.settings),
                    //   badgeColor: Colors.blue,
                    // ),
                  ],
                ),
                label: ''),
            //Pending Contracts
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
                  child: ImageIcon(const AssetImage("assets/images/pending_inactive.png"),size: 32,color: Color(KColors.kColorDarkGrey),),
                )),
                icon: ImageIcon(const AssetImage("assets/images/pending_inactive.png",),size: 32,color: Color(KColors.kColorLightGrey),),
                label: ''),
            //Setting
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
                  child: ImageIcon(const AssetImage("assets/images/settings_inactive.png"),size: 32,color: Color(KColors.kColorDarkGrey),),
                )),
                icon: ImageIcon(const AssetImage("assets/images/settings_inactive.png",),size: 32,color: Color(KColors.kColorLightGrey),),
                label: ''),
          ],

          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          fixedColor: Color(KColors.kColorPrimary),
          unselectedItemColor: Colors.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          // selectedLabelStyle: KFontStyle.kTextStyleSmall,
          // unselectedLabelStyle: FontStyles.kTextStyleSmall,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}
