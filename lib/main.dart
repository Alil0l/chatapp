import 'package:chatapp_new/screens/chat_screen.dart';
import 'package:chatapp_new/screens/forget_password_screen.dart';
import 'package:chatapp_new/screens/login_screen.dart';
import 'package:chatapp_new/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ChatApp(),
  );
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        ChatScreen.id: (context) => ChatScreen(),
        Login.id: (context) => const Login(),
        SignUp.id: (context) => const SignUp(),
        ForgetPassword.id: (context) => const ForgetPassword()
      },
      debugShowCheckedModeBanner: false,
      initialRoute: Login.id,
      theme: ThemeData.dark(),
    );
  }
}
