import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:migo_cabs/const/app_sizes.dart';
import 'package:migo_cabs/screens/auth/user_type_screen.dart';
import 'package:migo_cabs/screens/widgets/snackbar_toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OtpInputScreen extends StatefulWidget {
  final String mobile;
  final String otpSend;

  const OtpInputScreen(this.mobile, this.otpSend, {super.key});

  @override
  _OTPInputScreenState createState() => _OTPInputScreenState();
}

class _OTPInputScreenState extends State<OtpInputScreen> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _focusNode =
  FocusNode(); // FocusNode for the hidden TextField
  String otp = "";
  String userId="";

  @override
  void initState() {
    super.initState();

    // Automatically request focus on the TextField when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Dispose the FocusNode to avoid memory leaks
    _otpController.dispose();
    super.dispose();
  }

  Future<String> loginAccount(Map<String, dynamic> data) async {
    try {
      var response = await http.post(
        Uri.parse(AppSizes.BASEURL + "registration.php"),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        print("data ${data['mobile']}");
        var jsondata = jsonDecode(response.body.toString());

        if (jsondata[0]['message']=="1") {
          addStringToPref(jsondata[0]['u_id'].toString(),data['mobile'].toString());

          return "success";
        } else {
          return "Failed";
        }
        return "Failed";
      } else {
        // server error
        print("Server Error !");
        return Future.error("Server Error !");
      }
    } catch (SocketException) {
      // fetching error
      print("Error Fetching Data !");
      return Future.error("Error Fetching Data !");
    }
  }

  Future<void> addStringToPref(String u_id,String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('u_id', u_id);
    prefs.setString('mobile', mobile);
    setState(() {});
    user();
  }

  void user() async {
    userId = await AppSizes.uid;
    setState(() {
      print("User ID: $userId");
    });

  }

  void _onDashTapped() {
    // Request focus on the hidden TextField and ensure the keyboard opens
    if (!_focusNode.hasFocus) {
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    AppSizes().initSizes(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onDashTapped, // Ensure keyboard opens on tapping anywhere
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
              ),
              // Logo
              Image.asset(
                'assets/images/migosplash.jpg',
                // Replace with the correct asset path
                height: 150,
                width: 150,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 15),

              // Title
              Text(
                "Enter OTP",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // OTP Input Dashes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return GestureDetector(
                    onTap: _onDashTapped, // Open keyboard when tapping a dash
                    child: Container(
                      width: 50,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: otp.length > index
                                ? Colors.orange
                                : Colors.grey,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        otp.length > index ? otp[index] : "",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 0),

              // Hidden Text Field with FocusNode
              TextField(
                controller: _otpController,
                focusNode: _focusNode,
                // Attach the FocusNode
                keyboardType: TextInputType.number,
                maxLength: 4,
                style: TextStyle(
                  color: Colors.transparent,
                  fontSize: 1, // Tiny text to keep it visually hidden
                ),
                cursorColor: Colors.transparent,
                decoration: InputDecoration(
                  counterText: "",
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    otp = value;
                  });
                },
              ),

              // Continue Button
              ElevatedButton(
                onPressed: () async {
                  print("OTP Submitted: ${widget.otpSend}");
                  if (otp.length == 4) {
                    // Add OTP submission logic here
                    if (otp == widget.otpSend) {
                      Map<String, dynamic> data = {'mobile': widget.mobile};
                      String response = await loginAccount(data);

                      if (response == "success") {
                        toast(
                            "Login Successfully", context,
                            color: Colors.green);
                        Get.off(() =>  const UserTypeScreen());

                      } else {
                        toast("Failed ! Please try again...", context,
                            color: Colors.red);
                      }
                    } else {
                      toast("Please Enter Valid OTP", context,
                          color: Colors.red);
                    }
                  } else {
                    toast("Please Enter Valid OTP", context, color: Colors.red);
                  }
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
                'Enter the OTP sent to your mobile number.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Help ",
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                  Icon(
                    Icons.support_agent,
                    color: Colors.orange,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
