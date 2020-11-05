class ProductInfo {
  int jobId;
  int customerId;
  String pd_type;
  String brand;
  String model_name;
  String model_no;
  String device_config;
  String password;
  String sr_no;
  String war_staus;
  String fault_cust;
  String phy_status;
  String remarks;
  String added_date;

  ProductInfo ({
    this.jobId,
    this.customerId,
    this.pd_type,
    this.brand,
    this.model_name,
    this.model_no,
    this.device_config,
    this.password,
    this.sr_no,
    this.war_staus,
    this.fault_cust,
    this.phy_status,
    this.remarks,
    this.added_date
  });

  factory ProductInfo.fromJson(Map<String, dynamic> jsondata) {
    return ProductInfo(
        jobId: jsondata['jobId'],
        customerId: jsondata['customerId'],
        pd_type: jsondata['pd_type'],
        brand: jsondata['brand'],
        model_name: jsondata['model_name'],
        model_no: jsondata['model_no'],
        device_config: jsondata['device_config'],
        password: jsondata['password'],
        sr_no: jsondata['sr_no'],
        war_staus: jsondata['war_staus'],
        fault_cust: jsondata['fault_cust'],
        phy_status: jsondata['phy_status'],
        remarks: jsondata['remarks'],
        added_date: jsondata['added_date']
    );
  }
}