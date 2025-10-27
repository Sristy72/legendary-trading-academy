class CommunityItem {
  final String id;
  final String name;
  final String logo;
  final String lastMessage;
  final String timestamp;
  final bool hasUnread;
  final MessageType messageType;

  CommunityItem({
    required this.id,
    required this.name,
    required this.logo,
    required this.lastMessage,
    required this.timestamp,
    this.hasUnread = false,
    this.messageType = MessageType.text,
  });
}

enum MessageType { text, photo, document, emoji }
