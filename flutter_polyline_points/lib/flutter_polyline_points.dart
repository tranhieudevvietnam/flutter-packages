library flutter_polyline_points;

import 'package:flutter_polyline_points/src/utils/polyline_result.dart';
import 'package:flutter_polyline_points/src/utils/polyline_waypoint.dart';
import 'package:flutter_polyline_points/src/utils/request_enums.dart';
import 'src/PointLatLng.dart';
import 'src/network_util.dart';
import 'src/utils/geocode_result.dart';

export 'src/utils/request_enums.dart';
export 'src/utils/polyline_waypoint.dart';
export 'src/network_util.dart';
export 'src/PointLatLng.dart';
export 'src/utils/polyline_result.dart';
export 'src/utils/geocode_result.dart';

class PolylinePoints {
  NetworkUtil util = NetworkUtil();

  /// Get the list of coordinates between two geographical positions
  /// which can be used to draw polyline between this two positions
  ///
  Future<PolylineResult> getRouteBetweenCoordinates(
      String googleApiKey, PointLatLng origin, PointLatLng destination,
      {String? androidCert,
      String? androidPackage,
      String? bundleId,
      TravelMode travelMode = TravelMode.driving,
      List<PolylineWayPoint> wayPoints = const [],
      bool avoidHighways = false,
      bool avoidTolls = false,
      bool avoidFerries = true,
      bool optimizeWaypoints = false}) async {
    return await util.getRouteBetweenCoordinates(
        googleApiKey,
        origin,
        destination,
        travelMode,
        wayPoints,
        avoidHighways,
        avoidTolls,
        avoidFerries,
        optimizeWaypoints,
        androidCert: androidCert,
        androidPackage: androidPackage,
        bundleId: bundleId);
  }

  /// Decode and encoded google polyline
  /// e.g "_p~iF~ps|U_ulLnnqC_mqNvxq`@"
  ///
  List<PointLatLng> decodePolyline(String encodedString) {
    return util.decodeEncodedPolyline(encodedString);
  }

  Future<GeocodingResult?> getAddressByCoordinates(
    String googleKey,
    double latitude,
    double longitude, {
    String? androidCert,
    String? androidPackage,
    String? bundleId,
  }) async {
    return await util.getAddressByCoordinates(googleKey, latitude, longitude,
        androidCert: androidCert,
        androidPackage: androidPackage,
        bundleId: bundleId);
  }
}
