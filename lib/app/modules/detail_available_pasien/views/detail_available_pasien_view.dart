import 'package:consulin_mobile_dev/widgets/ui/loading_custom.dart';
import 'package:consulin_mobile_dev/widgets/ui/manage-time.dart';
import 'package:consulin_mobile_dev/widgets/ui/refresh_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_available_pasien_controller.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:consulin_mobile_dev/widgets/ui/custom_elevated_button.dart';

const double defaultPadding = 16.0;
const TextStyle specialtyTextStyle = TextStyle(
  color: Colors.blue,
  fontWeight: FontWeight.bold,
  fontSize: 10,
);

class DetailAvailablePasienView
    extends GetView<DetailAvailablePasienController> {
  const DetailAvailablePasienView({super.key});

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
      body: Obx(() {
        return controller.isLoading.value
            ? const LoadingCustom()
            : CustomRefreshIndicator(
                onRefresh: () async {
                  await controller.getDetailPsychologistPatient(Get.arguments);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
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
                                  '${controller.detailPsychologist.value.firstname.capitalizeFirst!}  ${controller.detailPsychologist.value.lastname.capitalizeFirst!}',
                                  style: const TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    const Icon(Icons.email_outlined,
                                        size: 16.0),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      controller.detailPsychologist.value.email
                                          .toString(),
                                      style: const TextStyle(color: textColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    const Icon(Icons.work_outline_rounded,
                                        size: 16.0),
                                    const SizedBox(width: 4.0),
                                    Text(
                                        controller.detailPsychologist.value
                                            .psychologist!.workExperience
                                            .toString(),
                                        style:
                                            const TextStyle(color: textColor)),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Icon(
                                        controller.detailPsychologist.value
                                                    .gender
                                                    .toString() ==
                                                'Male'
                                            ? Icons.male
                                            : Icons.female,
                                        size: 16.0),
                                    const SizedBox(width: 4.0),
                                    Text(
                                        controller
                                            .detailPsychologist.value.gender
                                            .toString(),
                                        style:
                                            const TextStyle(color: textColor)),
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
                            // Menampilkan spesialisasi secara dinamis menggunakan Wrap
                            Obx(() {
                              List<String>? specializations = controller
                                  .detailPsychologist
                                  .value
                                  .psychologist
                                  ?.specialization;

                              if (specializations == null ||
                                  specializations.isEmpty) {
                                return const Center(
                                    child:
                                        Text('No specializations available'));
                              }

                              return Wrap(
                                spacing: 2.0, // Jarak horizontal antar kartu
                                runSpacing: 2.0, // Jarak vertical antar baris
                                alignment: WrapAlignment.start,
                                children: specializations.map((specialization) {
                                  return Card(
                                    color: carddetail,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        specialization,
                                        style: const TextStyle(
                                          color: textColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Schedule',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Obx(() => GestureDetector(
                              onTap: () {
                                controller.toggleCalendar();
                              },
                              child: Card(
                                color: carddetail,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.selectedDate.value == null
                                            ? 'Pick a date'
                                            : controller.formatDate(
                                                controller.selectedDate.value!),
                                        style: const TextStyle(
                                            color: textColor, fontSize: 16),
                                      ),
                                      const Icon(Icons.calendar_today,
                                          color: textColor),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        Obx(() => controller.isCalendarVisible.value
                            ? SizedBox(
                                height: 350,
                                child: TableCalendar(
                                  firstDay: DateTime.now(),
                                  lastDay: DateTime.now().add(const Duration(
                                      days:
                                          7)), // Batasi hanya untuk seminggu ke depan
                                  focusedDay: controller.focusedDay.value,
                                  selectedDayPredicate: (day) => isSameDay(
                                      controller.selectedDate.value, day),
                                  enabledDayPredicate: (day) {
                                    // Mendapatkan hari aktif dari controller
                                    List<int> activeDays =
                                        controller.mapDaysToIndices(
                                      controller.detailPsychologist.value
                                              .psychologist?.schedule?.days
                                              .map((e) => e
                                                  .day) // Ambil nama hari dari data
                                              .toList() ??
                                          [],
                                    );

                                    return activeDays.contains(day.weekday) &&
                                        day.isAfter(DateTime.now().subtract(
                                            const Duration(days: 1))) &&
                                        day.isBefore(DateTime.now().add(
                                            const Duration(
                                                days:
                                                    8))); // Pastikan hanya dalam 7 hari ke depan
                                  },
                                  onDaySelected: (selectedDay, focusedDay) {
                                    controller.selectDate(selectedDay);
                                  },
                                  calendarStyle: const CalendarStyle(
                                    selectedDecoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox()),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Time',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        ManageTime(
                          isSingleSelect: true,
                          onChange: controller.onSelectedTime,
                          value: controller.selectedTime2,
                          times: controller.detailPsychologist.value
                              .psychologist!.schedule?.days[0].times,
                          disabled: false,
                        ),
                        const SizedBox(height: 16.0),
                        CustomElevatedButton(
                          primaryColor:
                              (controller.selectedDate.value != null &&
                                      controller.selectedTime2.isNotEmpty)
                                  ? primaryColor
                                  : carddetail,
                          onPressed: (controller.selectedDate.value != null &&
                                  controller.selectedTime2.isNotEmpty)
                              ? () => controller.bookAppointment(context)
                              : () {
                                  controller.showToast(
                                      "Please select a date and time",
                                      backgroundColor: warningColor);
                                },
                          buttonText: "Book Appointment",
                        )
                      ],
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
