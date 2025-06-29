import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pockettask/controller/database/hive_storage.dart';









class ThemeController extends GetxController {

  // Current theme mode (default: light)
  var isDarkMode = false.obs;

  // Hive box reference
  //final _themeBox = Hive.box('themeBox');

  @override
  void onInit() {
    super.onInit();
    _loadTheme(); // Load saved theme on startup
  }

  // Load theme from Hive
  void _loadTheme() {
    isDarkMode.value = SecureCache.themeBox.get('isDarkMode', defaultValue: false);
    //_themeBox.get('isDarkMode', defaultValue: false);
  }

  // Toggle theme and save to Hive
  void toggleTheme() {
    isDarkMode.toggle();
    //_themeBox.put('isDarkMode', isDarkMode.value);
    SecureCache.themeBox.put('isDarkMode', isDarkMode.value);
  }
}