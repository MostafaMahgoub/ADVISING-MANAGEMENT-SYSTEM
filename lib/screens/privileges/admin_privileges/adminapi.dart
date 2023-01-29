import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class adminapi extends StatelessWidget {

  var status;
  var data;
  var courses;


  updatemid(String token,String sname,String year,String semes,List<String> courses) async {
    String ServerUrl = "https://extra-hint.herokuapp.com/api/service/degree";
    final response = await http.post(ServerUrl, headers: {
      'Accept': 'application/json',
      'Authorization':'Bearer ${token}'
    },
        body: {
          'Student_id':sname,
          'year':year,
          'semester':semes,
          'courses':courses,

        }
    );
    status = response.body.contains("error");
    data = jsonDecode(response.body);
    if (status) {
      print("data :${data["error"]}");
    }else
    {
      print("data:${data["success"]}");
    }


  }



  getstumid(String token,String sname,String year,String semes) async {
    String ServerUrl = "https://extra-hint.herokuapp.com/api/service/mid";
    final response = await http.post(ServerUrl, headers: {
      'Accept': 'application/json',
      'Authorization':'Bearer ${token}'
    },
        body: {
          'Student_id':sname,
          'year':year,
          'semester':semes,
          'all_years':0,

        }
    );
    status = response.body.contains("error");
    data = jsonDecode(response.body);
    if (status) {
      print("data :${data["error"]}");
    }
    return data;


  }


  updatefinal(String token,String sname,String year,String semes,List<String> courses) async {
    String ServerUrl = "https://extra-hint.herokuapp.com/api/service/degree";
    final response = await http.post(ServerUrl, headers: {
      'Accept': 'application/json',
      'Authorization':'Bearer ${token}'
    },
        body: {
          'Student_id':sname,
          'year':year,
          'semester':semes,
          'courses':courses,

        }
    );
    status = response.body.contains("error");
    data = jsonDecode(response.body);
    if (status) {
      print("data :${data["error"]}");
    }else
    {
      print("data:${data["success"]}");
    }


  }



  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
