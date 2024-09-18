//Infinite Scroll
//Ambil data dari LaguRemoteDatasource().getLaguDaerahPages(pageKey)
//https://pub.dev/packages/infinite_scroll_pagination

import 'package:flutter/material.dart';
import 'package:flutter_lagu_daerah_app/data/datasources/lagu_remote_datasource.dart';
import 'package:flutter_lagu_daerah_app/data/models/lagu_response_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BeerListView extends StatefulWidget {
  const BeerListView({super.key});

  @override
  _BeerListViewState createState() => _BeerListViewState();
}

class _BeerListViewState extends State<BeerListView> {
  // static const _pageSize = 20;

  final PagingController<int, Lagu> _pagingController =
      PagingController(firstPageKey: 1);

  //edit
  final TextEditingController judulController = TextEditingController();
  final TextEditingController laguController = TextEditingController();
  final TextEditingController daerahController = TextEditingController();

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await LaguRemoteDatasource().getLaguDaerahPages(pageKey);
      // final lastPage = newItems.data.lastPage;
      final isLastPage = newItems.data.currentPage == newItems.data.lastPage;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.data.data);
      } else {
        //final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems.data.data, ++pageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lagu Daerah',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.blueGrey,
      ),
      body: PagedListView(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Lagu>(
            itemBuilder: (context, item, index) {
          return Card(
            child: ListTile(
              title: Text(item.judul),
              subtitle: Text(item.daerah),
              leading: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueGrey,
              ),
            ),
          );
        }),
      ),
      //floating
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.pushNamed(context, '/add');
          //show dialog add
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add New Lagu'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Judul',
                      ),
                      controller: judulController,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Lagu',
                      ),
                      maxLines: 6,
                      controller: laguController,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Daerah',
                      ),
                      controller: daerahController,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      LaguRemoteDatasource().addLaguDaerah(
                        judulController.text,
                        laguController.text,
                        daerahController.text,
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Berhasil ditambahkan"),
                      ));
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
