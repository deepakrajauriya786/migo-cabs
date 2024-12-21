import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../widgets/screens_header.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Map<String, List<Map<String, dynamic>>> tripData = {
    'One Way': [
      {
        'date': 'Dec 20 2024, 05:30 PM',
        'bookingId': 'NTL0643YCIVZ4HI',
        'from': 'Delhi',
        'to': 'Gwalior',
        'advancePay': '0.0 (0%)',
        'pendingAmount': '4232.65',
        'distance': '359.92 KM',
      },
      {
        'date': 'Dec 11 2024, 10:11 PM',
        'bookingId': 'TRJU4G5BKBTGTGDA',
        'from': 'Delhi',
        'to': 'Jaipur',
        'advancePay': '0.0 (0%)',
        'pendingAmount': '3635.19',
        'distance': '309.12 KM',
      },
    ],
    'Round Trip': [
      {
        'date': 'Dec 25 2024, 06:00 AM',
        'bookingId': 'RTRF0643YVZ8ZXG',
        'from': 'Mumbai',
        'to': 'Pune',
        'advancePay': '2000 (40%)',
        'pendingAmount': '3000.00',
        'distance': '148.00 KM',
      },
    ],
    'Local': [
      {
        'date': 'Dec 21 2024, 08:00 AM',
        'bookingId': 'LCL1234ABCDEF',
        'from': 'Delhi',
        'to': 'Delhi',
        'advancePay': '500 (50%)',
        'pendingAmount': '500.00',
        'distance': '50.00 KM',
      },
    ],
    'Airport': [
      {
        'date': 'Dec 30 2024, 09:00 AM',
        'bookingId': 'APT12345HJKL',
        'from': 'Delhi',
        'to': 'IGI Airport',
        'advancePay': '300 (30%)',
        'pendingAmount': '700.00',
        'distance': '20.00 KM',
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tripData.keys.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Custom AppBa4r
          ScreensHeader(title: "My Booking"),
          // Tab Bar
          TabBar(
            controller: _tabController,
            isScrollable: false,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orange,
            tabs: tripData.keys.map((type) => Tab(text: type)).toList(),
          ),
          // Tab Bar View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tripData.keys.map((type) {
                final data = tripData[type]!;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final booking = data[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(8.0),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        dashPattern: [8, 4],
                        color: Colors.grey,
                        strokeWidth: 1,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                booking['date'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Booking ID: ${booking['bookingId']}',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${booking['from']}',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '< - - - To - - - >',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${booking['to']}',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Text('Advance Pay: Rs. ${booking['advancePay']}'),
                              Text(
                                  'Booking Pending Amount: Rs. ${booking['pendingAmount']}'),
                              Text('Distance: ${booking['distance']}'),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Text(
                                      'PENDING',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.edit, color: Colors.grey),
                                      SizedBox(width: 8),
                                      Icon(Icons.delete, color: Colors.grey),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
