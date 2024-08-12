import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatUser currentUser = ChatUser(id: 'user1', firstName: 'You');
  final ChatUser geminiUser = ChatUser(
      id: 'user2', firstName: 'gemini', profileImage: 'asset/images/shoes.jpg');
  final Gemini gemini = Gemini.instance; // Adjust as needed
  List<ChatMessage> messages = []; // Initialize with your initial messages

  void onSend(ChatMessage message) async {
    setState(() {
      messages.add(message);
    });

    try {
      final String question = message.text;

      final contentStream = gemini.streamGenerateContent(question);

      await for (final event in contentStream) {
        final String response = event.content?.parts?.fold(
          "",
              (previous, current) => "$previous ${current.text}",
        ) ??
            "";

        setState(() {
          messages.add(ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          ));
        });
      }
    } catch (error) {
      print('Error generating content from Gemini: $error');
    }
  }

  void sentMediaMessage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      print('Picked image: ${file.path}');
      ChatMessage chatMessage = ChatMessage(
          user: currentUser,
          createdAt: DateTime.now(),
          text: "Describe this picture?",
          medias: [
            ChatMedia(url: file.path, fileName: "", type: MediaType.image)
          ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("GeminiAi",style: TextStyle(color: Colors.black),),),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'asset/images/ai.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Chat interface
          DashChat(
            inputOptions: InputOptions(
              trailing: [
                IconButton(
                  onPressed: sentMediaMessage,
                  icon: const Icon(Icons.image),
                ),
              ],
            ),
            currentUser: currentUser,
            messages: messages,
            onSend: onSend,
          ),
        ],
      ),
    );
  }
}
