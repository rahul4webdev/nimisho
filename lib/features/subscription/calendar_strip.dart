import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/helper/route_helper.dart' show RouteHelper;

class CalendarStrip extends StatefulWidget {
  @override
  _CalendarStripState createState() => _CalendarStripState();
}

class _CalendarStripState extends State<CalendarStrip> {
  final Map<String, String> shortDays = {
    "sunday": "Sun",
    "monday": "Mon",
    "tuesday": "Tue",
    "wednesday": "Wed",
    "thursday": "Thu",
    "friday": "Fri",
    "saturday": "Sat",
  };

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(builder: (checkoutController) {
      var weekData = checkoutController.weekData;

      if (weekData == null || weekData.isEmpty) {
        return const SizedBox.shrink();
      }

      final entries = weekData.entries.toList();
      DateTime today = DateTime.now();

      return SizedBox(
        height: 110, // extra space for better look
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(), // smooth scrolling
          child: Row(
            children: List.generate(entries.length, (index) {
              String day = entries[index].key;
              int value = entries[index].value ?? 0;
              String shortDay = shortDays[day] ?? day.substring(0, 3);

              DateTime date = today.add(Duration(days: index));
              String dayNumber = DateFormat("d").format(date);

              Color boxColor = index == 0 ? Colors.green : Colors.white;
              Color textColor = index == 0 ? Colors.white : Colors.black;

              return GestureDetector(
                onTap: () {
                  // ✅ navigate to subscription
                  Get.toNamed(RouteHelper.getSubscriptionRoute());
                },
                child: Container(
                  width: 65,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  decoration: BoxDecoration(
                    color: boxColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(dayNumber,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor)),
                      Text(shortDay,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: textColor)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        decoration: BoxDecoration(
                          color: index == 0 ? Colors.white : Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "$value",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: index == 0 ? Colors.green : Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      );
    });
  }
}
