import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String status;
  final String name;
  final String time;

  const AppointmentCard({
    Key? key,
    required this.status,
    required this.name,
    required this.time,
  }) : super(key: key);

  // Fungsi untuk menentukan warna berdasarkan status
  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'waiting':
        return primaryColor; // Sesuaikan dengan warna yang diinginkan
      case 'canceled':
        return Colors.red; // Merah untuk canceled
      case 'completed':
        return Colors.green; // Hijau untuk completed
      default:
        return Colors.grey; // Warna default jika status tidak dikenali
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          RotatedBox(
            quarterTurns: 1, // Rotate by 90 degrees
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: _getStatusColor(), // Gunakan warna berdasarkan status
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(
                status,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
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
          ),
        ],
      ),
    );
  }
}
