import 'package:dio/dio.dart';

final String UrlAPI = 'http://172.28.14.87:3381/';
Dio dio = Dio();

class DioService {
  static Future createDio({String? path}) async {
    try {
      var response = await dio.get<Map>(
        UrlAPI + path!,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      var data = response.data;
      return data;
    } catch (e) {
      print(e);
    }
  }
}
