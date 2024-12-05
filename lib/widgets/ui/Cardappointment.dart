import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';

class AppointmentCard extends StatelessWidget {
  final String name;
  final String time;
  final String status;
  final String details;

  const AppointmentCard({
    super.key,
    required this.name,
    required this.time,
    required this.status,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = status == "Canceled" ? warningColor : successColor;
    final String route = status == "Canceled"
        ? Routes.DETAIL_CANCEL_PASIEN
        : Routes.DETAIL_ONGOING_PASIEN;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: carddetail,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(Icons.person, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 8.0),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Name: $name",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Time: $time",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 35.0),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    status == "Canceled" ? "Canceled" : "On-going",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(route);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      "Detail",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
