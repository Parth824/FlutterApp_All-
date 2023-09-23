import 'package:chartgpt/chatmessage.dart';
import 'package:chartgpt/threedont.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:velocity_x/velocity_x.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  TextEditingController textEditingController = TextEditingController();
  List<ChatMessage> messgae = [];
  late OpenAI? chatGPT;

  bool _isImageSearch = false;

  bool _isTyping = false;

  @override
  void initState() {
    // TODO: implement initState
    chatGPT = OpenAI.instance.build(
      token: "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",
      baseOption: HttpSetup(
        receiveTimeout: Duration(milliseconds: 60000),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    chatGPT?.close();
    chatGPT?.genImgClose();
    super.dispose();
  }

  void _sendMessage() async {
    if (textEditingController.text.isEmpty) return;
    ChatMessage _message = ChatMessage(
      text: textEditingController.text,
      sender: "user",
      isImage: false,
    );

    setState(() {
      messgae.insert(0, _message);
      _isTyping = true;
    });

    textEditingController.clear();

    if (_isImageSearch) {
      final request = GenerateImage(_message.text, 1, size: "256x256");

      final response = await chatGPT!.generateImage(request);
      Vx.log(response!.data!.last!.url!);
      insertNewData(response.data!.last!.url!, isImage: true);
    } else {
      final request =
          CompleteText(prompt: _message.text, model: "kTranslateModelV3");

      final response = await chatGPT!.onCompletion(request: request);
      Vx.log(response!.choices[0].text);
      insertNewData(response.choices[0].text, isImage: false);
    }
  }

  void insertNewData(String response, {bool isImage = false}) {
    ChatMessage botMessage = ChatMessage(
      text: response,
      sender: "bot",
      isImage: isImage,
    );

    setState(() {
      _isTyping = false;
      messgae.insert(0, botMessage);
    });
  }

  Widget _buildTextComposet() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration.collapsed(hintText: "Send a message"),
          ),
        ),
        ButtonBar(
          children: [
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                _isImageSearch = false;
                _sendMessage();
              },
            ),
            TextButton(
                onPressed: () {
                  _isImageSearch = true;
                  _sendMessage();
                },
                child: const Text("Generate Image"))
          ],
        ),
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChatGPT App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              reverse: true,
              padding: Vx.m8,
              itemCount: messgae.length,
              itemBuilder: (context, index) {
                return messgae[index];
              },
            ),
          ),
          if (_isTyping) const ThreeDots(),
          const Divider(
            height: 1.0,
          ),
          Container(
            decoration: BoxDecoration(
              color: context.cardColor,
            ),
            child: _buildTextComposet(),
          ),
        ],
      ),
    );
  }
}
