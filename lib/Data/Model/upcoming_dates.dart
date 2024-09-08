/// maximum : "2024-10-02"
/// minimum : "2024-09-11"

class UpcomingDates {
  UpcomingDates({
      this.maximum, 
      this.minimum,});

  UpcomingDates.fromJson(dynamic json) {
    maximum = json['maximum'];
    minimum = json['minimum'];
  }
  String? maximum;
  String? minimum;
UpcomingDates copyWith({  String? maximum,
  String? minimum,
}) => UpcomingDates(  maximum: maximum ?? this.maximum,
  minimum: minimum ?? this.minimum,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['maximum'] = maximum;
    map['minimum'] = minimum;
    return map;
  }

}