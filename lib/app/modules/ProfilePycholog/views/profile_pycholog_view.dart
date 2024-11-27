import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_pycholog_controller.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';

class ProfilePychologView extends GetView<ProfilePychologController> {
  const ProfilePychologView({super.key});

  @override

  Widget build(BuildContext context) {
    Get.put(ProfilePychologController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: textColor,size: 40),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: textColor,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: textColor),
            onPressed: () {
              Get.toNamed('/notifications');
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'David William',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '123455678810',
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              color: primaryColor ,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.history, color: primaryColor),
                ),
                title: const Text(
                  'Appointment History',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                subtitle: const Text('See your appointment record',style: TextStyle(color: Colors.white, fontSize: 12)),
                trailing: const Icon(Icons.chevron_right, color: Colors.white),
                onTap: () {
                  Get.toNamed(Routes.PSIKOLOG_HISTORY);
                },
              ),
            ),
            const SizedBox(height: 20),

            Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.person, color: textColor),
                    ),
                    title: const Text(
                      'Personal Information',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: const Text('Edit your information',style: TextStyle(color: textColor, fontSize: 12)),
                    trailing: const Icon(Icons.chevron_right, color: textColor),
                    onTap: () {
                      Get.toNamed(Routes.PSIKOLOG_PER_INFO);
                    },
                  ),
                  const SizedBox(height: 20),

                  ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.business_center, color: textColor),
                    ),
                    title: const Text(
                      'Professional Details',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: const Text('Edit professional details'),
                    trailing: const Icon(Icons.chevron_right, color: textColor),
                    onTap: () {
                      Get.toNamed(Routes.PSIKOLOG_PRO_DET);
                    },
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.password, color: textColor),
                    ),
                    title: const Text(
                      'Change Password',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: const Text('Change your password'),
                    trailing: const Icon(Icons.chevron_right, color: textColor),
                    onTap: () {
                      Get.toNamed(Routes.PSIKOLOG_CHA_PASS);
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {

                controller.cancel(context);
              },
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
