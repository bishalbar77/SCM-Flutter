import 'dart:ffi';

import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:scm/models/Additional.dart';
import 'package:scm/models/Job.dart';
import 'package:scm/models/JobStatusUpdate.dart';
import 'package:scm/models/ServiceStatusUpdate.dart';
import 'package:scm/services/JobSheetService.dart';

class ManageJobsheet extends StatefulWidget {

  final int ID;
  ManageJobsheet({this.ID});

  @override
  _ManageJobsheetState createState() => _ManageJobsheetState();

}
class _ManageJobsheetState extends State<ManageJobsheet>
{
  // bool get isEditing => widget.ID != null;
  JobSheetService get service =>  GetIt.I<JobSheetService>();

  String errorMesaage;
  Job job = new Job();

  var _currencies = [
    "Food",
    "Transport",
    "Personal",
    "Shopping",
    "Medical",
    "Rent",
    "Movie",
    "Salary"
  ];

  TextEditingController _titleController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController servicetype = TextEditingController();
  TextEditingController remarks = TextEditingController();
  TextEditingController type_id = TextEditingController();
  TextEditingController remark = TextEditingController();
  TextEditingController item_name = TextEditingController();
  TextEditingController item_ref_number = TextEditingController();

  List<String> status = [
    "Initial Check",   "Parts Pending",   "Working", "Processing",   "Closed",
  ];
  List<String> services = [
    "Problem Diagnosis",   "Technician Notes",   "Customer Response", "Customer Status", "Internal Status", "Estimated Charges",
  ];


  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    service.getJob(widget.ID)
    .then((response) {
      setState(() {
        _isLoading = false;
      });
      if(response.error) {
        errorMesaage = response.errorMessage ?? 'JOBSHEET not fetched';
      }
      job = response.data;
      _idController.text=job.ID.toString();
      _titleController.text = job.jobsheetNumber;
      _statusController.text = job.job_status;
    });
  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Manage Jobsheet'),
      ),
      body: Container(
          child: Card(
            child: ListView(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0)
                ),
                ExpansionTile(
                  title: Text("Service Status"),
                  trailing: Icon(FontAwesomeIcons.angleDoubleRight),
                  children: <Widget>[
                    Container(height: 8),
                    SizedBox(height: 10,width: 0),
                    DropDownField(
                      textStyle: const TextStyle(fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 15.0),
                      controller: type_id,
                      hintText: "Select Service",
                      labelText: 'Service Type',
                      enabled: true,
                      itemsVisibleInDropdown: 3,
                      items: services,
                      onValueChanged: (value) {
                        setState(() {
                          type_id = value;
                        });
                      },
                    ),
                    Container(height: 8),
                    TextField(
                      controller: remark,
                      decoration: InputDecoration(border: OutlineInputBorder(),
                          hintText: 'Remarks',
                          labelText: 'Remarks'
                      ),
                    ),
                    Container(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 35,
                      child: RaisedButton(
                          child: Text("Submit", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold ),),
                          color: Theme.of(context).primaryColor,
                          onPressed: () async {
                            setState(() {
                              _isLoading= true;
                            });
                            final serve = ServiceStatusUpdate(
                              job_id : _idController.text,
                              type_id: type_id.text,
                              remark: remark.text,
                            );
                            final result = await service.manageStatus(serve);
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
                    ),
                    Container(height: 18),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0)
                ),
                ExpansionTile(
                  title: Text("Receive Additional Products"),
                  trailing: Icon(FontAwesomeIcons.angleDoubleRight),
                  children: <Widget>[
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
                          hintText: 'Item Reference Number',
                          labelText: 'Item Reference Number'
                      ),
                    ),
                    Container(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 35,
                      child: RaisedButton(
                          child: Text("Submit", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold ),),
                          color: Theme.of(context).primaryColor,
                          onPressed: () async {
                            setState(() {
                              _isLoading= true;
                            });
                            final job = Additional(
                              jb_id : _idController.text,
                              item_name: item_name.text,
                              item_ref_number: item_ref_number.text,
                            );
                            final result = await service.addPro(job);
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
                    ),
                    Container(height: 18),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0)
                ),
                ExpansionTile(
                  title: Text("Add Charges"),
                  trailing: Icon(FontAwesomeIcons.angleDoubleRight),
                  children: <Widget>[
                    Container(height: 8),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(border: OutlineInputBorder(),
                          hintText: 'JobSheet Number',
                          labelText: 'JobSheet Number'
                      ),
                    ),
                    Container(height: 8),
                    TextField(
                      controller: _statusController,
                      decoration: InputDecoration(border: OutlineInputBorder(),
                          hintText: 'Job Status',
                          labelText: 'Job Status'
                      ),
                    ),
                    Container(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 35,
                      child: RaisedButton(
                          child: Text("Submit", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold ),),
                          color: Theme.of(context).primaryColor,
                          onPressed: () async {
                            setState(() {
                              _isLoading= true;
                            });
                            final job = JobStatusUpdate(
                              ID : _idController.text,
                              jobsheetNumber: _titleController.text,
                              job_status: _statusController.text,
                            );
                            final result = await service.manageJob(job);
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
                    ),
                    Container(height: 18),
                  ],
                ),Padding(
                    padding: const EdgeInsets.all(8.0)
                ),
                ExpansionTile(
                  title: Text("Sent for Outside Work"),
                  trailing: Icon(FontAwesomeIcons.angleDoubleRight),
                  children: <Widget>[
                    Container(height: 8),
                    SizedBox(height: 10,width: 0),
                    DropDownField(
                      textStyle: const TextStyle(fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 15.0),
                      controller: type_id,
                      hintText: "Select Item",
                      labelText: 'Select Item',
                      enabled: true,
                      itemsVisibleInDropdown: 3,
                      items: services,
                      onValueChanged: (value) {
                        setState(() {
                          type_id = value;
                        });
                      },
                    ),
                    Container(height: 8),
                    SizedBox(height: 10,width: 0),
                    DropDownField(
                      textStyle: const TextStyle(fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 15.0),
                      controller: type_id,
                      hintText: "Select Supplier",
                      labelText: 'Select Supplier',
                      enabled: true,
                      itemsVisibleInDropdown: 3,
                      items: services,
                      onValueChanged: (value) {
                        setState(() {
                          type_id = value;
                        });
                      },
                    ),
                    Container(height: 8),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(border: OutlineInputBorder(),
                          hintText: 'Supplier Reference',
                          labelText: 'Supplier Reference'
                      ),
                    ),
                    Container(height: 8),
                    TextField(
                      controller: _statusController,
                      decoration: InputDecoration(border: OutlineInputBorder(),
                          hintText: 'Date',
                          labelText: 'Date'
                      ),
                    ),
                    Container(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 35,
                      child: RaisedButton(
                          child: Text("Submit", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold ),),
                          color: Theme.of(context).primaryColor,
                          onPressed: () async {
                            final title = 'Done';
                            final text =  'Jobsheet Updated';
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
                            );
                          }
                      ),
                    ),
                    Container(height: 18),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0)
                ),
                ExpansionTile(
                  title: Text("Received from Outside Work"),
                  trailing: Icon(FontAwesomeIcons.angleDoubleRight),
                  children: <Widget>[
                    Container(height: 8),
                    SizedBox(height: 10,width: 0),
                    DropDownField(
                      textStyle: const TextStyle(fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 15.0),
                      controller: type_id,
                      hintText: "Select Item",
                      labelText: 'Select Item',
                      enabled: true,
                      itemsVisibleInDropdown: 3,
                      items: services,
                      onValueChanged: (value) {
                        setState(() {
                          type_id = value;
                        });
                      },
                    ),
                    Container(height: 8),
                    SizedBox(height: 10,width: 0),
                    DropDownField(
                      textStyle: const TextStyle(fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 15.0),
                      controller: type_id,
                      hintText: "Select Supplier",
                      labelText: 'Select Supplier',
                      enabled: true,
                      itemsVisibleInDropdown: 3,
                      items: services,
                      onValueChanged: (value) {
                        setState(() {
                          type_id = value;
                        });
                      },
                    ),
                    Container(height: 8),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(border: OutlineInputBorder(),
                          hintText: 'Supplier Reference',
                          labelText: 'Supplier Reference'
                      ),
                    ),
                    Container(height: 8),
                    TextField(
                      controller: _statusController,
                      decoration: InputDecoration(border: OutlineInputBorder(),
                          hintText: 'Date',
                          labelText: 'Date'
                      ),
                    ),
                    Container(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 35,
                      child: RaisedButton(
                          child: Text("Submit", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold ),),
                          color: Theme.of(context).primaryColor,
                          onPressed: () async {
                            final title = 'Success';
                            final text =  'Job Updated';
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
                            );
                          }
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0)
                ),
                ExpansionTile(
                  title: Text("Job Status"),
                  trailing: Icon(FontAwesomeIcons.angleDoubleRight),
                  children: <Widget>[
                    Container(height: 8),
                    SizedBox(height: 10,width: 0),
                    DropDownField(
                      textStyle: const TextStyle(fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 15.0),
                      controller: _statusController,
                      hintText: "Select Status",
                      labelText: 'Job Status',
                      enabled: true,
                      itemsVisibleInDropdown: 3,
                      items: status,
                      onValueChanged: (value) {
                        setState(() {
                          _statusController = value;
                        });
                      },
                    ),
                    Container(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 35,
                      child: RaisedButton(
                          child: Text("Submit", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold ),),
                          color: Theme.of(context).primaryColor,
                          onPressed: () async {
                            setState(() {
                              _isLoading= true;
                            });
                            final job = JobStatusUpdate(
                              ID : _idController.text,
                              jobsheetNumber: _titleController.text,
                              job_status: _statusController.text,
                            );
                            final result = await service.manageJob(job);
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
                    ),
                    Container(height: 18),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
