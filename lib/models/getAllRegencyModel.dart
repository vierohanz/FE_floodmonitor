class getAllRegencyModel {
  final int id;
  final String name;
  final String latitude;
  final String longitude;

  getAllRegencyModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  // Factory method to create a Regency from a JSON object
  factory getAllRegencyModel.fromJson(Map<String, dynamic> json) {
    return getAllRegencyModel(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
