class DymmyOppertunityModel {
  String title;
  String image;
  DymmyOppertunityModel({
    required this.image,
    required this.title,
  });
}

List<DymmyOppertunityModel> oppeertunityList = [
  DymmyOppertunityModel(image: 'assets/images/1.png', title: 'باحث ميداني'),
  DymmyOppertunityModel(
      image: 'assets/images/2.png', title: 'تنظيم الطابور الصباحي'),
  DymmyOppertunityModel(
      image: 'assets/images/3.png', title: 'استلام المصاحف التالفة أوراقها '),
  DymmyOppertunityModel(
      image: 'assets/images/4.png', title: 'ترتيب وتوزيع كسوة الشتاء'),
  DymmyOppertunityModel(
      image: 'assets/images/5.png', title: 'تنظيم أنشطة يوم الخميس'),
  DymmyOppertunityModel(image: 'assets/images/6.png', title: 'جمع فائض الطعام'),
];
