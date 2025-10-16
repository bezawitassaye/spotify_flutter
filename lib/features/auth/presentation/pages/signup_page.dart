import 'package:flutter/material.dart';
import 'package:spotify/core/theme/app_pallete.dart';
import 'package:spotify/features/auth/presentation/widget/auth_fiels.dart';
import 'package:spotify/features/auth/presentation/widget/auth_gradinet_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final emailcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
     emailcontroller.dispose();
     namecontroller.dispose();
     passwordcontroller.dispose();
    _controller.dispose();
    super.dispose();
  }

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key:formkey ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign up.",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              AuthField(hintText: "Email",controller: emailcontroller,),
              const SizedBox(height: 15,),
              AuthField(hintText: "Name",controller: namecontroller,),
              const SizedBox(height: 15),
              AuthField(hintText: "Password",controller: passwordcontroller,isObscureText: true,),
              const SizedBox(height: 20),
              AuthGradient_Button(),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an account? ',
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: "Sign In",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppPallete.gradient1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
