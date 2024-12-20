import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../const/app_sizes.dart';
import '../widgets/screens_header.dart';
import '../widgets/snackbar_toast.dart';

class CustomerProfileUpdate extends StatefulWidget {
  const CustomerProfileUpdate({super.key});

  @override
  State<CustomerProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<CustomerProfileUpdate> {
  File? _imageFile; // To store the selected image
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _homeAddress = TextEditingController();
  final TextEditingController _officeAddress = TextEditingController();
  final TextEditingController _organizationName = TextEditingController();
  bool _isLoading = false; // Track loading state

  String userId = '';
  @override
  void initState() {
    super.initState();

  user().then((value) {
    setState(() {
      userId = value;
    });
    fetchUserProfile(userId);
  });
  }

  Future<String> user() async {
    userId = await AppSizes.uid;
    return userId;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _dobController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  bool isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  Future<void> _validateInput() async {
   if (_nameController.text.isEmpty) {
  toast("Please Enter Name", context); }
  else if (_emailController.text.isEmpty) {
      toast("Please Enter Email", context);
    } else if (!isValidEmail(_emailController.text)) {
      toast("Please Enter Valid Email", context);
    } else if (_mobileController.text.length != 10) {
      toast("Please Enter Valid Mobile", context);
    } else if (_passwordController.text.isEmpty) {
      toast("Please Enter Valid Password", context);
    } else if (_homeAddress.text.isEmpty) {
      toast("Please Enter Valid Pan", context);
    } else {
      // Valid input, proceed to update
    String response = await _updateProfile();
     if (response == "success") {
       toast(
           "Update Successfully", context,
           color: Colors.green);
       Navigator.pop(context);
     } else {
       toast("Failed ! Please try again...", context,
           color: Colors.red);
     }
    }
  }

  String _convertToBase64(File imageFile) {
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64String = base64Encode(imageBytes);
    setState(() {});
    return base64String;
  }


  Future<String> _updateProfile() async {
    setState(() {
          _isLoading = true; // Start loading
        });

    try {
      Map<String, dynamic> data;
      if (_imageFile == null) {
        data = {
          'u_id':userId,
          'name':_nameController.text,
          'mobile':_mobileController.text,
          'email':_emailController.text,
          'password':_passwordController.text,
          'home':_homeAddress.text,
          'office':_officeAddress.text,
          'o_name':_organizationName.text,
        };
      } else {
        String ff = _convertToBase64(_imageFile!);
        data = {
          'u_id':userId,
          'name':_nameController.text,
          'mobile':_mobileController.text,
          'email':_emailController.text,
          'password':_passwordController.text,
          'home':_homeAddress.text,
          'office':_officeAddress.text,
          'o_name':_organizationName.text,
          'img':ff,
        };
      }

      var response = await http.post(
        Uri.parse(AppSizes.BASEURL + "user_profile_update.php"),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false; // Stop loading
        });
        // // Navigate back or show success message

        print(response.body.toString());
        var jsondata = jsonDecode(response.body.toString());

        if (jsondata[0]['message']=="1") {

          return "success";
        } else {

          return "Failed";
        }
        return "Failed";
      } else {
        setState(() {
          _isLoading = false; // Stop loading
        });

        // // Navigate back or show success message

        // server error
        print("Server Error !");
        return Future.error("Server Error !");
      }
    } catch (SocketException) {
      setState(() {
        _isLoading = false; // Stop loading
      });
      // fetching error
      print("Error Fetching Data !");
      return Future.error("Error Fetching Data !");
    }
  }

  Future<String> fetchUserProfile(String u_id) async {
    setState(() {
          _isLoading = true; // Start loading
        });
    try {
      var response = await http.get(
        Uri.parse(AppSizes.BASEURL + "user_profile_fetch.php?u_id=${u_id}"));

      print("User ID send : $userId");
      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false; // Stop loading
        });
        print(response.body.toString());
        var jsondata = jsonDecode(response.body.toString());

