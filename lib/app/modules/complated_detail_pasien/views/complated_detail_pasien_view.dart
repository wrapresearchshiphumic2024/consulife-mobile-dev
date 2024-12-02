import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/complated_detail_pasien_controller.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';

const double defaultPadding = 16.0;
const TextStyle specialtyTextStyle = TextStyle(
  color: Colors.blue,
  fontWeight: FontWeight.bold,
  fontSize: 10,
);

class ComplatedDetailPasienView extends GetView<ComplatedDetailPasienController> {
  const ComplatedDetailPasienView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: textColor, size: 40),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Psychologist Detail',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150',
                  ),
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'David Williams',
                      style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: const [
                        Icon(Icons.email_outlined, size: 16.0),
                        SizedBox(width: 4.0),
                        Text('marjo@woho.id',style: TextStyle(color: textColor),),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: const [
                        Icon(Icons.work_outline_rounded, size: 16.0),
                        SizedBox(width: 4.0),
                        Text('7 years',style: TextStyle(color: textColor),),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: const [
                        Icon(Icons.male, size: 16.0),
                        SizedBox(width: 4.0),
                        Text('Male',style: TextStyle(color: textColor),),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Specialties:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Card(
                        color: carddetail,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: const Text('Clinical Psychology', style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                          ),),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Card(
                        color: carddetail,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: const Text('Developmental Psychology', style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                          ),),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Card(
                        color: carddetail,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: const Text('Educational Psychology', style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                          ),),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Card(
                        color: carddetail,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: const Text('General Psychology', style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                          ),),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Card(
              color: textColor,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Completed',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Card(
              color: carddetail,
              margin: EdgeInsets.zero,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Appointment Information',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text('Date: 2024-10-15',style: TextStyle(
                        color: textColor,
                        fontSize: 12,
                      ),),
                      Text('Time: 09 AM',style: TextStyle(
                        color: textColor,
                        fontSize: 12,
                      ),),
                      Text('Status: Cancelled',style: TextStyle(
                        color: textColor,
                        fontSize: 12,
                      ),),
                      Text('Duration: 1 Hour',style: TextStyle(
                        color: textColor,
                        fontSize: 12,
                      ),),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Card(
              color: carddetail,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Note',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'You have success fully completed a consultation session with David Williams. This session is now considered complete.',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 12,
                      ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


