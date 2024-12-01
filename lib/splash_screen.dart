import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usanacaixaapp/ui/views/entry_point/entry_point.dart';
import 'entry_point.dart'; // Certifique-se de que a tela "EntryPoint" esteja importada.

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay de 3 segundos antes de navegar para a próxima tela
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EntryPoint()), // Redireciona para a EntryPoint
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SvgPicture.asset(
          'assets/images/logo.svg', // Altere conforme o caminho da sua logo
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
