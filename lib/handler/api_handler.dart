import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

const String baseUrl = "https://sandbox.api.lettutor.com/";

class ApiHandler {
  static final Dio handler = Dio();
  static late Options _headers;
  static Options getHeaders() {
    return _headers;
  }

  static void setHeaders(Options newHeaders) {
    _headers = newHeaders;
  }

  static void initial() {
    // handler = Dio();
    // (handler.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    // return client;
    // };
  }
}
