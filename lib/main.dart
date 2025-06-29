import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pockettask/controller/database/hive_storage.dart';
import 'package:pockettask/view/features/screen/task_screen.dart';
import 'package:pockettask/view/splash/splashscreen.dart';
import 'package:pockettask/view/utils/theme/app_color.dart';
import 'package:pockettask/view/utils/theme/theme_controller.dart';
import 'controller/binding/my_bindings.dart';







void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SecureCache.init();
  runApp(MainApp());
}



 
class MainApp extends StatelessWidget {
  MainApp({super.key});

  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, child) {
        return child!;
      },
      child: Obx(
        () {
          return GetMaterialApp(
            //navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Pocket Task',
            initialBinding: MyBindings(),
            defaultTransition: Transition.downToUp,
            theme: _themeController.isDarkMode.value
              ?ThemeData.dark().copyWith(
                scaffoldBackgroundColor: AppColor.primaryBlack,
                cardColor: AppColor.primaryGreen,
                textTheme: TextTheme(bodyMedium: TextStyle(color: AppColor.primaryWhite), bodySmall: TextStyle(color: AppColor.primaryWhite)),
                iconTheme: IconThemeData(color: AppColor.primaryWhite)
              )
              :ThemeData.light().copyWith(
                scaffoldBackgroundColor: AppColor.primaryWhite,
                cardColor: AppColor.inactiveGrey.withOpacity(0.3),
                textTheme: TextTheme(bodyMedium: TextStyle(color: AppColor.primaryBlack), bodySmall: TextStyle(color: AppColor.textGrey)),
                iconTheme: IconThemeData(color: AppColor.primaryGreen)
              ),
          
            //perform your logic here
            home: SplashScreen(nextScreen: TaskScreen())
          );
        }
      ),
    );
  }
}
