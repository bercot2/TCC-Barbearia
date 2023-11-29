import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class APIConsumer{

  Future<bool> delete(String url) async {
    try {
      var response = await http.delete(Uri.parse(url)).timeout(const Duration(seconds: 60));

      if (response.statusCode == 204 || response.statusCode == 203){
        return true;
      }

      return false;
    } catch (e) {
      print(e);
    }
  }

  Future<http.Response> put({String url, Map<String, dynamic> body}) async {
    try {
      var response = await http.put(
        Uri.parse(url),
        headers: {
          "content-type": "application/json; charset=utf-8",
        },
        body: jsonEncode(body)).timeout(const Duration(seconds: 60));

        return response;
    } on TimeoutException catch(e){
      print(e);

      return null;
    } on Exception catch(e){
      print(e);
    }
  }

  Future<http.Response> post({String url, Map<String, dynamic> body}) async {
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "content-type": "application/json; charset=utf-8",
        },
        body: jsonEncode(body)).timeout(const Duration(seconds: 60));

        return response;
    } on TimeoutException catch(e){
      print(e);

      return null;
    } on Exception catch(e){
      print(e);
    }
  }

  Future<dynamic> get({String url}) async {
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      ).timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(Utf8Decoder().convert(response.bodyBytes));

        return jsonResponse;
      } else {
        return response.body;
      }
    } on TimeoutException catch(e){
      print(e);

      return null;
    } on Exception catch(e){
      print(e);
    }
    }
}