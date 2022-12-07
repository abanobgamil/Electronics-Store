import 'package:dio/dio.dart';

class DioHelper{


  static late Dio dio;

  static init()
  {
   dio= Dio(
     BaseOptions(
       baseUrl: "http://10.0.2.2:3000/",
       receiveDataWhenStatusError: true,
       headers: {
         'Content-Type':'application/json',
       }
     )
   );
  }



  static Future<Response> getData({
    required String url,
    Map<String,dynamic> ? query,
    String lang="en" ,
    String token="" ,
}) async
  {
    dio.options.headers=
        {
          'Content-Type':'application/json',
          "Lang":lang,
          "Authorization":token,
        };

    return await dio.get(url,queryParameters: query) ;
  }



  static Future<Response> postData({
    required String url,
    required Map<String,dynamic> data,
    Map<String,dynamic> ? query,
    String lang="en",
    String token='' ,
  }) async
  {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      "Lang":lang,
      "Authorization":token,
    };

    return await dio.post(url,data: data);
  }

  static Future<Response> putData({
    required String url,
    required Map<String,dynamic> data,
    Map<String,dynamic> ? query,
    String lang="en",
    String token='' ,
  }) async
  {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      "Lang":lang,
      "Authorization":token,
    };


    return await dio.put(url,data: data);
  }





}