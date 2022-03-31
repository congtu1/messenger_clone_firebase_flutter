
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger_clone/presentation/chat_detail/chatdetail_viewmodel/chatdetail_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

class ChatInputField extends StatefulWidget {
  ChatInputField({Key? key}) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            IconButton(
              color: const Color(0xFF00BF6D),
              onPressed: () async {
                // final XFile? pickFile = await _picker.pickImage(source: ImageSource.gallery);
                // final String fileName = path.basename(pickFile!.path);
                // File imageFile = File(pickFile.path);
                // chatViewModel.sendImage(context, imageFile, fileName);
              },
              icon: const Icon(Icons.attach_file),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20 * 0.75,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF00BF6D).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),
                    const SizedBox(width: 20 / 4),
                    Expanded(
                      child: buildTextField(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(
                Icons.send,
                size: 30,
              ),
              color: Colors.green.withOpacity(0.64),
              onPressed: () async {
               context.read<ChatDetailViewModel>().sendMessage();
               _editingController.clear();
                // clearInput();
                // toMax(chatViewModel);
                // setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

   buildTextField() {
    return Consumer<ChatDetailViewModel>(
      builder: (context, value, child) {
        return TextField(
          controller: _editingController,
          onTap: () async {
            if(value.getMessageStream != const Stream.empty()) {
              value.scrollToMax();
              setState(() {});
            }
          },
          onChanged: (text) {
            value.chatFieldInputChange(text);
          },
          decoration: const InputDecoration(
            hintText: "Type message",
            border: InputBorder.none,
          ),

        );
      },
    );
  }


}
