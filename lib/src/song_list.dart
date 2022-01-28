import 'package:flutter/material.dart';
import 'package:my_karaoke_sql/src/dbhelper.dart';
import 'package:my_karaoke_sql/src/song_item.dart';

class SongList extends StatefulWidget {
  const SongList({Key? key}) : super(key: key);

  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  DbHelper helper = DbHelper();
  List<SongItem>? songList;
  @override
  Widget build(BuildContext context) {
    showData();
    return ListView.builder(
      itemCount: (songList != null) ? songList!.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(songList![index].songName),
          leading: CircleAvatar(
            child: Text(
              songList![index].id.toString(),
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        );
      },
    );
  }

  Future showData() async {
    await helper.openDb();
    songList = await helper.getLists();
    setState(() {
      songList = songList;
    });
  }
}
