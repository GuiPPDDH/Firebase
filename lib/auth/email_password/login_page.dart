import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  Future<void> loginUser() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailEC.text,
      password: passwordEC.text,
    );

    final user = credential.user;
    var message = '';

    if (user != null && !user.emailVerified) {
      message = 'E-mail não confirmado, verifique o seu e-mail.';
    } else {
      message = 'E-mail validado com sucesso!';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login de usuário'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: emailEC,
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                ),
                TextField(
                  controller: passwordEC,
                  decoration: const InputDecoration(
                    label: Text('Senha'),
                  ),
                ),
                ElevatedButton(
                  onPressed: loginUser,
                  child: const Text('Login usuário'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
