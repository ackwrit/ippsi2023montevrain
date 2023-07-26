import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipssi2023montevrain/controller/firestore_helper.dart';
import 'package:ipssi2023montevrain/globale.dart';
import 'package:ipssi2023montevrain/model/music.dart';
import 'package:ipssi2023montevrain/view/player_music.dart';

class AllMusic extends StatefulWidget {
  const AllMusic({super.key});

  @override
  State<AllMusic> createState() => _AllMusicState();
}

class _AllMusicState extends State<AllMusic> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: FirestoreHelper().cloudMusics.snapshots(),
        builder: (context,snap){
        if(snap.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator.adaptive());

          }
        if(!snap.hasData){
          return Text("Erreur lors du chargement");
        }
        else
          {
            List documents = snap.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
                itemBuilder: (context,index){
                MyMusic music = MyMusic(documents[index]);
                return Card(
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MyPlayerMusic(music: music,)));
                    },
                    leading: Image.network(music.image ?? defaultImage,width: 100,),
                    title: Text(music.title),
                    subtitle: Text(music.artist),
                  ),
                );
                }
            );
          }

        }
    );
  }
}
