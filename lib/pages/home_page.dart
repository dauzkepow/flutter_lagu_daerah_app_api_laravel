//ketik stf lalu ctrl + spasi
//nama kelas sama dengan nama file
//home_page.dart kelas = HomePage
//statefull widget = widget yang punya state

//Ambil data Manual di List Models

import 'package:flutter/material.dart';
import 'package:flutter_lagu_daerah_app/data/models/province.dart';
import 'package:flutter_lagu_daerah_app/pages/detail_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  //fokus disini
  Widget build(BuildContext context) {
    return Scaffold(
      /*
        appBar: variabel depan huruf kecil (parameter warna biru)
        AppBar = widget atau class huruf depan Besar (huruf Besar)
        contoh : 
          color: Colors.white,
          title : Text(),
        jika ada garis biru kruwel kruwel = minta ditulis const
      */
      appBar: AppBar(
        title: const Text(
          'Lagu Daerah',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.blueGrey,
      ),
      //pakai listview builder = dibuild data sebanyak yang ada
      //itemBuilder = context, index
      //butuh return karena itemBuilder adalah function
      //ListView pakai widget ListTile
      //mendapatkan object ke index

      body: ListView.builder(
        itemBuilder: (context, index) {
          //agar bisa diklik
          return InkWell(
            //wrap dengan widget Inkwell
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                //butuh return
                return DetailPages(
                  province: laguDaerahList[index],
                );
              }));
            },

            child: Card(
              //wrap dengan widget card
              child: ListTile(
                title: Text(laguDaerahList[index].laguDaerah),
                //dengan teknik interpolasi
                subtitle: Text(
                    '${laguDaerahList[index].nama} - ${laguDaerahList[index].ibuKota}'),
                leading: Image.network(
                  laguDaerahList[index].photo,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        //diulang sebanyak data yg ada
        itemCount: laguDaerahList.length,
      ),
      //floating action
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Tambah Lagu'),
                content: const Column(
                  mainAxisSize: MainAxisSize.min, //ukuran form jadi kecil
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Nama Lagu'),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Nama Daerah'),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                  ElevatedButton(onPressed: () {}, child: const Text('Submit')),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
