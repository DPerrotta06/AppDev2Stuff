class Geo {
  String lat;
  String lon;

  Geo({required this.lat, required this.lon});

  factory Geo.fromJson(Map<String, dynamic> json) =>
      Geo(lat: json["lat"], lon: json["lon"]);
}
