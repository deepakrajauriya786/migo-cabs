import 'package:flutter/material.dart';
import 'package:migo_cabs/screens/vendor/provider/vendor_bottom_navigation_provider.dart';
import 'package:migo_cabs/screens/vendor/vendor_wallet_screen.dart';
import 'package:migo_cabs/screens/vendor/vendor_home_screen.dart';
import 'package:migo_cabs/screens/vendor/vendor_mybooking_screen.dart';
import 'package:migo_cabs/screens/vendor/vendor_profile_screen.dart';
import 'package:migo_cabs/screens/vendor/widgets/bottom_navigation_bar.dart';
import 'package:migo_cabs/screens/vendor/widgets/vendor_navigation_drawer.dart';
import 'package:provider/provider.dart';

class BottomNavigatorVendor extends StatelessWidget {
  const BottomNavigatorVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Consumer<VendorBottomNavigationProvider>(
            builder: (context, bottomnavigationprovider, child) {
          if (bottomnavigationprovider.getcurrentstate() == 0) {
            return VendorHomeScreen();
          } else if (bottomnavigationprovider.getcurrentstate() == 1) {
            return VendorMybookingScreen();
          } else if (bottomnavigationprovider.getcurrentstate() == 2) {
            return VendorWalletScreen();
          } else {
            return VendorProfileScreen();
          }
        }),
        Positioned(bottom: 0, left: 0, child: BottomNavigationBars())
      ]),
      drawer: VendorNavigationDrawer(),
    );
  }
}
