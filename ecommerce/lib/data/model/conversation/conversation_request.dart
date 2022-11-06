

import 'package:template/data/model/conversation/conversation_response.dart';

class ConversationRequest extends ConversationResponse{

  ConversationRequest() : super.fromJson({});

  ConversationRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}
