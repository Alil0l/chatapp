// ignore_for_file: use_build_context_synchronously

import 'package:chatapp_new/constants.dart';
import 'package:chatapp_new/screens/chat_screen.dart';
import 'package:chatapp_new/widgets/custom_button.dart';
import 'package:chatapp_new/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/custom_textbutton.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static String id = 'SignUp';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? password, email;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

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
                Image.asset('assets/images/scholar.png'),
                const Text('Scholar App', style: kMainTitleStyle),
              ]),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Sign Up', style: kSubTitleStyle),
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
                                await signupUser();
                                Navigator.pushNamed(context, ChatScreen.id,
                                    arguments: email);
                              } on FirebaseAuthException catch (ex) {
                                if (ex.code == 'weak-password') {
                                  showSnackBar(context, ex.code);
                                } else if (ex.code == 'email-already-in-use') {
                                  showSnackBar(context, ex.code);
                                }
                              } catch (ex) {
                                showSnackBar(context, ex.toString());
                              }
                              isLoading = false;
                              setState(() {});
                            }
                          },
                          buttonLabel: 'SignUp',
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("have an account?  ",
                                style: TextStyle(fontFamily: 'Pacifico')),
                            CustomTextButton(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                buttonLabel: 'Log In')
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }

  Future<void> signupUser() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
