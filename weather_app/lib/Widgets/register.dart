import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/Screens/loginPage.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool isShowPassword = false;
  bool isShowConfirmPassword = false;

  late String message = "";

  final _formRegister = GlobalKey<FormState>();

  @override
  void initState() {
    email.text = "";
    password.text = "";
    confirmPassword.text = "";
    fullname.text = "";
    super.initState();
  }

  Future<void> createNewAccount() async {
    setState(() {
      message='';
    });
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      credential.user?.updateDisplayName(fullname.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng ký thành công')),
      );
    } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
        setState(() {
          message='Email ${email.text} đã được đăng ký !';
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void handleRegistrationPageLogin() {
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return LoginPage();
      },
    ));
  }

  void handleShowPassword() => {
        setState(() {
          isShowPassword = !isShowPassword;
        })
      };

  void handleShowConfirmPassword() => {
        setState(() {
          isShowConfirmPassword = !isShowConfirmPassword;
        })
      };

  String? _fullNameValidator(String value) {
    if (value.isEmpty) {
      return 'Vui lòng nhập tên người dùng!';
    } else if (fullname.text.length < 3) {
      return 'Tên người dùng cần ít nhất 3 ký tự';
    }
    return null;
  }

  String? _emailValidator(String value) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Vui lòng nhập email!';
    } else if (!regExp.hasMatch(value)) {
      return 'Email không đúng định dạng';
    }
    return null;
  }

  String? _passwordValidator(String value) {
    String pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Vui lòng nhập mật khẩu!';
    } else if (!regExp.hasMatch(value)) {
      return 'Mật khẩu cần có ít nhất 8 ký tự bao gồm chữ cái và số';
    }
    return null;
  }

  String? _confirmPasswordValidator(String value) {
    if (value.isEmpty) {
      return 'Vui lòng nhập lại mật khẩu!';
    } else if (password.text != confirmPassword.text) {
      return 'Mật khẩu xác nhận phải đúng với mật khẩu đã nhập';
    }
    return null;
  }

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
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: const Color.fromARGB(200, 255, 255, 255),
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formRegister,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                        validator: (value) => _fullNameValidator(value!),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(fontSize: 18),
                        controller: fullname,
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(fontSize: 14),
                          border: UnderlineInputBorder(),
                          labelText: "Tên người dùng",
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                        validator: (value) => _emailValidator(value!),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(fontSize: 18),
                        controller: email,
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(fontSize: 14),
                          border: UnderlineInputBorder(),
                          labelText: "Tài khoản",
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                        validator: (value) => _passwordValidator(value!),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(fontSize: 18),
                        obscureText: !isShowPassword,
                        controller: password,
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(fontSize: 14),
                            border: const UnderlineInputBorder(),
                            labelText: "Mật khẩu",
                            suffixIcon: IconButton(
                              onPressed: handleShowPassword,
                              icon: Icon(!isShowPassword
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash),
                              iconSize: 18,
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                        validator: (value) => _confirmPasswordValidator(value!),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(fontSize: 18),
                        obscureText: !isShowConfirmPassword,
                        controller: confirmPassword,
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(fontSize: 14),
                            border: const UnderlineInputBorder(),
                            labelText: "Nhập lại mật khẩu",
                            suffixIcon: IconButton(
                              onPressed: handleShowConfirmPassword,
                              icon: Icon(!isShowConfirmPassword
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash),
                              iconSize: 18,
                            ))),
                  ),
                  if(message.isNotEmpty)
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                          message,
                          style: const TextStyle(fontSize: 14,color: Colors.red),
                        )),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(150, 4, 217, 46),
                            fixedSize: const Size(250, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onPressed: () {
                          if(_formRegister.currentState!.validate()){
                            createNewAccount();
                          }

                        },
                        child: const Text(
                          "Đăng ký",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Text("Bạn đã có tài khoản ? ",
                            style: TextStyle(fontSize: 16)),
                        InkWell(
                            onTap: handleRegistrationPageLogin,
                            child: const Text(
                              "Đăng nhập ngay",
                              style: TextStyle(fontSize: 16,
                                  color: const Color.fromARGB(255, 26, 155, 140),
                                  fontWeight: FontWeight.bold),
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
