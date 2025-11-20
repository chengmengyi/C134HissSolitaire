class HissEventData{
  int eventCode;
  String? strEventValue;
  int? intEventValue;
  bool? boolEventValue;
  dynamic anyEventValue;
  HissEventData({
    required this.eventCode,
    this.strEventValue,
    this.intEventValue,
    this.boolEventValue,
    this.anyEventValue,
});
}