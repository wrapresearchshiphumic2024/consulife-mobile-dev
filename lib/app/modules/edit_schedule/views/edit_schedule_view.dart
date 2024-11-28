import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/widgets/ui/button_back.dart';
import 'package:consulin_mobile_dev/widgets/ui/custom_elevated_button.dart';
import 'package:consulin_mobile_dev/widgets/ui/manage-day.dart';
import 'package:consulin_mobile_dev/widgets/ui/manage-time.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_schedule_controller.dart';

class EditScheduleView extends GetView<EditScheduleController> {
  const EditScheduleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ButtonBack(),
            const SizedBox(height: 20),
            _buildChooseDaySection(),
            const SizedBox(height: 10),
            ManageDay(
              value: controller.selectedDays,
              onChange: controller.onSelectedDay,
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Text("Set Available Time Slot",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 5),
                Text("(can multiple select)"),
              ],
            ),
            ManageTime(
              onChange: controller.onSelectedTime,
              value: controller.selectedTime,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomElevatedButton(
                primaryColor: primaryColor,
                onPressed: () {},
                buttonText: "Edit Schedule"),
          ],
        ),
      ),
    );
  }

  Row _buildChooseDaySection() {
    return const Row(
      children: [
        Text("Choose Day", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 5),
        Text("(can multiple select)"),
      ],
    );
  }
}
