import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ipssi2023montevrain/model/utilisateur.dart';

class FirestoreHelper {
  //attributs
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final cloudUsers = FirebaseFirestore.instance.collection("UTILISATEURS");



  Future<MyUser>inscription(String email,String firstName, String  nickName,String lastName, String password) async{
    UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    String uid = credential.user?.uid ?? "";
    Map<String,dynamic> map = {
      "NOM":lastName,
      "PRENOM":firstName,
      "PSEUDO":nickName,
      "EMAIL":email,
      "FAVORIS":[]
    };

    addUser(uid,map);
    return getUser(uid);

  }

  updateUser(String uid , Map<String,dynamic> data){
    cloudUsers.doc(uid).update(data);

  }

  Future<MyUser>getUser(String uid) async {
    DocumentSnapshot documentSnapshot = await cloudUsers.doc(uid).get();
    return MyUser.dataBase(documentSnapshot);
  }


  Future<MyUser>connect(String email, String password) async{
    UserCredential credential = await auth.signInWithEmailAndPassword(email: email, password: password);
    String uid = credential.user?.uid ?? "";
    return getUser(uid);
  }

  addUser(String uid, Map<String,dynamic> data){
    cloudUsers.doc(uid).set(data);
  }



  //méthode




}