import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_guard/widget/nav.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:http/http.dart' as http;

class RealTimeData extends StatefulWidget {
  const RealTimeData({super.key});

  @override
  State<RealTimeData> createState() => _RealTimeDataState();
}

class _RealTimeDataState extends State<RealTimeData> {
  String temperature = '';
  String humidity = '';
  String moisture = '';
  String heatIndex = '';
  

  Future<void> getInformation() async {
    var response = await http
        .get(Uri.parse('https://d675-120-89-104-102.ngrok.io/view_sensor_data'));
    print(response.body);
  final finalResponse=jsonDecode(response.body);
  print(finalResponse);
    setState(() {
      temperature=finalResponse['temperature'];
      humidity=finalResponse['humid'];
      moisture=finalResponse['moisturevalue'];
      heatIndex=finalResponse['heatindex'];
    });
    try {
      if (response.statusCode == 200) {
        print("sucess to upload image");
      } else {
        print(response.statusCode);
        print('Failed');
      }
    } catch (err) {
      print("error");
      print(err);
    }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 171, 253, 173),
        title: Text("Plant Detail",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: "Philosopher",
          fontSize: 25,
        ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Temperature: ${temperature} C",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
             new LinearPercentIndicator(
               width: MediaQuery.of(context).size.width - 50,
               animation: true,
               lineHeight: 25.0,
               animationDuration: 2000,
               percent: 0.23,
               barRadius: Radius.circular(10),
               progressColor: const Color.fromARGB(255, 255, 190, 59),
             ),
             SizedBox(height: 15,),
              Text("Humidity: ${humidity}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              new LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 25.0,
                animationDuration: 2500,
                percent: 0.44,
                barRadius: Radius.circular(10),
                progressColor: Colors.green,
              ),
              SizedBox(height: 15,),
               Text("Soil Moisture: ${moisture}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
               SizedBox(height: 15,),
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 25.0,
                animationDuration: 2500,
                percent: 0.08,
                barRadius: Radius.circular(10),
                progressColor: Color.fromARGB(180, 94, 53, 45),
              ),
              SizedBox(height: 15,),
               Text("Heat Index: ${heatIndex}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
               SizedBox(height: 15,),
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 25.0,
                animationDuration: 2500,
                percent: 0.08,
                barRadius: Radius.circular(10),
                progressColor: Color.fromARGB(255, 21, 6, 194),
              ),
              SizedBox(height: 25,),
             Text("Irrigation Time: 10s",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Colors.blue),),
          SizedBox(height: 15,),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}