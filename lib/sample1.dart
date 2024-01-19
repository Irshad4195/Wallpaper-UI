// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gallery_ui/wallpaper_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Sample1 extends StatefulWidget {
  const Sample1({super.key});

  @override
  State<Sample1> createState() => _Sample1State();
}

class _Sample1State extends State<Sample1> {
  var mykey = "S9lG7V7SMxdg9i2AKyhXTf8DtwWdPyzQxoOrNqgwOtBaGTbIRbMXgbzL";
  late Future<WallpaperUi> wallpaper;

  @override
  void initState() {
    getWallpapers(wallpaperTitles.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return FutureBuilder(
                future: getWallpapers("${wallpaperTitles[index]}"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Colors.red,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.maxFinite,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                color: Colors.teal,
                              ),
                              child: Image.network(
                                "${snapshot.data!.photos![index].src!.portrait}" != null ? "${snapshot.data!.photos![index].src!.portrait}" : "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            "${wallpaperTitles[index]}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.hasError.toString()}");
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                });
          },
          itemCount: wallpaperTitles.length,
        ),
      )),
    );
  }

  Future<WallpaperUi> getWallpapers(String search) async {
    var url = "https://api.pexels.com/v1/search?query=$search";
    var response =
        await http.get(Uri.parse(url), headers: {"Authorization": mykey});
    if (response.statusCode == 200) {
      var photos = jsonDecode(response.body);
      return WallpaperUi.fromJson(photos);
    } else {
      return WallpaperUi();
    }
  }

  final List<String> wallpaperTitles = [
    "Trees",
    //"Light",
    "Nature",
    "Space",
    "Animal",
    "Sky",
    "Mountain",
    "Flowers",
    "Forest",
    "Landscape",
    //"Party",
    "Art",
    //"Color",
    "Summer",
    "Winter",
    "Rain",
    //"Abstract",
    "City",
  ];
}
