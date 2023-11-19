import 'package:chatapp_new/constants.dart';
import 'package:chatapp_new/widgets/custom_button.dart';
import 'package:chatapp_new/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_textbutton.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});
  static String id = 'ForgetPass';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPriColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(children: [
            Image.asset('assets/images/scholar.png'),
            const Text(
              'Scholar App',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'pacifico',
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Recover Password', style: kSubTitleStyle),
                  ],
                ),
                Column(
                  children: [
                    CustomeFormTextField(
                      hintText: 'E-mail',
                      action: TextInputAction.done,
                      hidden: false,
                    ),
                    kSpace
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '');
                  },
                  child: CustomButton(
                    buttonLabel: 'Send Recovery E-mail',
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 32),
                    const Text("Try to ",
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
          )
        ],
      ),
    );
  }
}
