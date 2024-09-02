// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_lagu_daerah_app/data/models/province.dart';

class DetailPages extends StatefulWidget {
  //properti variabel penampung data models
  final Province province;

  //constructor
  const DetailPages({
    super.key,
    required this.province,
  });

  @override
  State<DetailPages> createState() => _DetailPagesState();
}

class _DetailPagesState extends State<DetailPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //representasikan = final Province province;
        //tampilkan data dari model data dari variabel province
        title: Text(
          widget.province.nama,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 2,
        centerTitle: true,
      ),
      body: ListView(
        /*
        //percobaan penyusunan data test
        padding: const EdgeInsets.all(16),
        children: [
          Text('Nama Lagu'),
          Text('Nama Prov - Ibukota'),
          Text('Lirik'),
        ],
        */

        //ambil data final Province province;
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            widget.province.laguDaerah,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            '${widget.province.nama} ${widget.province.ibuKota}',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),

          //-- gambar
          Image.network(
            widget.province.photo,
            height: 300,
          ),

          const SizedBox(
            height: 12,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Text(
              widget.province.lirikLaguDaerah,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
