import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_sql/src/add_edit_screen.dart';
import 'package:my_karaoke_sql/src/search_page.dart';
import 'package:my_karaoke_sql/src/song_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // DbHelper helper=DbHelper();
    // helper.testDb();
    // showData();
    return Scaffold(
      appBar: AppBar(
        title: Text('SQL DB용'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) {
                        return SearchPage(
                        );
                      },
                      fullscreenDialog: true),
                );
              },
            ),
        ],
      ),
      body: SongList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            AddEditPage(isNew: true),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
