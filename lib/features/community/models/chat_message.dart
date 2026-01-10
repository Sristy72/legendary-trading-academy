
class ChatMessage {
  final String? id;
  final String? chatId;
  final Sender? sender;
  final String? content;
  final String? contentType;
  final List<String>? fileUrl;
  final String? createdAt;
  final String? updatedAt;
  final bool? isMe;

  ChatMessage({
    this.id,
    this.chatId,
    this.sender,
    this.content,
    this.contentType,
    this.fileUrl,
    this.createdAt,
    this.updatedAt,
    this.isMe,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['_id'] as String?,
      chatId: json['chatId'] as String?,
      sender: json['sender'] != null
          ? Sender.fromJson(json['sender'] as Map<String, dynamic>)
          : null,
      content: json['content'] as String?,
      contentType: json['contentType'] as String?,
      fileUrl: (json['fileUrl'] as List<dynamic>?)?.map((e) => e as String).toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      isMe: json['isMe'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'chatId': chatId,
      'sender': sender?.toJson(),
      'content': content,
      'contentType': contentType,
      'fileUrl': fileUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isMe': isMe,
    };
  }
}

class Sender {
  final String? id;
  final String? name;
  final String? email;
  final String? username;
  final Avatar? avatar;

  Sender({
    this.id,
    this.name,
    this.email,
    this.username,
    this.avatar,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      avatar: json['avatar'] != null
          ? Avatar.fromJson(json['avatar'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'username': username,
      'avatar': avatar?.toJson(),
    };
  }
}

class Avatar {
  final String? publicId;
  final String? url;

  Avatar({this.publicId, this.url});

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      publicId: json['public_id'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'public_id': publicId,
      'url': url,
    };
  }
}
