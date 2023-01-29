import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class showfq extends StatefulWidget {
  static String routeName = "/showfq";

  @override
  _showfqState createState() => _showfqState();
}

class _showfqState extends State<showfq> {
  var status;

  var data;

  Future showfreq() async {

    final pref= await SharedPreferences.getInstance();
    final key ='token';
    final value = pref.get(key)  ;


    String ServerUrl = "https://extra-hint.herokuapp.com/api/service/list_feedbacks";
    final response = await http.get(ServerUrl, headers: {
      'Accept': 'application/json',
      'Authorization':'Bearer ${value}'
    },);
    status = response.body.contains("err");
    print("the orignal body  : ${response.body}");
    data = jsonDecode(response.body);
    if (status) {
      print("data :${data["err"]}");
    }
    print("the orignal body  : ${data}");
    return data;


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showfreq();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text("Show frequently questions",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
      ),

    body : Center(
      child: FutureBuilder(
        future:showfreq(),
        builder: (ctx, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting)
            {return CircularProgressIndicator();}
          else{
            return ListView.builder(
              itemCount: data['ALL Feedback'].length,
              itemBuilder: (_, index){
                return Card(
                  child : Padding(
                    padding: const EdgeInsets.only(top:32.0 , bottom:32,left:16.0,right:16.0),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children : <Widget>[
                        ListTile(
                          subtitle: Text("${snapshot.data['ALL Feedback'][index]['fheader']}",
                            style: TextStyle(
                                fontSize:22,
                                fontWeight : FontWeight.bold
                            ),
                          ),
                          title: Text("${snapshot.data['ALL Feedback'][index]['fbody']}",
                            style: TextStyle(
                              color:Colors.grey.shade600,
                            ),),
                          trailing: Text("${snapshot.data['ALL Feedback'][index]['User_id']} "),

                        ),

                      ],
                    ),
                  ),
                );
              },
            );
          }

        }
      ),
    )
    );
  }
}