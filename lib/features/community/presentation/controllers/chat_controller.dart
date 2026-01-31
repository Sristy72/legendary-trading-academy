import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/network/models/network_success.dart';
import 'package:flutter_ladydenily/features/community/data/community_repository_impl.dart';
import 'package:flutter_ladydenily/features/community/domain/community_repository.dart';
import 'package:flutter_ladydenily/features/community/models/chat_message.dart';
import 'package:get/get.dart';

import 'package:flutter_ladydenily/features/community/presentation/controllers/community_controller.dart';

class ChatController extends GetxController {
  // Accessing via CommunityController since it's already initialized and holds the repo
  final CommunityRepository _repository = Get.find<CommunityController>().repository;
  
  // Observables
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSending = false.obs;
  final TextEditingController messageController = TextEditingController();
  
  Timer? _timer;
  String? _currentChatId;

  // Load messages for a specific chat
  Future<void> loadMessages(String chatId, {bool isSilent = false}) async {
    _currentChatId = chatId;
    if (!isSilent) isLoading.value = true;
    
    final result = await _repository.getMessages(chatId);
    
    result.fold(
      (failure) {
        if (!isSilent) isLoading.value = false;
        if (!isSilent) Get.snackbar('Error', failure.message);
      },
      (success) {
        if (!isSilent) isLoading.value = false;
        messages.value = success.data;
        
        // Ensure polling is running for this chat
        if (_timer == null || !_timer!.isActive) {
          startPolling(chatId);
        }
      },
    );
  }
  
  void startPolling(String chatId) {
    stopPolling(); // cancel any existing
    _currentChatId = chatId;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentChatId == chatId) {
        loadMessages(chatId, isSilent: true);
      }
    });
  }

  void stopPolling() {
    _timer?.cancel();
    _timer = null;
  }

  // Send a text message
  Future<void> sendMessage(String chatId, String participantId) async {
    final content = messageController.text.trim();
    if (content.isEmpty) return;

    isSending.value = true;
    
    // Optimistic update (optional, but requested for "messenger like")
    // For now we wait for server response to be ensuring consistency
    
    final result = await _repository.sendMessage(
      chatId: chatId,
      content: content,
      contentType: 'text',
      participantId: participantId,
    );

    result.fold(
      (failure) {
        isSending.value = false;
        Get.snackbar('Error', failure.message);
      },
      (success) {
        isSending.value = false;
        messageController.clear();
        
        // Add the new message to the list with isMe forced to true to ensure correct alignment
        final message = success.data;
        final localMessage = ChatMessage(
          id: message.id,
          chatId: message.chatId,
          sender: message.sender,
          content: message.content,
          contentType: message.contentType,
          fileUrl: message.fileUrl,
          createdAt: message.createdAt,
          updatedAt: message.updatedAt,
          isMe: true, 
        );
        
        messages.add(localMessage);
        // Scroll to bottom logic would be handled by the UI listening to this list
      },
    );
  }

  // Placeholder for file picking (UI support requested)
  Future<void> pickAndSendFile(String chatId, String participantId) async {
    // TODO: Implement actual file upload if endpoint supports it. 
    // Currently only text send endpoint is provided.
    // This is just a UI placeholder action.
    Get.snackbar('Info', 'File upload not yet implemented on backend');
  }

  @override
  void onClose() {
    stopPolling();
    messageController.dispose();
    super.onClose();
  }
}
