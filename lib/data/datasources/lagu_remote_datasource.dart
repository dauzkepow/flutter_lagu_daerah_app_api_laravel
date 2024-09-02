//data dari backend, internet, server data dari luar

import 'package:flutter_lagu_daerah_app/data/models/lagu_response_model.dart';
import 'package:http/http.dart' as http;

class LaguRemoteDatasource {
  //ambil data dari backend endpoint api
  Future<LaguResponseModel> getLaguDaerah() async {
    final response =
        await http.get(Uri.parse('http://192.168.200.3:8000/api/lagudaerah'));
    if (response.statusCode == 200) {
      return LaguResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
