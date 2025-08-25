import 'package:flutter/material.dart';
import 'dart:async';

class ChatProvider extends ChangeNotifier {
  final Map<String, List<ChatMessage>> _groupMessages = {};
  final Map<String, bool> _typingUsers = {};
  final Map<String, StreamController<ChatMessage>> _messageStreams = {};
  bool _isLoading = false;
  String? _error;
  
  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  List<ChatMessage> getGroupMessages(String groupId) {
    return _groupMessages[groupId] ?? [];
  }
  
  bool isUserTyping(String groupId) {
    return _typingUsers[groupId] ?? false;
  }
  
  Stream<ChatMessage>? getMessageStream(String groupId) {
    return _messageStreams[groupId]?.stream;
  }
  
  // Initialize chat for a group
  void initializeGroupChat(String groupId) {
    if (!_groupMessages.containsKey(groupId)) {
      _groupMessages[groupId] = _getInitialMessages(groupId);
      _messageStreams[groupId] = StreamController<ChatMessage>.broadcast();
    }
  }
  
  // Send message
  Future<void> sendMessage({
    required String groupId,
    required String text,
    String? imageUrl,
    String? fileUrl,
  }) async {
    if (text.trim().isEmpty && imageUrl == null && fileUrl == null) return;
    
    _setLoading(true);
    _clearError();
    
    try {
      final message = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: text.trim(),
        sender: 'Me',
        time: _formatTime(DateTime.now()),
        isMe: true,
        imageUrl: imageUrl,
        fileUrl: fileUrl,
        timestamp: DateTime.now(),
      );
      
      // Add to local messages
      _groupMessages[groupId]?.add(message);
      
      // Emit to stream
      _messageStreams[groupId]?.add(message);
      
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Simulate message delivery status
      message.isDelivered = true;
      message.isRead = true;
      
      notifyListeners();
      
      // Simulate auto-reply for demo
      _simulateAutoReply(groupId, text);
      
    } catch (e) {
      _setError('Failed to send message: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }
  
  // Delete message
  Future<void> deleteMessage(String groupId, String messageId) async {
    try {
      final messages = _groupMessages[groupId];
      if (messages != null) {
        messages.removeWhere((msg) => msg.id == messageId);
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to delete message: ${e.toString()}');
    }
  }
  
  // Edit message
  Future<void> editMessage(String groupId, String messageId, String newText) async {
    try {
      final messages = _groupMessages[groupId];
      if (messages != null) {
        final messageIndex = messages.indexWhere((msg) => msg.id == messageId);
        if (messageIndex != -1) {
          messages[messageIndex].text = newText;
          messages[messageIndex].isEdited = true;
          notifyListeners();
        }
      }
    } catch (e) {
      _setError('Failed to edit message: ${e.toString()}');
    }
  }
  
  // Set typing status
  void setTypingStatus(String groupId, bool isTyping) {
    if (_typingUsers[groupId] != isTyping) {
      _typingUsers[groupId] = isTyping;
      notifyListeners();
    }
  }
  
  // Mark messages as read
  void markMessagesAsRead(String groupId) {
    final messages = _groupMessages[groupId];
    if (messages != null) {
      bool hasChanges = false;
      for (var message in messages) {
        if (!message.isRead) {
          message.isRead = true;
          hasChanges = true;
        }
      }
      if (hasChanges) {
        notifyListeners();
      }
    }
  }
  
  // Clear chat history
  void clearChatHistory(String groupId) {
    _groupMessages[groupId]?.clear();
    notifyListeners();
  }
  
  // Private methods
  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }
  
  void _setError(String? error) {
    if (_error != error) {
      _error = error;
      notifyListeners();
    }
  }
  
  void _clearError() {
    _setError(null);
  }
  
  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }
  
  void _simulateAutoReply(String groupId, String userMessage) {
    // Simple auto-reply logic for demo
    Timer(const Duration(seconds: 2), () {
      final replies = [
        'Thanks for sharing!',
        'That sounds great!',
        'I agree with you.',
        'Interesting point!',
        'Let me think about that.',
        'Good idea!',
      ];
      
      final reply = replies[DateTime.now().millisecond % replies.length];
      
      final autoMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: reply,
        sender: 'Sebastian Rudiger',
        time: _formatTime(DateTime.now()),
        isMe: false,
        timestamp: DateTime.now(),
        isDelivered: true,
        isRead: false,
      );
      
      _groupMessages[groupId]?.add(autoMessage);
      _messageStreams[groupId]?.add(autoMessage);
      notifyListeners();
    });
  }
  
  List<ChatMessage> _getInitialMessages(String groupId) {
    return [
      ChatMessage(
        id: '1',
        text: 'Hi, Jimmy! Any update today?',
        sender: 'Sebastian Rudiger',
        time: '09:32 PM',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isDelivered: true,
        isRead: true,
      ),
      ChatMessage(
        id: '2',
        text: 'All good! We have some update 🎉',
        sender: 'Me',
        time: '09:33 PM',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 1)),
        isDelivered: true,
        isRead: true,
      ),
      ChatMessage(
        id: '3',
        text: 'Here\'s the new landing page design!\nhttps://www.figma.com/file/EQJT...',
        sender: 'Me',
        time: '09:34 PM',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 2)),
        hasImage: true,
        imageUrl: 'assets/images/design_preview.jpg',
        isDelivered: true,
        isRead: true,
      ),
      ChatMessage(
        id: '4',
        text: 'Cool! I have some feedbacks on the "How it work" section, but overall looks good now! 👍',
        sender: 'Sebastian Rudiger',
        time: '10:15 PM',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
        isDelivered: true,
        isRead: true,
      ),
      ChatMessage(
        id: '5',
        text: 'Perfect! Will check it 🔥',
        sender: 'Me',
        time: '09:34 PM',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 44)),
        isDelivered: true,
        isRead: true,
      ),
    ];
  }
  
  @override
  void dispose() {
    for (var controller in _messageStreams.values) {
      controller.close();
    }
    super.dispose();
  }
}

class ChatMessage {
  final String id;
  String text;
  final String sender;
  final String time;
  final bool isMe;
  final DateTime timestamp;
  final bool hasImage;
  final String? imageUrl;
  final String? fileUrl;
  bool isDelivered;
  bool isRead;
  bool isEdited;
  
  ChatMessage({
    required this.id,
    required this.text,
    required this.sender,
    required this.time,
    required this.isMe,
    required this.timestamp,
    this.hasImage = false,
    this.imageUrl,
    this.fileUrl,
    this.isDelivered = false,
    this.isRead = false,
    this.isEdited = false,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'sender': sender,
      'time': time,
      'isMe': isMe,
      'timestamp': timestamp.toIso8601String(),
      'hasImage': hasImage,
      'imageUrl': imageUrl,
      'fileUrl': fileUrl,
      'isDelivered': isDelivered,
      'isRead': isRead,
      'isEdited': isEdited,
    };
  }
}
