import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';
import 'package:consulin_mobile_dev/widgets/ui/custom_elevated_button.dart';
import 'package:consulin_mobile_dev/widgets/ui/manage-day.dart';
import 'package:consulin_mobile_dev/widgets/ui/manage-time.dart';
import 'package:consulin_mobile_dev/widgets/ui/schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/manage_schedule_controller.dart';

class ManageScheduleView extends GetView<ManageScheduleController> {
  const ManageScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              _buildScheduleCards(height),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    _buildChooseDaySection(),
                    const SizedBox(height: 10),
                    ManageDay(
                      value: controller.selectedDays,
                      onChange: controller.onSelectedDay,
                      disabled: true,
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
                      disabled: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomElevatedButton(
                        primaryColor: primaryColor,
                        onPressed: () {
                          Get.toNamed(Routes.EDIT_SCHEDULE);
                        },
                        buttonText: "Edit Schedule"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Schedule Overview",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            const Text("Schedule Active"),
            Obx(() {
              return Switch(
                focusColor: primaryColor,
                activeColor: primaryColor,
                inactiveThumbColor: primaryColor.withOpacity(0.5),
                value: controller.isOpenAppointment.value,
                onChanged: controller.onChanged,
              );
            }),
          ],
        ),
      ],
    );
  }

  SizedBox _buildScheduleCards(double height) {
    return SizedBox(
      height: height / 6,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const ScheduleCard(title: "Monday", time: "10:00 - 11:00");
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 15);
        },
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
