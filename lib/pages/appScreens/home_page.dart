import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:relead/helpers/gps.dart';
import 'package:relead/pages/Oops%20Screens/OopsGps_page.dart';
import 'package:relead/pages/appScreens/Settings_page.dart';
import 'package:relead/pages/profileScreens/profile_page.dart';
import 'package:relead/utils/custom_widgets/selectedItemsRow.dart';
import 'package:relead/utils/extension.dart';
import 'package:relead/utils/global.colors.dart';

import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/homeController/filterController.dart';
import '../../models/marker.dart';
import 'filterDialog.dart';




class Home extends StatefulWidget {
  const Home({super.key, required this.damagedDatabaseDeleted, required this.store});
  final bool damagedDatabaseDeleted;
  final StoreDirectory store;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  List<MarkerModel> _markerList = [];
  final textController = TextEditingController();
  final GPS _gps = GPS();
  Position? _userPosition;
  Exception? _exception;
  final MapController _mapctl = MapController();
  late LatLng pos;
  late ConnectivityResult result;
  late StreamSubscription subscription;
  var isConnected = false;
  final int _pageIndex = 0;
  FilterController filterController = Get.put( FilterController());
  late Widget _settingsPage;
  List<String> _selectedCategories = [];
  List<String> _selectedSubcategories = [];


  void _handlePositionStream(Position position) {
    setState(() {
      _userPosition = position;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _gps.stopPositionStream();
  }

  @override
  void initState() {
    _settingsPage=Settings(damagedDatabaseDeleted: widget.damagedDatabaseDeleted,
        store: widget.store);
    startStreaming();
    _gps.startPositionStream(_handlePositionStream).catchError((e) {
      setState(() {
        _exception = e;
      });
    });

    if (widget.damagedDatabaseDeleted) {
      WidgetsBinding.instance.addPostFrameCallback(
            (_) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('At least one corrupted database has been deleted.'),
          ),
        ),
      );
    }
    _loadMarkers();

    super.initState();
  }

  void _loadMarkers({List<String>? selectedCategories, List<String>? selectedSubcategories}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String markerListJson = prefs.getString('markerList') ?? '[]';
    List<dynamic> markerListData = json.decode(markerListJson);
    _markerList = markerListData
        .map((markerData) => MarkerModel.fromJson(markerData))
        .toList();

    // Filter markers based on selected categories and subcategories
    if (selectedCategories != null && selectedSubcategories != null &&
        (selectedCategories.isNotEmpty || selectedSubcategories.isNotEmpty)) {
      _markerList.retainWhere((marker) {
        if (selectedCategories.contains(marker.subCategories.first.category.name)) {
          if (selectedSubcategories.isEmpty) {
            return true;
          } else {
            return selectedSubcategories.any(
                    (subcategory) => marker.subCategories.any((sub) => sub.name == subcategory));
          }
        }
        return false;
      });
    }

    // Remove markers associated with removed categories and subcategories
    if (selectedCategories != null && selectedSubcategories != null) {
      _markerList.removeWhere((marker) {
        if (selectedCategories.contains(marker.subCategories.first.category.name)) {
          if (selectedSubcategories.isEmpty) {
            return false;
          } else {
            return marker.subCategories.any(
                    (sub) => selectedSubcategories.contains(sub.name) == false);
          }
        }
        return false;
      });
    }

    setState(() {});
  }
  void loadMarkers(List<String>? selectedCategories, List<String>? selectedSubcategories) {
    _loadMarkers(selectedCategories: selectedCategories, selectedSubcategories: selectedSubcategories);
  }

  void _applyFilter(List<String> categories, List<String> subcategories) {
    setState(() {
      _selectedCategories = categories;
      _selectedSubcategories = subcategories;
      _loadMarkers();
    });
  }
  void _showFilterDialog() {
    FilterDialog.show((List<String> selectedCategories, List<String> selectedSubcategories) {
      setState(() {
        _selectedCategories = selectedCategories;
        _selectedSubcategories = selectedSubcategories;
        _loadMarkers(selectedCategories: _selectedCategories, selectedSubcategories: _selectedSubcategories);
      });
    });
  }

