//ambil data dari LaguRemoteDatasource().getLaguDaerah();

import 'package:flutter/material.dart';
import 'package:flutter_lagu_daerah_app/data/datasources/lagu_remote_datasource.dart';

import '../data/models/lagu_response_model.dart';

class LaguPage extends StatefulWidget {
  const LaguPage({super.key});

  @override
  State<LaguPage> createState() => _LaguPageState();
}

class _LaguPageState extends State<LaguPage> {
  //ambil data dari lagu_response_model.dart
  late Future<LaguResponseModel> laguDaerahList;

  //initstate
  @override
  void initState() {
    laguDaerahList = LaguRemoteDatasource().getLaguDaerah();
    super.initState();
  }

  //yang disarankan flutter pakai Future

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lagu Daerah',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.blueGrey,
      ),
      body: FutureBuilder<LaguResponseModel>(
        future: laguDaerahList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data!.data.data[index].judul),
                    subtitle: Text(snapshot.data!.data.data[index].daerah),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                    ),
                  ),
                );
              },
              itemCount: snapshot.data!.data.data.length,
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Center(
            child: const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
