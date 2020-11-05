import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:get_it/get_it.dart';
import 'package:scm/models/User.dart';
import 'package:scm/services/JobSheetService.dart';
import 'package:scm/views/ViewJobsheet.dart';
import 'package:scm/views/addJobsheet.dart';
import 'package:scm/views/list_jobsheet.dart';
import 'package:scm/views/login.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => JobSheetService());
}
final page = LoginPage();

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: page,
    );
  }
}

class Homepage extends StatefulWidget {

  final String email;
  Homepage({
    this.email
  });


  @override
  _HomepageState createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {

  JobSheetService get service =>  GetIt.I<JobSheetService>();
  String errorMesaage;
  User user = new User();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idController = TextEditingController();

  bool _isLoading = false;
  @override
  void initState() {
    // checkSession();
    super.initState();
    setState(() {
      _isLoading = true;
    });
    service.userData(widget.email)
        .then((response) {
      setState(() {
        _isLoading = false;
      });
      if(response.error) {
        errorMesaage = response.errorMessage ?? 'JOBSHEET not fetched';
      }
      user = response.data;
      _idController.text = user.ID.toString();
      _nameController.text = user.name;
      _emailController.text = user.email;
    });
  }

  // checkSession() {
  //   if(widget.email==null) {
  //     // Navigator.of(context)
  //     //     .push(MaterialPageRoute(builder: (__) => LoginPage()));
  //   }
  // }



  @override
  Widget build(BuildContext context) {
      // if (_isLoading) {
      //   return CircularProgressIndicator();
      // }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add_to_queue, color: Colors.white,), onPressed: (){
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (__) => AddJobsheet()));
          }),
          IconButton(icon: Icon(Icons.notifications_none, color: Colors.white,), onPressed: (){}),
        ],
        title: Text('SCM'),
      ),
      drawer: Drawer(
        child: new ListView(
          children: <Widget>[
            // Drawer header
            UserAccountsDrawerHeader(
              accountName: Text(_nameController.text),
              accountEmail: Text(_emailController.text),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white,),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blueAccent
              ),
            ),
            //Drawer Body
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Dashboard'),
                leading: Icon(Icons.home, color: Colors.blue,),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (__) => ViewJobsheet()));
              },
              child: ListTile(
                title: Text('Jobsheet'),
                leading: Icon(Icons.add_to_queue, color: Colors.amber,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Customer'),
                leading: Icon(Icons.group, color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (__) => Joblist()));
              },
              child: ListTile(
                title: Text('Manage Jobsheet'),
                leading: Icon(Icons.add_shopping_cart, color: Colors.blueAccent,),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (__) => AddJobsheet()));
              },
              child: ListTile(
                title: Text('Add Jobsheet'),
                leading: Icon(Icons.group_add, color: Colors.blueAccent,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings, color: Colors.deepPurple,),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (__) => LoginPage()));
              },
              child: ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.subdirectory_arrow_right,color: Colors.black,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
