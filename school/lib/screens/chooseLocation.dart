import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:school_vahan/main.dart';

class ChooseHomeLocation extends StatefulWidget {
  static String id = 'chooseLocation';
  final double lat;
  final double long;
  const ChooseHomeLocation({Key? key, this.lat = 0, this.long = 0})
      : super(key: key);

  @override
  _ChooseHomeLocationState createState() => _ChooseHomeLocationState();
}

class _ChooseHomeLocationState extends State<ChooseHomeLocation> {
  final _controller = Completer<GoogleMapController>();
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(12.933950, 77.663334),
    zoom: 14.4746,
  );
  MapPickerController mapPickerController = MapPickerController();
  late GoogleMapController mapController;
  late Position userPosition;
  Future<Position> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    setState(() {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((value) {
        cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.latitude),
          zoom: 20,
        );
      });
    });
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  var textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    getUserLocation().then((value) {
      CameraPosition targetPosition = CameraPosition(
        target: LatLng(widget.lat == 0 ? value.latitude : widget.lat,
            widget.long == 0 ? value.longitude : widget.long),
        zoom: 20,
      );
      mapController
          .animateCamera(CameraUpdate.newCameraPosition(targetPosition));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            MapPicker(
              iconWidget: SvgPicture.asset(
                "images/location_icon.svg",
                height: 60,
              ),
              mapPickerController: mapPickerController,
              child: GoogleMap(
                myLocationEnabled: true,
                zoomControlsEnabled: true,
                // hide location button
                // myLocationButtonEnabled: true,
                mapType: MapType.normal,
                //  camera position
                initialCameraPosition: cameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  mapController = controller;
                  cameraPosition = CameraPosition(
                    target: LatLng(widget.lat, widget.long),
                    zoom: 20,
                  );
                },
                onCameraMoveStarted: () {
                  // notify map is moving
                  mapPickerController.mapMoving!();
                  textController.text = "checking ...";
                },
                onCameraMove: (cameraPos) {
                  cameraPosition = cameraPos;
                },
                onCameraIdle: () async {
                  // notify map stopped moving
                  mapPickerController.mapFinishedMoving!();
                  //get address name from camera position
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                    cameraPosition.target.latitude,
                    cameraPosition.target.longitude,
                  );

                  // update the ui with the address
                  textController.text =
                      '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
                },
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).viewPadding.top + 20,
              width: MediaQuery.of(context).size.width - 50,
              height: 50,
              child: TextFormField(
                maxLines: 3,
                textAlign: TextAlign.center,
                readOnly: true,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero, border: InputBorder.none),
                controller: textController,
              ),
            ),
            Positioned(
              bottom: 24,
              left: 24,
              right: 50,
              child: SizedBox(
                height: 50,
                child: TextButton(
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: Color(0xFFFFFFFF),
                      fontSize: 19,
                      // height: 19/19,
                    ),
                  ),
                  onPressed: () {
                    secureStorage.write(
                        key: "latitude",
                        value: cameraPosition.target.latitude.toString());
                    secureStorage.write(
                        key: "longitude",
                        value: cameraPosition.target.longitude.toString());

                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFA3080C)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
