import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/widgets/ui/appointment_card.dart';
import 'package:consulin_mobile_dev/widgets/ui/column_chart.dart';
import 'package:consulin_mobile_dev/widgets/ui/stats_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_psycholog_controller.dart';

class HomePsychologView extends GetView<HomePsychologController> {
  const HomePsychologView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, Vincent",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Text(
                              "Welcome to ",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Consulife",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications)),
                  ],
                ),
                const SizedBox(height: 25),
                const Text(
                  "Your Summary",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: StatsCard(
                        title: "Total Consultation",
                        value: "428",
                        subTitle: "Consultation",
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: StatsCard(
                        title: "Today Session",
                        value: "5",
                        subTitle: "Session",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                const Text(
                  "Monthly Consultations",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 16),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 320, child: ColumnChart()),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Upcoming Appointment",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          fontSize: 16),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "See More",
                          style: TextStyle(
                              color: textColor, fontWeight: FontWeight.w100),
                        )),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    itemCount: controller.upcomingAppointment.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return AppointmentCard(
                        status: controller.upcomingAppointment[index]["status"],
                        name: controller.upcomingAppointment[index]["name"],
                        time: controller.upcomingAppointment[index]["time"],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Appointment History",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          fontSize: 16),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "See More",
                          style: TextStyle(
                              color: textColor, fontWeight: FontWeight.w100),
                        )),
                  ],
                ),
                const SizedBox(height: 10),
                ListView.separated(
                  itemCount: controller.historyAppointment.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return AppointmentCard(
                      status: controller.historyAppointment[index]["status"],
                      name: controller.historyAppointment[index]["name"],
                      time: controller.historyAppointment[index]["time"],
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
