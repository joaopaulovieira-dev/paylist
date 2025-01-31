import 'package:flutter/material.dart';

abstract class AppColors {
  Color get background;
  Color get primary;
  Color get primaryVariant;
  Color get secundary;
  Color get secundaryVariant;
  Color get menu;
  Color get deepPrimary;

  Color get menulateralColor;
  Color get menulateralselecionadoColor;
  Color get white;
  Color get black;
  Color get textmenulateralColor;
  Color get enabletextmenulateralColor;
  Color get novidadesColor;

  Color get appBar;
  Color get appBarTitle;
}

class AppColorsDefault implements AppColors {
  @override
  //Color get background => const Color(0xFF040505); //Darkmode
  Color get background => Colors.white;
  @override
  Color get primary => Colors.lightBlueAccent;
  @override
  Color get primaryVariant => Colors.red;
  @override
  Color get secundary => Color(0xFF01ba6e);
  @override
  Color get secundaryVariant => Colors.blue[900]!;
  @override
  Color get menu =>
      const Color(0xFF767676); //Cor do menu horizontal da tela de login
  @override
  Color get deepPrimary => const Color.fromARGB(129, 201, 224, 231);

  @override
  Color get novidadesColor => Colors.lightBlueAccent;

  @override
  Color get black => Colors.black;

  /////////////// MENU LATERAL ////////////////

  @override
  Color get menulateralColor => const Color(0xFFF5F7F8);
  //Color get menulateralColor => Colors.black; //Cor de fundo do menu lateral //Darkmode
  @override
  Color get menulateralselecionadoColor => Colors.transparent;
  @override
  Color get white => Colors.white;
  @override
  Color get textmenulateralColor =>
      const Color(0xFF767676); //Cor dos icones não selecionados
  @override
  Color get enabletextmenulateralColor =>
      Color(0xFF293757); //Cor do icone e texto selecionado

  /////////////// APP BAR ////////////////

  @override
  Color get appBar => Colors.white;
  //Color get appBar => const Color(0xFF040505); //Darkmode

  @override
  Color get appBarTitle => Colors.black;
  //  Color get appBarTitle => Colors.black; //Darkmode
}

// Paleta Completa:

//Azul claro cor primairia: Colors.lightBlueAccent;
// Azul Escuro (0xFF293757) // Use o Azul Escuro para elementos principais, como títulos e chamadas para ação.
// Azul Médio (0xFF519de8) // Use o Azul Médio para destacar elementos importantes e criar contraste.
// Azul Claro (0xFF70d9fb) // Use o Azul Claro para detalhes, fundos e elementos que precisam de suavidade.
// Cinza Neutro (0xFFD3D3D3) // Use o Cinza Neutro para textos, ícones e elementos secundários.
// Branco (0xFFFFFFFF) // Use o Branco como cor de fundo principal para criar um visual clean e moderno.
