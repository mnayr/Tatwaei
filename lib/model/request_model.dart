class RequestModel {
  String studentName;
  String grade;
  RequestModel({
    required this.grade,
    required this.studentName,
  });
}

List<RequestModel> requestList = [
  RequestModel(grade: 'الصف الثاني', studentName: 'الهنوف فهد السالم'),
  RequestModel(grade: 'الصف الأول', studentName: 'ريما علي السالمة'),
  RequestModel(grade: 'الصف الثاني', studentName: 'نورة خالد السويلم'),
  RequestModel(grade: 'الصف الثالث', studentName: 'العنود محمد السلمي'),
];
