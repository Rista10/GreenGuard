import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:green_guard/widget/nav.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';




class PlantHealth extends StatefulWidget {
  File? plantImage;
  PlantHealth({super.key, required this.plantImage});

  @override
  State<PlantHealth> createState() => _PlantHealthState();
}

class _PlantHealthState extends State<PlantHealth> 
{
  String? plantDisease;
  String? plantName;
  Future<void> uploadImage() async {
    final dio = Dio();
    var formData=FormData.fromMap({
      'file':await MultipartFile.fromFile(widget.plantImage!.path, filename: 'image.jpg')
    });

    var response=await dio.post('http://8794-202-166-219-119.ngrok.io/upload/', 
      data: formData,);
try{

    if (response.statusCode == 200) {
      print("sucess to upload image");
      
      setState(() {
        plantDisease=response.data['class'];
        List<String> parts=plantDisease!.split("___");
        if(parts.length>0){
          plantName=parts[0];
        }
      });

    
    } else {
      print(response.statusCode);
      print('Failed');
    }
}
catch(err){
  print(err);
}
  }

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uploadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, // Change this color to the desired color
        ),
        backgroundColor: Color.fromARGB(255, 171, 253, 173),
        title: Text(
          'My plant',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 65,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.file(
                  File(widget.plantImage!.path).absolute,
                  width: double.infinity,
                  height: 280,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                '${plantName}',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Philosopher',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 150,
                      width: 172,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.thermostat,
                              size: 50,
                            ),
                            Text(
                              'Temperature',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),
                            ),
                            Text(
                              '36 degree',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 172,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.water_drop_outlined,
                              size: 50,
                            ),
                            Text(
                              'Humidity',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),
                            ),
                            Text(
                              '40',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey, width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${plantDisease} detected',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        side: const BorderSide(
                                          color: Colors.green,
                                        )))),
                            onPressed: () {},
                            child: Text(
                              'Save to garden',
                              style: TextStyle(color: Colors.green),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
