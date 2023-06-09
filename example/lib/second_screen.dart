import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: Center(child: TextButton(onPressed: (){
      // context.navigationCubit.push(page)
    },child: Text("third"),),),),);
  }
}
