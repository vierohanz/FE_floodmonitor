class appBarModel {
  final String location;
  final DateTime date;

  appBarModel({required this.location, required this.date});

  factory appBarModel.fromJson(Map<String, dynamic> json) {
    return appBarModel(location: json['id'], date: json['date']);
  }
}
