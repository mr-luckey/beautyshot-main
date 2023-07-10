import 'package:beautyshot/Views/client_screens/client_login_screen.dart';
import 'package:beautyshot/Views/talent_screens/talent_login_screen.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ClientTalentScreen extends StatelessWidget {
  const ClientTalentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Get.to(()=>const ClientLoginScreen());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("CLIENT",style: KFontStyle.newYorkBold53,),
                      const SizedBox(width: 5.0,),
                      Image.asset(KImages.forward,height: 52,width: 52,),
                    ],
                  ),
                ),
              ),),
            Expanded(
              child: GestureDetector(
                onTap: (){

                  // Get.to(()=>const PortfolioScreen());
                  Get.to(()=>const TalentLoginScreen());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(KImages.backward,height: 52,width: 52,),
                      const SizedBox(width: 5.0,),
                      Text(Strings.talent.toUpperCase(),style: KFontStyle.newYorkBold53,),
                    ],
                  ),
                ),
              ),),
          ],
        ),
      ),
    );
  }
}
