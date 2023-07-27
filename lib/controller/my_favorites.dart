import 'package:flutter/material.dart';
import 'package:ipssi2023montevrain/controller/firestore_helper.dart';
import 'package:ipssi2023montevrain/globale.dart';
import 'package:ipssi2023montevrain/model/music.dart';
import 'package:ipssi2023montevrain/view/player_music.dart';

class MyFavorites extends StatefulWidget {
  const MyFavorites({super.key});

  @override
  State<MyFavorites> createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {




  listingMusic(){
    for (String uid in moi.favoris!){
      FirestoreHelper().getMusic(uid).then((value) {
        setState(() {
          myMusicTableau.add(value);
        });

      });
    }

  }


  @override
  void initState() {
    // TODO: implement initState
    myMusicTableau.clear();
    listingMusic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: myMusicTableau.length,
        itemBuilder: (context,index){
          MyMusic musicFavoris = myMusicTableau[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5.6,
            child: ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyPlayerMusic(music: musicFavoris)));
              },
              leading: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(musicFavoris.image ?? defaultImage),
              ),
              title: Text(musicFavoris.title),
              subtitle: Text(musicFavoris.artist),
            ),
          );

        }
    );
  }
}
