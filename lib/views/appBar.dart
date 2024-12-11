import 'package:dropdown_button2/dropdown_button2.dart';
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
    appBarC.fetchRegencies();

    return Container(
      height: hp * 0.18,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(3.0, 3.0),
            blurRadius: 6.0,
            spreadRadius: 1.0,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
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

                    return DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: const Row(
                          children: [
                            Icon(
                              Icons.list,
                              size: 16,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Select Regency',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: appBarC.regencies.map((regency) {
                          return DropdownMenuItem<String>(
                            value: regency.name,
                            child: Text(
                              regency.name,
                              style: TextStyle(
                                fontFamily: "NunitoSans",
                                fontWeight: FontWeight.w800,
                                fontSize: wp * 0.05,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        value: appBarC.selectedValue.value != null
                            ? appBarC.selectedValue.value
                            : null,
                        onChanged: (String? value) {
                          appBarC.updateSelectedValue(value!);
                          appBarC.toggleRotation();
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 50,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.blue.withOpacity(0.0),
                          ),
                          elevation: 10,
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                          iconEnabledColor: Colors.white,
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: const Color.fromARGB(255, 243, 243, 243)
                                .withOpacity(0.8),
                          ),
                          elevation: 10,
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility:
                                MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
