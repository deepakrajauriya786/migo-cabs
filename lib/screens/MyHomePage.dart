import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:migo_cabs/const/app_sizes.dart';
import 'model/PhotoModel.dart';
import 'model/PhotoModel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // late Future<List<Photo>> futurePhotos;
  String home = "nnnhfcfhcfhytfdgcfhy";

  List<Photo> dataProduct = [];

  Future<List> fetchPhotos() async {
    try {
      var response = await http.get(Uri.parse(
          AppSizes.BASEURL));

      if (response.statusCode == 200) {

        return jsonDecode(response.body);

        // final parsed =(jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
        // dataProduct =parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
        //
        // print("No Data Found !");
        //
        // if(dataProduct.isNotEmpty){
        //   print(dataProduct![0].thumbnailUrl);
        // }
        // return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
      } else {
        // Handle specific status codes or throw a more informative exception
        // if (response.statusCode == 404) {
        //         //   throw Exception('Album not found');
        //         // } else {
        //         //   throw Exception(
        //         //       'Failed to load album with status code: ${response.statusCode}');
        //         // }

        return Future.error("Server Error !");

      }
    } catch (SocketException) {
      // Handle network or other exceptions
      print('Error fetching photos');
      return Future.error("Error Fetching Data !");
    }
  }

  Future<List<Photo>> fetchPhotosByList() async {
    try {
      var response = await http.get(Uri.parse(
          'https://weblook.co.in/cab_taxi/api/banners.php'));
     var data= jsonDecode(response.body.toString());
      if (response.statusCode == 200) {

       for(Map<String,dynamic> index in data){
         dataProduct.add(new Photo(albumId: 11, id: 11, title: 'title', url: 'url', thumbnailUrl: index["thumbnailUrl"]??'jhf'));
       }
        return dataProduct;

      } else {

        return Future.error("Server Error !");

      }
    } catch (SocketException) {
      // Handle network or other exceptions
      return Future.error("Error Fetching Data !");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
      FutureBuilder<List>(
        future: fetchPhotos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            if(snapshot.data?.length !=0){
               return
                Image.network(snapshot.data?[0]["thumbnailUrl"] ?? '');

              //   GridView.builder(
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //   ),
              //   itemCount: snapshot.data?.length,
              //   itemBuilder: (context, index) {
              //     return
              //       Text(snapshot.data?[index]["message"] ?? 'loading...');
              //   },
              // );

            }else{
              return const Center(
                child: Text('No Data Available'),
              );
            }

          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

      // FutureBuilder<List>(
      //   future: fetchPhotos(),
      //   builder: (context, snapshot ) {
      //     if (snapshot.hasError) {
      //       return const Center(
      //         child: Text('An error has occurred!'),
      //       );
      //     } else if (snapshot.hasData) {
      //       if(snapshot.data?.length !=0){
      //         return GridView.builder(
      //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //             crossAxisCount: 2,
      //           ),
      //           itemCount: dataProduct?.length,
      //           itemBuilder: (context, index) {
      //             return
      //               Text(dataProduct?[index].thumbnailUrl ?? 'loading...');
      //           },
      //         );
      //       }else{
      //         return const Center(
      //           child: Text('No Data Available'),
      //         );
      //       }
      //
      //     } else {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),

    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({super.key, required this.photos});

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.network(photos[index].thumbnailUrl);
      },
    );
  }
}
