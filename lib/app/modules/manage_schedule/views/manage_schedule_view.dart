import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/widgets/ui/schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/manage_schedule_controller.dart';

class ManageScheduleView extends GetView<ManageScheduleController> {
  const ManageScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                            onChanged: (value) {
                              controller.onChanged(value);
                            },
                          );
                        }),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                    height: 5), // Menambahkan jarak antara header dan list
                SizedBox(
                  height: height / 6, // Menentukan tinggi untuk ListView
                  child: ListView.separated(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return const ScheduleCard(
                          title: "Monday", time: "10:00 - 11:00");
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 15,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    const Text(
                      "Choose Day",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("(can multiple select)"),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
