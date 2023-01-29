import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class intelege extends StatefulWidget {
  static String routeName = "/intelege";

  _showstudentmtd createState() => _showstudentmtd();
}

class _showstudentmtd extends State<intelege> {
  var status;
  var data;

  Future intlege() async {

    final pref = await SharedPreferences.getInstance();
    final key = 'token';
    final value = pref.get(key);

    String ServerUrl =
        "https://extra-hint.herokuapp.com/api/service/intell_advise";
    final response = await http.get(
      ServerUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${value}'
      },
    );
    status = response.body.contains("error");
    data = jsonDecode(response.body);

    if (status) {
      print("data :${data["error"]}");
    } else {
      print("intelege: ${data}");
      print("data: ${data.length}");
    }
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    intlege();

  }
  void _showDialog(String head, String body) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(head),
            content: Text(body),
            actions: [
              RaisedButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
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
            "Advising for semester",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ),
        body: Center(
          child: FutureBuilder(
              future: intlege(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (_, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            if (index != 0)
                              DataTable(columns: [
                                DataColumn(label: Text('Course',
                                  style: TextStyle(fontSize: 15, color : Colors.black),)),
                                DataColumn(label: Text('Level',
                                  style: TextStyle(fontSize: 15, color : Colors.black),)),
                                DataColumn(label: Text('Degree',
                                  style: TextStyle(fontSize: 15, color : Colors.black),)),
                              ],
                                  rows: [
                                  DataRow(cells:[ DataCell(Text(snapshot.data['${index}']['ccode'],
                                style: TextStyle(
                                  fontSize: 15,
                                ),)),
                        DataCell(Text(snapshot.data['${index}']['c_lvl']
                            .toString()
                            .trim(),
                        style: TextStyle(
                        fontSize: 15,
                        ),)),
                        DataCell(Text(snapshot.data['${index}']['c_theoretical_ratio']
                            .toString()
                            .trim(),
                        style: TextStyle(
                        fontSize: 15,
                        ),)),


                        ]),
                            ],
                                  ),

                          ],
                        );
                      });
                }
              }),
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()
    {
      _showDialog('AFS','Advising for semester is an algorithm that help students to enroll their courses\n depend on their roadmap (Theoretical or scientific)');

    },

        icon : Icon(Icons.message),
        label: Text('HELP'),
        foregroundColor: Colors.orange,
        backgroundColor: Colors.purple,
      ),
    );
  }
}