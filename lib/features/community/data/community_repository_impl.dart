import 'package:flutter_ladydenily/features/community/domain/community_repository.dart';
import 'package:flutter_ladydenily/features/community/models/community_item.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  @override
  Future<List<CommunityItem>> fetchCommunityList() async {
    // Mock data matching the screenshot
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      CommunityItem(
        id: '1',
        name: 'SkyscraperCity',
        logo: 'assets/images/avatar.png',
        lastMessage: 'Photo',
        timestamp: '20/03/2025',
        hasUnread: false,
        messageType: MessageType.photo,
      ),
      CommunityItem(
        id: '2',
        name: 'SkyscraperCity',
        logo: 'assets/images/avatar.png',
        lastMessage: 'Hello! Guys',
        timestamp: '5:27 am',
        hasUnread: true,
        messageType: MessageType.text,
      ),
      CommunityItem(
        id: '3',
        name: 'Mercedes-Benz Forum',
        logo: 'assets/images/avatar.png',
        lastMessage: 'Hello! Guys',
        timestamp: 'Yesterday',
        hasUnread: false,
        messageType: MessageType.text,
      ),
      CommunityItem(
        id: '4',
        name: 'Subaru Outback Forums',
        logo: 'assets/images/avatar.png',
        lastMessage: 'Photo',
        timestamp: '20/03/2025',
        hasUnread: false,
        messageType: MessageType.photo,
      ),
      CommunityItem(
        id: '5',
        name: 'Toyota Nation Forum',
        logo: 'assets/images/avatar.png',
        lastMessage: 'Document.pdf (1 page)',
        timestamp: '5:27 am',
        hasUnread: false,
        messageType: MessageType.document,
      ),
      CommunityItem(
        id: '6',
        name: 'Cadillac Owners Forum',
        logo: 'assets/images/avatar.png',
        lastMessage: 'Hello! Guys',
        timestamp: '5:27 am',
        hasUnread: false,
        messageType: MessageType.text,
      ),
      CommunityItem(
        id: '7',
        name: 'Subaru Outback Forums',
        logo: 'assets/images/avatar.png',
        lastMessage: '👍👍',
        timestamp: '5:27 am',
        hasUnread: false,
        messageType: MessageType.emoji,
      ),
      CommunityItem(
        id: '8',
        name: 'Subaru Forester Owners Forum',
        logo: 'assets/images/avatar.png',
        lastMessage: 'Hello! Guys',
        timestamp: '5:27 am',
        hasUnread: true,
        messageType: MessageType.text,
      ),
      CommunityItem(
        id: '9',
        name: 'Cadillac Owners Forum',
        logo: 'assets/images/avatar.png',
        lastMessage: 'Hello! Guys',
        timestamp: 'Yesterday',
        hasUnread: false,
        messageType: MessageType.text,
      ),
      CommunityItem(
        id: '10',
        name: 'Toyota Nation Forum',
        logo: 'assets/images/avatar.png',
        lastMessage: 'Document.pdf (1 page)',
        timestamp: '5:27 am',
        hasUnread: false,
        messageType: MessageType.document,
      ),
    ];
  }
}
