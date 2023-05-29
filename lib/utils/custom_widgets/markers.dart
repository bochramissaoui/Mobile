import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../api_endpoints.dart';
import '../global.colors.dart';

class Markers {
  static Future<List<Marker>> getMarkers(BuildContext context, RxList<String> selectedCategories, RxList<String> selectedSubcategories) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('markerList');
    if (jsonString != null) {
      final List<dynamic> myList = await json.decode(jsonString);
      final markers = myList.map((item) {
        final latitude = item['latitude'];
        final longitude = item['longitude'];
        final name = item['name'];
        final state = item['state'];
        return Marker(
            point: LatLng(latitude, longitude),
            width: 40,
            height: 40,
            builder: (context) => InkWell(
              onTap: () {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.vertical(
                            top:
                            Radius.circular(30))),
                    context: context,
                    builder:
                        (context) =>
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets
                                    .symmetric(
                                    horizontal:
                                    30),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 33,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              name,
                                              style: GoogleFonts.montserrat(
                                                  color:
                                                  GlobalColors.BlueColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 23)),
                                        ),
                                        IconButton(
                                          onPressed:
                                              () {
                                            Navigator.of(
                                                context)
                                                .pop();
                                          },
                                          icon:
                                          const Icon(
                                            Icons
                                                .close,
                                            size: 26,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 33,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Router status :    ",
                                          style: GoogleFonts.montserrat(
                                              color: GlobalColors
                                                  .BlueColor,
                                              fontWeight:
                                              FontWeight
                                                  .w600,
                                              fontSize:
                                              15),
                                        ),
                                        Container(
                                          height: 22,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 3,
                                                  offset: Offset(1, 1.5),
                                                ),
                                              ],
                                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                                              color: state == 'Installed'
                                                  ? const Color(0xFFD5F0B1)
                                                  : state == 'In progress'
                                                  ? const Color(0xFFFFF8E0)
                                                  : const Color(0xFFFADCD9)
                                          ),
                                          child: Center(
                                            child: Text(
                                              state,
                                              style: GoogleFonts.montserrat(
                                                color: state == 'Installed'
                                                    ? const Color(0xFF2E5C0E)
                                                    : state == 'In progress'
                                                    ? const Color(0xFFFFAD0D)
                                                    : const Color(0xFFA1170B),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        )

                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Latence : 58ms",
                                          style: GoogleFonts.montserrat(
                                              color: GlobalColors
                                                  .BlueColor,
                                              fontWeight:
                                              FontWeight
                                                  .w600,
                                              fontSize:
                                              15),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Upload : 44.77 Mbps",
                                          style: GoogleFonts.montserrat(
                                              color: GlobalColors
                                                  .BlueColor,
                                              fontWeight:
                                              FontWeight
                                                  .w600,
                                              fontSize:
                                              15),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Download : 44.84 Mbps",
                                          style: GoogleFonts.montserrat(
                                              color: GlobalColors
                                                  .BlueColor,
                                              fontWeight:
                                              FontWeight
                                                  .w600,
                                              fontSize:
                                              15),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 21,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Description :",
                                          style: GoogleFonts.montserrat(
                                              color: GlobalColors
                                                  .BlueColor,
                                              fontWeight:
                                              FontWeight
                                                  .w500,
                                              fontSize:
                                              23),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    Text(
                                      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters,",
                                      style: GoogleFonts.montserrat(
                                          color: GlobalColors
                                              .BlueColor,
                                          fontWeight:
                                          FontWeight
                                              .w300,
                                          fontSize:
                                          13),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 0, 0, 0),
                child: Image.asset(
                    'assets/icons/pin.png'
                ),
              ),
            ));
      }).toList();

      return markers;
    } else {
      final headers = {'content-Type': 'application/json'};
      final markersUrl =
      Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getZones);
      final markersResponse = await http.get(markersUrl, headers: headers);
      if (markersResponse.statusCode == 200) {
        final List<dynamic> markerList = json.decode(markersResponse.body);

        final jsonString = json.encode(markerList);
        await prefs.setString('markerList', jsonString);

        final markers = markerList.map((item) {
          final latitude = item['latitude'];
          final longitude = item['longitude'];
          final name = item['name'];
          final state = item['state'];
          return Marker(
              point: LatLng(latitude, longitude),
              width: 40,
              height: 40,
              builder: (context) => InkWell(
                onTap: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.vertical(
                              top:
                              Radius.circular(30))),
                      context: context,
                      builder:
                          (context) =>
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets
                                      .symmetric(
                                      horizontal:
                                      30),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 33,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                                name,
                                                style: GoogleFonts.montserrat(
                                                    color:
                                                    GlobalColors.BlueColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 23)),
                                          ),
                                          IconButton(
                                            onPressed:
                                                () {
                                              Navigator.of(
                                                  context)
                                                  .pop();
                                            },
                                            icon:
                                            const Icon(
                                              Icons
                                                  .close,
                                              size: 26,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 33,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Router status :    ",
                                            style: GoogleFonts.montserrat(
                                                color: GlobalColors
                                                    .BlueColor,
                                                fontWeight:
                                                FontWeight
                                                    .w600,
                                                fontSize:
                                                15),
                                          ),
                                          Container(
                                            height: 22,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 3,
                                                    offset: Offset(1, 1.5),
                                                  ),
                                                ],
                                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                color: state == 'Installed'
                                                    ? const Color(0xFFD5F0B1)
                                                    : state == 'In progress'
                                                    ? const Color(0xFFFFF8E0)
                                                    : const Color(0xFFFADCD9)
                                            ),
                                            child: Center(
                                              child: Text(
                                                state,
                                                style: GoogleFonts.montserrat(
                                                  color: state == 'Installed'
                                                      ? const Color(0xFF2E5C0E)
                                                      : state == 'In progress'
                                                      ? const Color(0xFFFFAD0D)
                                                      : const Color(0xFFA1170B),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          )

                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Latence : 58ms",
                                            style: GoogleFonts.montserrat(
                                                color: GlobalColors
                                                    .BlueColor,
                                                fontWeight:
                                                FontWeight
                                                    .w600,
                                                fontSize:
                                                15),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Upload : 44.77 Mbps",
                                            style: GoogleFonts.montserrat(
                                                color: GlobalColors
                                                    .BlueColor,
                                                fontWeight:
                                                FontWeight
                                                    .w600,
                                                fontSize:
                                                15),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Download : 44.84 Mbps",
                                            style: GoogleFonts.montserrat(
                                                color: GlobalColors
                                                    .BlueColor,
                                                fontWeight:
                                                FontWeight
                                                    .w600,
                                                fontSize:
                                                15),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 21,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Description :",
                                            style: GoogleFonts.montserrat(
                                                color: GlobalColors
                                                    .BlueColor,
                                                fontWeight:
                                                FontWeight
                                                    .w500,
                                                fontSize:
                                                23),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      Text(
                                        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters,",
                                        style: GoogleFonts.montserrat(
                                            color: GlobalColors
                                                .BlueColor,
                                            fontWeight:
                                            FontWeight
                                                .w300,
                                            fontSize:
                                            13),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 0, 0),
                  child: Image.asset(
                      'assets/icons/pin.png'
                  ),
                ),
              ));
        }).toList();

        return markers;
      } else {
        throw Exception('Failed to fetch markers');
      }
    }
  }
}