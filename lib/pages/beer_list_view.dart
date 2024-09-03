//Infinite Scroll
//Ambil data dari LaguRemoteDatasource().getLaguDaerahPages(pageKey)
//https://pub.dev/packages/infinite_scroll_pagination

import 'package:flutter/material.dart';
import 'package:flutter_lagu_daerah_app/data/datasources/lagu_remote_datasource.dart';
import 'package:flutter_lagu_daerah_app/data/models/lagu_response_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BeerListView extends StatefulWidget {
  @override
  _BeerListViewState createState() => _BeerListViewState();
}

class _BeerListViewState extends State<BeerListView> {
  // static const _pageSize = 20;

  final PagingController<int, Lagu> _pagingController =
      PagingController(firstPageKey: 1);

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
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
