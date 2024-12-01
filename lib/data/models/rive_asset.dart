import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveAsset {
  final int id;
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(this.src,
      {required this.id,
      required this.artboard,
      required this.stateMachineName,
      required this.title,
      this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> sideMenus = [
  RiveAsset(
    "assets/riveAssets/icons.riv",
    id: 0,
    artboard: "HOME",
    stateMachineName: "HOME_interactivity",
    title: "Home",
  ),
  RiveAsset(
    "assets/riveAssets/icons.riv",
    id: 3,
    artboard: "SETTINGS",
    stateMachineName: "SETTINGS_Interactivity",
    title: "Configurações",
  )
];

List<Icon> bottomNavBar = [
  Icon(
    Icons.home_filled,
    color: Colors.white,
    size: 25,
  ),
  Icon(
    Icons.shopping_cart_outlined,
    color: Colors.white,
    size: 25,
  ),
  Icon(
    Icons.assignment_outlined,
    color: Colors.white,
    size: 25,
  ),
  Icon(
    Icons.person,
    color: Colors.white,
    size: 25,
  )
];
