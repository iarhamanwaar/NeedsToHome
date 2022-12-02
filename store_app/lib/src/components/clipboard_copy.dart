
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget clipboardCopy(){
  return Container(
    width: double.infinity,
    
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(10)
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Copy This Text'),
          IconButton(onPressed: (){
            Clipboard.setData(ClipboardData(text: "Copy This Text"));
          }, icon: Icon(
            Icons.copy
          ))
        ],
      ),
    ),
  );
}