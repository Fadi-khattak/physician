import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:physician/main.dart';
class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: APP_ID,
      channelName: "physician",
      tempToken: Token
    ),
    enabledPermission: [
      Permission.camera,
      Permission.microphone,
    ],
  );

  @override
  void initState() {
    super.initState();
    initAgora();
  }



  void initAgora() async {
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffCDE0C9),
          title: const Text('Video Call',style: TextStyle(color: Colors.black),),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: client,
              ),
              AgoraVideoButtons(
                client: client,
              ),
            ],
          ),
        ),
      );
  }
}