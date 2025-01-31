import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/initial_loading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../theme/app_theme.dart';
import '../Supervisores/supervisores_page.dart';
import '../avaliacao_gc/avaliacao_gc_page.dart';
import '../gcs/gcs_page.dart';
import '../home/home_page.dart';
import '../igrejas/igrejas_page.dart';
import '../informacoes_pessoais/informacoes_pessoais_page.dart';
import '../licoes/licoes_page.dart';
import '../lideres/lideres_page.dart';
import '../lista_presenca/lista_presença_page.dart.dart';
import '../login/login_page.dart';
import '../melhores_acoes/melhores_acoes_page.dart';
import '../membros/membros_page.dart';
import '../secretarios/secretarios_page.dart';
import '../selecionar_perfil/selecionar_perfil_page.dart';
import '../verificar_perfil/verificar_perfil_page.dart';
import 'widget/custom_appbar_widget.dart';
import 'widget/menu_lateral_widget.dart';
import 'widget/pagina_selecionada_widget.dart';

class Control extends StatefulWidget {
  const Control({super.key, required this.userProfile});

  final String userProfile;

  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);

  final _key = GlobalKey<ScaffoldState>();

  late Future<String> _userProfileFuture;

  @override
  void initState() {
    super.initState();
    _userProfileFuture = getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _userProfileFuture,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              color: AppTheme.colors.white,
              alignment: Alignment.center,
              child: const CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else {
            return _buildControlWidget(snapshot.data ?? '');
          }
        }
      },
    );
  }

  Widget _buildControlWidget(String userProfile) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppTheme.colors.primary,
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor:
            AppTheme.colors.background, // Define a cor de fundo
      ),
      title: "Lord's Garden",
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => HomePage(context: context),
        '/melhores_acoes': (context) => const MelhoresAcoesPage(),
        '/informacoes_pessoais': (context) => const InformacoesPessoaisPage(),
        '/control': (context) => Control(userProfile: userProfile),
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
      home: Scaffold(
        key: _key,
        appBar: isSmallScreen
            ? AppBar(
                title: const Text("Lord's Garden"),
                leading: IconButton(
                  onPressed: () {
                    if (!Platform.isAndroid && !Platform.isIOS) {
                      _controller.setExtended(true);
                    }
                    _key.currentState?.openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                ),
              )
            : null,
        drawer: MenuLateral(
          controller: _controller,
          userProfile: userProfile,
        ),
        body: Row(
          children: [
            if (!isSmallScreen)
              MenuLateral(
                controller: _controller,
                userProfile: userProfile,
              ),
            Expanded(
              child: Scaffold(
                appBar: const CustomAppBarWidget(),
                body: Padding(
                  padding: const EdgeInsets.only(
                    left: 50,
                    right: 50,
                  ), //espaçamento lateral do centro da página central que mostra as outras páginas
                  child: Center(
                    child: PaginaSelecionadaWidget(
                      controller: _controller,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userProfileSnapshot = await FirebaseFirestore.instance
          .collection('perfil_usuario')
          .doc(user.uid)
          .get();
      if (userProfileSnapshot.exists) {
        Map<String, dynamic> userProfileData =
            userProfileSnapshot.data() as Map<String, dynamic>;
        return userProfileData['perfil'] ?? '';
      } else {
        return ''; // Retorna vazio se o perfil do usuário não for encontrado
      }
    } else {
      return ''; // Retorna vazio se o usuário não estiver autenticado
    }
  }
}
