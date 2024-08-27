// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/colors.dart';
import 'package:myapp/consts/test_style.dart';
import 'package:myapp/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: whiteColor,
            ),
          ),
        ],
        leading: Icon(
          Icons.sort_rounded,
          color: whiteColor,
        ),
        title: Text(
          "Beats",
          style: ourStyle(
            family: bold,
            size: 40,
          ),
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL,
        ),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No song found",
                style: ourStyle(size: 23),
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(bottom: 4),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(12),
                  // ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    tileColor: bgColor,
                    title: Text(
                      snapshot.data![index].displayNameWOExt,
                      style: ourStyle(
                        family: bold,
                        size: 18,
                      ),
                    ),
                    subtitle: Text(
                      "${snapshot.data![index].artist}",
                      style: ourStyle(
                        family: regular,
                        size: 12,
                      ),
                    ),
                    leading: Icon(
                      Icons.music_note,
                      color: whiteColor,
                    ),
                    trailing: Icon(
                      Icons.play_arrow,
                      color: whiteColor,
                    ),
                  ),
                ),
                itemCount: 100,
              ),
            );
          }
        },
      ),
    );
  }
}
