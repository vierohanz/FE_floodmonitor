import 'package:flood_monitor/models/appBarModel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class appBarController extends GetxController {
  final List<String> locations = ["Pekalongan", "Brebes", "Polines"];
  var currentIndex = 0.obs;

  Rx<appBarModel> appBarM = appBarModel(
    location: "Pekalongan",
    date: DateTime.now(),
  ).obs;

  void changeLocation() {
    currentIndex.value = (currentIndex.value + 1) % locations.length;
    appBarM.value = appBarModel(
      location: locations[currentIndex.value],
      date: DateTime.now(),
    );
  }

  String getFormattedDate() {
    return DateFormat('d MMMM yyyy HH:mm').format(appBarM.value.date);
  }
}
