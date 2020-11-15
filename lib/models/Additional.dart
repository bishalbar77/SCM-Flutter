import 'package:flutter/cupertino.dart';

class Additional {
  String jb_id;
  String item_name;
  String item_ref_number;

  Additional({
    @required this.jb_id,
    @required this.item_name,
    @required this.item_ref_number,
  });


  Map<String, dynamic> toJson() {
    return {
      "jb_id" : jb_id,
      "item_name": item_name,
      "item_ref_number" : item_ref_number,
    };
  }
}