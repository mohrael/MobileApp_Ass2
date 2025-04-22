import 'package:flutter/material.dart';

import '../helper/accounts_db.dart';

class RegisterProvider extends ChangeNotifier {
  bool isButtonLoading = false;
  String error = '';

  SQLDB sqldb = SQLDB();

  Future<void> register({
    required int studentId,
    required String name,
    int? level,
    required String email,
    required String password,
    String? gender,
  }) async {
    isButtonLoading = true;
    notifyListeners();
    try {
      var data = await sqldb.insertStudent(
        name,
        email,
        studentId,
        password,
        level,
        gender,
      );

      if (data == -1) {
        error = "Student ID already exists!";
      } else {
        error = '';
      }
      isButtonLoading = false;
    } catch (e) {
      isButtonLoading = false;
      error = e.toString();
    }
    notifyListeners();
  }
}
