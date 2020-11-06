import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:scm/models/AddNewJobsheet.dart';
import 'package:scm/services/JobSheetService.dart';

class AddJobsheet extends StatelessWidget {

  List<String> servicetype = [
    "Carry In",
    "Pickup",
    "Onsite",
  ];

  List<String> warranty = [
    "Warranty",   "Non-warranty",   "Return",
  ];

  JobSheetService get service =>  GetIt.I<JobSheetService>();

  TextEditingController warrantystatus = new TextEditingController();
  TextEditingController selectservice = new TextEditingController();
  TextEditingController first_name = new TextEditingController();
  TextEditingController last_name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController jb_no = new TextEditingController();
  TextEditingController jb_date = new TextEditingController();
  TextEditingController pd_type = new TextEditingController();
  TextEditingController brand = new TextEditingController();
  TextEditingController md_name = new TextEditingController();
  TextEditingController md_no = new TextEditingController();
  TextEditingController dv_config = new TextEditingController();
  TextEditingController dv_pwd = new TextEditingController();
  TextEditingController sr_no = new TextEditingController();
  TextEditingController problem = new TextEditingController();
  TextEditingController py_status = new TextEditingController();
  TextEditingController remarks = new TextEditingController();
  TextEditingController item_name = new TextEditingController();
  TextEditingController item_ref_number = new TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Jobsheet Details'),),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading ? CircularProgressIndicator(): ListView(
          children: [
            Container(height: 16),
            Text(
              'Service',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black38,
              ),
              textAlign: TextAlign.left,
            ),
            Container(height: 8),
            TextField(
              controller: first_name,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Customer First Name',
                  labelText: 'Customer First Name'
              ),
            ),
            Container(height: 8),
            TextField(
              controller: last_name,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Customer Last Name',
                  labelText: 'Customer Last Name'
              ),
            ),
            Container(height: 8),
            TextField(
              controller: email,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Customer Email',
                  labelText: 'Customer Email'
              ),
            ),
            Container(height: 8),
            TextField(
              controller: phone,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Customer Phone',
                  labelText: 'Customer Phone'
              ),
            ),
            Container(height: 8),
            SizedBox(height: 10,width: 0),
            DropDownField(
              textStyle: const TextStyle(fontWeight: FontWeight.normal,
                  color: Colors.black,
                  fontSize: 15.0),
              controller: selectservice,
              hintText: "Select Service Type",
              labelText: 'Service Type',
              enabled: true,
              itemsVisibleInDropdown: 3,
              items: servicetype,
              onValueChanged: (value) {
                setState(() {
                  selectservice = value;
                });
              },
            ),
            Container(height: 8),
            TextField(
              controller: jb_no,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Jobsheet Number',
                  labelText: 'Jobsheet Number'
              ),
            ),
            Container(height: 8),
            TextField(
              controller: jb_date,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Jobsheet Date',
                  labelText: 'Jobsheet Date',
              ),
            ),
            Container(height: 16),
            Text(
              'Product Information',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black38,
              ),
              textAlign: TextAlign.left,
            ),
            Container(height: 8),
            TextField(
              controller: pd_type,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Product Type',
                  labelText: 'Product Type'
              ),
            ),
            Container(height: 8),
            TextField(
              controller: brand,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Brand',
                  labelText: 'Brand'
              ),
            ),
            Container(height: 8),
            TextField(
              controller: md_name,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Model Name',
                  labelText: 'Model Name'
              ),
            ),
            Container(height: 8),
            TextField(
              controller: md_no,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Model Number',
                  labelText: 'Model Number'
              ),
            ),
            Container(height: 8),
            TextField(
              controller: sr_no,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Serial Number',
                  labelText: 'Serial Number'
              ),
            ),
            Container(height: 8),
            TextField(
              controller: dv_config,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Device Configuration',
                  labelText: 'Device Configuration'
              ),
            ),
            Container(height: 8),
            TextField(
              controller: dv_pwd,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Password',
                  labelText: 'Password'
              ),
            ),
            Container(height: 8),
            TextField(
              controller: problem,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Problem reported',
                  labelText: 'Problem reported'
              ),
            ),
            Container(height: 8),
            DropDownField(
              labelStyle: const TextStyle(fontWeight: FontWeight.normal,
                  color: Colors.black38,
                  fontSize: 15.0),
              textStyle: const TextStyle(fontWeight: FontWeight.normal,
                  color: Colors.black38,
                  fontSize: 15.0),
              controller: warrantystatus,
              hintText: "Select Warranty Status",
              labelText: "Warranty Status",
              enabled: true,
              itemsVisibleInDropdown: 3,
              items: warranty,
              onValueChanged: (value) {
                setState(() {
                  warrantystatus = value;
                });
              },
            ),
            Container(height: 8),
            TextField(
              controller: py_status,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Physical Status',
                  labelText: 'Physical Status'
              ),
            ),
            Container(height: 8),
            TextField(
              controller: remarks,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Remarks',
                  labelText: 'Remarks'
              ),
            ),
            Container(height: 16),
            Text(
              'Received Items',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black38,
              ),
              textAlign: TextAlign.left,
            ),
            Container(height: 8),
            TextField(
              controller: item_name,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Item Name',
                  labelText: 'Item Name'
              ),
            ),
            Container(height: 8),
            TextField(
              controller: item_ref_number,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Reference Number',
                  labelText: 'Reference Number'
              ),
            ),
            Container(height: 18),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: RaisedButton(
                child: Text('Submit', style: TextStyle(color: Colors.white),),
                color: Theme
                    .of(context)
                    .primaryColor,
                  onPressed: () async {
                    setState(() {
                      _isLoading= true;
                    });
                    final job = AddNewJobsheet(
                      id : "3",
                      first_name: first_name.text,
                      last_name: last_name.text,
                      email: email.text,
                      phone: phone.text,
                      pd_type: pd_type.text,
                      jb_no: jb_no.text,
                      brand: brand.text,
                      md_name: md_name.text,
                      md_no: md_no.text,
                      dv_pwd: dv_pwd.text,
                      dv_config: dv_config.text,
                      sr_no: sr_no.text,
                      problem: problem.text,
                      py_status: py_status.text,
                      remarks: remarks.text,
                      item_name: item_name.text,
                      item_ref_number: item_ref_number.text,
                      selectservice: selectservice.text,
                      warrantystatus: warrantystatus.text,
                    );
                    final result = await service.addJob(job);
                    setState(() {
                      _isLoading= true;
                    });
                    final title = 'Done';
                    final text = result.error ? (result.errorMessage ?? 'An error occurred' ): 'Jobsheet Updated';
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(title),
                          content: Text(text),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        )
                    )
                        .then((data) {
                      if (result.data) {
                        Navigator.of(context).pop();
                      }
                    });
                  }
              ),
            )
          ],
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}