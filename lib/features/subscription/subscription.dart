import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../coupon/controllers/coupon_controller.dart';
import '../item/controllers/item_controller.dart';

class ItemCustomSubscription extends StatefulWidget {
  @override
  _ItemCustomSubscriptionState createState() => _ItemCustomSubscriptionState();
}

class _ItemCustomSubscriptionState extends State<ItemCustomSubscription> {



  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponController>(
      builder: (couponController) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubscriptionTypeSection(couponController),
              SizedBox(height: 24),
              _buildDateSection(),
              SizedBox(height: 24),
              _buildTimeSection(),
              SizedBox(height: 24),
              _buildDaysSection(),
            ],
          ),
        );
      }
    );
  }

  Widget _buildSubscriptionTypeSection(CouponController couponController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Subscription Type',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            _buildSubscriptionButton('Daily'),
            SizedBox(width: 8),
            _buildSubscriptionButton('Weekly'),
            SizedBox(width: 8),
            _buildSubscriptionButton('Alternate'),
          ],
        ),
      ],
    );
  }

  Widget _buildSubscriptionButton(String type) {
    return GetBuilder<ItemController>(
        builder: (itemController) {
          bool isSelected =itemController.selectedSubscription == type;

          return Expanded(
          child: GestureDetector(
            onTap: () {

              itemController.setSubscription(selectedSubType: type);
              print(itemController.selectedSubscription);
              // setState(() {
              //   Get.find<ItemController>().subscriptionType = type;
              // });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.green[400] : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? Colors.green[400]! : Colors.grey[300]!,
                ),
              ),
              child: Center(
                child: Text(
                  type,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _buildDateSection() {
    return GetBuilder<ItemController>(
        builder: (itemController) {
        return Column(
          children: [
            _buildDateField('Start Date', itemController.startDate, (date) {
              itemController.setstartDate(selectStartDate: date);

            }),
            SizedBox(height: 16),
            _buildDateField('End Date', itemController.endDate, (date) {
              itemController.setendDate(selectEndTime: date);
            }),
          ],
        );
      }
    );
  }

  Widget _buildDateField(String label, DateTime? selectedDate, Function(DateTime) onDateSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),
            );
            if (picked != null) {
              onDateSelected(picked);
            }
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate != null
                      ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                      : 'Choose ${label.toLowerCase()}',
                  style: TextStyle(
                    color: selectedDate != null ? Colors.black : Colors.grey[500],
                    fontSize: 16,
                  ),
                ),
                Icon(Icons.calendar_today, color: Colors.grey[400], size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSection() {
    return GetBuilder<ItemController>(
      builder: (itemController) {
        // list of slots
        final slotList = [
          {
            'start': TimeOfDay(hour: 6, minute: 0),
            'end': TimeOfDay(hour: 9, minute: 0),
          },
          {
            'start': TimeOfDay(hour: 9, minute: 0),
            'end': TimeOfDay(hour: 12, minute: 0),
          },
          {
            'start': TimeOfDay(hour: 12, minute: 0),
            'end': TimeOfDay(hour: 15, minute: 0),
          },
        ];

        // create formatted slot values
        final slotValues = slotList
            .map((s) =>
        '${(s['start'] as TimeOfDay).format(Get.context!)} - ${(s['end'] as TimeOfDay).format(Get.context!)}')
            .toList();

        // default = first slot (6–9)
        String defaultValue = slotValues.first;

        // controller ke value
        String currentValue =
            '${itemController.startTime.format(Get.context!)} - ${itemController.endTime.format(Get.context!)}';

        // agar currentValue slotValues me nahi hai to fallback default
        String selectedValue =
        slotValues.contains(currentValue) ? currentValue : defaultValue;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scheduled Time',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedValue, // 👈 safe value
                  items: slotList.map((slot) {
                    final start = slot['start'] as TimeOfDay;
                    final end = slot['end'] as TimeOfDay;
                    final label =
                        '${start.format(Get.context!)} - ${end.format(Get.context!)}';
                    return DropdownMenuItem<String>(
                      value: label,
                      child: Text(
                        label,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (selectedValue) {
                    if (selectedValue != null) {
                      final parts = selectedValue.split(' - ');
                      final startLabel = parts[0];
                      final endLabel = parts[1];

                      // map labels back to TimeOfDay
                      final slots = {
                        '6:00 AM': TimeOfDay(hour: 6, minute: 0),
                        '9:00 AM': TimeOfDay(hour: 9, minute: 0),
                        '12:00 PM': TimeOfDay(hour: 12, minute: 0),
                        '3:00 PM': TimeOfDay(hour: 15, minute: 0),
                      };

                      itemController.setSheduleTime(
                        selectStartTime: slots[startLabel]!,
                        selectEndTime: slots[endLabel]!,
                      );
                    }
                  },
                  icon: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.access_time,
                        color: Colors.white, size: 16),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDaysSection() {

    return GetBuilder<ItemController>(
      builder: (itemController) {

        if (itemController.selectedSubscription != 'Weekly') {
          return SizedBox.shrink(); // Returns an empty widget
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Days',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(7, (index) {
                String day = itemController.weekDays[index];
                String fullDay = itemController.weekDaysFull[index];
                bool isSelected = itemController.selectedDays.contains(fullDay);


                return GestureDetector(
                  onTap: () {
                    setState(() {
                      itemController.setSelectedDays(index: index);
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green[400] : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.green[400]! : Colors.grey[300]!,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        );
      }
    );
  }
}
