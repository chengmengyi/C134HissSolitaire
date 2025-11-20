class HissEventData{
  int eventCode;
  String? strEventValue;
  int? intEventValue;
  dynamic anyEventValue;
  HissEventData({
    required this.eventCode,
    this.strEventValue,
    this.intEventValue,
    this.anyEventValue,
});
}