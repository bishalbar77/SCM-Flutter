import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:scm/models/Job.dart';
import 'package:scm/models/JobStatusUpdate.dart';
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



  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text('Manage Jobsheet' ),),
  //     body: Padding(
  //       padding: const EdgeInsets.all(12.0),
  //       child: _isLoading ? CircularProgressIndicator() :Column(
  //         children: [
  //           TextField(
  //             controller: _titleController,
  //             decoration: InputDecoration(border: OutlineInputBorder(),
  //                 hintText: 'JobSheet Number',
  //                 labelText: 'JobSheet Number'
  //             ),
  //           ),
  //           Container(height: 8),
  //           TextField(
  //             controller: _statusController,
  //             decoration: InputDecoration(border: OutlineInputBorder(),
  //                 hintText: 'Job Status',
  //                 labelText: 'Job Status'
  //             ),
  //           ),
  //           Container(height: 18),
  //           SizedBox(
  //             width: double.infinity,
  //             height: 35,
  //             child: RaisedButton(
  //               child: Text('Submit',style: TextStyle(color: Colors.white),),
  //               color: Theme.of(context).primaryColor,
  //               onPressed: () async {
  //                 setState(() {
  //                   _isLoading= true;
  //                 });
  //                 final job = JobStatusUpdate(
  //                   ID : _idController.text,
  //                   jobsheetNumber: _titleController.text,
  //                   job_status: _statusController.text,
  //                 );
  //                 final result = await service.manageJob(job);
  //                 setState(() {
  //                   _isLoading= true;
  //                 });
  //                 final title = 'Done';
  //                 final text = result.error ? (result.errorMessage ?? 'An error occurred' ): 'Jobsheet Updated';
  //                 showDialog(
  //                   context: context,
  //                   builder: (_) => AlertDialog(
  //                     title: Text(title),
  //                     content: Text(text),
  //                     actions: <Widget>[
  //                       FlatButton(
  //                         child: Text('Ok'),
  //                         onPressed: () {
  //                         Navigator.of(context).pop();
  //                         },
  //                       )
  //                     ],
  //                   )
  //                 )
  //                 .then((data) {
  //                   if (result.data) {
  //                     Navigator.of(context).pop();
  //                   }
  //                 });
  //               }
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "Status",),
              Tab(text: "Additional"),
              Tab(text: "Charges"),
              Tab(text: "Send"),
              Tab(text: "Receive"),
              Tab(text: "Service"),
            ],
          ),
          title: Text('Manage Jobsheet'),
        ),
        body: TabBarView(
          children: [
               Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: _isLoading ? CircularProgressIndicator() :ListView(
                    children: [
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
                            child: Text('Submit',style: TextStyle(color: Colors.white),),
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
                      )
                    ],
                  ),
                ),
              ),
            Center( child: Text("Page 2")),
            Center( child: Text("Page 3")),
            Center( child: Text("Page 4")),
            Center( child: Text("Page 5")),
            Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _isLoading ? CircularProgressIndicator() :ListView(
                  children: [
                    TextField(
                      decoration: InputDecoration(border: OutlineInputBorder(),
                          hintText: 'Service Type',
                          labelText: 'Service Type'
                      ),
                    ),
                    Container(height: 8),
                    TextField(
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
                          child: Text('Submit',style: TextStyle(color: Colors.white),),
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
