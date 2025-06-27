import '../models/chat_model.dart';

class ChatService {
  // In-memory storage for chats (key: conversationId)
  final Map<String, List<ChatMessage>> _chatStorage = {};

  // Fetch chat messages for a conversation
  Future<List<ChatMessage>> fetchChat(String conversationId) async {
    // Return existing messages if available
    if (_chatStorage.containsKey(conversationId)) {
      return _chatStorage[conversationId]!;
    }

    // Initialize with mock data if first time
    _chatStorage[conversationId] = List.from(ChatMessage.mockChat);
    return _chatStorage[conversationId]!;
  }

  // Send a new message to a conversation
  Future<bool> sendMessage(String conversationId, ChatMessage message) async {
    try {
      // Initialize conversation if doesn't exist
      if (!_chatStorage.containsKey(conversationId)) {
        _chatStorage[conversationId] = [];
      }

      // Add the new message
      _chatStorage[conversationId]!.add(message);

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 300));

      return true; // Success
    } catch (e) {
      return false; // Failure
    }
  }

  // Optional: Clear chat history (for testing)
  Future<void> clearChat(String conversationId) async {
    if (_chatStorage.containsKey(conversationId)) {
      _chatStorage[conversationId]!.clear();
    }
    await Future.delayed(const Duration(milliseconds: 100));
  }
}