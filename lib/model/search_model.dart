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
    this.checkValue = false,
  });
}

List<SearchModelAlMakaan> almakaanList = [
  SearchModelAlMakaan(title: 'داخل المدرسة'),
  SearchModelAlMakaan(title: 'خارج المدرسة'),
];

class SearchModelAlJins {
  String title;
  bool checkValue;
  SearchModelAlJins({
    required this.title,
    this.checkValue = false,
  });
}

List<SearchModelAlJins> aljinsList = [
  SearchModelAlJins(title: 'ذكر'),
  SearchModelAlJins(title: 'انثى'),
];