        if (jsondata[0]['message']=="1") {
          _nameController.text =jsondata[0]['name']??'';
          _emailController.text = jsondata[0]['email']??'';
          _mobileController.text =jsondata[0]['mobile']??'';
          _passwordController.text = jsondata[0]['password']??'';
          _homeAddress.text = jsondata[0]['addreass']??'';
          _officeAddress.text = jsondata[0]['shop_detail']??'';
          _organizationName.text = jsondata[0]['shop_reg_no']??'';
          return "success";
        } else {

          return "Failed";
        }
      } else {
        setState(() {
          _isLoading = false; // Stop loading
        });
        // server error
        print("Server Error !");
        return Future.error("Server Error !");
      }
    } catch (SocketException) {
      setState(() {
        _isLoading = false;
      });
      print("Error Fetching Data !");
      return Future.error("Error Fetching Data !");
    }
  }


  // Future<void> _updateProfile() async {
  //   setState(() {
  //     _isLoading = true; // Start loading
  //   });
  //
  //   // Simulate a network request (replace with your actual update logic)
  //   Map<String, dynamic> response;
  //   if (_imageFile == null) {
  //     // response = await ApiService.userupdate(
  //     //     _nameController.text,
  //     //     _dobController.text,
  //     //     _emailController.text,
  //     //     "",
  //     //     _adharController.text,
  //     //     _panController.text);
  //   } else {
  //     String ff = _convertToBase64(_imageFile!);
  //     response = await ApiService.userupdate(
  //         await getstring(USER_TOKEN),
  //         _nameController.text,
  //         _dobController.text,
  //         _emailController.text,
  //         ff,
  //         _adharController.text,
  //         _panController.text);
  //   }
  //
  //   print(response);
  //   if (response["success"]) {
  //     userProvider.updateUserName(response["name"]);
  //     userProvider.updateUserDOB(response["dob"]);
  //     userProvider.updateUserEmail(response["email"]);
  //     userProvider.updateUserProfile(response["profile"]);
  //     userProvider.updateUserAdhar(response["aadhar"]);
  //     userProvider.updateUserPAN(response["pan"]);
  //     toast(response["message"], context);
  //   } else {
  //     toast("Something Went Wrong", context);
  //   }
  //
  //   // After the update logic
  //   setState(() {
  //     _isLoading = false; // Stop loading
  //   });
  //
  //   // // Navigate back or show success message
  //   Navigator.pop(context);
  // }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    // final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        // Use Stack to overlay the progress indicator
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                ScreensHeader(
                  title: 'Profile',
                ),
                // Top section (Header)

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              // Display the image
                              SizedBox(
                                width: 140,
                                height: 140,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(70),
                                  child:
                                      Image.asset("assets/icons/profile.png"),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: _pickImage,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.orange,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: const Icon(Icons.camera_alt,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: _nameController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                labelText: 'Enter Your Name',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                focusColor: Colors.orange,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.alternate_email),
                                labelText: 'Enter Email Address',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                focusColor: Colors.orange,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: _mobileController,
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Mobile Number',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                prefixIcon: Icon(Icons.phone),
                                focusColor: Colors.orange,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                counterText: "",
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: _homeAddress,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.home),
                                counterText: "",
                                labelText: 'Home Address',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: _officeAddress,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.house_outlined),
                                counterText: "",
                                labelText: 'Office Address',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: _organizationName,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.warehouse_outlined),
                                counterText: "",
                                labelText: 'Organisation Name',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                              ),
                            ),
                          ),
                          // const SizedBox(height: 20),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 15),
                          //   child: TextField(
                          //     controller: _homeAddress,
                          //     maxLength: 10,
                          //     keyboardType: TextInputType.number,
                          //     decoration: const InputDecoration(
                          //       prefixIcon: Icon(Icons.roundabout_left),
                          //       counterText: "",
                          //       labelText: 'Role',
                          //       border: OutlineInputBorder(
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(15)),
                          //       ),
                          //     ),
                          //   ),
                          // ),

                        ],
                      ),
                    ),
                  ),
                ),

                // Update Button
                InkWell(
                  onTap: () {
                    _validateInput();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    width: screen.width,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    height: 50,
                    child: const Center(
                      child: Text("Update Changes",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Circular Progress Indicator
          if (_isLoading) // Show loading indicator if loading
            ModalBarrier(
              dismissible: false,
              color: Colors.black.withOpacity(0.5), // Background color
            ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(), // Circular progress indicator
            ),
        ],
      ),
    );
  }
}
