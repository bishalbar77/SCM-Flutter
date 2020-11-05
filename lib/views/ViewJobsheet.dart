import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:scm/models/ApiResponse.dart';
import 'package:scm/models/Jobsheet.dart';
import 'package:scm/services/JobSheetService.dart';
import 'package:scm/views/CloseJobsheet.dart';
import 'package:scm/views/ViewJob.dart';
import 'ManageJobsheet.dart';
import 'addJobsheet.dart';

class ViewJobsheet extends StatefulWidget {

  _ViewJobsheetState createState() => _ViewJobsheetState();
}
class _ViewJobsheetState extends State<ViewJobsheet>
{

  JobSheetService get service =>  GetIt.I<JobSheetService>();
  // Model

  String formatTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
  ApiResponse<List<Jobsheet>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchJobs();
    super.initState();
  }

  _fetchJobs() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getJobSheet();
    setState(() {
      _isLoading =false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Jobsheets'),),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (__) => AddJobsheet()))
                .then((_) {
              _fetchJobs();
            });
          },
          child: Icon(Icons.add),
        ),
        body: Builder(
          builder: (_) {
            if (_isLoading) {
              return CircularProgressIndicator();
            }
            if(_apiResponse?.error) {
              return Center(child: Text(_apiResponse.errorMessage));
            }

            return ListView.separated(
                itemBuilder:(__, index) {
                  return Dismissible(
                    key: ValueKey(_apiResponse.data[index].jobsheetNumber),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {

                    },
                    confirmDismiss: (direction) async{
                      final result = await showDialog(
                          context: context,
                          builder: (_) => CloseJobsheet()
                      );
                      return(result);
                    },
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.only(left: 16),
                      child: Align(child: Icon(Icons.delete, color: Colors.white,), alignment: Alignment.centerLeft,),
                    ),
                    child: ListTile(
                      title: Text(_apiResponse.data[index].jobsheetNumber, style: TextStyle(color: Theme.of(context).primaryColor),),
                      subtitle: Text('Last managed on ${_apiResponse.data[index].job_date}'),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (__) => ViewJob(ID: _apiResponse.data[index].ID)));
                      },
                    ),
                  );
                },
                separatorBuilder: (_, __) => Divider(height: 1, color: Colors.green),
                itemCount: _apiResponse.data.length);
          },
        )
    );
  }
}

