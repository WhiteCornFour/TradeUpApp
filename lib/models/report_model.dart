class ReportModel {
  String? _idUserReported;
  String? _content;
  String? _tagnameToReport;
  List<String>? _imageList;
  int? _status; // 0: chưa xử lý | 1: đang xử lý | 2: đã hoàn thành
  String? _createdAt;

  // Constructor
  ReportModel({
    String? idUserReported,
    String? content,
    String? tagnameToReport,
    List<String>? imageList,
    int? status,
    String? createdAt,
  }) : _idUserReported = idUserReported,
       _content = content,
       _tagnameToReport = tagnameToReport,
       _imageList = imageList ?? [],
       _status = status ?? 0,
       _createdAt = createdAt;

  // Getters
  String? get idUserReported => _idUserReported;
  String? get content => _content;
  String? get tagnameToReport => _tagnameToReport;
  List<String>? get imageList => _imageList;
  int? get status => _status;
  String? get createdAt => _createdAt;

  // Setters
  set idUserReported(String? value) => _idUserReported = value;
  set content(String? value) => _content = value;
  set tagnameToReport(String? value) => _tagnameToReport = value;
  set imageList(List<String>? value) => _imageList = value;
  set status(int? value) => _status = value;
  set createdAt(String? value) => _createdAt = value;

  // Convert object to Map (for Firebase or JSON)
  Map<String, dynamic> toMap() {
    return {
      'idUserReported': _idUserReported,
      'content': _content,
      'tagnameToReport': _tagnameToReport,
      'imageList': _imageList,
      'status': _status,
      'createdAt': _createdAt,
    };
  }

  // Create object from Map
  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      idUserReported: map['idUserReported'],
      content: map['content'],
      tagnameToReport: map['tagnameToReport'],
      imageList: List<String>.from(map['imageList'] ?? []),
      status: map['status'],
      createdAt: map['createdAt'],
    );
  }
}
