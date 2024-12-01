class UserRegisterModel {
  final String name;
  final String phoneNumber;
  final String cpf;
  final String email;
  final String password;
  final String rePassword;

  UserRegisterModel(
      {required this.name,
      required this.phoneNumber,
      required this.cpf,
      required this.email,
      required this.password,
      required this.rePassword});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone_number': phoneNumber,
      'cpf': cpf,
      'email': email,
      'password': password,
      're_password': rePassword,
    };
  }
}
