import 'package:flutter/material.dart';

class MySecondePage extends StatefulWidget {
  const MySecondePage({super.key});

  @override
  State<MySecondePage> createState() => _MySecondePageState();
}

class _MySecondePageState extends State<MySecondePage> {
  //variables
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: bodyPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value){
          setState(() {
            index= value;
          });

        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
            label: "Musique"
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favoris"
          ),

        ],
      ),
    );
  }

  Widget bodyPage(){
    switch(index){
      case 0 : return Text("Afficher les musiques");
      case 1: return Text("Afficher mes favoris");
      default : return Text("coucou");
    }

  }
}
