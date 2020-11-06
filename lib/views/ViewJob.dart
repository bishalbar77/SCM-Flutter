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

  void product() {
    service2.getproduct(widget.ID)
        .then((response){
      if(response.error) {
        errorMesaage = response.errorMessage ?? 'JOBSHEET not fetched';
      }
      productInfo = response.data;
      _idController.text=productInfo.jobId.toString();
      // _titleController.text = job.jobsheetNumber;
      // _statusController.text = job.job_status;
    });
  }

  Widget build(BuildContext context) {
    return Container(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0)
              ),
              ExpansionTile(
                title: Text("LOGIN FORM"),
                trailing: Icon(FontAwesomeIcons.signInAlt),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'username',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {
                    },
                    child: Text("Log-In"),
                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0)
              ),
              ExpansionTile(
                title: Text("LOGIN FORM"),
                trailing: Icon(FontAwesomeIcons.signInAlt),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'username',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {
                    },
                    child: Text("Log-In"),
                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0)
              ),
              ExpansionTile(
                title: Text("LOGIN FORM"),
                trailing: Icon(FontAwesomeIcons.signInAlt),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'username',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {
                    },
                    child: Text("Log-In"),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
