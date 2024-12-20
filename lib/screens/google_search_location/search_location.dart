import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../../const/app_sizes.dart';
import '../customer/home_screen_tabs/airport_transfers_screen.dart';
import '../customer/home_screen_tabs/hourly_rentals_screen.dart';
import '../customer/home_screen_tabs/one_way_screen.dart';
import '../customer/home_screen_tabs/round_trip_screen.dart';
import '../widgets/screens_header.dart';

class GoogleMapSearchPlacesApi extends StatefulWidget {
  final String pickupAddress;
  final String dropAddress;
  final String type;
  final String typeLocation;

  const GoogleMapSearchPlacesApi(
      this.pickupAddress,  this.dropAddress,this.type, this.typeLocation,
      {super.key});

  @override
  _GoogleMapSearchPlacesApiState createState() =>
      _GoogleMapSearchPlacesApiState();
}

class _GoogleMapSearchPlacesApiState extends State<GoogleMapSearchPlacesApi> {
  final _controller = TextEditingController();
  var uuid = const Uuid();
  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {

    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$apiKey&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      if (kDebugMode) {
        print('mydata');
        print(data);
      }
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ScreensHeader(title: "Search Location"),
          SizedBox(
            height: 20,
          ),
          Align(

            alignment: Alignment.topCenter,
            child: TextField(

              controller: _controller,
              decoration:InputDecoration(
                labelText: 'Search Location',
                hintText: "Search your location here",
                labelStyle: TextStyle(color: Colors.grey),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon: Icon(Icons.location_on, color: Colors.orange),
                floatingLabelStyle: TextStyle(color: Colors.orange),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.orange),
                  onPressed: () {
                    _controller.clear();
                  },
                ),
              ),
            ),
          ).marginSymmetric(horizontal: 20),
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _placeList.length,
              itemBuilder: (context, index) {
                return
                  GestureDetector(
                  onTap: () {
                    widget.type == "1"
                        ? Get.off(
                        widget.typeLocation == "1"
                            ? OneWayScreen(
                                pickupAddress: _placeList[index]["description"],
                                dropAddress: widget.dropAddress,
                              )
                            : OneWayScreen(
                                pickupAddress: widget.pickupAddress,
                                dropAddress: _placeList[index]["description"],
                              )
                    )
                        : widget.type == "2"
                            ? Get.off(
                        widget.typeLocation == "1"
                            ? RoundTripScreen(
                          pickupAddress: _placeList[index]["description"],
                          dropAddress: widget.dropAddress,
                        )
                            : RoundTripScreen(
                          pickupAddress: widget.pickupAddress,
                          dropAddress: _placeList[index]["description"],
                        )
                              )
                            : widget.type == "3"
                                ? Get.off(
                        widget.typeLocation == "1"
                            ? HourlyRentalsScreen(
                          pickupAddress: _placeList[index]["description"],
                          dropAddress: widget.dropAddress,
                        )
                            : HourlyRentalsScreen(
                          pickupAddress: widget.pickupAddress,
                          dropAddress: _placeList[index]["description"],
                        )
                                  )
                                : Get.off(
                        widget.typeLocation == "1"
                            ? AirportTransfersScreen(
                          pickupAddress: _placeList[index]["description"],
                          dropAddress: widget.dropAddress,
                        )
                            : AirportTransfersScreen(
                          pickupAddress: widget.pickupAddress,
                          dropAddress: _placeList[index]["description"],
                        )
                                  );
                  },
                  child: ListTile(
                    title: Text(_placeList[index]["description"]),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
