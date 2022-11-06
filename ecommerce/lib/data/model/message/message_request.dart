

import 'package:template/data/model/message/message_response.dart';

class MessageRequest extends MessageResponse{

  MessageRequest() : super.fromJson({});

  MessageRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    if(conversation != null) data['conversation'] = super.conversation?.id;
    return data;
  }
}
