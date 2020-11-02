import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:scm/services/JobSheetService.dart';
import 'package:scm/views/addJobsheet.dart';
import 'package:scm/views/list_jobsheet.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => JobSheetService());
}

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
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              accountName: Text('Demo User'),
              accountEmail: Text('admin@admin.com'),
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
                    .push(MaterialPageRoute(builder: (__) => Joblist()));
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
              onTap: (){},
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
              onTap: (){},
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
