import 'package:flutter/material.dart';
import 'package:green_guard/widget/nav.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RealTimeData extends StatefulWidget {
  const RealTimeData({super.key});

  @override
  State<RealTimeData> createState() => _RealTimeDataState();
}

class _RealTimeDataState extends State<RealTimeData> {
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
            Text("Temperature: 23 C",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
             new LinearPercentIndicator(
               width: MediaQuery.of(context).size.width - 50,
               animation: true,
               lineHeight: 25.0,
               animationDuration: 2000,
               percent: 0.23,
               barRadius: Radius.circular(10),
               progressColor: Colors.yellow,
             ),
             SizedBox(height: 15,),
              Text("Humidity: 44",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
               Text("Soil Moisture: 8",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
               SizedBox(height: 15,),
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 25.0,
                animationDuration: 2500,
                percent: 0.08,
                barRadius: Radius.circular(10),
                progressColor: Colors.red,
              ),
              SizedBox(height: 25,),
            Text("Water Pump: 100%",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Colors.blue),),
            SizedBox(height: 10,),
             Text("Irrigation Time: 10s",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Colors.blue),),
          SizedBox(height: 15,),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}