import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:migo_cabs/const/app_sizes.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../splash_screen.dart';
import '../customer_bottom_screens/customer_booking_screen.dart';
import '../customer_bottom_screens/customer_notification_history.dart';
import '../customer_home_screen.dart';
import '../customer_profile_update.dart';
import '../wallet_screan/help_us.dart';
import '../wallet_screan/wallet_screan.dart';

class MyNavigationDrawer extends StatelessWidget {
  const MyNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes().initSizes(context);
    return Drawer(
      backgroundColor: Colors.white,
      width: AppSizes.screenwidth * 0.7,
      child: Column(
        children: [
          customheader(context),
          // Menu Items
          Expanded(
            child: ListView(
              children: [
                _buildListTile(Icons.verified_user, 'Home', () {
                  Get.off(const CustomerHomeScreen());
                }),
                _buildListTile(Icons.payment, 'Wallet Details', () {
                  Get.to(() => const CustomerWalletHistory());
                }),
                _buildListTile(Icons.history, 'Booking History', () {
                  Get.to(() => const BookingPage());
                }),
                _buildListTile(Icons.settings, 'Settings', () {
                  Get.to(() => const CustomerProfileUpdate());
                }),
                _buildListTile(Icons.help, 'Help', () {
                  Get.to(() => const CustomerHelpUp());
                }),
                _buildListTile(Icons.notifications, 'Notification', () {
                  Get.to(const CustomerNotificationHistory());}),
                _buildListTile(Icons.share, 'Share App', () {
                  Share.share('Install my App: https://play.google.com/store/apps/details?id=');
                }),
                _buildListTile(Icons.star, 'Rate App', () async {
                  launchURI();
                }),
                const Divider(),
                _buildListTile(Icons.logout, 'Logout', () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  final success = await prefs.remove('u_id');
                  print(success);
                  if(success){
                    Get.off(() => const SplashScreen());
                  }

                }, isLogout: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void launchURI() async {
    final Uri url = Uri.parse('https://play.google.com/store/apps/details?id=com.example.myapp'); // Replace with your package name
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');}
  }
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap,
      {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.black),
      title: Text(
        title,
        style: TextStyle(color: isLogout ? Colors.red : Colors.black),
      ),
      onTap: onTap,
    );
  }

  Widget customheader(context) {
    return Container(
      height: 125,
      color: Colors.orange,
      child: Column(
        children: [
          SizedBox(
            height: 35,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Stack(
                children: [
                  // Display the image
                  Container(
                    width: 80,
                    height: 80,
                    color: Colors.orange,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset("assets/icons/profile.png"),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomerProfileUpdate(),
                            ));
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black87,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(3),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Raj Kumar",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  Text.rich(TextSpan(
                      text: "Cash: ",
                      style: TextStyle(color: Colors.white),
                      children: <InlineSpan>[
                        TextSpan(
                            text: "₹200",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white))
                      ])),
                  Text.rich(TextSpan(
                      text: "Rating: ",
                      style: TextStyle(color: Colors.white),
                      children: <InlineSpan>[
                        TextSpan(
                            text: "4.5", style: TextStyle(color: Colors.green))
                      ]))
                ],
              )
            ],
          ),
        ],
      ),
    );

}
