

import 'package:farmpicks/views/screens/auth/loginscreen.dart';
import 'package:farmpicks/views/screens/auth/welcome_screens/welcome_register_screen.dart';
import 'package:farmpicks/views/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';






void main() async {
  WidgetsFlutterBinding.ensureInitialized();

 // await Firebase.initializeApp();
 // FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.getInstance();
  //firebaseAppCheck.installAppCheckProviderFactory( SafetyNetAppCheckProviderFactory.getInstance());
  //FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.getInstance(); firebaseAppCheck.installAppCheckProviderFactory( SafetyNetAppCheckProviderFactory.getInstance());
  runApp(
      ProviderScope(child: const MyApp())
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    Widget? firstWidget;
    if(firebaseUser!=null)
    {
      firstWidget=MainScreen();
    }
    else
    {
      firstWidget=WelcomeRegisterScreen();
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
        useMaterial3: true,
      ),
      home: firstWidget,
      builder: EasyLoading.init(),
    );
  }
}

