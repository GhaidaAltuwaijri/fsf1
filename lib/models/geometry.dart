import 'package:focus_spot_finder/models/location.dart';

class Geometry {
  final Location location; //geometry has a location obj

  Geometry({this.location});

  Geometry.fromJson(Map<dynamic,dynamic> parsedJson)
      :location = Location.fromJson(parsedJson['location']);
}