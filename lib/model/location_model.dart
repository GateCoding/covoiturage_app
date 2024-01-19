class Location {
  final String city;

  Location({required this.city});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(city: json['city']);
  }
}
