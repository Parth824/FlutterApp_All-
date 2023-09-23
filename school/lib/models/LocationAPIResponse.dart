import 'location_model.dart';

class LocationAPIResponse {
  LocationModel data;
  LocationAPIResponse({required this.data});
  factory LocationAPIResponse.fromJson(dynamic json) {
    return LocationAPIResponse(data: LocationModel.fromJson(json['data']));
  }
}
