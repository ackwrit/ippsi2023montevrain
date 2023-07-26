import 'package:audioplayers/audioplayers.dart';
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
  Duration position = Duration(seconds: 0);
  bool isFavorite = false;
  late StatutPlayer statutPlayer;
  late AudioPlayer audioPlayer;
  late double volumeSound;
  late Duration dureeTotalMusic;



  //méthode

  play(){
    setState(() {
      statutPlayer = StatutPlayer.play;
    });
    audioPlayer.play(UrlSource(widget.music.file),volume: volumeSound);

  }

  pause(){
    setState(() {
      statutPlayer = StatutPlayer.pause;
    });
    audioPlayer.pause();
  }

  stop(){
    setState(() {
      statutPlayer = StatutPlayer.stop;
    });
    audioPlayer.stop();
  }

  forward(){
    if(position.inSeconds + 10 <= dureeTotalMusic.inSeconds){
      setState(() {
        Duration time = Duration(seconds: position.inSeconds + 10);
        audioPlayer.seek(time);
      });

    }


  }

  backward(){
   if(position.inSeconds <= 10){
     setState(() {
       Duration time = Duration(seconds: 0);
       position = time;
     });

   }
   else
     {
       setState(() {
         Duration time = Duration(seconds: position.inSeconds - 10);
         position = time;
       });

     }

  }
  configurationPlayer(){
    statutPlayer = StatutPlayer.stop;
    volumeSound = 0.5;
    dureeTotalMusic = const Duration(seconds: 8000);
    audioPlayer = AudioPlayer();
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        dureeTotalMusic = event;
      });
    });
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });






  }

  cleanPlayer(){
    audioPlayer.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    configurationPlayer();
    super.initState();
  }


  @override
  void dispose() {
    cleanPlayer();
    // TODO: implement dispose
    super.dispose();
  }
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
                    volumeSound -= 0.1;

                  },
                  icon: const FaIcon(FontAwesomeIcons.volumeLow)
              ),
              IconButton(
                  onPressed: (){
                    setState(() {
                      volumeSound += 0.1;
                    });

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
                max: dureeTotalMusic.inSeconds.toDouble(),
                min: 0,
                value: position.inSeconds.toDouble(),
                onChanged: (value){
                  setState(() {
                    Duration time = Duration(seconds: value.toInt());
                    position = time;
                  });

                }
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(dureeTotalMusic.inSeconds.toString())
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: (){
                backward();

              }, icon: const FaIcon(FontAwesomeIcons.backward)
              ),
              IconButton(
                  onPressed: (){
                    if(statutPlayer == StatutPlayer.stop || statutPlayer == StatutPlayer.pause){
                      setState(() {
                        statutPlayer = StatutPlayer.play;
                        play();
                      });
                    }
                    else
                      {
                        setState(() {
                          statutPlayer = StatutPlayer.pause;
                          pause();
                        });
                      }


              }, icon:FaIcon((statutPlayer == StatutPlayer.pause)?FontAwesomeIcons.play: FontAwesomeIcons.pause,size: 40,)
              ),
              IconButton(
                  onPressed: (){
                    forward();

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
