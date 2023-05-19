import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weather_app/Screens/homePage.dart';

import '../Screens/registerPage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isShowPassword = false;

  String message="";

  @override
  void initState() {
    email.text = "";
    password.text = "";
    super.initState();
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();


    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return const HomePage();
        },
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
      }
      else if (e.code == 'invalid-credential') {
        // handle the error here
      }
    } catch (e) {
      // handle the error here
    }
  }


  Future<void> handleLogin() async {
    setState(() {
      message="";
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text,
          password: password.text
      );
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return const HomePage();
        },
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          message="Tài khoản không tồn tại !";
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          message="Sai mật khẩu !";
        });
      }
    }
  }

  void handleRegistrationPageRedirect() {
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return const RegisterPage();
      },
    ));
  }

  void handleShowPassword() => {
        setState(() {
          isShowPassword = !isShowPassword;
        })
      };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/login-background.gif"),
                fit: BoxFit.cover,
                alignment: Alignment.topLeft)),
        alignment: Alignment.center,
        child: Container(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/gif/user-login.gif"),
                        fit: BoxFit.cover,
                      ))),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(150, 255, 255, 255),
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                          style: TextStyle(fontSize: 18),
                          controller: email,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: "Tài khoản",
                            icon: Icon(Icons.people),
                          )),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(150, 255, 255, 255),
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                          style: const TextStyle(fontSize: 18),
                          obscureText: !isShowPassword,
                          controller: password,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: const Icon(Icons.lock),
                              labelText: "Mật khẩu",
                              suffixIcon: IconButton(
                                onPressed: handleShowPassword,
                                icon: Icon(!isShowPassword
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash),
                                iconSize: 18,
                              ))),
                    ),
                  ),
                  if(message.isNotEmpty)
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          message,
                          style: const TextStyle(fontSize: 16,color: Colors.red),
                        )),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(150, 0, 255, 227),
                            fixedSize: const Size(250, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onPressed: handleLogin,
                        child: const Text(
                          "Đăng nhập",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                  Container(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text("Hoặc đăng nhập với",
                              style: TextStyle(fontSize: 18)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Image.asset('assets/images/google-logo.png'),
                              iconSize: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              onPressed: signInWithGoogle,
                            ),
                            IconButton(
                              icon:
                                  Image.asset('assets/images/facebook-logo.png'),
                              iconSize: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              onPressed: () {},
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                         Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              const Text("Bạn chưa có tài khoản ? ",
                                  style: TextStyle(fontSize: 18)),
                              InkWell(
                                  onTap: handleRegistrationPageRedirect,
                                  child: const Text(
                                    "Đăng ký ngay",
                                    style: TextStyle(fontSize: 18,
                                    color: Color.fromRGBO(12, 112, 4, 1.0),
                                    fontWeight: FontWeight.w900),
                                  ))
                            ],

                          ),
                        ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
