class UserModel {
  final int id;
  final String name;
  final String email;
  final String balance;

  UserModel({required this.id, required this.name, required this.email, required this.balance});

  // Método para converter JSON em uma instância de Group
  factory UserModel.fromMap(dynamic map) {
    return UserModel(id: map['id'], name: map['name'], email: map['email'], balance: map['balance']);
  }
}
