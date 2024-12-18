import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:migo_cabs/screens/splash_screen.dart';
import 'package:migo_cabs/screens/vendor/provider/vendor_bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => VendorBottomNavigationProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          Colors.transparent, // Set the status bar color to transparent
      statusBarIconBrightness:
          Brightness.dark, // Adjust icon brightness for contrast
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
