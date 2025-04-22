import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_assignment2/screens/storeList.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';
import '../widgets/customed_rich_span.dart';
import '../widgets/customed_text_form_field.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCntr = TextEditingController();

  final TextEditingController _passwordCntr = TextEditingController();

  String _error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            padding: EdgeInsets.all(20.sp),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ChangeNotifierProvider(
                  create: (context) => LoginProvider(),
                  child: Consumer<LoginProvider>(
                    builder: (context, login, child) {
                      return Column(
                        children: [
                          CustomedTextFormField(
                            controller: _emailCntr,
                            labelText: "Student Id",
                            regexActive: false,
                            isPassword: false,
                          ),
                          SizedBox(
                            height: 20.h,
                            // child: const Text(
                            //     "In case you forgot : id@stud.fci-cu.edu.eg"),
                          ),
                          CustomedTextFormField(
                            controller: _passwordCntr,
                            labelText: "Password",
                            regexActive: false,
                            isPassword: true,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          const CustomedRichSpan(
                              text: "Don't have an account? ",
                              inkwellText: "Sign In",
                              screen: RegisterScreen()),
                          SizedBox(
                            height: 10.h,
                          ),
                          if (login.isButtonLoading)
                            const CircularProgressIndicator()
                          else
                            ElevatedButton(
                                onPressed: () async {
                                  //TODO: LOGIN API
                                  // await login.login(
                                  //     _emailCntr.text, _passwordCntr.text);
                                  // setState(() {
                                  //   if (login.authResponseModel.statusCode! !=
                                  //       200) {
                                  //     _error = login.authResponseModel.message!;
                                  //   } else {
                                  //     _error = "";
                                  //   }
                                  // });
                                  // login.authResponseModel.statusCode == 200
                                  //     ? Navigator.pushReplacement(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 const ProfileScreen()))
                                  //     : null;

                                  //TODO:LOGIN LOCAL DB
                                  await login.login(int.parse(_emailCntr.text));
                                  setState(() {
                                    if (login.student.email != null) {
                                      if (login.student.password !=
                                          _passwordCntr.text) {
                                        _error = "Check Password";
                                      } else {
                                        _error = '';
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text("Logged In Successfully"),
                                          behavior: SnackBarBehavior.floating,
                                          dismissDirection:
                                              DismissDirection.startToEnd,
                                        ));
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const StoreList()));
                                      }
                                    } else {
                                      setState(() {
                                        _error = login.error;
                                      });
                                    }
                                  });
                                  // print(_error);
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    backgroundColor: Colors.black,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50.w, vertical: 5.h)),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: const Color(0xffBE7C01),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                )),
                          SizedBox(
                            height: 5.h,
                          ),
                          // _error.isNotEmpty
                          //     ? Text(
                          //         login.authResponseModel.message!,
                          //         style: const TextStyle(color: Colors.red),
                          //       )
                          //     : Container()
                          _error.isNotEmpty
                              ? Text(
                                  _error,
                                  style: const TextStyle(color: Colors.red),
                                )
                              : Container()
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
