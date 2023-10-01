import 'dart:io';

import 'package:flutter/material.dart';
import 'package:green_guard/pages/homepage.dart';
import 'package:green_guard/pages/plantHealth.dart';
import 'package:green_guard/pages/realTimeData.dart';
import 'package:image_picker/image_picker.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  File? image;
  final _picker=ImagePicker();

  Future getPlantImage()async{
    
    final pickedFile= await _picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
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
    return SizedBox(
      height: 70,
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 80,
          decoration: BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color:Colors.grey.withOpacity(0.3),
                blurRadius:10,
                offset: const Offset(0, -5)
              ),
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                }, 
                icon: const Icon(Icons.home)),
                IconButton(
                  onPressed: ()async{
                    await getPlantImage();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => PlantHealth(plantImage: image))));
                  }, 
                  icon: const Icon(Icons.qr_code_scanner)),
                   IconButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RealTimeData()));
                   
                }, 
                icon: const Icon(Icons.border_all)),
                  IconButton(
                    onPressed: (){
                       }, 
                    icon: const Icon(Icons.menu))
            ],
          ),
        ),
      ),
    );
  }
}