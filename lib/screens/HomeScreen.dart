import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:get/get.dart';
import 'package:remainder/controller/datacontroller.dart';
import '../models.dart';
import '../services/dataService.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: ReadJsonData(), builder: (context,data){
        if(data.hasError){
          return Center(
            child: Text("${data.error}"),
          );
        }else if(data.hasData){
          var items = data.data as List<UserModel>;
          return
            ListView.builder(itemBuilder: (context,index){
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 6),

                child: Container(
                  height:MediaQuery.of(context).size.height*0.25,
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,height: 100,
                        child: Image(image: NetworkImage(items[index].avatar.toString()),
                          fit: BoxFit.fill,),
                      ),
                      Expanded(child: Container(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(left: 8,right: 8,top: 18),
                              child: Text(
                                items[index].firstName + " " +items[index].lastName+"("+items[index].gender+")",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),),  ),
                            Padding(padding: EdgeInsets.only(left:0.2,right: 9,top: 8),
                              child: Text(
                                items[index].email,
                                style: TextStyle(
                                  fontSize: 15,

                                ),),),

                            Padding(padding: EdgeInsets.only(left: 8,right: 8,top: 7),
                              child: Text("Gender: "+
                                  items[index].gender.toString(),
                                style: TextStyle(
                                  fontSize: 15,

                                ),),  ),
                            Padding(padding: EdgeInsets.only(left: 8,right: 8,top: 6),
                              child: Text("Domain: "+
                                  items[index].domain,
                                style: TextStyle(
                                  fontSize: 15,

                                ),),  ),
                            Padding(padding: EdgeInsets.only(left: 8,right: 8,top: 8),
                              child: Text("Availability: "+
                                  items[index].available.toString(),
                                style: TextStyle(
                                  fontSize: 15,

                                ),),  ),
                          ],
                        ),

                      )),

                    ],
                  ),

                ),
              );
            });
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }

      }),
    );
  }


  Future<List<UserModel>>ReadJsonData()async{
    final response = await rootBundle.rootBundle.loadString('jsonfile/data.json');
    final list = json.decode(response as String) as List<dynamic>;

    return list.map((e) => UserModel.fromJson(e)).toList();
  }
}
