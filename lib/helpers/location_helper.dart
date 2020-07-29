import 'dart:convert';

import 'package:flutter_great_places/helpers/google_config.dart';
import 'package:http/http.dart' as http;

class LocationHelper {
  static String generateLocationPreviewImage({double latitude, longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude' +
        '&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude' +
        '&key=' +
        GoogleConfig.apiKey;
  }

  static Future<String> getPlaceAddress(double lat, lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng' +
            '&key=' +
            GoogleConfig.apiKey;
    final response = await http.get(url);
    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
