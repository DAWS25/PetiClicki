class PointOfInterest {
  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final String iconType;
  final List<String> petTypes; // cat, dog, ferret, etc.
  final String placeType; // sitter, clinic, hospital, shelter

  PointOfInterest({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.iconType,
    required this.petTypes,
    required this.placeType,
  });

  factory PointOfInterest.fromJson(Map<String, dynamic> json) {
    return PointOfInterest(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      iconType: json['iconType'] as String,
      petTypes: (json['petTypes'] as List<dynamic>).cast<String>(),
      placeType: json['placeType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'iconType': iconType,
      'petTypes': petTypes,
      'placeType': placeType,
    };
  }
}
