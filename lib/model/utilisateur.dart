
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ipssi2023montevrain/globale.dart';

class MyUser {
  //attributs
  late String lastName;
  late String firstName;
  late String nickName;
  DateTime? birthday;
  String? avatar;
  late String mail;
  late String uid;
  List? favoris;

  //variable caluclé

  int get age{
    DateTime now = DateTime.now();
    int age = now.year - birthday!.year;
    int month1 = now.month;
    int month2 = birthday!.month;
    if(month2>month1){
      age --;
    }
    else if (month1 == month2) {
      int day1 = now.day;
      int day2 = birthday!.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;


  }

  String get fullName {
    return firstName + " " + lastName ;
  }


  //constructeur
  MyUser(){
    lastName = "";
    firstName = "";
    nickName = "";
    mail = "";
    uid = "";
  }

  MyUser.dataBase(DocumentSnapshot documentSnapshot){
    uid = documentSnapshot.id;
    Map<String,dynamic> map = documentSnapshot.data() as Map<String,dynamic>;
    lastName = map["NOM"];
    nickName = map["PSEUDO"];
    firstName = map["PRENOM"];
    mail = map["EMAIL"];
    Timestamp? timestamp = map["BIRTHDAY"] ;
    if(timestamp == null){
      birthday = DateTime.now();

    }
    else
      {
        birthday = timestamp.toDate();
      }
    avatar = map["AVATAR"] ?? defaultImage;
    favoris = map["FAVORIS"] ?? [];

  }




  //méthodes

}