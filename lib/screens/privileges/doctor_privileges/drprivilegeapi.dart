import'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class drapi extends StatelessWidget {
  var status;
  var data;


  showfreq(String token) async {
    String ServerUrl = "https://extra-hint.herokuapp.com/api/service/list_feedbacks";
    final response = await http.post(ServerUrl, headers: {
      'Accept': 'application/json',
      'Authorization':'Bearer ${token}'
    },);
    status = response.body.contains("error");
    data = jsonDecode(response.body);
    if (status) {
      print("data :${data["error"]}");
    }
    return data;


  }


  postfreq(String token,String cname,String question,String answer) async {
    String ServerUrl = "https://extra-hint.herokuapp.com/api/service/add_feedback";
    final response = await http.post(ServerUrl, headers: {
      'Accept': 'application/json',
      'Authorization':'Bearer ${token}'
    },
      body: {
      'ccode':cname,
        'fheader':question,
        'fbody':answer,

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
    String ServerUrl = "https://extra-hint.herokuapp.com/api/service/list_feedbacks";
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
  getsturecord(String token,String sname,String year,String semes) async {
    String ServerUrl = "https://extra-hint.herokuapp.com/api/service/list_feedbacks";
    final response = await http.post(ServerUrl, headers: {
      'Accept': 'application/json',
      'Authorization':'Bearer ${token}'
    },
        body: {
          'Student_id':sname,
          'year':year,
          'semester':semes,
          'all_years':1,

        }
    );
    status = response.body.contains("error");
    data = jsonDecode(response.body);
    if (status) {
      print("data :${data["error"]}");
    }
    return data;


  }






  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

