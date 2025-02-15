class MetaModel {
  int? totalDocuments;
  int? totalPages;
  int? currentPage;
  int? limitPerPage;

  MetaModel(
      {this.totalDocuments,
      this.totalPages,
      this.currentPage,
      this.limitPerPage});

  MetaModel.fromJson(Map<String, dynamic> json) {
    totalDocuments = json['totalDocuments'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    limitPerPage = json['limitPerPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalDocuments'] = totalDocuments;
    data['totalPages'] = totalPages;
    data['currentPage'] = currentPage;
    data['limitPerPage'] = limitPerPage;
    return data;
  }
}
