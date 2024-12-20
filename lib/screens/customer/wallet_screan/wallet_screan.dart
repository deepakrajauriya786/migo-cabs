import 'package:flutter/material.dart';
import 'package:migo_cabs/screens/widgets/screens_header.dart';

class CustomerWalletHistory extends StatelessWidget {
  const CustomerWalletHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [ScreensHeader(title: 'Wallet History')],
      ),
    );
  }
}
