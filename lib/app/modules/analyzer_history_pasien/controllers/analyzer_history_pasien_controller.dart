import 'package:get/get.dart';

class AnalyzerHistoryPasienController extends GetxController {

  final String latestAnalyzerResult = '''
I often feel overwhelmed with my daily tasks, and I struggle to find motivation. I have trouble sleeping and frequently feel anxious about upcoming deadlines. Additionally, I sometimes feel sad without any specific reason, making it difficult to enjoy things I once liked.
''';

  final String earlierScanResult = '''
Over the past month, I've experienced significant mood swings. Some days I feel extremely sad without any particular reason, and I lose interest in things I usually enjoy. Other times, I'm irritable and get frustrated easily. These shifts in my mood are affecting my relationships with family and friends, and I'm struggling to manage my emotions. I'm also finding it hard to stay motivated at work.
''';


  final DateTime latestAnalyzerResultDate = DateTime.now(); // Tanggal sekarang
  final DateTime earlierScanResultDate = DateTime.now().subtract(Duration(days: 30)); // Tanggal 30 hari yang lalu

  final double stressProbability = 75.0;
  final double anxietyProbability = 60.0;
  final double depressionProbability = 50.0;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

  }

  @override
  void onClose() {
    super.onClose();
    // Bersihkan resource atau lakukan aksi sebelum controller dihancurkan
  }
}
