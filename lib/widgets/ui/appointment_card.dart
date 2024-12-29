import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppointmentCard extends StatelessWidget {
  final String status;
  final String name;
  final String time;
  final String id;
  final bool isVertical;
  final bool isPatient;

  const AppointmentCard({
    super.key,
    required this.status,
    required this.name,
    required this.time,
    required this.id,
    required this.isVertical,
    required this.isPatient,
  });

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'waiting':
        return primaryColor;
      case 'ongoing':
        return successColor;
      case 'canceled':
        return Colors.red;
      case 'completed':
        return textColor;
      default:
        return Colors.white;
    }
  }

  void _navigateToDetail(BuildContext context) {
    if (isPatient) {
      Get.toNamed(Routes.DETAIL_COMPLETED_PASIEN, arguments: id);
    } else {
      Get.toNamed(Routes.DETAIL_COMPLETED, arguments: id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context),
      child: Container(
        padding: const EdgeInsets.only(right: 20, left: 0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            RotatedBox(
              quarterTurns: 1,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  color: _getStatusColor(),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  status.capitalizeFirst!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            isVertical
                ? Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name: $name",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor),
                            ),
                            Text(
                              "Time: $time",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor),
                            ),
                          ],
                        ),
                        if (status.toLowerCase() == 'canceled' ||
                            status.toLowerCase() == 'completed')
                          SvgPicture.asset(
                            status.toLowerCase() == 'canceled'
                                ? 'assets/icons/cancel.svg'
                                : 'assets/icons/complate.svg',
                            width: 30,
                            height: 30,
                          ),
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name: $name",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: textColor),
                      ),
                      Text(
                        "Time: $time",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: textColor),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
