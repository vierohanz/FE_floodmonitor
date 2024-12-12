import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flood_monitor/controllers/appBarController.dart';
import 'package:flood_monitor/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class appBar extends StatelessWidget {
  final appBarController appBarC = Get.put(appBarController());

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    // Trigger fetching regencies when the view is created

    return Container(
      height: hp * 0.18,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 157, 157, 157),
            offset: Offset(3, 3),
            blurRadius: 6.0,
            spreadRadius: 1.0,
          ),
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        image: const DecorationImage(
          image: AssetImage('assets/images/appbar.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(
          top: hp * 0.065,
          left: wp * 0.04,
          right: wp * 0.02,
          bottom: hp * 0.03,
        ),
        height: hp * 0.1,
        width: wp,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Banjir Text Box
            Container(
              width: wp * 0.3,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(width: 3, color: Colors.white),
                color: Colors.amber[800],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "BANJIR",
                  style: TextStyle(
                    fontFamily: "NunitoSans",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: wp * 0.04,
                  ),
                ),
              ),
            ),

            Container(
              width: wp * 0.47,
              height: hp * 1,
              margin: const EdgeInsets.only(top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    if (appBarC.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (appBarC.regencies.isEmpty) {
                      return const Text(
                        "No regencies available",
                        style: TextStyle(color: Colors.white),
                      );
                    }

                    return Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: CustomDropdown(
                          closedHeaderPadding:
                              EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Pilih Kota",
                          items: appBarC.regencies.map((regency) {
                            return regency.name;
                          }).toList(),
                          onChanged: (String? value) {
                            if (value != null) {
                              appBarC.updateSelectedValue(value);
                            } else {
                              appBarC.saveSelectedValue(
                                  0, "unknown", "0.0", "0.0");
                            }
                          },
                          decoration: CustomDropdownDecoration(
                            expandedFillColor: Colors.black.withOpacity(0.8),
                            closedFillColor: Colors.transparent,
                            headerStyle: TextStyle(
                              fontFamily: "NunitoSans",
                              fontWeight: FontWeight.w600,
                              fontSize: wp * 0.045,
                              color: Colors.white,
                            ),
                            listItemStyle: TextStyle(
                              fontFamily: "NunitoSans",
                              fontWeight: FontWeight.w600,
                              fontSize: wp * 0.04,
                              color: Colors.white,
                            ),
                            hintStyle: TextStyle(
                              fontFamily: "NunitoSans",
                              fontWeight: FontWeight.w600,
                              fontSize: wp * 0.04,
                              color: const Color.fromARGB(255, 193, 193, 193),
                            ),
                            closedSuffixIcon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            expandedSuffixIcon: Icon(
                              Icons.arrow_drop_up,
                              color: Colors.black,
                            ),
                          ),
                        ));
                  }),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      child: Text(
                        appBarC.getFormattedDate(),
                        style: TextStyle(
                          fontFamily: "NunitoSans",
                          fontWeight: FontWeight.w600,
                          fontSize: wp * 0.029,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
