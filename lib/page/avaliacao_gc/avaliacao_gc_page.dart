// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../theme/app_theme.dart';
import 'widgets/avaliacao_gc_editar_widget.dart';
import 'widgets/avaliacao_gc_form_widget.dart';
import 'widgets/avaliacao_gc_list_widget.dart';

class AvaliacaoGcPage extends StatefulWidget {
  const AvaliacaoGcPage({super.key});

  @override
  _AvaliacaoGcPageState createState() => _AvaliacaoGcPageState();
}

class _AvaliacaoGcPageState extends State<AvaliacaoGcPage> {
  final _firestore = FirebaseFirestore.instance;
  bool _showForm = false;
  bool _isEditing =
      false; // Variável para controlar se estamos editando ou criando uma nova igreja
  late String _selectedavaliacaogcId; // ID da igreja selecionada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avaliação de GCs', style: TextStyle(fontSize: 30)),
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: AppTheme.colors.appBar,
        surfaceTintColor: AppTheme.colors.appBar,
        // Adicionando botão de retorno quando o formulário estiver sendo exibido
        leading: _showForm
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _showForm = false;
                  });
                },
              )
            : null,
      ),
      backgroundColor: AppTheme.colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Avalie os GCs de sua igreja e tenha um controle mais eficiente das atividades.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: _showForm
                ? _isEditing
                    ? AvaliacaoGcEditarWidget(
                        avaliacaoId: _selectedavaliacaogcId)
                    : const AvaliacaoGcFormWidget() // Aqui exibimos o formulário de cadastro se _showForm for verdadeiro
                : StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('avaliacoes_gc').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return AvaliacaoGcListWidget(
                          snapshot: snapshot.data!,
                          onAvaliacaoGcSelected: (avaliacaogcId) {
                            setState(() {
                              _showForm = true;
                              _isEditing =
                                  true; // Indicar que estamos editando, não criando
                              _selectedavaliacaogcId = avaliacaogcId;
                            });
                          },
                          gcData: const [],
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                              'Erro ao carregar membros: ${snapshot.error}'),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: !_showForm
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _showForm = true;
                  _isEditing =
                      false; // Indicar que estamos criando uma nova igreja, não editando
                });
              },
              tooltip: 'Registrar Nova Avaliação',
              backgroundColor: AppTheme.colors.primary,
              child: Icon(Icons.add, color: AppTheme.colors.white),
            )
          : null, // Ocultando o botão flutuante quando o formulário estiver sendo exibido
    );
  }
}
