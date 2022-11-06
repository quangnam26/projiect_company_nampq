
import 'package:template/data/model/policyandterm/policy_and_term_response.dart';

class PolicyAndTermResquest extends PolicyAndTermResponse{
  
  PolicyAndTermResquest.fromJson(Map<String, dynamic> json):super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}