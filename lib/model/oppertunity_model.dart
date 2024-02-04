class OppertunityModel {
  String title;
  String image;
  OppertunityModel({
    required this.image,
    required this.title,
  });
}

List<OppertunityModel> oppeertunityList = [
  OppertunityModel(image: 'assets/images/1.png', title: 'باحث ميداني'),
  OppertunityModel(
      image: 'assets/images/2.png', title: 'تنظيم الطابور الصباحي'),
  OppertunityModel(
      image: 'assets/images/3.png', title: 'استلام المصاحف التالفة أوراقها '),
  OppertunityModel(
      image: 'assets/images/4.png', title: 'ترتيب وتوزيع كسوة الشتاء'),
  OppertunityModel(
      image: 'assets/images/5.png', title: 'تنظيم أنشطة يوم الخميس'),
  OppertunityModel(image: 'assets/images/6.png', title: 'جمع فائض الطعام'),
];
