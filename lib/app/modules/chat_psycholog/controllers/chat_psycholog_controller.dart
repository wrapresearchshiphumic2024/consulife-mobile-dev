import 'package:consulin_mobile_dev/app/modules/Profile/controllers/profile_pycholog_controller.dart';
import 'package:consulin_mobile_dev/app/utils/storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatPsychologController extends GetxController {
  late StreamChatClient client;
  late Channel channel; // Declare channel without initialization here

  final isLoading = false.obs;

  final ProfilePychologController profilePsychologController =
      Get.find<ProfilePychologController>();

  @override
  void onInit() {
    super.onInit();
    // Initialize the StreamChatClient with the API key from environment variables
    final apiKey = dotenv.env["API_KEY"];
    if (apiKey == null) {
      throw Exception('API_KEY is not set in the environment variables');
    }
    client = StreamChatClient(apiKey, logLevel: Level.INFO);
    connectUser();
  }

  Future<void> connectUser() async {
    isLoading.value = true;
    // Check if profile is initialized
    try {
      final token = await fetchToken(
        StorageService.getToken("user_id").toString(),
        '${profilePsychologController.profile.value.firstname} ${profilePsychologController.profile.value.lastname}',
      );

      // Connect the user to the StreamChatClient
      await client.connectUser(
        User(id: StorageService.getToken("user_id").toString()),
        token,
      );

      // Create or get the channel
      channel = client.channel(
        'messaging',
      ); // Specify the channel ID
      await channel.watch(); // Watch the channel for updates
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> fetchToken(String userId, String name) async {
    print(name);
    final response = await http.post(
      Uri.parse(
          '${dotenv.env["API_CHAT_URL"]}/chat-token'), // Adjust the URL as needed
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': userId, 'name': name}),
    );
    print('userId: $userId');

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch token: ${response.body}');
    }

    final data = jsonDecode(response.body);
    print('User connected to StreamChatClient ${data['token']}');
    return data['token'];
  }
}
