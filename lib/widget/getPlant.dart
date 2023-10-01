import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_guard/model/plantmodel.dart';
import 'package:green_guard/pages/plantDetail.dart';
import 'package:http/http.dart ' as http;

class GetPlant extends StatefulWidget {
  const GetPlant({super.key});

  @override
  State<GetPlant> createState() => _GetPlantState();
}

class _GetPlantState extends State<GetPlant> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  PlantModel? plantModel;
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://trefle.io/api/v1/plants?token=mO00Pcm7MWkGhFwKgLQTEvV366mlOCbf1OpYkrTR4po'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      plantModel = PlantModel.fromJson(jsonResponse);
    } else {
      print('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: plantModel != null
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: plantModel!.data!.length,
                itemBuilder: (context, index) {
                  final plant = plantModel!.data![index];
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlantDetail(
                                      plantDetail: plant,
                                    )))
                      },
                      child: Image.network(
                        plant.imageUrl ?? '',
                        height: 100,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                })
            : CircularProgressIndicator(), // Show a loading indicator while fetching data
      ),
    );
  }
}
