import 'package:flutter/material.dart';
import 'package:gallery_ui/wallpaper_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Sample extends StatefulWidget {
  const Sample({super.key});

  @override
  State<Sample> createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  var mykey = "S9lG7V7SMxdg9i2AKyhXTf8DtwWdPyzQxoOrNqgwOtBaGTbIRbMXgbzL";
  late Future<WallpaperUi> wallpaper;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
              future: getWallpapers("Landscape}"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: Colors.red,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color: Colors.red,
                                ),
                                child: Image.network(
                                  "${snapshot.data!.photos![index].src!.portrait}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              "${wallpaperTitles[index]}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: wallpaperTitles.length,
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.hasError.toString()}");
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }

  Future<WallpaperUi> getWallpapers(String search) async {
    var url = "https://api.pexels.com/v1/search?query=$search&per_page=1";
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
    "Light",
    "Nature",
    "Space",
    "Animal",
    "Sky",
    "Mountain",
    "Flowers",
    "Forest",
    "Landscape",
    "Party",
    "Art",
    "Color",
    "Summer",
    "Winter",
    "Rain",
    "Abstract",
    "City",
  ];
}





/*Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.red,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: Colors.red,
                        ),
                        child: Image.network(
                          "${wallpaperTitles[index]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      "${wallpaperTitles[index]}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
            itemCount: wallpaperTitles.length,
          ),
        ),
      ),
    );*/