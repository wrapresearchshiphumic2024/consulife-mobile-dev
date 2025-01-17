import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this package
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  // Disable rotation by locking the orientation to portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Portrait mode
    DeviceOrientation.portraitDown, // Portrait mode (upside down)
  ]);
  String initialRoute = await checkInitialRoute();

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      builder: FToastBuilder(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        scaffoldBackgroundColor: const Color(0xffF5F5F7),
      ),
    ),
  );
  FlutterNativeSplash.remove();
}

Future<String> checkInitialRoute() async {
  String? isFirstTime = GetStorage().read('isFirstTime');
  String? token = GetStorage().read('auth_token');
  String? role = GetStorage().read('role');
  if (isFirstTime != null) {
    if (token != null) {
      if (role == "patient") {
        return Routes.LANDING_PASIEN;
      } else if (role == "psychologist") {
        return Routes.LANDING_PSYCHOLOG;
      }
    }
    return Routes.SIGNIN;
  }
  return Routes.ONBOARDING;
}
