import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/widgets/ui/loading_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../controllers/detail_chat_patient_controller.dart';

class DetailChatPatientView extends GetView<DetailChatPatientController> {
  const DetailChatPatientView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const LoadingCustom();
      }

      return StreamChat(
        client: controller.client,
        child: StreamChannel(
          channel: controller.channel,
          showLoading: true,
          loadingBuilder: (context) => const LoadingCustom(),
          child: const ChannelPage(),
        ),
      );
    });
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StreamChannelHeader(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: textColor, size: 40),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamMessageListView(
              emptyBuilder: (context) =>
                  const Center(child: Text('No messages')),
            ),
          ),
          const StreamMessageInput(),
        ],
      ),
    );
  }
}
