import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T>{


  Future showAlertDialog(String title,String msg,VoidCallback positive){
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: <Widget>[
        FlatButton(
          onPressed: positive,
          child: Text('确定'),
        ),
        FlatButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text('取消'),
        )
      ],
    ));
  }

  void showToast(String msg){
    Toast.show(msg, context);
  }

}