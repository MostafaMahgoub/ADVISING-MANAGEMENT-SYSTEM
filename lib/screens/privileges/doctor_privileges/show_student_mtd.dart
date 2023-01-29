/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class showstudentmtd extends StatefulWidget {
  final String fname, lname;
  showstudentmtd({this.fname, this.lname});
  static String routeName = "/showstudentmtd";

  _showstudentmtd createState() => _showstudentmtd();
}

class _showstudentmtd extends State<showstudentmtd> {
  var status, status2, usert;
  var data;
  var data2;
  String x;

  _read() async {
    final pref1 = await SharedPreferences.getInstance();
    x = pref1.get('uname');
  }

  searchstudent(String fname, String lname) async {
    final pref = await SharedPreferences.getInstance();

    final key = 'token';
    final value = pref.get(key);
    usert = pref.get('usertype');
    String ServerUrl = "https://extra-hint.herokuapp.com/api/auth/deep_search";
    final response = await http.post(ServerUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${value}'
    }, body: {
      'first_name': fname,
      'last_name': lname,
    });
    status2 = response.body.contains("err");
    data2 = jsonDecode(response.body);
    if (status2) {
      print(" search :${data2}");
    } else {
    }
    return data2["student"][1]["id"];
  }

  Future getstumid() async {
    final id = widget.fname != null
        ? await searchstudent(widget.fname, widget.lname)
        : 0;
    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);

    String ServerUrl =
        "https://extra-hint.herokuapp.com/api/service/current_courses";
    final response = await http.post(
      ServerUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${value}'
      },
      body: usert == '2'
          ? {
              'Student_id': '${id}',
            }
          : {},
    );
    status = response.body.contains("error");
    data = jsonDecode(response.body);

    if (status) {
      print("data :${data}");
    } else {
      print("get: ${data}");
    }
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Shader linearGradient = LinearGradient(
      colors: <Color>[Color(0xFFF3BB1C), Color(0xFFFF7643)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            "Student midterm degrees",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ),
        body: Center(
          child: FutureBuilder(
              future: _read(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {

                  return FutureBuilder(
                      future: getstumid(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          return  snapshot.hasData?ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (_, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (index == 0)
                                      widget.fname != null
                                          ? Text(
                                              "Student name:  ${widget.fname} ${widget.lname}",
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  foreground: Paint()
                                                    ..shader = linearGradient),
                                            )
                                          : Text(
                                              "Student name:  ${x}",
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  foreground: Paint()
                                                    ..shader = linearGradient),
                                            ),
                                    if (index == 0)
                                      Table(
                                          border: TableBorder.all(
                                              color: Colors.black),
                                          children: [
                                            TableRow(
                                              children: [
                                                Container(
                                                  color: Colors.black,
                                                  child: Center(
                                                      child: Text(
                                                    ' code :',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                                ),
                                                Container(
                                                  color: Colors.black,
                                                  child: Center(
                                                      child: Text(
                                                    ' mid degree :',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                                ),
                                                Container(
                                                  color: Colors.black,
                                                  child: Center(
                                                      child: Text(
                                                    ' final degree :',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ]),
                                    Table(
                                        border: TableBorder.all(
                                            color: Colors.black),
                                        children: [
                                          TableRow(
                                            children: [
                                              Center(
                                                  child: Text(
                                                snapshot.data[index]['ccode'],
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              )),
                                              Center(
                                                  child: Text(
                                                snapshot.data[index]
                                                        ['hmedterm_d']
                                                    .toString()
                                                    .trim(),
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              )),
                                              Center(
                                                  child: Text(
                                                snapshot.data[index]['hfinal_d']
                                                    .toString()
                                                    .trim(),
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              )),
                                            ],
                                          ),
                                        ]),
                                  ],
                                );
                              }):Center(
                        child: Text("THERE'S NO INFO FOR THIS STUDENT"));
                        }
                      });
                }
              }),
        ));
  }
}
*/