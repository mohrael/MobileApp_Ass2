import 'package:flutter/material.dart';

import '../helper/accounts_db.dart';
import '../model/student_model.dart';

class LoginProvider extends ChangeNotifier {
  LoginProvider();

  bool isButtonLoading = false;
  String error = "";

  SQLDB sqldb = SQLDB();
  Student student = Student();

  Future<void> login(int id) async {
    isButtonLoading = true;
    notifyListeners();

    try {
      var data = await sqldb.getStudentById(id);

      student = Student.fromJson(data!);
    } catch (e) {
      error = "Invalid Credentials, Try Again";
    }

    isButtonLoading = false;
    notifyListeners();
  }
}
