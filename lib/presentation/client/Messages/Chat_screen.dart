import 'package:flutter/material.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';

import 'package:kolshy_app/presentation/shared/widgets/bottom_nav_bar.dart';
import 'package:kolshy_app/presentation/shared/Search/SearchPage.dart';
import 'package:kolshy_app/presentation/client/cart/ShoppingCartPage.dart';
import '../../shared/home/home_screen.dart';
import '../../shared/settings/Settings_screen.dart';
import '../notifications/notification_screen.dart';


// Message data model
class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];
  final Color primaryColor = const Color(0xFFE51742);

  // State to control preset buttons visibility
  bool _showPresetButtons = true;
  late int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
    // Add an initial greeting from the chatbot
    _messages.add(
      Message(text: "Hello! How can I help you today?", isUser: false),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage([String? messageText]) async {
    String userMessage = messageText ?? _messageController.text.trim();
    if (userMessage.isEmpty) return;

    // Add user message to the chat list
    setState(() {
      _messages.add(Message(text: userMessage, isUser: true));
      _showPresetButtons = false; // Hide buttons after first message
    });
    _messageController.clear();
    _scrollToEnd();

    // Simulate a typing delay before the chatbot responds
    await Future.delayed(const Duration(milliseconds: 1000));

    // Get the chatbot's response
    String chatbotResponse = _getChatbotResponse(userMessage);

    // Add the chatbot's response to the chat list
    setState(() {
      _messages.add(Message(text: chatbotResponse, isUser: false));
    });
    _scrollToEnd();
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  String _getChatbotResponse(String userMessage) {
    String lowerCaseMessage = userMessage.toLowerCase();
    if (lowerCaseMessage.contains('faster delivery')) {
      return "I've forwarded your request for faster delivery to our logistics team. We will notify you of the status shortly.";
    } else if (lowerCaseMessage.contains('product issue')) {
      return "I'm sorry to hear you're having an issue with your product. Could you please provide your order number and a brief description of the problem?";
    } else if (lowerCaseMessage.contains('hello') || lowerCaseMessage.contains('hi')) {
      return "Hi there! How can I assist you?";
    } else if (lowerCaseMessage.contains('thanks') || lowerCaseMessage.contains('thank you')) {
      return "You're welcome! Is there anything else I can help with?";
    }
    return "I'm sorry, I didn't understand that. Could you please rephrase your question?";
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          if (index != _selectedIndex) {
            setState(() => _selectedIndex = index);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => getScreenForTab(index)),
            );
          }
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            // This will replace the current screen with the HomeScreen,
            // effectively navigating 'back' to it.
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        title: Text(
          localizations.messages,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                  message: _messages[index],
                  primaryColor: primaryColor,
                );
              },
            ),
          ),
          if (_showPresetButtons)
            _buildPresetOptions(localizations),
          _buildMessageInput(localizations),
        ],
      ),
    );
  }

  // New, modern message input widget
  Widget _buildMessageInput(AppLocalizations localizations) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 1.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: localizations.sendHint,
                hintStyle: TextStyle(color: Colors.grey.shade500),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (text) {
                setState(() {
                  _showPresetButtons = text.isEmpty;
                });
              },
            ),
          ),
          const SizedBox(width: 8),
          _buildIconButton(
            icon: Icons.send,
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildPresetOptions(AppLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          _buildPresetButton(localizations.presetFasterDelivery),
          const SizedBox(height: 8),
          _buildPresetButton(localizations.presetProductIssue),
          const SizedBox(height: 8),
          _buildPresetButton(localizations.presetOther),
        ],
      ),
    );
  }

  Widget _buildPresetButton(String text) {
    return GestureDetector(
      onTap: () {
        _sendMessage(text);
        setState(() {
          _showPresetButtons = false;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: primaryColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}

// Separate MessageBubble widget
class MessageBubble extends StatelessWidget {
  final Message message;
  final Color primaryColor;

  const MessageBubble({
    super.key,
    required this.message,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
        decoration: BoxDecoration(
          color: message.isUser ? primaryColor : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            fontSize: 16,
            color: message.isUser ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}

// Navigation function for the BottomNavBar
Widget getScreenForTab(int index) {
  switch (index) {
    case 0:
      return const HomeScreen();
    case 1:
      return const ShoppingCartPage();
    case 2:
      return const SearchPage();
    case 3:
      return const ChatScreen();
    case 4:
      return const SettingsScreen();
    default:
      return const HomeScreen();
  }
}