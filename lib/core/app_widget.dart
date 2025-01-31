import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'initial_loading.dart';

import '../../page/Supervisores/supervisores_page.dart';
import '../../page/avaliacao_gc/avaliacao_gc_page.dart';
import '../../page/control/control_page.dart';
import '../../page/gcs/gcs_page.dart';
import '../../page/home/home_page.dart';
import '../../page/igrejas/igrejas_page.dart';
import '../../page/informacoes_pessoais/informacoes_pessoais_page.dart';
import '../../page/licoes/licoes_page.dart';
import '../../page/lideres/lideres_page.dart';
import '../../page/lista_presenca/lista_presença_page.dart.dart';
import '../../page/login/login_page.dart';
import '../../page/membros/membros_page.dart';
import '../../page/secretarios/secretarios_page.dart';
import '../../page/selecionar_perfil/selecionar_perfil_page.dart';
import '../../page/verificar_perfil/verificar_perfil_page.dart';
import '../../theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppTheme.colors.primary,
            ),
        visualDensity: VisualDensity
            .adaptivePlatformDensity, //Adaptação de densidade de tela
        scaffoldBackgroundColor:
            AppTheme.colors.background, // Define a cor de fundo
      ),

      // Responsividade
      builder: (context, child) => ResponsiveBreakpoints.builder(
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 1280, name: TABLET),
          const Breakpoint(start: 1281, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
        child: child!,
      ),
      title: "Lord's Garden",
      initialRoute: '/initial_loading',
      routes: {
        '/login': (context) => const LoginPage(), //Tela de Login
        '/home': (context) => HomePage(context: context), //Tela de Home
        '/informacoes_pessoais': (context) =>
            const InformacoesPessoaisPage(), //Tela de Informações Pessoais
        '/control': (context) => const Control(
              userProfile: '',
            ), //Tela de Base
        '/selecionar_perfil': (context) => const SelecionarPerfilPage(),
        '/verificar_perfil': (context) => const VerificarPerfilPage(),
        '/initial_loading': (context) => InitialLoading(),
        '/igrejas': (context) => const IgrejasPage(),
        '/gcs': (context) => const GCsPage(),
        '/membros': (context) => const MembrosPage(),
        '/lista_presenca': (context) => const ListaPresencaPage(),
        '/licoes': (context) => const LicoesPage(),
        '/avaliacao_gc': (context) => const AvaliacaoGcPage(),
        '/supervisores': (context) => const SupervisoresPage(),
        '/lideres': (context) => const LideresPage(),
        '/secretarios': (context) => const SecretariosPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
