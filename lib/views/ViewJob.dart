import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:scm/models/Job.dart';
import 'package:scm/models/ProductInfo.dart';
import 'package:scm/services/JobSheetService.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewJob extends StatefulWidget {

  final int ID;
  ViewJob({this.ID});

  @override
  _ViewJobState createState() => _ViewJobState();

}
class _ViewJobState extends State<ViewJob>
{

  // bool get isEditing => widget.ID != null;
  JobSheetService get service =>  GetIt.I<JobSheetService>();
  JobSheetService get service2 =>  GetIt.I<JobSheetService>();


  String errorMesaage;
  Job job = new Job();
  ProductInfo productInfo = new ProductInfo();

  TextEditingController servicetype = TextEditingController();
  TextEditingController job_no = TextEditingController();
  TextEditingController job_date = TextEditingController();
  TextEditingController job_status = TextEditingController();


  TextEditingController pd_type = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController model_name = TextEditingController();
  TextEditingController model_no = TextEditingController();
  TextEditingController device_config = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController sr_no = TextEditingController();
  TextEditingController war_staus = TextEditingController();
  TextEditingController fault_cust = TextEditingController();
  TextEditingController phy_status = TextEditingController();
  TextEditingController remarks = TextEditingController();

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    service.getJob(widget.ID)
        .then((response) {

      if(response.error) {
        errorMesaage = response.errorMessage ?? 'JOBSHEET not fetched';
      }
      job = response.data;
      job_no.text = job.jobsheetNumber;
      servicetype.text = job.job_type;
      job_status.text = job.job_status;
      job_date.text = job.job_date;
    });
    product();
  }
  void product() {
    service2.getproduct(widget.ID)
        .then((response){
      if(response.error) {
        setState(() {
          _isLoading = false;
        });
        errorMesaage = response.errorMessage ?? 'JOBSHEET not fetched';
      }
      setState(() {
        _isLoading = false;
      });
      productInfo = response.data;
      pd_type.text = productInfo.pd_type;
      brand.text = productInfo.brand;
      model_name.text = productInfo.model_name;
      model_no.text = productInfo.model_no;
      device_config.text = productInfo.device_config;
      password.text = productInfo.password;
      sr_no.text = productInfo.sr_no;
      war_staus.text = productInfo.war_staus;
      fault_cust.text = productInfo.fault_cust;
      phy_status.text = productInfo.phy_status;
      remarks.text = productInfo.remarks;
    });
  }

  Widget build(BuildContext context) {
    return _isLoading ? Container(
      color: Colors.white70.withOpacity(0.3),
      width: MediaQuery.of(context).size.width,//70.0,
      height: MediaQuery.of(context).size.height, //70.0,
      child: new Padding(
          padding: const EdgeInsets.all(5.0),
          child: new Center(child: new CircularProgressIndicator())),
    ): Scaffold(
      appBar: AppBar(
        title: Text(job_no.text),
      ),
      body: Container(
          child: Card(
            child: ListView(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0)
                ),
                ExpansionTile(
                  title: Text("Service"),
                  trailing: Icon(FontAwesomeIcons.angleDoubleDown),
                  children: <Widget>[
                    Container(height: 8),
                    Text(
                      'Service Type:  ${servicetype.text}',
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
                    ),
                    Container(height: 8),
                    Text(
                      'Jobsheet Number:  ${job_no.text}',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
                    ),
                    Container(height: 8),
                    Text(
                      'Jobsheet Date:  ${job_date.text}',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
                    ),
                    Container(height: 8),
                    Text(
                      'Jobsheet Status:  ${job_status.text}',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
                    ),
                    Container(height: 18),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0)
                ),
                ExpansionTile(
                  title: Text("Product Information"),
                  trailing: Icon(FontAwesomeIcons.angleDoubleDown),
                  children: <Widget>[
                    Container(height: 8),
                    Text(
                      'Product Type:  ${pd_type.text}',
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
                    ),
                    Container(height: 8),
                    Text(
                      'Brand:  ${brand.text}',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
                    ),
                    Container(height: 8),
                    Text(
                      'Model Name:  ${model_name.text}',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
                    ),
                    Container(height: 8),
                    Text(
                      'Model Number:  ${model_no.text}',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
                    ),
                    Container(height: 8),
                    Text(
                      'Service Type:  ${servicetype.text}',
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
                    ),
                    Container(height: 8),
                    Text(
                      'Serial Number:  ${sr_no.text}',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
                    ),
                    Container(height: 8),
                    Text(
                      'Device Configuration:  ${device_config.text}',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
                    ),
                    Container(height: 8),
                    Text(
                      'Password:  ${password.text}',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
                    ),Container(height: 8),
                    Text(
                      'Warranty Status:  ${war_staus.text}',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
                    ),
                    Container(height: 8),
                    Text(
                      'Physical Status:  ${phy_status.text}',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
                    ),
                    Container(height: 8),
                    Text(
                      'Remarks:  ${remarks.text}',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
                    ),
                    Container(height: 18),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0)
                ),
                ExpansionTile(
                  title: Text("Service Status"),
                  trailing: Icon(FontAwesomeIcons.angleDoubleDown),
                  children: <Widget>[
                    Container(height: 18),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
