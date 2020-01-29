import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//const String url_api = "http://nabita.info/eduprog/crud/service.php";
const String url_api = "http://10.14.52.46:8080/flutter_login/service.php";

class UserData {
  static String userName;
  static String userFullName;
  static String userSession;

  static printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}



void setConfigUser(String _user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('c_user', _user);
}

Future<String> getConfigUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _data = prefs.getString('c_user');
  return _data;
}

void setConfigSession(String _user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('c_session', _user);
}

Future<String> getConfigSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _data = prefs.getString('c_session');
  return _data;
}


void showLoading(context, b) async {
  if (b)
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  width: 10,
                ),
                Text("Loading..."),
              ],
            ),
          ),
        );
      },
    );
  else
    Navigator.pop(context);
}

Future<bool> showAlert(BuildContext context, String text, String title) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      );
    },
  );
}

Future httpPost(String url, Map<String, String> params) async {

  try{
    final response =
    await http.post(url, body: params);
    print("ini url :${url}  param ${params}");


    if (response.statusCode == 200) {

      print('data body ${response.body}');
      // If the call to the server was successful, parse the JSON
      return response.body;
    } else {
      // If that call was not successful, throw an error.
      //throw Exception('Failed to load post');
      return null;
    }
  }catch(e){
    return null;
  }



}
