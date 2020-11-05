import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:scm/models/Job.dart';
import 'package:scm/models/ProductInfo.dart';
import 'package:scm/services/JobSheetService.dart';

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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('$_titleController.text'),
        ),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) => EntryItem(
            data[index],
          ),
        ),
      ),
    );
  }
}

class Entry {
  final String title;
  final List<Entry>
  children; // Since this is an expansion list ...children can be another list of entries
  Entry(this.title, [this.children = const <Entry>[]]);
}

// This is the entire multi-level list displayed by this app
final List<Entry> data = <Entry>[
  Entry(
    'Service',
    <Entry>[
      Entry(
        'Section A0',
        <Entry>[
          Entry('Item A0.1'),
          Entry('Item A0.2'),
          Entry('Item A0.3'),
        ],
      ),
      Entry('Section A1'),
      Entry('Section A2'),
    ],
  ),
  // Second Row
  Entry('Product Information', <Entry>[
    Entry('Section B0'),
    Entry('Section B1'),
  ]),
  Entry(
    'Service Status',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
      Entry(
        'Section C2',
        <Entry>[
          Entry('Item C2.0'),
          Entry('Item C2.1'),
          Entry('Item C2.2'),
          Entry('Item C2.3'),
        ],
      )
    ],
  ),
];

// Create the Widget for the row
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);
  final Entry entry;

  // This function recursively creates the multi-level list rows.
  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(
        title: Text(root.title),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}