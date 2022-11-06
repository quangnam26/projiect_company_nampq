import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/conversation/conversation_request.dart';
import 'package:template/data/model/conversation/conversation_response.dart';
import 'package:template/data/model/message/message_request.dart';
import 'package:template/data/model/message/message_response.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/helper/socket_service.dart';
import 'package:template/provider/conversation_provider.dart';
import 'package:template/provider/image_upload_provider.dart';
import 'package:template/provider/message_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import '../../../di_container.dart';
import '../dash_board/dash_board_controller.dart';

// ignore: deprecated_member_use
class ChatController extends GetxController with SingleGetTickerProviderMixin {
  final ConversationProvider conversationProvider =
      GetIt.I.get<ConversationProvider>();
  final MessageProvider messsageProvider = GetIt.I.get<MessageProvider>();
  final ImageUploadProvider imageUploadProvider =
      GetIt.I.get<ImageUploadProvider>();
  final socket = sl<SocketService>();
  final sharePrerence = sl<SharedPreferenceHelper>();
  final TextEditingController messageController = TextEditingController();
  final RefreshController refreshController = RefreshController();

  // Variables
  String userId = '';
  String message = '';
  RxBool isSend = false.obs;
  Rx<ConversationResponse?> conversation = ConversationResponse().obs;
  final MessageRequest messageRequest = MessageRequest();
  int limit = 10;
  int page = 1;

  RxBool isEnteringMessage = false.obs;

  //List
  // RxList<MessageResponse> messages = <MessageResponse>[MessageResponse()].obs;
  ValueNotifier<List<MessageResponse>> messages =
      ValueNotifier([MessageResponse()]);

  @override
  void onInit() {
    super.onInit();
    // animationController = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    userId = sharePrerence.getProfile;
    _getConversation();
  }

  @override
  void onClose() {
    super.onClose();
    conversation.close();
    socket.getSocket().off(support_message);
    // messages.close();
    messages.dispose();
    messageController.dispose();
    isSend.close();
    isEnteringMessage.close();
  }

  /// Get conversation.
  ///
  /// If user hasn't conversation then It will is create a conversation for current user.
  void _getConversation() {
    conversationProvider.paginate(
      limit: 1,
      page: 1,
      filter: '&users=$userId',
      onSuccess: (conversations) {
        // Conversation isn't empty.
        if (conversations.isNotEmpty) {
          conversation.value = conversations.first;
          // Get message from the conversation.
          _getMesssage(
              conversationId: conversation.value!.id.toString(),
              isRequired: true);
          // Listen admin answer questions
          _onListeningRecievedMessage();
        } else {
          // Conversation is empty will create a conversation for the user.
          _createConversation();
        }
      },
      onError: (onError) {
        Get.find<DashBoardController>().checkLogin();
        debugPrint("An error occurred while getting the conversation $onError");
      },
    );
  }

  ///
  /// Create  a new conversation.
  ///
  void _createConversation() {
    final ConversationRequest conversationRequest = ConversationRequest();
    conversationRequest.lastTime = DateTime.now().millisecondsSinceEpoch;
    conversationRequest.name = 'Name';
    conversationRequest.users = [userId];

    conversationProvider.add(
      data: conversationRequest,
      onSuccess: (conversation) {
        this.conversation.value = conversation;
        // Register listen admin answer questions.
        _onListeningRecievedMessage();
        debugPrint("Đã tạo thành công.");
      },
      onError: (onError) {
        debugPrint(
            "An error occurred while processing the conversation $onError");
      },
    );
  }

  ///
  /// Get messages of Conversation.
  ///
  /// The @param [idConversation] is id of the conversation.
  void _getMesssage(
      {required bool isRequired, required String conversationId}) {
    if (isRequired) {
      page = 1;
      messages.value.clear();
      messages.value.add(MessageResponse());
    } else {
      page += 1;
    }
    messsageProvider.paginate(
      page: page,
      limit: limit,
      filter: '&conversation=$conversationId',
      onSuccess: (List<MessageResponse> messages) {
        if (messages.isNotEmpty) {
          final List<MessageResponse> values = [
            ...this.messages.value,
            ...messages
          ];
          this.messages.value = values;
          if (isRequired) {
            Future.delayed(const Duration(milliseconds: 500), () {
              refreshController.resetNoData();
              refreshController.refreshCompleted();
            });
          } else {
            Future.delayed(const Duration(milliseconds: 300), () {
              refreshController.loadNoData();
              refreshController.loadComplete();
            });
          }
        }
      },
      onError: (onError) {
        Get.find<DashBoardController>().checkLogin();
        debugPrint(
            "An error occurred while paginating results for message $onError");
      },
    );
  }

