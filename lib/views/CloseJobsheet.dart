import 'package:flutter/material.dart';

class CloseJobsheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Warning'),
      content: Text('Are you sure you want to close the Jobsheet'),
      actions: [
        FlatButton(
            child: Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop(true);
            }
        ),
        FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop(false);
            }
        ),
      ],
    );
  }
}
