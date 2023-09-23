import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:school_vahan/models/location_model.dart';
import 'package:school_vahan/models/user_model.dart';
import 'package:school_vahan/screens/payments_screen.dart';
import 'package:school_vahan/screens/profile.dart';
import 'package:school_vahan/screens/update_user_details.dart';

import '../constants.dart';
import '../helpers/notification.dart';
import '../models/LocationAPIResponse.dart';
import '../models/bus_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const id = 'home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {


  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() {
    _auth.signOut();
  }

  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  static CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(28.703502, 77.200874),
    zoom: 14.4746,
  );
  List<String> keysRetrieved = [];
  late BitmapDescriptor nearbyIcon;
  late BitmapDescriptor homeIcon;
  PolylinePoints polylinePoints = PolylinePoints();

  bool busIsOnline = true;
  bool profileLoaded = false;
  var randomGenerator = Random();
  double busLatitude = 0;
  double busLongitude = 0;
  final Set<Marker> _markers = {
    const Marker(
        markerId: MarkerId(""), position: LatLng(12, 12), rotation: 0.0),
    const Marker(
        markerId: MarkerId(""), position: LatLng(12, 12), rotation: 0.0),
  };
  Map<PolylineId, Polyline> polylines = {};
  final databaseRef = FirebaseDatabase.instance.ref();
  String? subsEndDate = '';
  bool paidForCurrentMonth = false;

  UserModel userModel = UserModel(
    schoolId: '',
    long: '',
    guardianPhNo: '',
    lat: '',
    busNumber: '',
    guardianName: '',
    address: '',
    schoolName: '',
    standard: '',
    studentName: '',
    subsEndDate: '',
  );
  bool profileComplete = false;
  late Future vehicleData;

  // Map Functions

  // void setPermissions() async {
  //   Map<PermissionGroup, PermissionStatus> permissions =
  //       await Permission
  //           .requestPermissions([PermissionGroup.location]);
  // }

  void getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  Future<LocationModel> getVehicleLocation(String vehicleNum) async {
    var queryParameters = {'start_index': '0', 'end_index': '100'};
    var uri = Uri.https('loconav.com', '/api/v3/device/all_devices_with_count',
        queryParameters);
    var response =
        await http.get(uri, headers: {'Authorization': 'zSgBeyDr3Co15xaBXrTa'});

    if (response.statusCode == 200) {
      Map<String, dynamic> allBusLocationInJson = jsonDecode(response.body);
      List<LocationAPIResponse> listOfBuses =
          List.from(allBusLocationInJson['data'].map((x) {
        return LocationAPIResponse.fromJson(x);
      }));
      LocationModel busLocDataInJson = listOfBuses
          .firstWhere((bus) => bus.data.vehicle_number == userModel.busNumber)
          .data;
      print(busLocDataInJson.cordinate);
      return busLocDataInJson;
    } else {
      throw Exception('Failed tp fetch latest location');
    }
  }

  Future<List<LatLng>> getDirections(double lat, double long) async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCc9Gj2WoE8N2IT6tUqD5BjXuezwpZgvJ0",
      PointLatLng(lat, long),
      PointLatLng(double.parse(userModel.lat), double.parse(userModel.long)),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void createMarker() {
    ImageConfiguration imageConfiguration =
        createLocalImageConfiguration(context, size: const Size(1, 1));
    BitmapDescriptor.fromAssetImage(
      imageConfiguration,
      'images/busIcon.png',
    ).then((icon) {
      nearbyIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
      imageConfiguration,
      'images/homeIcon2.png',
    ).then((icon) {
      homeIcon = icon;
    });
  }
  //
  // LatLngBounds calculateBounds(double lat, double long) {
  //   return bound;
  // }

  void _onMapCreated(double lat, double long) async {
    PolylineId id = PolylineId('initialLine');
    List<LatLng> list = await getDirections(lat, long);

    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: list,
      width: 4,
    );
    polylines[id] = polyline;

    final LatLng offerLatLng =
        LatLng(double.parse(userModel.lat), double.parse(userModel.long));
    final LatLng currentLatLng = LatLng(lat, long);
    LatLngBounds bound;
    if (offerLatLng.latitude > lat && offerLatLng.longitude > long) {
      bound = LatLngBounds(southwest: currentLatLng, northeast: offerLatLng);
    } else if (offerLatLng.longitude > long) {
      bound = LatLngBounds(
          southwest: LatLng(offerLatLng.latitude, long),
          northeast: LatLng(lat, offerLatLng.longitude));
    } else if (offerLatLng.latitude > lat) {
      bound = LatLngBounds(
          southwest: LatLng(lat, offerLatLng.longitude),
          northeast: LatLng(offerLatLng.latitude, long));
    } else {
      bound = LatLngBounds(southwest: offerLatLng, northeast: currentLatLng);
    }
    CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 50);

    //TODO: This is a hack. Need to find a better way to handle map initialization
    Future.delayed(const Duration(milliseconds: 1500), () {
      mapController.animateCamera(u2).then((void v) {
        check(u2, mapController);
      });
    });
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    mapController.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      check(u, c);
    }
  }

  // void onLocationChange(double lat, double long) {
  //   CameraUpdate u2 =
  //       CameraUpdate.newLatLngBounds(calculateBounds(lat, long), 50);
  //   mapController.animateCamera(u2).then((void v) {
  //     check(u2, mapController);
  //   });
  // }

