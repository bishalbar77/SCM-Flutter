import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:scm/models/Job.dart';
import 'package:scm/services/JobSheetService.dart';

class ManageJobsheet extends StatefulWidget {

  final String jobsheetNumber;
  ManageJobsheet({this.jobsheetNumber});

  @override
  _ManageJobsheetState createState() => _ManageJobsheetState();
}
class _ManageJobsheetState extends State<ManageJobsheet>
{
  bool get isEditing => widget.jobsheetNumber != null;
  JobSheetService get service =>  GetIt.I<JobSheetService>();

  String errorMesaage;
  Job job = new Job();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _statusController = TextEditingController();

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    service.getJob(widget.jobsheetNumber)
    .then((response) {
      print("managejob line 34 Response is this ${response}");
      setState(() {
        _isLoading = false;
      });
      if(response.error) {
        errorMesaage = response.errorMessage ?? 'JOBSHEET not fetched';
      }
      job = response.data;
      print("Response is this $job");
      _titleController.text = job.jobsheetNumber;
      _statusController.text = job.job_status;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Jobsheet' ),),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading ? CircularProgressIndicator() :Column(
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
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
