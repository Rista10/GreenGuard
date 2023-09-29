import 'dart:io';

import 'package:flutter/material.dart';
import 'package:green_guard/pages/plantHealth.dart';
import 'package:green_guard/widget/getPlant.dart';
import 'package:green_guard/widget/nav.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;
  final _picker=ImagePicker();

  Future getPlantImage()async{
    final pickedFile= await _picker.pickImage(source: ImageSource.camera,imageQuality: 80);
    if(pickedFile!=null)
    {
      setState(() {
        image=File(pickedFile.path);
      });
    }else
    {
      print('No image uploaded');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset("assets/images/title_logo.png"),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.black,
              ))
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                color: const Color.fromARGB(255, 243, 235, 166),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Know Your Plant",
                              style: TextStyle(
                                fontFamily: 'Philosopher',
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Just scan below and you will know",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(
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
                                onPressed: () async{
                                  await getPlantImage();
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PlantHealth(plantImage: image,)));
                                },
                                child: const Text(
                                  "Scan Now",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: 128,
                        width: 128,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/scan.png"))),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "Learn about plants",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                ),
              ),
              Container(
                height: 150,
                width: double.infinity,
                color: Colors.white,
                child: GetPlant(),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "Plant Snapshot",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                ),
              ),
              Container(
                height: 220,
                width: double.infinity,
                color: Colors.white,
                child: PlantSnapShot(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
