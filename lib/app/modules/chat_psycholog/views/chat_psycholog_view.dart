import 'package:consulin_mobile_dev/widgets/ui/loading_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import '../controllers/chat_psycholog_controller.dart';

class ChatPsychologView extends GetView<ChatPsychologController> {
  const ChatPsychologView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        scaffoldBackgroundColor: const Color(0xffF5F5F7),
      ),
      builder: (context, child) => StreamChat(
        client: controller.client,
        child: child,
      ),
      home: Obx(() {
        return controller.isLoading.value
            ? const LoadingCustom()
            : Scaffold(
                appBar: AppBar(
                  title: const Text('Chat Room'),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                body: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ChannelListPage(),
                ),
              );
      }),
    );
  }
}

class ChannelListPage extends StatefulWidget {
  const ChannelListPage({
    super.key,
  });

  @override
  State<ChannelListPage> createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {
  late final _listController = StreamChannelListController(
    client: StreamChat.of(context).client,
    filter: Filter.in_(
      'members',
      [StreamChat.of(context).currentUser!.id],
    ),
    channelStateSort: const [SortOption('last_message_at')],
    limit: 20,
  );

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamChannelListView(
      controller: _listController,
      loadingBuilder: (context) => const LoadingCustom(),
      onChannelTap: (channel) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return StreamChannel(
                channel: channel,
                child: const ChannelPage(),
              );
            },
          ),
        );
      },
    );
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: StreamChannelHeader(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamMessageListView(), // Menampilkan daftar pesan
          ),
          StreamMessageInput(), // Input untuk mengirim pesan
        ],
      ),
    );
  }
}
