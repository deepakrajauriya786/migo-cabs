import 'package:flutter/material.dart';
import 'package:migo_cabs/const/app_sizes.dart';


class VendorNavigationDrawer extends StatelessWidget {
  const VendorNavigationDrawer({super.key});

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
                _buildListTile(Icons.verified_user, 'Post Booking', () {}),
                _buildListTile(Icons.payment, 'Cabs/Driver', () {}),
                _buildListTile(Icons.history, 'Account', () {}),
                _buildListTile(Icons.settings, 'Membership', () {}),
                _buildListTile(Icons.local_offer, 'Help & Support', () {}),
                _buildListTile(Icons.help, 'Language', () {}),
                _buildListTile(Icons.notifications, 'Refer and Earn', () {}),
                _buildListTile(Icons.share, 'Notification', () {}),
                
                const Divider(),
                _buildListTile(Icons.logout, 'Logout', () {}, isLogout: true),
              ],
            ),
          ),
        ],
      ),
    );
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
                      child: Image.asset("assets/images/migosplash.jpg"),
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
                      text: "Wallet Balance: ",
                      style: TextStyle(color: Colors.white),
                      children: <InlineSpan>[
                        TextSpan(
                            text: "₹200",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white))
                      ])),
                
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
