import 'dart:convert';
import 'package:http/http.dart';
import '../core.dart';
class ApiServices {
  String endPoint='https://reqres.in/api/users?page=2';
  Future<List<Data>> getUser() async{
    Response response= await get(Uri.parse(endPoint));
    if(response.statusCode == 200){
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => Data.fromJson(e)).toList();
    }
    else{
      throw Exception(response.reasonPhrase);
    }
  }
}


