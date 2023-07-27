import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ipssi2023montevrain/controller/background_controller.dart';
import 'package:ipssi2023montevrain/controller/firestore_helper.dart';
import 'package:ipssi2023montevrain/globale.dart';
import 'package:ipssi2023montevrain/model/music.dart';
import 'package:http/http.dart' as http;

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
  late String itemsDetails ="";



  //méthode

  Future<String> apiRequest() async{
    print(widget.music.artist);
    Uri url = Uri.parse("https://spotify23.p.rapidapi.com/search/?q=${widget.music.artist}&type=artists&limit=10&numberOfTopResults=5");

    Map<String,String>? headers = {
      'X-RapidAPI-Key': 'ead077df7fmsh1ae9f5962c38526p199a97jsn712230501fb9',
      'X-RapidAPI-Host': 'spotify23.p.rapidapi.com',
      'Host': "spotify23.p.rapidapi.com",
      "content-type":"application/json"

    };
    http.Response bod = await http.get(url,headers: headers);
    Map<String,dynamic> datas = jsonDecode(bod.body) as Map<String,dynamic>;
    var items = datas["artists"]["items"];
    String value = items[0]["data"]["uri"];
    //String avatar = items[0]["visuals"]["avatarImage"]["sources"][0]["url"];
    String uid = value.toString().substring(15,value.length);
    print(uid);

    Uri getDetail = Uri.parse("https://spotify23.p.rapidapi.com/artist_overview/?id=$uid");
    http.Response put = await http.get(getDetail,headers: headers);
    Map<String,dynamic> datasInfos = jsonDecode(put.body) as Map<String,dynamic>;
    setState(() {
      itemsDetails = datasInfos["data"]["artist"]["profile"]["biography"]["text"];
      print(itemsDetails);

    });
    return itemsDetails;




  }

  SnackBar afficheSnack() {

    return SnackBar(
      duration: const Duration(seconds: 15),
      backgroundColor: Colors.amber,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))),
        content: SingleChildScrollView(
          
          child: Container(
            width: MediaQuery.of(context).size.width,

            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView(
              children: [
                Text("Discographie",),
                Text(itemsDetails)

              ],
            ),
          ),
        )
    );

  }

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

  listingMusic(){
    for (String uid in moi.favoris!){
      FirestoreHelper().getMusic(uid).then((value) {
        setState(() {
          myMusicTableau.add(value);
        });

      });
    }

  }

  forward(){

    if(position.inSeconds + 10 <= dureeTotalMusic.inSeconds){
      setState(() {
        Duration time = Duration(seconds: position.inSeconds + 10);
        audioPlayer.seek(time);


      });

    }
    else {
      if(moi.favoris!.contains(widget.music.uid)){
        int indice = moi.favoris!.indexOf(widget.music.uid);
        if(indice <= myMusicTableau.length){
          setState(() {
            widget.music = myMusicTableau[indice + 1];
            audioPlayer.play(UrlSource(widget.music.file));
          });


        }

      }
    }



  }

  backward(){
   if(position.inSeconds <= 10){
     setState(() {
       Duration time = Duration(seconds: 0);
       position = time;
       audioPlayer.seek(time);
     });
     if(position == Duration(seconds: 0)){
       if(moi.favoris!.contains(widget.music.uid)){
         int indice = moi.favoris!.indexOf(widget.music.uid);
         if (indice  > 0) {
           setState(() {
             widget.music = myMusicTableau[indice - 1];
             audioPlayer.play(UrlSource(widget.music.file));

           });
         }
       }
     }

   }
   else
     {
       setState(() {
         Duration time = Duration(seconds: position.inSeconds - 10);
         position = time;
         audioPlayer.seek(time);
       });

     }

  }
  configurationPlayer(){



    listingMusic();
    statutPlayer = StatutPlayer.stop;
    volumeSound = 0.5;
    dureeTotalMusic = const Duration(seconds: 8000);
    audioPlayer = AudioPlayer();
    play();
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        dureeTotalMusic = event;
      });
    });
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
      if(position == dureeTotalMusic) {
        if (moi.favoris!.contains(widget.music.uid)) {
          int indice = moi.favoris!.indexOf(widget.music.uid);
          if (indice < myMusicTableau.length) {
            setState(() {
              widget.music = myMusicTableau[indice + 1];
              audioPlayer.play(UrlSource(widget.music.file));

            });
          }
        }

      }
    });
    apiRequest().then((value) {
      setState(() {
        itemsDetails = value;
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

                  if(moi.favoris!.contains(widget.music.uid)){
                    moi.favoris!.remove(widget.music.uid);
                    Map<String,dynamic> data = {
                      "FAVORIS": moi.favoris
                    };
                    FirestoreHelper().updateUser(moi.uid, data);
                  }
                  else{
                    moi.favoris!.add(widget.music.uid);
                    Map<String,dynamic> data = {
                      "FAVORIS": moi.favoris
                    };
                    FirestoreHelper().updateUser(moi.uid, data);

                  }
                });
              },
              icon: Icon(Icons.favorite,color: moi.favoris!.contains(widget.music.uid)? Colors.red :Colors.white,)
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
                    setState(() {
                      volumeSound -= 0.1;
                      audioPlayer.setVolume(volumeSound);
                    });


                  },
                  icon: const FaIcon(FontAwesomeIcons.volumeLow)
              ),
              IconButton(
                  onPressed: (){
                    setState(() {
                      volumeSound += 0.1;
                      audioPlayer.setVolume(volumeSound);
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
                ScaffoldMessenger.of(context).showSnackBar(afficheSnack());
                ;

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
                    audioPlayer.seek(position);
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


              }, icon:FaIcon((statutPlayer == StatutPlayer.pause || statutPlayer == StatutPlayer.stop)?FontAwesomeIcons.play: FontAwesomeIcons.pause,size: 40,)
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
