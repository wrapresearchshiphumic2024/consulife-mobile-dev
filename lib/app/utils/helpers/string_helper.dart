import 'package:intl/intl.dart';

String formatDate(String date) {
  // Parse the date string into a DateTime object
  DateTime parsedDate = DateTime.parse(date);
  // Format the date to "dd MMM yyyy"
  return DateFormat('dd MMM yyyy').format(parsedDate);
}

String getSpecializationString(List<String>? specialization) {
  if (specialization == null || specialization.isEmpty) {
    return '';
  } else if (specialization.length == 1) {
    return specialization[0]; // Jika hanya ada satu spesialisasi
  } else {
    // Gabungkan semua elemen dengan koma, kecuali yang terakhir, yang dihubungkan dengan "and"
    String allButLast =
        specialization.sublist(0, specialization.length - 1).join(', ');
    String lastItem = specialization.last;
    return '$allButLast and $lastItem';
  }
}
