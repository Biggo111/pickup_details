import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickup_details/constants/colors.dart';
import 'package:pickup_details/widgets/custom_button.dart';
import 'package:pickup_details/widgets/datepicker_container.dart';
import 'package:pickup_details/widgets/dropdownmenu_container.dart';
import 'package:pickup_details/widgets/save_button.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class PickupDetailsScreen extends StatefulWidget {
  final String screenTitle;
  const PickupDetailsScreen({super.key, required this.screenTitle});

  @override
  State<PickupDetailsScreen> createState() => _PickupDetailsScreenState();
}

class _PickupDetailsScreenState extends State<PickupDetailsScreen> {
  String? selectedOption;
  String? selectedOption2;

  int selectedButtonIndex = -1;

  bool isParkingHeightRestricted = false;

  String? searchQuery;
  List<Map<String, dynamic>> searchResults = [];

  // void fetchSearchResults(String query) async {
  //   if (query.length >= 2) {
  //     final url = Uri.parse(
  //         'https://api.instantpickup.delivery/api/v2/trip/get-address');
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'query': query}),
  //     );

  //     if (response.statusCode == 200) {
  //       final jsonData = jsonDecode(response.body);
  //       final List<dynamic> data = jsonData['data'];

  //       setState(() {
  //         searchResults = List<Map<String, dynamic>>.from(data);
  //       });
  //     }
  //   } else {
  //     setState(() {
  //       searchResults = [];
  //     });
  //   }
  // }

  void fetchSearchResults(String query) async {
    if (query.length < 2) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Internet'),
            content: Text('Please check your internet connection'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    final url = Uri.parse(
        'https://api.instantpickup.delivery//api/v2/trip/get-address');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'query': query}),
    );

    final jsonData = jsonDecode(response.body);
    final List<dynamic> data = jsonData['data'];

    setState(() {
      searchResults = List<Map<String, dynamic>>.from(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.screenTitle,
                    style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Container(
                height: 50,
                width: 390,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '',
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                          fetchSearchResults(value);
                        },
                      ),
                    ),
                    Positioned(
                      left: 10.0,
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 30.0,
                        height: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
              if (searchResults.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final result = searchResults[index];
                      return ListTile(
                        title: Text(result['address']),
                        subtitle: Text(result['postcode']),
                      );
                    },
                  ),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "House No/Flat/Unit/Building Name*",
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200]),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter House No/Flat/Unit/Building Name',
                        hintStyle: GoogleFonts.montserrat(fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pickup Date*",
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DatePickerContainer(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pickup Time*",
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownMenuContainer(
                        items: const [
                          '8-10',
                          '10-12',
                          '12-2',
                          '2-4',
                          '4-6',
                          '6-8'
                        ],
                        selectedValue: selectedOption,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedOption = newValue;
                          });
                        },
                        hintText: 'Select a Pickup Time',
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What Floor Are You On?*",
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownMenuContainer(
                        items: const [
                          'Ground Floor',
                          'Basement',
                          'First Floor',
                          'Second Floor',
                          'Third Floor',
                          'Fourth Floor'
                        ],
                        selectedValue: selectedOption2,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedOption = newValue;
                          });
                        },
                        hintText: "Select A Floor",
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Is There A Lift Available?*",
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            text: "No",
                            onPressed: () {
                              setState(() {
                                selectedButtonIndex = 0;
                              });
                            },
                            isPressed: selectedButtonIndex == 0,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CustomButton(
                            text: "Yes",
                            onPressed: () {
                              setState(() {
                                selectedButtonIndex = 1;
                              });
                            },
                            isPressed: selectedButtonIndex == 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: Text(
                          "Is There Any Parking Height Restriction?*",
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            text: "No",
                            onPressed: () {
                              setState(() {
                                selectedButtonIndex = 0;
                                isParkingHeightRestricted = false;
                              });
                            },
                            isPressed: selectedButtonIndex == 0,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CustomButton(
                            text: "Yes",
                            onPressed: () {
                              setState(() {
                                selectedButtonIndex = 1;
                                isParkingHeightRestricted = true;
                              });
                            },
                            isPressed: selectedButtonIndex == 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Maximum Height*",
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 46,
                        width: 172,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: isParkingHeightRestricted ? scaffoldBackgroundColor : Colors.grey[400],),
                        child: TextField(
                          enabled: isParkingHeightRestricted ? true : false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ex.150cm',
                            hintStyle: GoogleFonts.montserrat(fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SaveButton(text: "Save", onTap: () {})
            ],
          ),
        ),
      ),
    );
  }
}
