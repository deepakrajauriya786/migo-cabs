import 'package:flutter/material.dart';

class VendorWalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            // Balance Card
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green[100],
                              child: Icon(Icons.account_balance_wallet, color: Colors.green),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Balance",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.help_outline),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      "₹112.39",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Handle top-up action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size(double.infinity, 48),
                      ),
                      child: Text(
                        "Top up",
                        style: TextStyle(fontSize: 16 , color: Colors.white , fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Payment Methods
            // Card(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: ListTile(
            //     leading: Icon(Icons.payment),
            //     title: Text("Payment methods"),
            //     trailing: Icon(Icons.arrow_forward_ios, size: 16),
            //     onTap: () {
            //       // Handle payment methods action
            //     },
            //   ),
            // ),
            // SizedBox(height: 16),

            // Withdraw Button
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                 
                  
                    ElevatedButton(
                      onPressed: () {
                        // Handle withdraw action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size(double.infinity, 48),
                      ),
                      child: Text(
                        "Withdraw Amount",
                        style: TextStyle(fontSize: 16 , color: Colors.white , fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

