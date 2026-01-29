import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/community/models/community_item.dart';
import 'package:flutter_ladydenily/features/community/presentation/controllers/chat_controller.dart';
import 'package:flutter_ladydenily/features/community/presentation/widgets/chat_bubbles.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChatDetailsScreen extends StatefulWidget {
  final CommunityItem communityItem;
  final String currentUserId;

  const ChatDetailsScreen({
    super.key,
    required this.communityItem,
    required this.currentUserId,
  });

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> with WidgetsBindingObserver {
  late final ChatController controller;
  late final String participantId;
  bool _isScreenActive = false;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ChatController());
    WidgetsBinding.instance.addObserver(this);
    
    // Determine participantId
    if (widget.communityItem.participants.isNotEmpty) {
      participantId = widget.communityItem.participants.firstWhere(
        (id) => id != widget.currentUserId,
        orElse: () => widget.communityItem.participants.first,
      );
    } else {
      participantId = "unknown"; 
    }

    _isScreenActive = true;
    controller.loadMessages(widget.communityItem.id);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _isScreenActive = false;
    controller.stopPolling();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      controller.stopPolling();
    } else if (state == AppLifecycleState.resumed) {
      if (_isScreenActive && mounted) {
        controller.startPolling(widget.communityItem.id);
      }
    }
  }

  @override
  void deactivate() {
    _isScreenActive = false;
    controller.stopPolling();
    super.deactivate();
  }

  @override
  void activate() {
    super.activate();
    _isScreenActive = true;
    if (mounted) {
      controller.startPolling(widget.communityItem.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5), // Light grey background like image
      appBar: AppBar(
        title: Text(
          widget.communityItem.title,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: AppColors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              
              // Reverse list if we want bottom-up, but ListView builder with reverse:true is better usually.
              // However API returns chronological usually. 
              // Standard chat UI: Bottom is latest.
              // We need to display them. 
              final messages = controller.messages;
              
              if (messages.isEmpty) {
                 return const Center(child: Text("No messages yet"));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                // Make it scroll to bottom initially? 
                // Alternatively, reverse: true and reverse the list order.
                // Assuming API returns [oldest ... newest], we want to show newest at bottom.
                // If we use reverse: false (default), we are at top.
                // Let's use reverse: true and reverse the list.
                reverse: true,
                itemBuilder: (context, index) {
                   final message = messages[messages.length - 1 - index];
                   return ChatBubble(
                     message: message,
                     isSender: message.isMe ?? false, // API provides isMe
                   );
                },
              );
            }),
          ),

          // Input Area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SafeArea( // Handle bottom notch
              child: Row(
                children: [
                  // File/Audio buttons
                  IconButton(
                    icon: const Icon(Iconsax.attach_circle, color: Colors.grey),
                    onPressed: () => controller.pickAndSendFile(widget.communityItem.id, participantId),
                  ),
                  IconButton(
                    icon: const Icon(Iconsax.microphone, color: Colors.grey),
                    onPressed: () {
                        // Audio recording placeholder
                        Get.snackbar("Info", "Audio recording not implemented");
                    },
                  ),
                  
                  // Text Field
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: controller.messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        minLines: 1,
                        maxLines: 4,
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 8),

                  // Send Button
                  Obx(() {
                    return controller.isSending.value
                        ? const SizedBox(
                            width: 24, 
                            height: 24, 
                            child: CircularProgressIndicator(strokeWidth: 2)
                          )
                        : CircleAvatar(
                            backgroundColor: AppColors.buttonColor,
                            child: IconButton(
                              icon: const Icon(Iconsax.send_1, color: Colors.white, size: 20),
                              onPressed: () => controller.sendMessage(widget.communityItem.id, participantId),
                            ),
                          );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
