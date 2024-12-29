import 'package:consulin_mobile_dev/widgets/ui/refresh_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../controllers/profile_pasien_controller.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';

class ProfilePasienView extends GetView<ProfilePasienController> {
  const ProfilePasienView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfilePasienController());
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return controller.isLoading.value
              ? Center(
                  child: LoadingAnimationWidget.progressiveDots(
                    color: Colors.black,
                    size: 50,
                  ),
                )
              : CustomRefreshIndicator(
                  onRefresh: () async {
                    await controller.fetchPsychologistProfile();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey[200],
                                child: const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                '${controller.profile.value.firstname.capitalizeFirst} ${controller.profile.value.lastname.capitalizeFirst}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                controller.profile.value.phoneNumber.toString(),
                                style: const TextStyle(
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          color: primaryColor,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
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
                              child: const Icon(Icons.history,
                                  color: primaryColor),
                            ),
                            title: const Text(
                              'Appointment History',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: const Text('See your appointment record',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                            trailing: const Icon(Icons.chevron_right,
                                color: Colors.white),
                            onTap: () {
                              Get.toNamed(Routes.HISTORY_PASIEN);
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
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
                                  child: const Icon(Icons.person,
                                      color: textColor),
                                ),
                                title: const Text(
                                  'Personal Information',
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: const Text('Edit your information',
                                    style: TextStyle(
                                        color: textColor, fontSize: 12)),
                                trailing: const Icon(Icons.chevron_right,
                                    color: textColor),
                                onTap: () {
                                  Get.toNamed(
                                      Routes.PERSONAL_INFORMATION_PASIEN);
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
                                  child: const Icon(Icons.password,
                                      color: textColor),
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
                                trailing: const Icon(Icons.chevron_right,
                                    color: textColor),
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
        }),
      ),
    );
  }
}
