import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'Provider/settings_provider.dart';
import 'Provider/notifications_provider.dart';
import 'View/Login/login_View.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize shared preferences
  final prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 713),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SettingsProvider()),
            ChangeNotifierProvider(create: (_) => NotificationProvider()),
          ],
          child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'MobiCratch',
              theme: ThemeData(
                // Override the button theme colors
                primarySwatch: Colors.blue,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              home: LoginView()),
        );
      },
    );
  }
}
