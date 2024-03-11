import 'package:apitest/view/screens/add.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),

       body: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [

  Center( 
    child: Column(
      children: [

 ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.home_filled), label: Text('home')),
        ElevatedButton.icon(onPressed: (){
          Navigator.of(context).pushNamed("adduser");
        }, icon: Icon(Icons.person_add), label: Text('add')),

    
      ],
    ),

),

  
],
       ),
      ),
    );
  }
}