import 'package:finance/widgets/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final client = Supabase.instance.client;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLoading = false;

  Future<String?> userLogin(String email, String password) async {
    try {
      final response = await client.auth
          .signInWithPassword(password: password, email: email);
      final user = response.user;
      return user?.id;
    } on AuthException catch (e) {
      print(e);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Connexion')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              /*  Image.asset(
                'images/logo.png',
                height: 150,
              ), */
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Connexion",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Password'),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });
                          dynamic loginResult = await userLogin(
                              _emailController.text, _passwordController.text);

                          setState(() {
                            isLoading = false;
                          });
                          if (loginResult != null) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Bottom()),
                                (route) => false);
                          } else {
                            /* context
                                .showErrorMessage('Invalid email or password'); */
                          }
                        },
                  child: Text(
                    isLoading ? "Processing ..." : "Login",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                ),
              )
            ]),
          ),
        ));
  }
}
