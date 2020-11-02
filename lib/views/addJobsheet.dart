import 'package:flutter/material.dart';

class AddJobsheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Jobsheet Details'),),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
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
              decoration: InputDecoration(border: OutlineInputBorder(),
                hintText: 'Customer Name',
                  labelText: 'Customer Name'
              ),
            ),
            Container(height: 8),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Service Type',
                  labelText: 'Service Type'
              ),
            ),
            Container(height: 8),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Jobsheet Number',
                  labelText: 'Jobsheet Number'
              ),
            ),
            Container(height: 8),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Jobsheet Date',
                  labelText: 'Jobsheet Date'
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
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Product Type',
                  labelText: 'Product Type'
              ),
            ),
            Container(height: 8),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Brand',
                  labelText: 'Brand'
              ),
            ),
            Container(height: 8),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Model Name',
                  labelText: 'Model Name'
              ),
            ),
            Container(height: 8),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Model Number',
                  labelText: 'Model Number'
              ),
            ),
            Container(height: 8),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Serial Number',
                  labelText: 'Serial Number'
              ),
            ),
            Container(height: 8),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Device Configuration',
                  labelText: 'Device Configuration'
              ),
            ),
            Container(height: 8),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Password',
                  labelText: 'Password'
              ),
            ),
            Container(height: 8),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Problem reported',
                  labelText: 'Problem reported'
              ),
            ),
            Container(height: 8),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Service Type',
                  labelText: 'Service Type'
              ),
            ),
            Container(height: 8),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Physical Status',
                  labelText: 'Physical Status'
              ),
            ),
            Container(height: 8),
            TextField(
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
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Item Name',
                  labelText: 'Item Name'
              ),
            ),
            Container(height: 8),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'Service Type',
                  labelText: 'Service Type'
              ),
            ),
            Container(height: 8),
            TextField(
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
