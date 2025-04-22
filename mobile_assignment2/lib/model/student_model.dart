class Student {
  int? id;
  String? name;
  String? email;
  String? password;
  int? level;
  String? gender;
  String? picPath;

  Student(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.level,
      this.gender,
      this.picPath});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['StudentId'];
    name = json['Name'];
    email = json['Email'];
    password = json['Password'];
    gender = json['gender'];
    level = json['Level'];
    picPath = json['PicturePath'];
  }
}
