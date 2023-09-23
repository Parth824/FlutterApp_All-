class BusModel {
  final String lattitude;
  final String longitude;
  final String vehicle_number;

  BusModel({
    required this.lattitude,
    required this.longitude,
    required this.vehicle_number
  });

  factory BusModel.fromJson({required Map data}){
    return BusModel(longitude: data['cordinate'][0], lattitude: data['cordinate'][1],vehicle_number: data['vehicle_number']);
  }
}
