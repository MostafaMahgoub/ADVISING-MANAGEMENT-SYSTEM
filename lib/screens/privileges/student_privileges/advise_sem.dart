
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/*class intelege extends StatefulWidget {
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (index == 0)
                              Table(
                                  border: TableBorder.all(color: Colors.black),
                                  children: [
                                    TableRow(
                                      children: [
                                        Container(
                                          color: Colors.black,
                                          child: Center(
                                              child: Text(
                                                ' CODE :',
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
                                                ' LEVEL :',
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
                                                ' DEGREE :',
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
                                border: TableBorder.all(color: Colors.black),
                                children: [
                                  TableRow(
                                    children: [
                                      Center(
                                          child: Text(
                                            snapshot.data['${index}']['ccode'],
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          )),
                                      Center(
                                          child: Text(
                                            snapshot.data['${index}']['c_lvl']
                                                .toString()
                                                .trim(),
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          )),
                                      Center(
                                          child: Text(
                                            snapshot.data['${index}']['c_theoretical_ratio']
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
                      });
                }
              }),
        ));
  }
}*/
