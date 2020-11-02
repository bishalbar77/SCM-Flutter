class Jobsheet {
  String ID;
  String jobsheetNumber;
  String job_date;
  String job_status;
  DateTime createdDate;
  DateTime lastManage;

  Jobsheet ({
    this.ID,
    this.jobsheetNumber,
    this.job_date,
    this.job_status,
    this.createdDate,
    this.lastManage
  });

  factory Jobsheet.fromJson(Map<String, dynamic> item) {
    return Jobsheet(
        ID: "5",
        jobsheetNumber: item['job_number'],
        job_date: item['job_date'],
        job_status: item['job_status'],
        lastManage: DateTime.parse(item['updated_at']),
        createdDate: DateTime.parse(item['created_at'])
    );
  }
}