  ///
  /// Refresh messages.
  ///
  void onRefresh() {
    _getMesssage(
        isRequired: true, conversationId: conversation.value!.id.toString());
  }

  ///
  /// Refresh messages.
  ///
  void onLoading() {
    _getMesssage(
        isRequired: false, conversationId: conversation.value!.id.toString());
  }

  ///
  /// Listen user or admin send a message.
  ///
  /// Listen user entering a new message.
  ///
  void _onListeningRecievedMessage() {
    if (!socket.hasListeners(support_message)) {
      socket.on(
        support_message,
        (event) {
          // If idConversation equals idConversation receive the message.
          if (event['conversationId'] == conversation.value?.id) {
            // If the user is entering a new message.
            if (event['enteringMesssage'] == true) {
              // If user send a message. Then show is indicator.
              if (event['userId'] != userId) {
                isEnteringMessage.value = true;
              }
            } else {
              isEnteringMessage.value = false;
              if (event['userId'] != userId) {
                _getMesssage(
                    conversationId: conversation.value!.id.toString(),
                    isRequired: true);
              }
            }
          }
        },
      );
    }
  }

  ///
  /// Create a new message for conversation.
  ///
  void createMessageForConversation() {
    // animationController?.reset();
    // If message is empty can't send a message.
    if (isSend.isFalse && IZIValidate.nullOrEmpty(messageRequest.images)) {
      return;
    }

    messageRequest.conversation = conversation.value;
    messageRequest.user = userId;
    messageRequest.content = message;

    messsageProvider.add(
      data: messageRequest,
      onSuccess: (MessageRequest message) {
        // Emit the message for admin listen user sended the message.
        _sendMessage(enteringMessage: false);

        // Refresh converstaion.
        _getMesssage(
            conversationId: conversation.value!.id.toString(),
            isRequired: true);

        // Clear data.
        onChangeSend(message: '');
        this.message = '';
        messageController.text = '';
        messageRequest.images = [];
      },
      onError: (onError) {
         Get.find<DashBoardController>().checkLogin();
        debugPrint(
            "An error occurred while processing create a new message for conversation $onError");
      },
    );
  }

  ///
  /// Send a message to the conversation.
  ///
  void _sendMessage({required bool enteringMessage}) {
    socket.emit(support_message, {
      'conversationId': conversation.value?.id,
      'enteringMesssage': enteringMessage,
      'userId': userId,
    });
  }

  ///
  /// Check received messsage of who are messages.
  ///
  /// Return [true] if the message of owner.
  bool isOwner({required MessageResponse message}) {
    return message.user.toString() == userId;
  }

  ///
  /// Convert time a message to hh:mm.
  ///
  /// Return [true] if the message of owner.
  String messageHour({required BuildContext context, required MessageResponse message}) {
    final date = IZIDate.parse(message.createdAt.toString()).toLocal();
    return "${IZIDate.formatTime24Hour(context, date)} ${IZIDate.formatDate(date, format: 'a')}";
  }

  ///
  /// Change color icon send message.
  ///
  /// Check condition send message.
  ///
  void onChangeSend({required String message}) {
    if (message.isNotEmpty) {
      isSend.value = true;
    } else {
      isSend.value = false;
    }
  }

  ///
  /// Change indicator a message.
  ///
  void onChangeIndicator({required String message}) {
    if (message.isNotEmpty) {
      _sendMessage(enteringMessage: true);
    } else {
      _sendMessage(enteringMessage: false);
    }
  }

  ///
  /// Pick images.
  ///
  Future pickImage() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      final List<File> files = [];
      for (int i = 0; i < images.length; i++) {
        files.add(File(images[i].path));
      }
      imageUploadProvider.addImages(
        files: files,
        onSuccess: (List<String> images) {
          //images
          messageRequest.images = images;
          print(images);
          createMessageForConversation();
        },
        onError: (onError) {
          debugPrint(
              "An error occurred while uploading the image to the server $onError");
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      IZIAlert.error(message: 'Bạn phải cho phép quyền truy cập hệ thống');
      //chưa cấp quyền thì vào setting hệ thống cho phép
      openAppSettings();
    }
  }
}
