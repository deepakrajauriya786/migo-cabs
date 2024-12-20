import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:migo_cabs/const/app_sizes.dart';
import 'package:migo_cabs/screens/widgets/snackbar_toast.dart';
import 'package:random_string/random_string.dart';
import '../model/PhotoModel.dart';
import 'otp_input_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController numbers = TextEditingController();

  Future<String> sendOtp(Map<String, dynamic> data) async {
    try {
      var response = await http.post(
        Uri.parse( AppSizes.BASEURL +"login_otp.php"),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        print("otp send");
        return "success";
      } else {
        print(response.body);
        // server error
        print("Failed !");
        return "err";
      }
    } catch (SocketException) {
      // fetching error
      print("Failed !");
      return "err";
    }
  }


  @override
  void initState() {
    super.initState();

  }

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
            const SizedBox(
              height: 100,
            ),
            // Logo
            Image.asset(
              'assets/images/migosplash.jpg', // Replace with the correct asset path
              height: 120,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 30),


            // FutureBuilder<List<Photo>>(
            //     future: futurePhotos,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasError) {
            //         return const Center(
            //           child: Text('An error has occurred!'),
            //         );
            //       } else if (snapshot.hasData) {
            //         if(snapshot.data![2].id==3){
            //           return Text('right');
            //         }else{
            //           return Text('wrong');
            //         }
            //       } else {
            //         return const Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       }
            //     },
            // ),


            // Title
            SizedBox(
              width: AppSizes.screenwidth,
              child: const Text(
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
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                  const BorderSide(color: Colors.orange, width: 1.5),
                ),
              ),
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              maxLength: 10,
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                EasyLoading.show(status: 'Loading...');

                if (numbers.text.length < 10) {

                  toast("Please Enter Valid Number", context,
                      color: Colors.red);

                } else {

                  String otp = randomNumeric(4);
                  Map<String, dynamic> data = {
                    'mobile': numbers.text,
                    'otp': otp.toString()
                  };

                  String response= await sendOtp(data);
                  if(response == "success"){
                    // EasyLoading.dismiss();
                    toast("OTP Sent ${otp.toString()}", context, color: Colors.green);
                    Fluttertoast.showToast(msg: "OTP Sent Successfully ${otp.toString()}");
                    Get.off(() =>  OtpInputScreen(numbers.text,otp.toString()));


                  }else{
                    // EasyLoading.dismiss();
                    Fluttertoast.showToast(msg: "Failed ! Please try again...");

                  }





                }
                // Add navigation or action here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Consent Text
            const Text(
              'By proceeding you consent to calls, WhatsApp, or SMS messages, including from automated means, from TaxiKing or its associates to the number provided',
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

class PhotosList extends StatelessWidget {
  const PhotosList({super.key, required this.photos});

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return Expanded(

      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return Image.network(photos[index].thumbnailUrl);
        },
      ),
    );
  }
}