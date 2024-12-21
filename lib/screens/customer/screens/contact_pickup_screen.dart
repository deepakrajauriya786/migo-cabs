import 'package:flutter/material.dart';

import '../../../const/app_sizes.dart';
import '../../widgets/screens_header.dart';

class ContactPickupScreen extends StatefulWidget {

  const ContactPickupScreen({super.key});

  @override
  _ContactPickupScreenState createState() => _ContactPickupScreenState();
}

class _ContactPickupScreenState extends State<ContactPickupScreen> {
  // Variable to keep track of the selected option
  String selectedOption = "Inclusions";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreensHeader(title: "Contact and Pickup Info"),
            // Input fields
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  buildTextField("NAME"),
                  buildTextField("EMAIL ID"),
                  buildTextField("PHONE NO"),
                  buildTextField(
                    "PICKUP ADDRESS",
                  ),
                  buildTextField("PICKUP LANDMARK"),
                  buildTextField(
                    "DROP ADDRESS",
                  ),
                  buildTextField("DROP LANDMARK"),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Proceed to Pay Button
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => BookingPage(),
                //     ));
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: AppSizes.screenwidth,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(
                      child: Text(
                        'Proceed To Pay',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
            ),

            const SizedBox(height: 10),

            // Trip Details Card
            Card(
              color: Colors.white,
              margin: const EdgeInsets.all(16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trip Route
                    Container(
                      width: AppSizes.screenwidth - 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Delhi, India",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Madhya Pradesh, India",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey),

                    // Fare Details
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Fare",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              "₹3984.19 (All Inclusive)",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            Text(
                              "₹4065.50",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Trip Details
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Trip Type"),
                        Text("One Way"),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Pickup At"),
                        Text("DEC 20 2024 at 11:01 AM"),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Car Type"),
                        Text("G Vagan R"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Options Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildSelectableBox("Inclusions"),
                  buildSelectableBox("Exclusions"),
                  buildSelectableBox("Facilities"),
                ],
              ),
            ),

            // Selected content display
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Selected: $selectedOption content goes here.",
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, {String? initialValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.orange, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.orange),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.orange, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildSelectableBox(String option) {
    bool isSelected = selectedOption == option;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = option;
        });
      },
      child: Container(
        width: 100, // Adjust width as needed
        height: 40, // Adjust height as needed
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          option,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
