import 'package:flutter/foundation.dart';
import '../models/chat_model.dart';

class ChatProvider with ChangeNotifier {
  // Key: conversationId (leadId or userId), Value: List of messages
  final Map<String, List<ChatMessage>> _chats = {};

  // Get chat messages for a specific conversation
  List<ChatMessage> getChat(String conversationId) {
    return _chats[conversationId] ?? [];
  }

  // Send a new message to a conversation
  void sendMessage(String conversationId, ChatMessage message) {
    if (!_chats.containsKey(conversationId)) {
      _chats[conversationId] = [];
    }
    _chats[conversationId]!.add(message);
    notifyListeners();
  }

  // Initialize mock chat data for testing/demo
  void initializeMockChat(String conversationId) {
    if (!_chats.containsKey(conversationId)) {
      _chats[conversationId] = List.from(ChatMessage.mockChat);
      notifyListeners();
    }
  }

  // Clear all messages in a conversation
  void clearChat(String conversationId) {
    if (_chats.containsKey(conversationId)) {
      _chats[conversationId]!.clear();
      notifyListeners();
    }
  }

  // Get last message for a conversation (useful for chat list preview)
  ChatMessage? getLastMessage(String conversationId) {
    final messages = _chats[conversationId];
    return messages != null && messages.isNotEmpty ? messages.last : null;
  }

  // Get unread count for a conversation (optional enhancement)
  int getUnreadCount(String conversationId, String currentUser) {
    final messages = _chats[conversationId];
    if (messages == null || messages.isEmpty) return 0;

    final unreadMessages = messages.where((msg) {
      final isFromOtherUser = msg.sender != currentUser;
      final isRecent = msg.timestamp.isAfter(
        DateTime.now().subtract(const Duration(days: 1)),
      );
      return isFromOtherUser && isRecent;
    });

    return unreadMessages.length;
  }
}