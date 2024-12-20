import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/app_sizes.dart';
import 'auth/user_type_screen.dart';
import 'auth/welcome_screen.dart';
import 'customer/customer_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {




  void navigatescreen() {
    Get.off(() => MyWidget());
  }

  // Future<void> routes() async {
  //   print(await getbool(ISLOGIN));
  //   if (await getbool(ISLOGIN)) {
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //       builder: (context) => const HomeScreen(),
  //     ));
  //   } else {
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //       builder: (context) => const Onboarding1(),
  //     ));
  //   }
  // }

  void userCheck() async {
   String userId = await AppSizes.uid;
   print(userId);
    if(userId.isEmpty){
      navigatescreen();
    }else{
      Get.off(() => const UserTypeScreen());

    }


  }

  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(const Duration(seconds: 3), () {
      userCheck();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/migosplash.jpg",
          height: 300,
          width: 330,
          fit: BoxFit.fill,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
