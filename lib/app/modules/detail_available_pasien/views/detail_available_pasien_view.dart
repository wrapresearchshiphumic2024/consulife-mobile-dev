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

class DetailAvailablePasienView extends GetView<DetailAvailablePasienController> {
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
      body: SingleChildScrollView(
        child: Padding(
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
                          Text('marjo@woho.id', style: TextStyle(color: textColor)),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: const [
                          Icon(Icons.work_outline_rounded, size: 16.0),
                          SizedBox(width: 4.0),
                          Text('7 years', style: TextStyle(color: textColor)),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: const [
                          Icon(Icons.male, size: 16.0),
                          SizedBox(width: 4.0),
                          Text('Male', style: TextStyle(color: textColor)),
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
                            child: const Text(
                              'Clinical Psychology',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Card(
                          color: carddetail,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: const Text(
                              'Developmental Psychology',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 10,
                              ),
                            ),
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
                            child: const Text(
                              'Educational Psychology',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Card(
                          color: carddetail,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: const Text(
                              'General Psychology',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Card(
                color: primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Available',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
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
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.selectedDate.value == null
                              ? 'Pick a date'
                              : controller.formatDate(controller.selectedDate.value!),
                          style: const TextStyle(color: textColor, fontSize: 16),
                        ),
                        const Icon(Icons.calendar_today, color: textColor),
                      ],
                    ),
                  ),
                ),
              )),
              Obx(() => controller.isCalendarVisible.value
                  ? Container(
                height: 350,
                child: TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(const Duration(days: 365)),
                  focusedDay: controller.focusedDay.value,
                  selectedDayPredicate: (day) => isSameDay(controller.selectedDate.value, day),
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
              Obx(() => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 2.5,
                ),
                itemCount: controller.availableTimes.length,
                itemBuilder: (context, index) {
                  final time = controller.availableTimes[index];
                  final isSelected = controller.selectedTime.value == time;
                  return GestureDetector(
                    onTap: () {
                      controller.selectTime(time);
                    },
                    child: Card(
                      color: isSelected ? primaryColor : carddetail,
                      child: Center(
                        child: Text(
                          time,
                          style: TextStyle(
                            color: isSelected ? Colors.white : textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )),
              const SizedBox(height: 16.0),
              CustomElevatedButton(
                primaryColor: (controller.selectedDate.value != null && controller.selectedTime.isNotEmpty)
                    ? primaryColor
                    : carddetail,
                onPressed: (controller.selectedDate.value != null && controller.selectedTime.isNotEmpty)
                    ? () => controller.BookAppointment(context)
                    : () {
                  controller.showToast("Please select a date and time", backgroundColor: warningColor);
                },
                buttonText: "Book Appointment",
              )
            ],
          ),
        ),
      ),
    );
  }
}
