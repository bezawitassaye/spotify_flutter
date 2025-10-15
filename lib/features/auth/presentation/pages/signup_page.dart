import 'package:flutter/material.dart';
import 'package:spotify/features/auth/presentation/widget/auth_fiels.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign up.",
              style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold
        
            ),),
            const SizedBox(height: 30,),
            AuthField(hintText: "Email"),
            const SizedBox(height: 15,),
            AuthField(hintText: "Name"),
            const SizedBox(height: 15,),
            AuthField(hintText: "Phone"),
          ],
        ),
      ),
    );
  }
}