import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/psycholog_controller.dart';

class PsychologView extends GetView<PsychologController> {
  const PsychologView({super.key});

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
          'Psychologist',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => controller.filterPsychologists(name: value),
              decoration: InputDecoration(
                hintText: 'Search psychologist by name',
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.filterPsychologists(gender: 'Male');
                      },
                      child: const Text(
                        'Male',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        controller.filterPsychologists(gender: 'Female');
                      },
                      child: const Text(
                        'Female',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.filterPsychologists(status: 'Available');
                      },
                      child: const Text(
                        'Available',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.filterPsychologists(status: 'Full Booked');
                      },
                      child: const Text(
                        'Full Booked',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),

          Expanded(
            child: Obx(
                  () {
                return ListView.builder(
                  itemCount: controller.filteredPsychologists.length,
                  itemBuilder: (context, index) {
                    final psychologist = controller.filteredPsychologists[index];
                    return PsychologistCard(
                      psychologist: psychologist,
                      onTap: () => controller.goToDetails(psychologist),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PsychologistCard extends StatelessWidget {
  final Psychologist psychologist;
  final VoidCallback onTap;

  const PsychologistCard({
    super.key,
    required this.psychologist,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: carddetail,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0), // Padding hanya di sisi kiri
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/pikolog.png',
                            width: 80,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              psychologist.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(psychologist.specialty),
                            const SizedBox(height: 8.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 12.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.2),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        psychologist.gender == 'Male'
                                            ? Icons.male
                                            : Icons.female,
                                        size: 12,
                                        color: textColor,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        psychologist.gender,
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 7.0,
                                    horizontal: 12.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.orange.withOpacity(0.2),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                        size: 16,
                                        color: textColor,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        '7 years',
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                color: psychologist.status == 'Available'
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text(
                                psychologist.status,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                RotatedBox(
                  quarterTurns: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Details',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
