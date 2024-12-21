import 'package:flutter/material.dart';
import 'package:migo_cabs/const/app_sizes.dart';
import 'package:migo_cabs/screens/customer/screens/select_cab_screen.dart';

import '../../widgets/screens_header.dart';

class PaymentOptionsPage extends StatefulWidget {

  const PaymentOptionsPage({super.key});

  @override
  _PaymentOptionsPageState createState() => _PaymentOptionsPageState();
}

class _PaymentOptionsPageState extends State<PaymentOptionsPage> {
  int selectedIndex = 0;

  final List<Map<String, String>> paymentOptions = [
    {'label': '₹0% now', 'amount': '₹3984.00 Later'},
    {'label': '₹25% now', 'amount': '₹996.00 Pay'},
    {'label': '₹50% now', 'amount': '₹1992.00 Pay'},
    {'label': '₹100% now', 'amount': '₹3984.00 Pay'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ScreensHeader(title: "Payment"),
          Expanded(
            child: ListView.builder(
              itemCount: paymentOptions.length,
              itemBuilder: (context, index) {
                final isSelected = index == selectedIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.orange : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? Colors.orange : Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          paymentOptions[index]['label']!,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          paymentOptions[index]['amount']!,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => CarSelectionPage(),
              //     ));
            },
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: AppSizes.screenwidth,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                    child: Text(
                      'Continue Payment',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
