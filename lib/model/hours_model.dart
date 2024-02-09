class HoursModel {
  String name;
  String hour;
  String id;
  HoursModel({required this.hour, required this.id, required this.name});
}

List<HoursModel> hoursList = [
  HoursModel(hour: '20 ساعه', id: '0000000', name: 'رغد بنت محمد'),
  HoursModel(hour: '13 ساعه', id: '1111111', name: 'حصة بنت نايف '),
  HoursModel(hour: '16 ساعه', id: '2222222', name: 'نوره بنت عبدالله'),
  HoursModel(hour: '20 ساعه', id: '3333333', name: 'ليان بنت خالد'),
  HoursModel(hour: '38 ساعه', id: '4444444', name: 'شيخه بنت عبدالرحمن'),
  HoursModel(hour: '15 ساعه', id: '5555555', name: 'الجازي بنت عبدالعزيز'),
];
