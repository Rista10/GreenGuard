import 'package:flutter/material.dart';
import 'package:green_guard/model/plantmodel.dart';

class PlantDetail extends StatefulWidget {
  Data plantDetail;

  PlantDetail({super.key,required this.plantDetail});

  @override
  State<PlantDetail> createState() => _PlantDetailState();
}

class _PlantDetailState extends State<PlantDetail> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Color.fromRGBO(240, 244, 240, 1),
        title: Image.asset('assets/images/title_logo.png'),
      ),
      body: Column(
        children: [
          Image.network(widget.plantDetail.imageUrl ?? '',
          height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
          ),
          SizedBox(height: 10,),
          Text('${widget.plantDetail.commonName}',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            fontFamily: 'Philosopher',
          ),
          ),
          SizedBox(height: 10,),
          Text('${widget.plantDetail.scientificName}',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          )
        ],
      ),
    );
  }
}