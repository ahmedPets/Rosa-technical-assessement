import 'package:flutter/material.dart';
import 'package:technical_assessement/constants/colors.dart';
import 'package:technical_assessement/constants/strings.dart';

showAlertDialog(BuildContext context) {  
  // Create button  
  Widget okButton = ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(kColorMain),
    ),
    child: const Text(kStringOk),
    onPressed: () {  
      Navigator.of(context).pop();  
    },  
  );  
  
  // Create AlertDialog  
  AlertDialog alert = AlertDialog(  
    // title: Text("Simple Alert"),  
    content: const Text(kStringSelectionDate),
    actions: [  
      okButton,  
    ],  
  );  
  
  // show the dialog  
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );  
}