import 'dart:convert';

class Distance {
  String? duration;
  int? durationValue;
  String? distance;
  int? distanceValue;
  Distance({
    this.duration,
    this.durationValue,
    this.distance,
    this.distanceValue,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'duration': duration,
      'durationValue': durationValue,
      'distance': distance,
      'distanceValue': distanceValue,
    };
  }

  factory Distance.fromMap(Map<String, dynamic> map) {
    return Distance(
      duration: map['duration']['text'] != null ? map['duration']['text'] as String : null,
      durationValue: map['duration']['value'] != null ? map['duration']['value'] as int : null,
      distance: map['distance']['text'] != null ? map['distance']['text'] as String : null,
      distanceValue: map['distance']['value'] != null ? map['distance']['value'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Distance.fromJson(String source) => Distance.fromMap(json.decode(source) as Map<String, dynamic>);
}