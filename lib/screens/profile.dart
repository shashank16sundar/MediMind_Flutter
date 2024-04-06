import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),onPressed: (){},
        ),
        title: Text("tProfile",style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.light_mode_outlined)),
        ],
      ),
      
      body: SingleChildScrollView(
        child:Container(),
      ),
    );
  }
}