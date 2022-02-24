import 'package:flutter/material.dart';
import 'data/repository.dart';
import 'di/injection.dart';
import 'model/user.dart';
import 'nav_routes.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Repository repo = injector.get<Repository>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          width: 400,
          height: 400,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(38.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () async {
                        final token = await repo.login(User(
                            username: usernameController.text,
                            digest: passwordController.text));
                        Navigator.pushNamed(context, Routes.home);
                      },
                      child: const Text("Accedi"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
