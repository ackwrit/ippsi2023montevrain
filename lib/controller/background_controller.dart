
import 'package:flutter/material.dart';
import 'package:ipssi2023montevrain/controller/my_custom_path.dart';
import 'package:ipssi2023montevrain/globale.dart';

class MyBackground extends StatefulWidget {
  const MyBackground({super.key});

  @override
  State<MyBackground> createState() => _MyBackgroundState();
}

class _MyBackgroundState extends State<MyBackground> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomPath(),
      child: Container(
        color: Colors.purple,
        
        /*decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(defaultImage),
            fit: BoxFit.fill
          )
        ),*/
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
