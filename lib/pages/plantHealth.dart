import 'dart:io';

import 'package:flutter/material.dart';
import 'package:green_guard/widget/nav.dart';

class PlantHealth extends StatefulWidget {
  File? plantImage;
  PlantHealth({super.key, required this.plantImage});

  @override
  State<PlantHealth> createState() => _PlantHealthState();
}

class _PlantHealthState extends State<PlantHealth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, // Change this color to the desired color
        ),
        title: Text('My plant',style: TextStyle(color: Colors.black),),
        toolbarHeight: 65,
        elevation: 0,
        backgroundColor: Colors.white,
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
                'Dumb Cane',
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
                    child: Row(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.file(
                          File(widget.plantImage!.path).absolute,
                          width: 150,
                          height: 120,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'This plant looks healthy !',
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
                      )
                    ]),
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
