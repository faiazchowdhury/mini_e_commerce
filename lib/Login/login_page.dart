import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mini_e_commerce/Home_Page/HomePage.dart';
import 'package:mini_e_commerce/Login/LoginProvide.dart';
import 'package:mini_e_commerce/Login/RegistrationProvider.dart';
import 'package:mini_e_commerce/Login/signup_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0Xfffafafa),
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Enter Your Credential to login",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Color(0xfff0e4f2),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    const Expanded(flex: 2, child: Icon(Icons.person)),
                    Expanded(
                      flex: 13,
                      child: TextField(
                        controller: userNameController,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                          hintText: "Username",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Color(0xfff0e4f2),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    const Expanded(flex: 2, child: Icon(Icons.password)),
                    Expanded(
                      flex: 13,
                      child: TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              loginProvider.isLoading
                  ? const CircularProgressIndicator()
                  : GestureDetector(
                      onTap: () async {
                        if (passwordController.text == "" ||
                            userNameController.text == "") {
                          Fluttertoast.showToast(
                              msg: "Email or Password not provided");
                        } else {
                          loginProvider.setEmail(userNameController.text);
                          loginProvider.setPass(passwordController.text);
                          await loginProvider.loginPressed();
                          if (loginProvider.statusCode == 200) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          }
                        }
                      },
                      child: Container(
                        width: 1000,
                        height: 50,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xff9c27b3)),
                        child: const Center(
                            child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
              const Text(
                "Forgot Password?",
                style: TextStyle(
                    color: Color(0xff9c27b3), fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              RichText(
                  text: TextSpan(
                children: [
                  const TextSpan(
                      text: "Don't have an account?  ",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "Sign up",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MultiProvider(providers: [
                                      ChangeNotifierProvider(
                                          create: (_) => Registrationprovider())
                                    ], child: SignUpPage()))),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff9c27b3)))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
