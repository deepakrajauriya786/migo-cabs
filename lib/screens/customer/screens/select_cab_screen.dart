import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../const/app_sizes.dart';
import '../../widgets/screens_header.dart';
import 'contact_pickup_screen.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class CarSelectionPage extends StatefulWidget {

  final String pickupAddress;
  final String dropAddress;
  final String type;
  final String pickUpdDate;
  final String pickUpTime;

  const CarSelectionPage(
      this.pickupAddress,  this.dropAddress,this.type, this.pickUpdDate,this.pickUpTime,
      {super.key});


  @override
  _CarSelectionPageState createState() => _CarSelectionPageState();
}

class _CarSelectionPageState extends State<CarSelectionPage> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> cars = [
    {
      'name': 'Toyota Etios Free',
      'image': 'assets/images/sedan.png',
      'price': 4065.50,
      'discountedPrice': 3984.19,
      'description': 'Up to 338.79 Km',
    },
    {
      'name': 'Toyota Etios Free',
      'image': 'assets/images/sedan.png',
      'price': 3387.92,
      'discountedPrice': 3280.50,
      'description': 'Up to 320.00 Km',
    },
    {
      'name': 'Sdfsfd',
      'image': 'assets/images/sedan.png',
      'price': 147374.52,
      'discountedPrice': 145000.00,
      'description': 'Up to 1500.00 Km',
    },
  ];


  @override
  void initState() {
    super.initState();
    getDistance(widget.pickupAddress,widget.dropAddress);

  }

  Future<void> getDistance(String origin, String destination) async {
    print("dddddd");

    final String url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$origin&destinations=$destination&key=$apiKey';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final distance = data['rows'][0]['elements'][0]['distance']['text'];
        final duration = data['rows'][0]['elements'][0]['duration']['text'];

        print('Distance: $distance');
        print('Duration: $duration');
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Exception11: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreensHeader(title: "One Way Booking"),
          // Route Details
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New Delhi',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' - - - - - - - - - - - - - - - -',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' Gwalior',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'DEC 20 2024 at 11:01 AM',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          // Horizontal ListView of Cars
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final car = cars[index];
                final isSelected = index == selectedIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    width: 120,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? Colors.orange : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          car['image'],
                          height: 70,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 8),
                        Text(
                          car['name'],
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '₹${car['price'].toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange,
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

          // Price Info Section
          SizedBox(
            height: 30,
          ),
          Container(
            width: AppSizes.screenwidth,
            padding: EdgeInsets.symmetric(vertical: 15),
            color: Colors.orange,
            child: Text(
              textAlign: TextAlign.center,
              'PRICE INCLUSIVE OF ALL TOLLS AND TAXES',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                // Car Details
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            cars[selectedIndex]['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '₹${cars[selectedIndex]['discountedPrice'].toStringAsFixed(2)} (All Inclusive)',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '₹${cars[selectedIndex]['price'].toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            cars[selectedIndex]['description'],
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Image.asset(
                      cars[selectedIndex]['image'],
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            height: 1,
            width: AppSizes.screenwidth,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          ),
          // Select Cab Button
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactPickupScreen(),
                  ));
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
                      'Select Cab',
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
