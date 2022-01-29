import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_sql/src/add_edit_screen.dart';
import 'package:my_karaoke_sql/src/dbhelper.dart';
import 'package:my_karaoke_sql/src/song_item.dart';
import 'package:my_karaoke_sql/src/song_item_controller.dart';

class SongList extends StatefulWidget {
  const SongList({Key? key}) : super(key: key);

  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  DbHelper helper = DbHelper();
  List<SongItem>? songList;
  SongItemController songItemController = Get.put(
    SongItemController(),
  );
  @override
  Widget build(BuildContext context) {
    showData();
    return ListView.builder(
      itemCount: (songList != null) ? songList!.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(songList![index].id!),
          onDismissed: (direction) {
            String songName = songList![index].songName;
            helper.deleteList(songList![index]);
            setState(() {
              songList!.removeAt(index);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${songList![index].id!}..$songName deleted"),
              ),
            );
          },
          child: ListTile(
            title: Text(songList![index].songName),
            // title:Text(songItemController.songItem.value.songName),
            leading: CircleAvatar(
              child: Text(
                songList![index].id.toString(),
                // songItemController.songItem.value.id.toString(),
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Get.to(
                  AddEditPage(
                    isNew: false,
                    songItem: songList![index],
                    // songItem: songItemController.songItem.value,
                  ),
                );
              },
            ),
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
