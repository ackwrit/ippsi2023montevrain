
import 'package:ipssi2023montevrain/model/music.dart';
import 'package:ipssi2023montevrain/model/utilisateur.dart';

String defaultImage = "https://tse2.mm.bing.net/th?id=OIP.Ja_A16t6HOsvb4DPYB4ZCQHaDY&pid=Api";
MyUser moi = MyUser();
MyUser serviceClient = MyUser();
enum StatutPlayer {play,pause,stop}
List<MyMusic> myMusicTableau = [];