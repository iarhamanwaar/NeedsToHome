import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../repository/settings_repository.dart';
import 'directions_model.dart';

class DirectionsRepository {
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRepository({Dio dio}) : _dio = dio ?? Dio();


  Future<Directions> getDirections({
    @required LatLng origin,
    @required LatLng destination,
  }) async {
    print('get shop');
    print(origin.latitude);
    print(origin.longitude);
    print(destination.latitude);
    print(destination.longitude);
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': setting.value.googleMapsKey,
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      print(response.data);

      return Directions.fromMap(response.data);
    }
    return null;
  }
}
