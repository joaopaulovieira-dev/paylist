import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paylist/page/melhores_acoes/melhores_acoes_page.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../avaliacao_gc/avaliacao_gc_page.dart';
import '../../gcs/gcs_page.dart';
import '../../home/home_page.dart';
import '../../licoes/licoes_page.dart';
import '../../lideres/lideres_page.dart';
import '../../lista_presenca/lista_presença_page.dart.dart';
import '../../membros/membros_page.dart';
import '../../secretarios/secretarios_page.dart';

class PaginaSelecionadaWidget extends StatelessWidget {
  const PaginaSelecionadaWidget({
    super.key,
    required this.controller,
  });

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return FutureBuilder<String>(
          future: getUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else {
                final userProfile = snapshot.data!;
                return _getPageByIndex(
                    userProfile, controller.selectedIndex, context);
              }
            }
          },
        );
      },
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

  Widget _getPageByIndex(String userProfile, int index, BuildContext context) {
    switch (userProfile) {
      case 'Administrador':
        return _getPageByIndexAdministrador(index, context);
      case 'Supervisor':
        return _getPageByIndexSupervisor(index, context);
      case 'Líder':
        return _getPageByIndexLider(index, context);
      case 'Secretário':
        return _getPageByIndexSecretario(index, context);
      default:
        return HomePage(context: context);
    }
  }

  Widget _getPageByIndexAdministrador(int index, BuildContext context) {
    switch (index) {
      case 0:
        return HomePage(context: context); //Home
      case 1:
        return const MelhoresAcoesPage(); //Melhores Ações
      // case 2:
      //   return const IgrejasPage(); //Igrejas
      // case 3:
      //   return const SupervisoresPage(); //Supervisores
      // case 4:
      //   return const LideresPage(); //Líderes
      // case 5:
      //   return const SecretariosPage(); //Secretários
      // case 6:
      //   return const LicoesPage(); //Lições
      // case 7:
      //   return const GCsPage(); //GCs
      // case 8:
      //   return const MembrosPage(); //Membros
      // case 9:
      //   return const ListaPresencaPage(); //Lista de Presença
      // case 10:
      //   return const AvaliacaoGcPage(); //Avaliação de GC
      default:
        return HomePage(context: context);
    }
  }

  Widget _getPageByIndexSupervisor(int index, BuildContext context) {
    switch (index) {
      case 0:
        return HomePage(context: context); //Home
      case 1:
        return const LideresPage(); //Líderes
      case 2:
        return const SecretariosPage(); //Secretários
      case 3:
        return const LicoesPage(); //Lições
      case 4:
        return const GCsPage(); //GCs

      case 5:
        return const MembrosPage(); //Membros
      case 6:
        return const ListaPresencaPage(); //Lista de Presença
      case 7:
        return const AvaliacaoGcPage(); //Avaliação de GC
      default:
        return HomePage(context: context);
    }
  }

  Widget _getPageByIndexLider(int index, BuildContext context) {
    switch (index) {
      case 0:
        return HomePage(context: context); //Home
      case 1:
        return const SecretariosPage(); //Secretários
      case 2:
        return const LicoesPage(); //Lições
      case 3:
        return const GCsPage(); //GCs
      case 4:
        return const MembrosPage(); //Membros
      case 5:
        return const ListaPresencaPage(); //Lista de Presença
      case 6:
        return const AvaliacaoGcPage(); //Avaliação de GC
      default:
        return HomePage(context: context);
    }
  }

  Widget _getPageByIndexSecretario(int index, BuildContext context) {
    switch (index) {
      case 0:
        return HomePage(context: context); //Home
      case 1:
        return const LicoesPage(); //Lições
      case 2:
        return const MembrosPage(); //Membros
      case 3:
        return const ListaPresencaPage(); //Lista de Presença
      case 4:
        return const AvaliacaoGcPage(); //Avaliação de GC
      default:
        return HomePage(context: context);
    }
  }
}
