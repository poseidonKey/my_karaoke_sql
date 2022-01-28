import 'package:flutter/material.dart';
import 'package:my_karaoke_sql/src/dbhelper.dart';
import 'package:my_karaoke_sql/src/song_item.dart';
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
        title: Text('Material App Bar'),
      ),
      body: SongList(),
    );
  }

}
