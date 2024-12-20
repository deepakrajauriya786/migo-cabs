import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:migo_cabs/screens/widgets/screens_header.dart';

import '../../auth/otp_input_screen.dart';
import '../../google_search_location/location_distance.dart';
import '../../google_search_location/search_location.dart';
import '../customer_home_screen.dart';

class OneWayScreen extends StatefulWidget {
  final String dropAddress;
  final String pickupAddress;
  final String type;

  const OneWayScreen({
    this.dropAddress = '',
    this.pickupAddress = '',
    this.type = '0',
    Key? key,
  }) : super(key: key);

  @override
  State<OneWayScreen> createState() => _OneWayScreenState();
}

class _OneWayScreenState extends State<OneWayScreen> {
  TextEditingController _datecontroller = TextEditingController();
  TextEditingController _timecontroller = TextEditingController();
  TextEditingController _pickupcontroller = TextEditingController();
  TextEditingController _dropcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _pickupcontroller.text =widget.pickupAddress;
    _dropcontroller.text =widget.dropAddress;


  }


  Future<DateTime?> pickFutureDate(BuildContext context) async {
    final DateTime today = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: today,
      // Set the current date as the initial date
      firstDate: today,
      // Only allow selecting dates from today onwards
      lastDate: DateTime(today.year + 5),
      // Allow up to 5 years in the future
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.orange, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.orange, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    return pickedDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    final TimeOfDay now = TimeOfDay.now();
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: now, // Set the current time as the initial time
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.orange, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.orange, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    return pickedTime;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(const CustomerHomeScreen()); // Navigate to CustomerHomeScreen
        return true; // Prevent default back press behavior
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreensHeader(title: "One Way"),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Create New Booking",
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _buildTextField(
                    controller: _pickupcontroller,
                    label: 'Pickup Address',
                    icon: Icons.location_on,
                    isenable: false,
                    callback: ()  {
                      Get.to(
                        GoogleMapSearchPlacesApi(_pickupcontroller.text,_dropcontroller.text,"1","1"),
                      );

                      setState(() {});
                    },
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    controller: _dropcontroller,
                    label: 'Drop Address',
                    icon: Icons.location_on_outlined,
                    isenable: false,
                    callback: ()  {
                      Get.to(
                        GoogleMapSearchPlacesApi(_pickupcontroller.text,_dropcontroller.text,"1","2"),
                      );
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _datecontroller,
                          label: 'Pickup Date',
                          icon: Icons.calendar_today,
                          isenable: false,
                          callback: () async {
                            final DateTime? selectedDate =
                            await pickFutureDate(context);
                            if (selectedDate != null) {
                              _datecontroller.text = "${selectedDate.toLocal()}"
                                  .split(' ')[0]; // Format date
                            }
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                            controller: _timecontroller,
                            label: 'Pickup Time',
                            icon: Icons.access_time,
                            isenable: false,
                            callback: () async {
                              final TimeOfDay? selectedTime =
                              await pickTime(context);
                              if (selectedTime != null) {
                                _timecontroller.text =
                                    selectedTime.format(context);
                                setState(() {});
                                // Update your text field or state with the selected time
                              }
                            }),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(
                        LocationDistance(_pickupcontroller.text,_dropcontroller.text,"1",_datecontroller.text,_timecontroller.text),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'EXPLORE CABS',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ), // The widget of your current screen
    );

  }

  Widget _buildTextField(
      {required String label,
      required IconData icon,
      required VoidCallback callback,
      required TextEditingController controller,
      bool isenable = true}) {
    return
      TextField(
      onTap: callback,
      controller: controller,
      readOnly: !isenable,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(icon, color: Colors.orange),
        floatingLabelStyle: TextStyle(color: Colors.orange),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
