import 'package:flutter/material.dart';

class AddJobsheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Jobsheet Details'),),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'JobSheet Number'
              ),
            ),
            Container(height: 8),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Customer Mobile Number'
              ),
            ),
            Container(height: 8),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Product Type'
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
