import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ipssi2023montevrain/globale.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  //variable
  bool isEditing = false;
  TextEditingController nickName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //afficher l'image de la personne
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(moi.avatar ?? defaultImage),
              ),

              const SizedBox(height: 10,),
              
              // nom complet
              Text(moi.fullName,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              Text("Age : ${moi.age}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
              const Divider(thickness: 3,color: Colors.black,),
              ListTile(
                leading: Icon(Icons.person),
                title: (isEditing)?TextField(
                  controller: nickName,
                  decoration: InputDecoration.collapsed(

                   hintText: moi.nickName,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    filled: true
                  ),
                ):Text(moi.nickName),
                trailing: IconButton(
                    onPressed: (){
                      setState(() {
                        isEditing = !isEditing;
                      });

                      
                    }, 
                    icon: FaIcon((isEditing)?FontAwesomeIcons.save:FontAwesomeIcons.pencil,size: 20,color: Colors.black,)
                ),
              ),
              ListTile(
                leading: Icon(Icons.mail),
                title: Text(moi.mail),
              ),
              
              //pseudo
              
              //mail
            ],
          ),
        )
    );
  }
}
