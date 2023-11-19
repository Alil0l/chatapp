// ignore_for_file: use_build_context_synchronously

import 'package:chatapp_new/screens/chat_screen.dart';
import 'package:chatapp_new/screens/forget_password_screen.dart';
import 'package:chatapp_new/screens/signup_screen.dart';
import 'package:chatapp_new/constants.dart';
import 'package:chatapp_new/widgets/custom_button.dart';
import 'package:chatapp_new/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_bar.dart';
import '../widgets/custom_textbutton.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static String id = 'Login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email, password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPriColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(children: [
                Image.asset(kLogo),
                const Text('Scholar App', style: kMainTitleStyle),
              ]),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Sign In', style: kSubTitleStyle),
                      ],
                    ),
                    kSpace,
                    CustomeFormTextField(
                      onChanged: (data) {
                        email = data;
                      },
                      hintText: 'E-mail',
                      action: TextInputAction.next,
                      hidden: false,
                    ),
                    kSpace,
                    CustomeFormTextField(
                      onChanged: (data) {
                        password = data;
                      },
                      hintText: 'Password',
                      action: TextInputAction.done,
                      hidden: true,
                    ),
                    kSpace,
                    CustomButton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            try {
                              await loginUser();
                              Navigator.pushNamed(context, ChatScreen.id,
                                  arguments: email);
                            } on FirebaseAuthException catch (ex) {
                              if (ex.code == 'user-not-found') {
                                showSnackBar(
                                    context, 'No user found for that email.');
                              } else if (ex.code == 'wrong-password') {
                                showSnackBar(context,
                                    'Wrong password provided for that user.');
                              } else {
                                showSnackBar(context, ex.code);
                              }
                            }

                            isLoading = false;
                            setState(() {});
                          }
                        },
                        buttonLabel: 'LOGIN'),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("don't have an account?  ",
                            style: TextStyle(fontFamily: 'Pacifico')),
                        CustomTextButton(
                            onTap: () {
                              Navigator.pushNamed(context, SignUp.id);
                            },
                            buttonLabel: 'Sign Up')
                      ],
                    ),
                    CustomTextButton(
                      onTap: () {
                        Navigator.pushNamed(context, ForgetPassword.id);
                      },
                      buttonLabel: 'Forget Password?',
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
