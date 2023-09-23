class LocationModel {
  String vehicle_number;
  String device_id;
  List<String> cordinate;
  String address;
  String city;
  String state;
  String motion_status;
  String motion_state;
  String speed;
  String orientation;
  String last_received_at;
  String share_link;
  String ignition;
  LocationModel(
      {required this.address,
      required this.city,
      required this.vehicle_number,
      required this.device_id,
      required this.cordinate,
      required this.state,
      required this.motion_state,
      required this.motion_status,
      required this.speed,
      required this.orientation,
      required this.last_received_at,
      required this.share_link,
      required this.ignition});

  factory LocationModel.fromJson(dynamic json) {
    return LocationModel(
      vehicle_number: json['vehicle_number'],
      device_id: json['device_id'],
      cordinate: List<String>.from(json["cordinate"].map((x) => x)),
      address: json['address'],
      city: json['city'],
      state: json['state'],
      motion_status: json['motion_status'],
      motion_state: json['motion_state'],
      speed: json['speed'].toString(),
      orientation: json['orientation'],
      last_received_at: json['last_received_at'].toString(),
      share_link: json['share_link'],
      ignition: json['ignition'],
    );
  }
}
