class Job {
  int ID;
  String jobsheetNumber;
  String job_date;
  String job_status;
  String job_type;
  DateTime createdDate;
  DateTime lastManage;

  Job ({
    this.ID,
    this.jobsheetNumber,
    this.job_date,
    this.job_type,
    this.job_status,
    this.createdDate,
    this.lastManage
  });

  factory Job.fromJson(Map<String, dynamic> jsondata) {
    return Job(
        ID: jsondata['id'],
        job_type: jsondata['job_type'],
        jobsheetNumber: jsondata['job_number'],
        job_status: jsondata['job_status'],
        job_date: jsondata['job_date']
    );
  }
}