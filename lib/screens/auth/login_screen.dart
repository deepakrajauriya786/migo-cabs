import 'package:flutter/material.dart';
import 'package:migo_cabs/const/app_sizes.dart';
import 'package:migo_cabs/screens/widgets/snackbar_toast.dart';

import 'otp_input_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController numbers = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppSizes().initSizes(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            // Logo
            Image.asset(
              'assets/images/migosplash.jpg', // Replace with the correct asset path
              height: 120,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 30),

            // Title
            Container(
              width: AppSizes.screenwidth,
              child: Text(
                "What's your Mobile Number?",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 3),

            // Mobile Number Input
            TextField(
              controller: numbers,
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                counterText: "",
                hintText: '9009000900',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.orange, width: 1.5),
                ),
              ),
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              maxLength: 10,
            ),
            const SizedBox(height: 10),

            // Continue Button
            ElevatedButton(
              onPressed: () {
                if (numbers.text.length < 10) {
                  toast("Please Enter Valid Number", context,
                      color: Colors.red);
                } else {
                  toast("OTP Sent", context, color: Colors.green);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpInputScreen(),
                      ));
                }
                // Add navigation or action here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),

            // Consent Text
            Text(
              'By proceeding you consent to calls, WhatsApp, or SMS messages, including from automated means, from MigoCabs or its associates to the number provided',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
