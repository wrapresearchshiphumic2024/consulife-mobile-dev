import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AiAnalyzerPasienController extends GetxController {
  // Map untuk terjemahan
  final Map<String, Map<String, String>> translations = {
    'English': {
      'title': 'Health Mental Analyzer',
      'hint_text': 'Tell us about your current mental state...',
      'analyze_button': 'Analyze',
      'cancel_button': 'Cancel',
      'analysis_results': 'Analysis Results',
      'result_placeholder': 'Your result will appear here',
      'stress_probability': 'Probability of Stress',
      'anxiety_probability': 'Probability of Anxiety',
      'depression_probability': 'Probability of Depression',
    },
    'Indonesian': {
      'title': 'Analisis Kesehatan Mental',
      'hint_text': 'Ceritakan kondisi mental Anda saat ini...',
      'analyze_button': 'Analisis',
      'cancel_button': 'Batal',
      'analysis_results': 'Hasil Analisis',
      'result_placeholder': 'Hasil Anda akan muncul di sini',
      'stress_probability': 'Probabilitas Stres',
      'anxiety_probability': 'Probabilitas Kecemasan',
      'depression_probability': 'Probabilitas Depresi',
    }
  };

  // Variabel untuk bahasa
  final currentLanguage = 'English'.obs;

  // Variabel untuk TextController dan status tombol
  final textController = TextEditingController();
  final isAnalyzeEnabled = false.obs;
  final isResultAvailable = false.obs;

  // Data hasil analisis
  final stressProbability = 0.obs;
  final anxietyProbability = 0.obs;
  final depressionProbability = 0.obs;
  String lastAnalyzed = '';

  // Metode untuk mendapatkan teks sesuai bahasa
  String translate(String key) {
    return translations[currentLanguage.value]?[key] ?? key;
  }

  // Mengubah bahasa
  void changeLanguage(String language) {
    currentLanguage.value = language;
  }

  // Validasi input untuk mengaktifkan tombol Analyze
  void validateInput() {
    isAnalyzeEnabled.value = textController.text.trim().isNotEmpty;
  }

  // Fungsi untuk membersihkan input dan reset status
  void clearInput() {
    textController.clear();
    isAnalyzeEnabled.value = false;
    isResultAvailable.value = false;
  }

  // Fungsi untuk melakukan analisis (simulasi)
  void analyze() {
    // Simulasi hasil analisis
    stressProbability.value = 65;
    anxietyProbability.value = 40;
    depressionProbability.value = 70;
    lastAnalyzed = '01 Nov 2024';

    isResultAvailable.value = true;
  }

  // Mengambil data untuk chart
  Map<String, double> getChartData() {
    return {
      'Stress': stressProbability.value.toDouble(),
      'Anxiety': anxietyProbability.value.toDouble(),
      'Depression': depressionProbability.value.toDouble(),
    };
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}