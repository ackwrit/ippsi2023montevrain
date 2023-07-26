import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ipssi2023montevrain/controller/background_controller.dart';
import 'package:ipssi2023montevrain/globale.dart';
import 'package:ipssi2023montevrain/model/music.dart';

class MyPlayerMusic extends StatefulWidget {
  MyMusic music;
  MyPlayerMusic({required this.music,super.key});

  @override
  State<MyPlayerMusic> createState() => _MyPlayerMusicState();
}

class _MyPlayerMusicState extends State<MyPlayerMusic> {
  //variable
  double position = 0;
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.music.album ?? ""),
        actions: [
          IconButton(
              onPressed: (){
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              icon: Icon(Icons.favorite,color: (isFavorite)? Colors.red :Colors.white,)
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          MyBackground(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: bodyPage(),
            ),
          ),
        ],
      ),

    );



  }

  Widget bodyPage(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //affiche l'image
          Container(
            height: 250,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image:  DecorationImage(
                image: NetworkImage(widget.music.image ?? defaultImage),
                fit: BoxFit.fill
              )
            ),
          ),
          //bouton volume
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: (){

                  },
                  icon: const FaIcon(FontAwesomeIcons.volumeLow)
              ),
              IconButton(
                  onPressed: (){

                  },
                  icon: const FaIcon(FontAwesomeIcons.volumeHigh)
              ),



            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(widget.music.title,style: const TextStyle(fontSize: 25),),
                  Text(widget.music.artist,style: const TextStyle(fontSize: 20,fontStyle: FontStyle.italic),),
                ],
              ),
              IconButton(onPressed: (){

              }, icon: const FaIcon(FontAwesomeIcons.info)
              )
            ],
          ),

          Container(

            width: MediaQuery.of(context).size.width,
            child: Slider.adaptive(
                secondaryActiveColor: Colors.black,
                activeColor: Colors.amber,
                max: 400,
                min: 0,
                value: position,
                onChanged: (value){
                  setState(() {
                    position = value;
                  });

                }
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: (){

              }, icon: const FaIcon(FontAwesomeIcons.backward)
              ),
              IconButton(onPressed: (){

              }, icon:const  FaIcon(FontAwesomeIcons.play,size: 40,)
              ),
              IconButton(
                  onPressed: (){

                  },
                  icon: const FaIcon(FontAwesomeIcons.forward)
              ),

                ],
              ),








        ],

      ),
    );
  }
}
