class UserBean {
  int userId;
  String userName;
  String userImage;
  String email;
  String phoneNumber;
  int type;

  UserBean({this.userId, this.userName, this.userImage, this.email, this.phoneNumber,
    this.type});

  UserBean.fromJson(Map<String, dynamic> jsonMap) {
    userId = jsonMap["userId"];
    userName = jsonMap["userName"];
    userImage = jsonMap["userImage"];
    email = jsonMap["email"];
    phoneNumber = jsonMap["phoneNumber"];
    type = jsonMap["type"];
  }
}