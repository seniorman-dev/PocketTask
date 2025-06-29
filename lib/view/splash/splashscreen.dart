import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pockettask/view/splash/splashscreen_2.dart';
import 'package:pockettask/view/utils/theme/app_color.dart';






class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key, required this.nextScreen});
  final Widget nextScreen;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Icon(
          color: AppColor.primaryGreen,
          CupertinoIcons.doc_text,
          size: 70.r,
        )
      ), 
      nextScreen: SplashScreen2(nextScreen: nextScreen),
      duration: 1000, //4000
      backgroundColor: AppColor.primaryBlue,
      centered: true,
      //splashIconSize: 500,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(milliseconds: 1000),  //2
    );
  }
}