  checkInternet() async {
    result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      isConnected = true;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        duration: const Duration(seconds: 5),
        content: Container(
          height: 59,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 7,
                  offset: Offset(4, 6), // changes position of shadow
                ),
              ],
              color: Color(0xFFD5F0B1),
              borderRadius: BorderRadius.all(Radius.circular(80))),
          child: Row(
            children: [
              const SizedBox(width: 16),
              const Icon(
                Icons.wifi,
                color: Color(0xff2E5C0E),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  "Connected".tr,
                  style: GoogleFonts.montserrat(
                      color: const Color(0xff2E5C0E),
                      fontWeight: FontWeight.w700,
                      fontSize: 21),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 100.0),
      ));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      isConnected = false;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        duration: const Duration(seconds: 15),
        content: Container(
          height: 59,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 7,
                  offset: Offset(4, 6), // changes position of shadow
                ),
              ],
              color: Color(0xFFFADCD9),
              borderRadius: BorderRadius.all(Radius.circular(80))),
          child: Row(
            children: [
              const SizedBox(width: 16),
              const Icon(
                Icons.wifi_off,
                color: Color(0xffA1170B),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  "Connection Lost".tr,
                  style: GoogleFonts.montserrat(
                      color: const Color(0xffA1170B),
                      fontWeight: FontWeight.w700,
                      fontSize: 21),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 100.0),
      ));
    }
    setState(() {});
  }
  startStreaming() {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      checkInternet();
    });
  }


  @override
  Widget build(BuildContext context) {
    const String urlTemplate = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

    Widget child;

    if (_exception != null) {
      child = const OopsGps();
      return Scaffold(
        body: Center(child: child),
      );
    } else if (_userPosition == null) {
      child = const CircularProgressIndicator();
      return Scaffold(
        body: Center(child: child),
      );
    } else {
      return WillPopScope(
        onWillPop: ()async{
          final value=await showDialog<bool>(context: context, builder:(context){
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.0.hp)
              ),
              child: SizedBox(
                height: 33.0.hp,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/OopsFace.png',
                      height: 13.0.hp,
                      width: 20.0.wp,
                    ),
                    SizedBox(height: 2.0.hp),
                    Text(
                      "Close this app ?".tr,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: GlobalColors.BlueColor,
                          fontSize: 10.0.sp),
                    ),SizedBox(height: 0.5.hp),
                    //Enter the email address associated with your account
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                        child: Text(
                          "are you sure to close this app ?".tr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w300,
                            color: GlobalColors.blackTextColor,
                            fontSize: 8.0.sp,
                          ),
                        )),
                    SizedBox(height: 2.0.hp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                      children: [
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.of(context).pop(false)
                          },
                          style: ButtonStyle(
                              minimumSize:
                              MaterialStateProperty.all(Size(21.0.wp, 3.5.hp)),
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  GlobalColors.BlueColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0.wp),
                              ))),
                          child: Text(
                            'No'.tr,
                            style: GoogleFonts.montserrat(
                                color: GlobalColors.WhiteColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 10.0.sp),
                          ),
                        ),
                        SizedBox(
                          width: 3.5.wp,
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.of(context).pop(true)
                          },
                          style: ButtonStyle(
                              minimumSize:
                              MaterialStateProperty.all(Size(21.0.wp, 3.5.hp)),
                              backgroundColor: const MaterialStatePropertyAll<Color>(
                                  Color(0xffE9E9E9)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0.wp),
                              ))),
                          child: Text(
                            'Yes'.tr,
                            style: GoogleFonts.montserrat(
                                color: GlobalColors.BlueColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 10.0.sp),
                          ),
                        )
                      ],
                    )
                  ],
                ),

              ),
            );
          });
          if(value!=null){
            return Future.value(value);
          }
          else{
            return Future.value(false);
          }
        },
        child: Scaffold(

          resizeToAvoidBottomInset: false,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child:FlutterMap(
                        mapController: _mapctl,
                        options: MapOptions(
                          center: LatLng(
                            // _userPosition!.latitude, _userPosition!.longitude
                              35.83,10.59
                          ),
                          zoom: 9,
                          maxZoom: 19,
                          maxBounds: LatLngBounds.fromPoints([
                            LatLng(-90, 180),
                            LatLng(90, 180),
                            LatLng(90, -180),
                            LatLng(-90, -180),
                          ]),
                          interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                          keepAlive: true,
                        ),
                        nonRotatedChildren: [
                          // AttributionWidget.defaultWidget(
                          //   source: Uri.parse(urlTemplate).host,
                          // ),
                        ],
                        children: [

                          TileLayer(
                            urlTemplate: urlTemplate,
                            tileProvider: widget.store.getTileProvider(
                              FMTCTileProviderSettings(
                                  behavior: CacheBehavior.cacheFirst,
                                  cachedValidDuration: const Duration(days: 30), //recache every month
                                  maxStoreLength: 15000), //less than 350mb,
                              //deletes old tiles if max length is surpassed
                            ),
                            maxZoom: 19,
                            userAgentPackageName: 'dev.org.fmtc.example.app',
                            panBuffer: 3,
                            backgroundColor: const Color(0xFFaad3df),
                          ),
                          MarkerLayer(
                            markers: _markerList.map((marker) {
                              return Marker(
                                  point: LatLng(marker.latitude, marker.longitude),
                                  width: 60,
                                  height: 60,
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
                                                                    marker.name,
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
                                                                    color: marker.state == 'Installed'
                                                                        ? const Color(0xFFD5F0B1)
                                                                        : marker.state == 'In progress'
                                                                        ? const Color(0xFFFFF8E0)
                                                                        : const Color(0xFFFADCD9)
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    marker.state,
                                                                    style: GoogleFonts.montserrat(
                                                                      color: marker.state == 'Installed'
                                                                          ? const Color(0xFF2E5C0E)
                                                                          : marker.state == 'In progress'
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
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            marker.subCategories.map((subCategory) => subCategory.name).join(', '),
                                                            style: GoogleFonts.montserrat(
                                                                color: GlobalColors
                                                                    .BlueColor,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w300,
                                                                fontSize:
                                                                13),
                                                          ),
                                                          Text(
                                                              marker.subCategories.first.category.name,
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
                            }).toList(),
                          ) ,
                        ],
                      )
              ),

              //TOP BAR

              searchBarUI(),

              //filter row

              Column(
                children: [
                  const SizedBox(
                    height: 115,
                  ),
                  SelectedItemsRow(
                    selectedCategories: _selectedCategories,
                    selectedSubcategories: _selectedSubcategories,
                    onApplyFilter: (categories, subcategories) {
                      setState(() {
                        _selectedCategories = categories;
                        _selectedSubcategories = subcategories;
                      });
                      _loadMarkers(
                          selectedCategories: categories, selectedSubcategories: subcategories);
                    },
                  ),
                ],
              ),

              //BOTTOM BAR
              Align(
                alignment: const Alignment(0, 1),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 20, 30),
                        child: Stack(children: [
                          ClipRRect(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                              child: BottomNavigationBar(
                                currentIndex: _pageIndex,
                                selectedItemColor: GlobalColors.WhiteColor,
                                unselectedItemColor: Colors.white,
                                showSelectedLabels: false,
                                showUnselectedLabels: false,
                                backgroundColor: GlobalColors.BlueColor,
                                onTap: ((int index) {
                                  setState(() {
                                    if (index == 2) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              _settingsPage));
                                    } else if (index == 0) {
                                      _mapctl.move(
                                          LatLng(_userPosition!.latitude,
                                              _userPosition!.longitude),
                                          15.5);
                                    } else if (index == 1) {
                                      // Navigator.push(
                                      //    context,
                                      //    MaterialPageRoute(
                                      //        builder: (context) =>
                                      //            const NotificationPage()));
                                    }
                                  });
                                }),
                                items: const [
                                  BottomNavigationBarItem(
                                    icon: Icon(
                                      Icons.compass_calibration_outlined,
                                      size: 30,
                                    ),
                                    label: "Position",
                                  ),
                                  BottomNavigationBarItem(
                                    icon: Icon(
                                      Icons.notifications_none_outlined,
                                      size: 35,
                                    ),
                                    label: "Notifications",
                                  ),
                                  BottomNavigationBarItem(
                                    icon: Icon(
                                      Icons.settings_outlined,
                                      size: 35,
                                    ),
                                    label: "Settings",
                                  ),
                                ],
                              )),
                        ]),
                      ),
                    ),
                    //profile pic
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()));
                        },
                        child: CircleAvatar(
                          radius: 33,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(400.0),
                                child: FutureBuilder<SharedPreferences>(
                                  future: _prefs,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final imageUrl = snapshot.data!.getString('img');
                                      if (imageUrl != null && imageUrl.isNotEmpty) {
                                        return Image.network(
                                          imageUrl,
                                          height: 18.0.wp,
                                          width: 18.0.wp,
                                          errorBuilder: (context, error, stackTrace) {
                                            // In case the network image fails to load, display the default image
                                            return Image.network(
                                              'https://storage.googleapis.com/relead-maps.appspot.com/abed4f33-3edc-4308-95f6-44fbbfd1ee21.png',
                                              height: 18.0.wp,
                                              width: 18.0.wp,
                                            );
                                          },
                                        );
                                      }
                                    }
                                    // If 'img' is null or empty, or if there's an error retrieving the shared preferences,
                                    // display the default image
                                    return Image.network(
                                      'https://storage.googleapis.com/relead-maps.appspot.com/abed4f33-3edc-4308-95f6-44fbbfd1ee21.png',
                                      height: 18.0.wp,
                                      width: 18.0.wp,
                                    );
                                  },
                                ),
                              ),
                            )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget searchBarUI() {
    return FloatingSearchBar(
        margins: const EdgeInsets.fromLTRB(30, 50, 30, 0),
        automaticallyImplyBackButton: false,
        iconColor: GlobalColors.BlueColor,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        hint: 'Search or Use Filter ...'.tr,
        openAxisAlignment: 0.0,
        axisAlignment: 0.0,
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 20),
        elevation: 4.0,
        physics: const BouncingScrollPhysics(),
        onQueryChanged: (query) {
          //Methods
        },
        transitionCurve: Curves.easeInOut,
        transitionDuration: const Duration(milliseconds: 500),
        transition: CircularFloatingSearchBarTransition(),
        debounceDelay: const Duration(milliseconds: 500),
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircularButton(
              icon: const Icon(Icons.filter_list_alt),
              onPressed: () {
                _showFilterDialog();
              },
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
        builder: (context, transition) {
          return const ClipRRect();
        });
  }


}
