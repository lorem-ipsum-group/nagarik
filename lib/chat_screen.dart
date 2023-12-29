import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:nagarik/main.dart';
import 'package:nagarik/message.dart';
import 'package:nagarik/my_colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Message> msgs = [];
  bool isTyping = false;

  void sendMsg() async {
    String text = controller.text;
    controller.clear();

    try {
      if (text.isNotEmpty) {
        setState(() {
          msgs.insert(0, Message(true, text));
          isTyping = true;
        });
        scrollController.animateTo(0.0,
            duration: const Duration(seconds: 1), curve: Curves.easeOut);

        var response = await http.post(
          Uri.parse("https://nagarik-chatbot-api.onrender.com/v1/chat"),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "input": text,
          }),
        );

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          if (jsonResponse.containsKey("answer")) {
            setState(() {
              isTyping = false;
              msgs.insert(
                0,
                Message(
                  false,
                  jsonResponse["answer"].toString().trimLeft(),
                ),
              );
            });
            scrollController.animateTo(0.0,
                duration: const Duration(seconds: 1), curve: Curves.easeOut);
          } else {
            print("Unexpected response format: $jsonResponse");
          }
        } else {
          print("HTTP Request failed with status: ${response.statusCode}");
        }
      }
    } catch (e) {
      print("Error during HTTP request: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Some error occurred, please try again!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pastel, // Replace with your color
        title: const Text("Live Chat", style: TextStyle(color: red, fontWeight: FontWeight.w400),),
        toolbarHeight: 50,
        leading: IconButton(
          onPressed: () {
            // Navigate back to the home page
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => const Root()));
          },
          icon: const Icon(Icons.arrow_back, size: 34,color: red,),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: msgs.length,
              shrinkWrap: true,
              reverse: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: isTyping && index == 0
                      ? Column(
                          children: [
                            BubbleNormal(
                              text: msgs[0].msg,
                              textStyle: const TextStyle(color:white),
                              isSender: true,
                              color: blue,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 16, top: 4),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Typing...", style: TextStyle(color: fadedRed),),
                              ),
                            )
                          ],
                        )
                      : BubbleNormal(
                          text: msgs[index].msg,
                          textStyle: const TextStyle(color:white),
                          isSender: msgs[index].isSender,
                          color: msgs[index].isSender
                              ? blue
                              : red,
                        ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        controller: controller,
                        textCapitalization: TextCapitalization.sentences,
                        onSubmitted: (value) {
                          sendMsg();
                        },
                        textInputAction: TextInputAction.send,
                        showCursor: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter text",
                          hintStyle: TextStyle(color: lightGrey)
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  sendMsg();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.send,
                    color: white,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
