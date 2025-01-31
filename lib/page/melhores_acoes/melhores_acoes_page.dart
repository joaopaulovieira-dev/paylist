// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:universal_web_image/universal_web_image.dart';

import '../../../theme/app_theme.dart';

class MelhoresAcoesPage extends StatefulWidget {
  const MelhoresAcoesPage({super.key});

  @override
  _MelhoresAcoesPageState createState() => _MelhoresAcoesPageState();
}

class _MelhoresAcoesPageState extends State<MelhoresAcoesPage> {
  List<Map<String, dynamic>> _acoesData = [];
  late AcoesDataSource _acoesDataSource;

  @override
  void initState() {
    super.initState();
    _fetchAcoesData();
  }

  Future<void> _fetchAcoesData() async {
    final codigosAcoes = [
      'BRAP4',
      'BRAP3',
      'AURE3',
      'CMIN3',
      'TAEE11',
      'TAEE3',
      'CMIG4',
      'ISAE4',
      'SANB4',
      'CPFE3',
      'WIZC3',
      'BRSR6',
      'CSMG3',
      'BBAS3',
      'BMGB4',
      'BBDC4',
      'BBDC3',
      'CMIG3',
      'ITSA3',
      'CPLE6',
      'EGIE3',
      'ITSA4',
      'BBSE3',
      'VBBR3',
      'VIVT3',
      'BEES3',
      'ABCB4',
      'ITUB4',
      'SAPR4',
      'TIMS3',
      'ALUP11',
      'PSSA3',
      'CXSE3',
      'SBSP3',
    ];

    try {
      List<Map<String, dynamic>> todasAcoesData = [];

      for (final codigo in codigosAcoes) {
        final codigoEncoded = Uri.encodeComponent(codigo);
        final url =
            'https://brapi.dev/api/quote/$codigoEncoded?token=qCeYczVj8uxZezbqzYgFEE';
        if (kDebugMode) {
          print('URL da requisição: $url');
        }

        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonData = jsonDecode(response.body);
          final results = jsonData['results'] as List;
          todasAcoesData.addAll(results.cast<Map<String, dynamic>>());
        } else {
          if (kDebugMode) {
            print(
                'Erro ao buscar dados da ação $codigo: ${response.statusCode}');
          }
          if (kDebugMode) {
            print('Resposta da API: ${response.body}');
          }
        }
      }

      setState(() {
        _acoesData = todasAcoesData;
        _acoesDataSource = AcoesDataSource(acoesData: _acoesData);
      });
    } catch (e) {
      if (kDebugMode) {
        print('Erro na requisição: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Melhores Ações', style: TextStyle(fontSize: 30)),
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: AppTheme.colors.appBar,
        surfaceTintColor: AppTheme.colors.appBar,
      ),
      backgroundColor: AppTheme.colors.white,
      body: _acoesData.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: SfDataGrid(
                gridLinesVisibility:
                    GridLinesVisibility.none, // Remove as bordas da grade
                headerGridLinesVisibility:
                    GridLinesVisibility.none, // Remove as bordas do cabeçalho
                source: _acoesDataSource,
                columns: [
                  GridColumn(
                    columnName: 'Ícone',
                    width: 50,
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text(''),
                    ),
                  ),
                  GridColumn(
                    columnName: 'Ticker',
                    width: 100,
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('Ticker'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'Valor Atual',
                    width: 100,
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('Valor Atual'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'Nome',
                    width: 300,
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('Nome'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'Setor',
                    width: 150,
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('Setor'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'DY',
                    width: 100,
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('DY + JCP 2018'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'P/L',
                    width: 100,
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('DY + JCP 2019'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'P/VP',
                    width: 100,
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('DY + JCP 2020'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'P/Ativos',
                    width: 100,
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('DY + JCP 2021'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'Marg. Bruta',
                    width: 100,
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('DY + JCP 2022'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'Marg. EBIT',
                    width: 100,
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('DY + JCP 2023'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'ROE',
                    width: 100,
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('DY + JCP 2024'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'ROIC',
                    width: 100,
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('DY Médio (7 anos)'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'CAGR Lucros 5 anos',
                    width: 100,
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('PMax'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'CAGR Receitas 5 anos',
                    width: 100,
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('Margem de Segurança (80%)'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'Div. Líq. / EBITDA',
                    width: 100,
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('Melhores Oportunidades'),
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class AcoesDataSource extends DataGridSource {
  AcoesDataSource({required List<Map<String, dynamic>> acoesData}) {
    _acoesData = acoesData
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'Ícone', value: e['logourl']),
              DataGridCell<String>(columnName: 'Ticker', value: e['symbol']),
              DataGridCell<double>(
                  columnName: 'Valor Atual', value: e['regularMarketPrice']),
              DataGridCell<String>(columnName: 'Nome', value: e['longName']),
              DataGridCell<String>(columnName: 'Setor', value: e['setor']),
              DataGridCell<double>(columnName: 'DY', value: e['DY']),
              DataGridCell<double>(columnName: 'P/L', value: e['P/L']),
              DataGridCell<double>(columnName: 'P/VP', value: e['P/VP']),
              DataGridCell<double>(
                  columnName: 'P/Ativos', value: e['P/Ativos']),
              DataGridCell<double>(
                  columnName: 'Marg. Bruta', value: e['margemBruta']),
              DataGridCell<double>(
                  columnName: 'Marg. EBIT', value: e['margemEbit']),
              DataGridCell<double>(columnName: 'ROE', value: e['ROE']),
              DataGridCell<double>(columnName: 'ROIC', value: e['ROIC']),
              DataGridCell<double>(
                  columnName: 'CAGR Lucros 5 anos',
                  value: e['cagrLucros5Anos']),
              DataGridCell<double>(
                  columnName: 'CAGR Receitas 5 anos',
                  value: e['cagrReceitas5Anos']),
              DataGridCell<double>(
                  columnName: 'Div. Líq. / EBITDA',
                  value: e['dividaLiquidaEbitda']),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _acoesData = [];

  @override
  List<DataGridRow> get rows => _acoesData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>(
      (e) {
        if (e.columnName == 'Ícone') {
          return UniversalWebImage(
            imageUrl: e.value.toString(),
          );
        } else if (e.columnName == 'Valor Atual') {
          final price = e.value as double;
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'R\$ ${price.toStringAsFixed(2)}',
            ),
          );
        }
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(e.value.toString()),
        );
      },
    ).toList());
  }
}
