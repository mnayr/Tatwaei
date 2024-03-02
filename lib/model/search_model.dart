class SearchModelAlMajaal {
  String title;
  bool checkValue;
  SearchModelAlMajaal({
    required this.title,
    this.checkValue = false,
  });
}

List<SearchModelAlMajaal> almajaalList = [
  SearchModelAlMajaal(title: 'خدمية'),
  SearchModelAlMajaal(title: 'ادارية'),
  SearchModelAlMajaal(title: 'اخرى'),
  SearchModelAlMajaal(title: 'اجتماعية'),
  SearchModelAlMajaal(title: 'صحية'),
];

class SearchModelAlMakaan {
  String title;
  bool checkValue;
  SearchModelAlMakaan({
    required this.title,
    required this.checkValue,
  });
}

List<SearchModelAlMakaan> almakaanList = [
  SearchModelAlMakaan(title: 'داخل المدرسة', checkValue: true),
  SearchModelAlMakaan(title: 'خارج المدرسة', checkValue: false),
];

class SearchModelAlJins {
  String title;
  bool checkValue;
  SearchModelAlJins({
    required this.title,
    required this.checkValue,
  });
}

List<SearchModelAlJins> aljinsList = [
  SearchModelAlJins(title: 'ذكر', checkValue: true),
  SearchModelAlJins(title: 'انثى', checkValue: false),
];
