class ChatMessage {
  final String id;
  final String sender; // "provider" or "lead_provider"
  final String text;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.sender,
    required this.text,
    required this.timestamp,
  });

  // Constructor with optional id (generates one if not provided)
  factory ChatMessage.create({
    String? id,
    required String sender,
    required String text,
    DateTime? timestamp,
  }) {
    return ChatMessage(
      id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      sender: sender,
      text: text,
      timestamp: timestamp ?? DateTime.now(),
    );
  }

  // Convert JSON to ChatMessage
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      sender: json['sender'] as String,
      text: json['text'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  // Convert ChatMessage to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Mock chat data
  static List<ChatMessage> mockChat = [
    ChatMessage.create(
      sender: "provider",
      text: "Hi, I'm interested in your lead",
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
    ChatMessage.create(
      sender: "lead_provider",
      text: "Great! Let's discuss the details",
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    ChatMessage.create(
      sender: "provider",
      text: "I can offer my services for \$2000",
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    ChatMessage.create(
      sender: "lead_provider",
      text: "That works for me. Let's proceed!",
      timestamp: DateTime.now(),
    ),
  ];

  // Copy with method for immutability
  ChatMessage copyWith({
    String? id,
    String? sender,
    String? text,
    DateTime? timestamp,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}