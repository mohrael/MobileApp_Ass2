import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/register_provider.dart';
import '../widgets/customed_rich_span.dart';
import '../widgets/customed_text_form_field.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _registerNameCntr = TextEditingController();
  final TextEditingController _registerEmailCntr = TextEditingController();

  final TextEditingController _registerStudentIdCntr = TextEditingController();

  final TextEditingController _registerPasswordCntr = TextEditingController();
  final TextEditingController _registerConfirmPasswordCntr =
      TextEditingController();

  var _level;

  var _gender;

  String _error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.h),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  ChangeNotifierProvider(
                      create: (context) => RegisterProvider(),
                      child: Consumer<RegisterProvider>(
                        builder: (context, register, child) {
                          // print(register.isButtonLoading);
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomedTextFormField(
                                  controller: _registerNameCntr,
                                  labelText: "Name",
                                  regexActive: false,
                                  isPassword: false),
                              SizedBox(
                                height: 22.h,
                              ),
                              CustomedTextFormField(
                                  controller: _registerEmailCntr,
                                  labelText: "Email",
                                  regexActive: true,
                                  isPassword: false,
                                  regExp:
                                      RegExp(r'^\d{8}@stud\.fci-cu\.edu\.eg$'),
                                  helperText:
                                      "example: studentID@stud.fci-cu.edu.eg"),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomedTextFormField(
                                  controller: _registerStudentIdCntr,
                                  labelText: "Student Id",
                                  regexActive: false,
                                  isPassword: false),
                              SizedBox(
                                height: 22.h,
                              ),
                              CustomedTextFormField(
                                controller: _registerPasswordCntr,
                                labelText: "Password",
                                helperText:
                                    "Password should contain at least an uppercase letter, number and non-numeric symbol",
                                regexActive: true,
                                isPassword: true,
                                regExp: RegExp(
                                    r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^a-zA-Z\d]).{5,}$"),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomedTextFormField(
                                  controller: _registerConfirmPasswordCntr,
                                  labelText: "Confirm Password",
                                  regexActive: false,
                                  isPassword: true),
                              SizedBox(
                                height: 22.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: Colors.black, width: 2)),
                                child: DropdownButton(
                                  isExpanded: true,
                                  borderRadius: BorderRadius.circular(4),
                                  items: const [
                                    DropdownMenuItem<String>(
                                      value: "1",
                                      child: Text("1"),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "2",
                                      child: Text("2"),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "3",
                                      child: Text("3"),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "4",
                                      child: Text("4"),
                                    ),
                                  ],
                                  hint: const Text(
                                    "Level",
                                    style: TextStyle(color: Color(0xffBE7C01)),
                                  ),
                                  iconEnabledColor: Colors.black,
                                  value: _level,
                                  onChanged: (val) {
                                    setState(() {
                                      _level = val!;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Radio(
                                        focusColor: Colors.black,
                                        activeColor: Colors.black,
                                        value: "Male",
                                        groupValue: _gender,
                                        onChanged: (val) {
                                          setState(() {
                                            _gender = "Male";
                                          });
                                        }),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Male",
                                        style: TextStyle(
                                            color: const Color(0xffBE7C01),
                                            fontSize: 15.sp),
                                      )),
                                  Expanded(
                                    flex: 1,
                                    child: Radio(
                                        value: "Female",
                                        focusColor: Colors.black,
                                        activeColor: Colors.black,
                                        groupValue: _gender,
                                        onChanged: (val) {
                                          setState(() {
                                            _gender = "Female";
                                          });
                                        }),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Female",
                                        style: TextStyle(
                                            color: const Color(0xffBE7C01),
                                            fontSize: 15.sp),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              const CustomedRichSpan(
                                  text: "Have an existing account? ",
                                  inkwellText: "Login",
                                  screen: LoginScreen()),
                              SizedBox(
                                height: 10.h,
                              ),
                              register.isButtonLoading
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      onPressed: () async {
                                        //TODO:Register API
                                        // print(int.parse(_level).runtimeType);
                                        // print(register.authResponseModel.data);
                                        // if ((_registerNameCntr.text.isNotEmpty &&
                                        //         _registerNameCntr.text.length >=
                                        //             3) &&
                                        //     (RegExp(r'^\d{8}@stud\.fci-cu\.edu\.eg$')
                                        //         .hasMatch(
                                        //             _registerEmailCntr.text)) &&
                                        //     RegExp(
                                        //       r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^a-zA-Z\d]).{5,}$",
                                        //     ).hasMatch(
                                        //         _registerPasswordCntr.text) &&
                                        //     _registerStudentIdCntr
                                        //         .text.isNotEmpty &&
                                        //     (_level != null) &&
                                        //     (_gender != null)) {
                                        //   if (_registerPasswordCntr.text ==
                                        //       _registerConfirmPasswordCntr.text) {
                                        //     await register.register(
                                        //         name: _registerNameCntr.text,
                                        //         email: _registerEmailCntr.text,
                                        //         password:
                                        //             _registerPasswordCntr.text,
                                        //         level: int.parse(_level),
                                        //         gender: _gender == 'Male' ? 1 : 2,
                                        //         studentId: int.parse(
                                        //             _registerStudentIdCntr.text));
                                        //
                                        //     setState(() {
                                        //       if (!register
                                        //           .authResponseModel.message!
                                        //           .contains("Successfully")) {
                                        //         _error = register
                                        //             .authResponseModel.message!;
                                        //       } else {
                                        //         _error = "";
                                        //       }
                                        //     });
                                        //     if (register.authResponseModel.message!
                                        //         .contains("Successfully")) {
                                        //       Navigator.of(context).pushReplacement(
                                        //           MaterialPageRoute(
                                        //               builder: (context) =>
                                        //                   const LoginScreen()));
                                        //     }
                                        //   } else {
                                        //     setState(() {
                                        //       _error = "Check Passwords";
                                        //     });
                                        //   }
                                        // } else {
                                        //   setState(() {
                                        //     _error = "Check Inputs";
                                        //   });
                                        // }

                                        //TODO:Register LOCAL DB
                                        if ((_registerNameCntr
                                                    .text.isNotEmpty &&
                                                _registerNameCntr.text.length >=
                                                    3) &&
                                            (RegExp(r'^\d{8}@stud\.fci-cu\.edu\.eg$')
                                                .hasMatch(
                                                    _registerEmailCntr.text)) &&
                                            RegExp(
                                              r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^a-zA-Z\d]).{5,}$",
                                            ).hasMatch(
                                                _registerPasswordCntr.text) &&
                                            _registerStudentIdCntr
                                                .text.isNotEmpty &&
                                            _registerConfirmPasswordCntr.text ==
                                                _registerPasswordCntr.text &&
                                            _registerEmailCntr.text.substring(
                                                    0,
                                                    _registerEmailCntr.text
                                                        .indexOf("@")) ==
                                                _registerStudentIdCntr.text) {
                                          await register.register(
                                              name: _registerNameCntr.text,
                                              email: _registerEmailCntr.text,
                                              password:
                                                  _registerPasswordCntr.text,
                                              level: int.parse(_level),
                                              gender: _gender,
                                              studentId: int.parse(
                                                  _registerStudentIdCntr.text));
                                          setState(() {
                                            if (register.error.isNotEmpty) {
                                              _error = register.error;
                                            } else {
                                              _error = '';
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Registered Successfully"),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                dismissDirection:
                                                    DismissDirection.startToEnd,
                                              ));
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginScreen()));
                                            }
                                          });
                                        } else if (_registerConfirmPasswordCntr
                                                .text !=
                                            _registerPasswordCntr.text) {
                                          setState(() {
                                            _error = "Check Passwords";
                                          });
                                        } else {
                                          setState(() {
                                            _error = "Check Inputs";
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          backgroundColor: Colors.black,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 50.w, vertical: 5.h)),
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            color: const Color(0xffBE7C01),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold),
                                      )),
                              _error.isNotEmpty
                                  ? Text(
                                      _error,
                                      style: const TextStyle(color: Colors.red),
                                    )
                                  : Container()
                            ],
                          );
                        },
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/*
                          // TextFormField(
                          //     obscureText: !_show,
                          //     controller: _registerConfirmPasswordCntr,
                          //     cursorColor: Colors.black,
                          //     onChanged: (s) {
                          //       setState(() {});
                          //     },
                          //     decoration: InputDecoration(
                          //       suffixIcon: IconButton(
                          //           onPressed: () {
                          //             setState(() {
                          //               _show = !_show;
                          //             });
                          //           },
                          //           icon: !_show
                          //               ? const Icon(Icons.remove_red_eye)
                          //               : const Icon(Icons.close)),
                          //       labelText: "Confirm Password",
                          //       labelStyle:
                          //           const TextStyle(color: Color(0xffBE7C01)),
                          //       enabledBorder: const OutlineInputBorder(
                          //           borderSide: BorderSide(
                          //               color: Colors.black, width: 2)),
                          //       focusedBorder: const OutlineInputBorder(
                          //           borderSide: BorderSide(
                          //               color: Colors.black, width: 2)),
                          //     )),

                          // TextFormField(
                          //     obscureText: !_show,
                          //     controller: _registerPasswordCntr,
                          //     cursorColor: Colors.black,
                          //     onChanged: (s) {
                          //       setState(() {});
                          //     },
                          //     decoration: InputDecoration(
                          //       helperText: _registerPasswordCntr.text
                          //           .isEmpty
                          //           ? ""
                          //           : "Password should contain at least an uppercase letter, number and non-numeric symbol",
                          //       helperStyle: TextStyle(
                          //           color:
                          //           RegExp(r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^a-zA-Z\d]).{5,}$")
                          //               .hasMatch(
                          //               _registerPasswordCntr.text)
                          //               ? const Color(0xff007C04)
                          //               : const Color(0xffD10000),
                          //           fontWeight: FontWeight.bold),
                          //       suffixIcon: IconButton(
                          //           onPressed: () {
                          //             setState(() {
                          //               _show = !_show;
                          //             });
                          //           },
                          //           icon: !_show
                          //               ? const Icon(Icons.remove_red_eye)
                          //               : const Icon(Icons.close)),
                          //       labelText: "Password",
                          //       labelStyle:
                          //       const TextStyle(color: Color(0xffBE7C01)),
                          //       enabledBorder: const OutlineInputBorder(
                          //           borderSide: BorderSide(
                          //               color: Colors.black, width: 2)),
                          //       focusedBorder: const OutlineInputBorder(
                          //           borderSide: BorderSide(
                          //               color: Colors.black, width: 2)),
                          //     )),

                          // TextFormField(
                          //     controller: _registerStudentIdCntr,
                          //     keyboardType: TextInputType.number,
                          //     cursorColor: Colors.black,
                          //     onChanged: (s) {},
                          //     decoration: const InputDecoration(
                          //         labelText: "Student Id",
                          //         labelStyle:
                          //             TextStyle(color: Color(0xffBE7C01)),
                          //         enabledBorder: OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //                 color: Colors.black, width: 2)),
                          //         focusedBorder: OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //                 color: Colors.black, width: 2)))),

                          // TextFormField(
                          //     controller: _registerEmailCntr,
                          //     cursorColor: Colors.black,
                          //     onChanged: (s) {
                          //       setState(() {});
                          //     },
                          //     decoration: InputDecoration(
                          //         helperText: _registerEmailCntr.text
                          //             .isEmpty
                          //             ? ""
                          //             : "example: studentID@stud.fci-cu.edu.eg",
                          //         helperStyle: TextStyle(
                          //             color:
                          //             RegExp(
                          //                 r'^\d{8}@stud\.fci-cu\.edu\.eg$')
                          //                 .hasMatch(
                          //                 _registerEmailCntr.text)
                          //                 ? const Color(0xff007C04)
                          //                 : const Color(0xffD10000),
                          //             fontWeight: FontWeight.bold),
                          //         labelText: "Email",
                          //         labelStyle:
                          //         const TextStyle(color: Color(0xffBE7C01)),
                          //         enabledBorder: const OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //                 color: Colors.black, width: 2)),
                          //         focusedBorder: const OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //                 color: Colors.black, width: 2)))),

                          // TextFormField(
                          //     controller: _registerNameCntr,
                          //     cursorColor: Colors.black,
                          //     onChanged: (s) {
                          //       setState(() {});
                          //     },
                          //     decoration: InputDecoration(
                          //         helperText: _registerNameCntr.text.isEmpty
                          //             ? ""
                          //             : "Name must be more than 3",
                          //         helperStyle: TextStyle(
                          //             color: _registerNameCntr.text.length < 3
                          //                 ? const Color(0xffD10000)
                          //                 : const Color(0xff007C04),
                          //             fontWeight: FontWeight.bold),
                          //         labelText: "Name",
                          //         labelStyle:
                          //             const TextStyle(color: Color(0xffBE7C01)),
                          //         enabledBorder: const OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //                 color: Colors.black, width: 2)),
                          //         focusedBorder: const OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //                 color: Colors.black, width: 2)))),


*/