// Dropdown Methods:

  void selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Profile(
              user: userModel,
            ),
          ),
        );
        break;
      case 1:
        Navigator.pushNamed(context, PaymentsScreen.id);
        break;
      case 2:
        signOut();
        break;
    }
  }

  String prettify(double d) =>
      d.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0*$'), '');

  //To fetch User details
  void getUserData(String? uid) async {
    try {
      if (subsEndDate == '') {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .get()
            .then((value) {
          userModel.schoolId = value.get('school_id');
          userModel.long = value.get('longitude');
          userModel.guardianPhNo = value.get('guardian_phone_number');
          userModel.lat = value.get('latitude');
          userModel.busNumber = value.get("bus_number");
          userModel.guardianName = value.get('guardian_name');
          userModel.address = value.get('address');
          userModel.schoolName = 'school_name';
          userModel.standard = value.get('standard');
          userModel.studentName = value.get('student_name');
          userModel.subsEndDate = value.get('subs_end_date');
          setState(() {
            if (value.exists) {
              profileComplete = true;
              subsEndDate = userModel.subsEndDate;
            }
            _kGooglePlex = CameraPosition(
              target: LatLng(
                double.parse(userModel.lat),
                double.parse(userModel.long),
              ),
              // zoom: 15,
            );
          });

          _markers.remove(_markers.elementAt(0));
          _markers.addAll([
            Marker(
                markerId: const MarkerId('0'),
                position: LatLng(
                    double.parse(
                      value.get('latitude'),
                    ),
                    double.parse(value.get('longitude'))),
                rotation: 0,
                icon: homeIcon),
            const Marker(
                markerId: MarkerId('1'), position: LatLng(12, 12), rotation: 0)
          ]);
        }).whenComplete(() {
          setState(() {
            profileLoaded = true;
          });
        });
      } else {
        setState(() {
          subsEndDate = userModel.subsEndDate;
        });
      }
      final String todayDate = formatter.format(DateTime.now());
      if (todayDate.compareTo(subsEndDate!) == -1) {
        setState(() {
          paidForCurrentMonth = true;
        });
      } else {
        paidForCurrentMonth = false;
      }
    } catch (e) {
      // DisplayDialog.displayDialog(context, "Error", e.toString());
      profileComplete = false;
    }
  }

  getDistanceImMeter({required String startLongitude, required String startLatitude,required String endLatitude, required String endLongitude})
  async{
    NotificationHelper.MeterK = await Geolocator.distanceBetween(double.parse(startLatitude),double.parse(startLongitude),double.parse(endLatitude),double.parse(endLongitude));

    if(NotificationHelper.MeterK! <= 1000)
      {
        if(NotificationHelper.not == 0)
        {
          await  NotificationHelper.notification.simpleNotification(title: "Buse", body: "Buser is 10 meter");
          NotificationHelper.not++;
        }
      }
    else{
      NotificationHelper.not = 0;
    }
  }

  @override
  void dispose() {
    mapController.dispose();
    _markers.clear();
    super.dispose();
  }

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    getCurrentPosition();

    String? _uid = _auth.currentUser?.uid;

    //notification
    getUserData(_uid);Timer.periodic(Duration(seconds: 3), (timer) {
    NotificationHelper.notification.getUri();

    });
    NotificationHelper.notification.getdata();
  }

  @override
  Widget build(BuildContext context) {
    createMarker();
    return Scaffold(
        floatingActionButton: Align(
          alignment: const Alignment(1, 1.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 45.0,
                width: 45.0,
                child: FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () async{
                    // onLocationChange();
                   await NotificationHelper.notification.sendNotification();
                  },
                ),
              ),
              SizedBox(height: 15,),
              SizedBox(
                height: 45.0,
                width: 45.0,
                child: FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () async{
                    // onLocationChange();

                  },
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0Xffffd800),
        body: profileLoaded == false
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : profileComplete == false
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "You profile isn't complete.",
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EnterUserDetails(
                                  phone:
                                      _auth.currentUser!.phoneNumber.toString(),
                                  user: userModel,
                                ),
                              ),
                            );
                          },
                          child: const Text("Complete Profile"),
                        ),
                      ],
                    ),
                  )
                : Stack(
                    alignment: Alignment.topRight,
                    children: [
                      subsEndDate == ''
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : paidForCurrentMonth
                              ? StreamBuilder(
                                  stream: Stream.periodic(
                                          const Duration(seconds: 10))
                                      .asyncMap((i) => getVehicleLocation(
                                          userModel.busNumber)),
                                  builder: (context,
                                      AsyncSnapshot<LocationModel> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      );
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.active) {
                                      if (snapshot.hasData &&
                                          subsEndDate != '') {
                                        double busLat = double.parse(
                                            snapshot.data!.cordinate[0]);
                                        double busLong = double.parse(
                                            snapshot.data!.cordinate[1]);
                                        LatLng driverPosition =
                                            LatLng(busLat, busLong);

                                        Marker thisMarker = Marker(
                                          markerId: MarkerId(
                                              snapshot.data!.device_id),
                                          position: driverPosition,
                                          icon: nearbyIcon,
                                          rotation: 0,
                                        );
                                        PolylineId id = PolylineId(
                                            snapshot.data!.device_id);
                                        List<LatLng> list = [];
                                        getDirections(busLat, busLong).then(
                                            (value) => {list.addAll(value)});
                                        Future.delayed(
                                            const Duration(milliseconds: 500),
                                            () {
                                          Polyline polyline = Polyline(
                                            polylineId: id,
                                            color: Colors.blue,
                                            points: list,
                                            width: 4,
                                          );
                                          polylines[id] = polyline;
                                        });

                                        List<String>? busAddressList =
                                            snapshot.data?.address.split(',');
                                        String? busAddress =
                                            snapshot.data?.address.substring(
                                                0,
                                                snapshot.data?.address.indexOf(
                                                    '${busAddressList?.elementAt(busAddressList.length - 3)}'));
                                        _markers.remove(_markers.elementAt(1));
                                        _markers.add(thisMarker);
                                        if (busLat == 0 || busLong == 0) {
                                          _markers.clear();
                                          return const Center(
                                            child:
                                                Text('Your bus is offline now'),
                                          );
                                        } else {
                                          return Stack(children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.72,
                                                  child: GoogleMap(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      bottom: 280,
                                                    ),
                                                    mapType: MapType.normal,
                                                    myLocationButtonEnabled:
                                                        false,
                                                    initialCameraPosition:
                                                        _kGooglePlex,
                                                    myLocationEnabled: true,
                                                    zoomGesturesEnabled: true,
                                                    zoomControlsEnabled: true,
                                                    polylines: Set<Polyline>.of(
                                                        polylines.values),
                                                    markers: _markers,
                                                    onMapCreated:
                                                        (GoogleMapController
                                                            controller) {
                                                      mapController =
                                                          controller;
                                                      _controller
                                                          .complete(controller);
                                                      _onMapCreated(
                                                          busLat, busLong);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 20,
                                                    top: 15,
                                                    right: 20,
                                                  ),
                                                  // margin: EdgeInsets.only(left: ),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.24,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  color:
                                                      const Color(0Xffffd800),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              vertical: 6,
                                                              horizontal: 10,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.black,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),

                                                              // boxShadow: const [
                                                              //   BoxShadow(
                                                              //     color: Colors
                                                              //         .black12,
                                                              //     blurRadius: 5.0,
                                                              //   ),
                                                              // ],
                                                            ),
                                                            child: Text(
                                                              userModel
                                                                  .busNumber,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                "DISTANCE",
                                                                style: kTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            15),
                                                              ),
                                                              Text(
                                                                "${prettify(Geolocator.distanceBetween(double.parse(userModel.lat), double.parse(userModel.long), busLat, busLong) / 1000).toString()} KM",
                                                                style:
                                                                    kTextStyle,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                        "CURRENT BUS LOCATION:",
                                                        style:
                                                            kTextStyle.copyWith(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic),
                                                      ),
                                                      Text(
                                                        '${busAddress?.substring(0, busAddress.length - 1)}',
                                                        style: kTextStyle,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'BUS SPEED:',
                                                            style: kTextStyle.copyWith(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic),
                                                          ),
                                                          Text(
                                                            ' ${snapshot.data?.speed}',
                                                            style: kTextStyle,
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]);
                                        }
                                      } else {
                                        _markers.clear();
                                        return const Center(
                                          child:
                                              Text('Your bus is offline now'),
                                        );
                                      }
                                    }
                                    return const Center(
                                      child: Text("Error Occurred"),
                                    );
                                  })
                              : const Center(
                                  child:
                                      Text("Payment not made for this month"),
                                ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.only(right: 10, top: 40),
                          decoration: BoxDecoration(
                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: PopupMenuButton<int>(
                            icon: const Icon(
                              Icons.menu_rounded,
                              size: 30,
                              color: Colors.black,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(17.0),
                              ),
                            ),
                            color: Colors.white,
                            itemBuilder: (context) => [
                              PopupMenuItem<int>(
                                value: 0,
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.account_circle,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text("Profile")
                                  ],
                                ),
                              ),
                              PopupMenuItem<int>(
                                value: 1,
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.monetization_on,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text("Payments")
                                  ],
                                ),
                              ),
                              PopupMenuItem<int>(
                                value: 2,
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.logout,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text("Log out")
                                  ],
                                ),
                              ),
                            ],
                            onSelected: (item) => selectedItem(context, item),
                          ),
                        ),
                      ),
                      StreamBuilder<BusModel>(
                        stream: NotificationHelper.streamController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                snapshot.error.toString(),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            return getVlaue(snapshot.data!);
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ],
                  )
        // profileLoaded &&
        //         profileComplete &&
        //         subsEndDate != '' &&
        //         paidForCurrentMonth
        //     ? Container(
        //         height: MediaQuery.of(context).size.height * 0.1,
        //         width: MediaQuery.of(context).size.width,
        //         color: Colors.white,
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Text(
        //               "TIME TO REACH",
        //               style: kTextStyle.copyWith(fontSize: 15),
        //             ),
        //             Text(
        //               "${prettify(Geolocator.distanceBetween(double.parse(userModel.lat), double.parse(userModel.long), busLatitude, busLongitude) / 1000).toString()} KM",
        //               style: kTextStyle,
        //             ),
        //           ],
        //         ),
        //       )
        //     : const SizedBox(),

        );
  }
  Widget getVlaue(BusModel busModel) {

    for(int i =0;i< NotificationHelper.data!.length;i++)
    {
      if(NotificationHelper.data![i]['bus_number'] == busModel.vehicle_number)
      {
        NotificationHelper.id =  i;
      }
    }
   getDistanceImMeter(startLongitude: NotificationHelper.data![NotificationHelper.id!]['longitude'], startLatitude: NotificationHelper.data![NotificationHelper.id!]['latitude'], endLatitude: busModel.lattitude, endLongitude: busModel.longitude);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(visible: false,child: Text("${NotificationHelper.MeterK}")),
        ],
      ),
    );
  }
}

