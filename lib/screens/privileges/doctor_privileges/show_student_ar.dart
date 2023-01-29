import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class showstudentar extends StatefulWidget {
  static String routeName = "/showstudentar";
  String fname, lname;
  showstudentar({
    this.fname,
  });

  _showstudentar createState() => _showstudentar();
}

class _showstudentar extends State<showstudentar> {
  var status, status2, usert, dlevel, slevel;
  var data;
  var data2;
  String x;
  var ddata;
  var sid;
  var did;

  _read() async {
    final pref1 = await SharedPreferences.getInstance();
    x = pref1.get('uname');
    sid = pref1.get('uid');
    slevel = pref1.get('level');
  }

  searchstudent(
    String fname,
  ) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);
    usert = pref.get('usertype');

    String ServerUrl = "https://extra-hint.herokuapp.com/api/auth/deep_search";
    final response = await http.post(ServerUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${value}'
    }, body: {
      'Student_id': fname,
    });
    status2 = response.body.contains("err");
    data2 = jsonDecode(response.body);

    if (status2) {
      print(" data :${data2["err"]}");
    } else {
      //print("searched data: ${data2['student'][1]['id']}");

    }
    return data2;
  }

  Future getstuar() async {
    /* ddata = widget.fname != null
        ? await searchstudent(
            widget.fname,
          )
        : 0;
    did = ddata['student'][0]['id'];
    dlevel = ddata['student'][0]['id'];*/
    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);

    String ServerUrl =
        "https://extra-hint.herokuapp.com/api/service/Student_Records";
    final response = await http.post(
      ServerUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${value}'
      },
      body: usert == '2'
          ? {
              'msg': 'cgpa',
              'Student_id': "${widget.fname}",
            }
          : {
              'msg': 'cgpa',
            },
    );
    status = response.body.contains("err");
    data = jsonDecode(response.body);

    if (status) {
      print("data :${data}");
    } else {
      print("data: ${data}");
      // print("data: ${data.length}");
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(
          "Academic Record",
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
                    future: getstuar(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        return ListView.builder(
                            itemCount: data.length - 1,
                            itemBuilder: (_, index) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  if (index == 0)
                                    ListTile(
                                      title: Column(
                                        children: [
                                          Row(
                                            children: [
                                              widget.fname != null
                                                  ? Text(
                                                      "Student name:  ${widget.fname}",
                                                      style: new TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          foreground: Paint()),
                                                    )
                                                  : Text(
                                                      "Student name:  ${x}",
                                                      style: new TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          foreground: Paint()),
                                                    ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text('acadmic id :'),
                                              usert == '2'
                                                  ? Text('${did}')
                                                  : Text('${sid}'),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  'program : computer science'),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text('acadmic level :'),
                                              usert == '2'
                                                  ? Text('${dlevel}')
                                                  : Text('${slevel}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  if (!snapshot.data[index]['original'].keys
                                      .contains("err"))
                                    Row(
                                      children: [
                                        Container(
                                          child: Center(
                                              child: Text(
                                            'year :',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          )),
                                        ),
                                        Container(
                                          child: Center(
                                              child: Text(
                                            '${snapshot.data[index]["original"]['year']}',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          )),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          child: Center(
                                              child: Text(
                                            'semest',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          )),
                                        ),
                                        Container(
                                          child: Center(
                                              child: Text(
                                            ' ${snapshot.data[index]['original']['semester']}',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          )),
                                        ),
                                      ],
                                    ),
                                  Table(
                                      border:
                                          TableBorder.all(color: Colors.black),
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
                                                ' gl :',
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
                                                ' point :',
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
                                                ' degree :',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ]),
                                  /* if (!snapshot.data[index]['original'].keys
                                      .contains("err"))
                                    for (int i = 0;
                                        i <
                                            snapshot
                                                .data[index]['original']
                                                    ['Courses']
                                                .length;
                                        i++)
                                      Table(
                                          border: TableBorder.all(
                                              color: Colors.black),
                                          children: [
                                            TableRow(
                                              children: [
                                                Center(
                                                    child: Text(
                                                  snapshot.data[index]
                                                          ['original']
                                                          ['Courses'][i]
                                                          ["Course code="]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                )),
                                                Center(
                                                    child: Text(
                                                  snapshot.data[index]
                                                          ['original']
                                                          ['Courses'][i]
                                                          ["Grade="]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                )),
                                                Center(
                                                    child: Text(
                                                  snapshot.data[index][i]
                                                          ["Points="]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                )),
                                                Center(
                                                    child: Text(
                                                  snapshot.data[index][i]
                                                          ["degree"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                )),
                                              ],
                                            ),
                                          ]),*/
                                  if (!snapshot.data[index]['original'].keys
                                      .contains("err"))
                                    Table(
                                        border: TableBorder.all(
                                            color: Colors.black),
                                        children: [
                                          TableRow(
                                            children: [
                                              Center(
                                                  child: Text(
                                                'semester gpa',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              )),
                                              Center(
                                                  child: Text(
                                                snapshot.data[1]['original']
                                                        ['sgpa:']
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              )),
                                            ],
                                          ),
                                        ]),
                                ],
                              );
                            });
                      }
                    });
              }
            }),
      ),
    );
  }
}
