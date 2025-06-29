import 'package:get/get.dart';
import 'package:pockettask/controller/database/task_controller.dart';
import 'package:pockettask/view/utils/theme/theme_controller.dart';






class MyBindings implements Bindings {
  @override
  void dependencies() {

    // TODO: implement dependencies
    //Get.put(() => ConnectionService(), permanent: true); //GetxService
    Get.put(() => TaskController(),);
    Get.put(() => ThemeController(), permanent: true);
  }
  
}