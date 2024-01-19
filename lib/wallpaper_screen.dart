import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gallery_ui/wallpaper_model.dart';
import 'package:http/http.dart' as http;

class WallpaperHome extends StatefulWidget {
  const WallpaperHome({super.key});

  @override
  State<WallpaperHome> createState() => _WallpaperHomeState();
}

class _WallpaperHomeState extends State<WallpaperHome> {
  TextEditingController searchController = TextEditingController();
  var mykey = "S9lG7V7SMxdg9i2AKyhXTf8DtwWdPyzQxoOrNqgwOtBaGTbIRbMXgbzL";
  late Future<WallpaperUi> wallpaper;

  @override
  void initState() {
    super.initState();
    wallpaper = getWallpapers("${wallpaperTitles.indexed}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 60),
                  width: 350,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Find Wallpaper...",
                      suffixIcon: IconButton(
                          onPressed: () {
                            wallpaper =
                                getWallpapers(searchController.text.toString());
                            setState(() {});
                          },
                          icon: Icon(Icons.search)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                  future: getWallpapers("${wallpaperTitles.indexed}"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                height: 200,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9)),
                                child: Image.network(
                                  "${snapshot.data!.photos![index].src!.portrait}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                "${snapshot.data!.photos![index].photographer}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
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
              /*FutureBuilder(
                  future: wallpaper = getWallpapers(""),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Widget> images = snapshot.data!.photos!
                          .map((pics) => Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  height: 200,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9)),
                                  child: Image.network(
                                    "${pics.src!.portrait}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ))
                          .toList(); // Convert Iterable to List

                      return Row(
                        children: images,
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.hasError.toString()}");
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),

              /* FutureBuilder(
                  future: wallpaper,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              snapshot.data!.photos!.map((pics) => Container(
                                    clipBehavior: Clip.antiAlias,
                                    height: 200,
                                    width: 150,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(9)),
                                    child: Image.network(
                                      "${pics.src!.portrait}",
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.hasError.toString()}");
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    ); 
                  }),*/
              Container(
                margin: const EdgeInsets.only(right: 100, top: 30),
                child: const Text(
                  "Best of the Month",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 1; i < 6; i++)
                      Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        width: 150,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage("assets/images/$i.jpg"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 150, top: 30),
                child: const Text(
                  "The color tone",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 1; i < 20; i++)
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 20),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(
                              255, i * 25 - 213, i * 10, 213 - i * 25),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 195, top: 30),
                child: const Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    width: 160,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/ab1.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Abstract",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    width: 160,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/n1.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Nature",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    width: 160,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/s1.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Space",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    width: 160,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/an2.jpeg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Animal",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    width: 160,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/m1.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Mountain",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    width: 160,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/f1.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Flower",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
      ),*/
              /*bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,
                  color: Colors.blue,
                ),
                label: "Apps Menu"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.download_sharp,
                  color: Colors.blue,
                ),
                label: "Download"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                label: "Person"),
          ],
        )*/
            ]),
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
    "City"
  ];
}
