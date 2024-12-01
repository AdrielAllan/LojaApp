import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/models/user_model.dart';

class InfoPofileMenu extends StatelessWidget {
  const InfoPofileMenu({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundColor: Color(0xFF332858),
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 40,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          user.name,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Carteira atual \$${user.balance}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
