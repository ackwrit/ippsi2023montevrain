import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ipssi2023montevrain/controller/firestore_helper.dart';
import 'package:ipssi2023montevrain/globale.dart';
import 'package:ipssi2023montevrain/view/seconde_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController nickName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController firstName = TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body:Padding(
          padding: const EdgeInsets.all(15),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 300,
                  width: 450,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        image: NetworkImage("https://tse2.mm.bing.net/th?id=OIP.Ja_A16t6HOsvb4DPYB4ZCQHaDY&pid=Api"),
                      fit: BoxFit.fill,
                    )
                  ),
                ),
                const SizedBox(height: 10,),

                TextField(

                  controller: mail,
                  decoration: InputDecoration(
                    hintText: "Entrer votre mail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                ),

                const SizedBox(height: 10,),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Entrer votre password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                ),

                const SizedBox(height: 10,),


                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: const StadiumBorder()
                  ),
                    onPressed: (){
                    FirestoreHelper().connect(mail.text, password.text).then((value) {
                      setState(() {
                        moi = value;
                      });
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return const MySecondePage();
                          }
                      ));

                    }).catchError((error){

                    });

                    },
                    child: const Text("Connexion")
                ),
                const SizedBox(height: 10,),

                TextButton(
                    onPressed: (){
                      FirestoreHelper().inscription(mail.text, "djino", "skweel", "dissingar", password.text).then((value){
                        setState(() {
                          moi = value;
                        });
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return const MySecondePage();
                            }
                        ));

                      }).catchError((){

                      });

                    },
                    child: const Text("Inscription")
                ),
              ],
            ),
          ),
        ),
      )

    );
  }
}
