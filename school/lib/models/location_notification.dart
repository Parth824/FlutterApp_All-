// import 'dart:async';
// import 'dart:convert';
// import 'dart:ffi';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:school_vahan/models/bus_model.dart';
//
// import '../helpers/notification.dart';
//
// class LocationNotification extends StatefulWidget {
//   const LocationNotification({Key? key}) : super(key: key);
//
//   @override
//   State<LocationNotification> createState() => _LocationNotificationState();
// }
//
// class _LocationNotificationState extends State<LocationNotification> {
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//     );
//   }
//
//
//
//

// class Location_Notificition{
//
//   Location_Notificition._();
//
//   static final Location_Notificition location_notificition = Location_Notificition._();
//
//   StreamController<BusModel> streamController = StreamController<BusModel>();
//   int? id;
//   List<QueryDocumentSnapshot<Map<String, dynamic>>>? data;
//   double? MeterK;
//   int not = 0;
//
//   Future<void> getUri() async {
//     var queryParameters = {'start_index': '0', 'end_index': '100'};
//     var uri = Uri.https('loconav.com', '/api/v3/device/all_devices_with_count',
//         queryParameters);
//     var response =
//         await http.get(uri, headers: {'Authorization': 'zSgBeyDr3Co15xaBXrTa'});
//
//     if (response.statusCode == 200) {
//       final databody = jsonDecode(response.body);
//       Map k = databody['data'][0]['data'];
//       BusModel busModel = BusModel.fromJson(data: k);
//       streamController.sink.add(busModel);
//     }
//   }
//
//   Srtm(){
//     StreamBuilder<BusModel>(
//       stream: streamController.stream,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Center(
//             child: Text(
//               snapshot.error.toString(),
//             ),
//           );
//         } else if (snapshot.hasData) {
//            getVlaue(snapshot.data!);
//         }
//
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );
//   }
//
//   void getVlaue(BusModel busModel) async {
//
//     for(int i =0;i< data!.length;i++)
//       {
//         if(data![i]['bus_number'] == busModel.vehicle_number)
//           {
//             id =  i;
//           }
//       }
//    await _getDistanceImMeter(startLongitude: data![id!]['longitude'], startLatitude: data![id!]['latitude'], endLatitude: busModel.lattitude, endLongitude: busModel.longitude);
//   }
//
//   Future<void> _getDistanceImMeter({required String startLongitude, required String startLatitude,required String endLatitude, required String endLongitude})
//   async{
//       MeterK = await Geolocator.distanceBetween(double.parse(startLatitude),double.parse(startLongitude),double.parse(endLatitude),double.parse(endLongitude));
//
//       if(not == 0)
//         {
//           await  NotificationHelper.notification.simpleNotification(title: "Buse", body: "Buser is 10 meter");
//           not++;
//         }
//   }
//   Future<void> getdata() async{
//     QuerySnapshot<Map<String, dynamic>> k = await NotificationHelper.firebaseFirestore.collection('user').get();
//     data =  k.docs;
//   }
// }