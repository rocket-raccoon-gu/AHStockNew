library stock_api;

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:stock_api/utils/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:stock_api/responses/base_response.dart';

import 'requests/login_request.dart' as loginRequestModel;
part 'endpoints.dart';
part 'utils/debuggable_client.dart';
part 'responses/failure.dart';

class ContentTypes {
  static const String applicationCharset = "application/json;charset=UTF-8";
  static const String applicationJson = "application/json";
  static const String formurlencoded = "application/x-www-form-urlencoded";
}

// var mainbaseUrl = String.fromEnvironment('BASE_URL',
//     defaultValue: "https://admin-qatar.testuatah.com");
// var mainapplicationPath =
//     String.fromEnvironment('APPLICATION_PATH', defaultValue: "/rest/V1/");

const Duration timeoutDuration = Duration(seconds: 30);

class StockApi {
  final String applicationPath;
  final Uri baseUrl;
  final http.Client _client;

  String cookie = "";
  String fullcookie = "";
  String token = "";

  bool networkOnline = true;
  @visibleForTesting
  StockApi(this.baseUrl, this.applicationPath, this._client);
  factory StockApi.create(
      {required String baseUrl,
      required String applicationPath,
      Duration connectionTimeout = timeoutDuration}) {
    return StockApi(
        Uri.parse(baseUrl), //'xlrds/webresources/SearchSymbol',
        applicationPath,
        IOClient(HttpClient()));
  }
  factory StockApi.debuggable(
      {required String baseUrl,
      required String applicationPath,
      Duration connectionTimeout = timeoutDuration}) {
    HttpClient httpClient = HttpClient();
    httpClient.connectionTimeout = connectionTimeout;
    return StockApi(
        Uri.parse(baseUrl), //'xlrds/webresources/SearchSymbol',
        applicationPath,
        _DebuggableClient(IOClient(HttpClient())));
  }
  factory StockApi.proxy(
      {required String baseUrl,
      required String applicationPath,
      required String proxyIp,
      Duration connectionTimeout = timeoutDuration}) {
    HttpClient httpClient = HttpClient();
    httpClient.connectionTimeout = connectionTimeout;
    httpClient.findProxy = (uri) {
      return "PROXY $proxyIp:8888;";
    };
    httpClient.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => Platform.isAndroid);
    return StockApi(
        Uri.parse(baseUrl), //'xlrds/webresources/SearchSymbol',
        applicationPath,
        IOClient(httpClient));
  }
}

extension StockGeneralApi on StockApi {
  Future<http.Response> loginService(
      {required String userId,
      required String password,
      required String version}) async {
    Uri url = _endpointWithApplicationPath("/pk_dv_login.php");
    // Uri url11 = Uri.parse(_endpointWithApplicationCustomPath(
    //     "custom-api/api/qatar/pk_dv_login.php"));
    // Uri url = Uri.parse(
    //     'https://admin-qatar.testuatah.com/custom-api/api/qatar/pk_dv_login.php');
    // Uri url = Uri.parse(
    //     'https://www.testuatah.com/custom-api/api/qatar/pk_dv_login.php');

    print(url);
    final loginRequest = loginRequestModel.LoginRequest(
        username: userId, password: password, version: version);
    final Map<String, String> headers = {
      'Content-Type': ContentTypes.applicationCharset,
    };
    try {
      serviceSend("Login");
      return _handleRequest(
          onRequest: () => _client.post(
                url,
                body: jsonEncode(loginRequest),
                headers: headers,
              ),
          onResponse: (response) {
            print(response.body);
            // cookie = updateCookie(response);
            // fullcookie = updateFullCookie(response);

            return response;
          });
    } catch (e) {
      serviceSendError("Login");
      rethrow;
    }
  }

  Future<http.Response> loginServiceOtherRgion(
      {required String userId,
      required String password,
      required String version}) async {
    // Uri url = _endpointWithApplicationPath("/pk_dv_login.php");

    // Uri url =
    //     Uri.parse('https://uae.ahmarket.com/rest/V1/integration/admin/token');
    Uri url11 = Uri.parse(
        _endpointWithApplicationCustomPath("rest/V1/integration/admin/token"));
    // Uri url = Uri.parse(
    //     'https://admin-qatar.testuatah.com/custom-api/api/qatar/pk_dv_login.php');
    // Uri url = Uri.parse(
    //     'https://www.testuatah.com/custom-api/api/qatar/pk_dv_login.php');

    print(url11);

    log(url11.toString());
    // final loginRequest = loginRequestModel.LoginRequest(
    //     username: userId, password: password, version: version);

    final Map<String, dynamic> body = {
      "username": userId,
      "password": password
    };

    final Map<String, String> headers = {
      'Content-Type': ContentTypes.applicationCharset,
    };
    try {
      serviceSend("Login");
      return _handleRequest(
          onRequest: () => _client.post(
                url11,
                body: jsonEncode(body),
                headers: headers,
              ),
          onResponse: (response) {
            print(response.body);
            // cookie = updateCookie(response);
            // fullcookie = updateFullCookie(response);

            return response;
          });
    } catch (e) {
      serviceSendError("Login");
      rethrow;
    }
  }

  Future profileService(
    String token1,
  ) async {
    // Uri url = Uri.parse(
    //     _endpointWithApplicationCustomPath('custom-api/api/qatar/getUser.php'));
    Uri url = _endpointWithApplicationPath('/getUser.php');
    // Uri url =
    //     Uri.parse('https://www.testuatah.com/custom-api/api/qatar/getUser.php');
    print(url);
    final Map<String, String> headers = {
      'Content-Type': ContentTypes.applicationJson,
      'Authorization': 'Bearer $token1'
    };
    print(url);
    serviceSend("profile service");
    print(token1);
    print(headers);
    return _handleRequest(
        onRequest: () => _client.get(url, headers: headers),
        onResponse: (response) {
          return response.body;
        });
  }

  Future<String> generalService(
      {required String endpoint, required String token}) async {
    final url = _endpointWithApplicationPath(_ordersService + endpoint);
    // final generalRequest =
    //     GeneralRequest(proc: "general_service", request: request);
    final Map<String, String> headers = {
      'Content-Type': ContentTypes.applicationCharset,
      'Authorization': 'Bearer $token',
    };

    print("my path$url");

    return _handleRequest(
        onRequest: () => _client.get(url, headers: headers),
        onResponse: (response) {
          return response.body;
        });
  }

  Future<String> checkPromotionService({required String endpoint}) async {
    final url = Uri.parse(
        'https://admin-qatar.testuatah.com/custom-api/api/scan_barcode_percentage.php?barcode=$endpoint');

    log(url.toString());

    final Map<String, String> headers = {
      'Content-Type': ContentTypes.applicationCharset,
    };

    return _handleRequest(
        onRequest: () => _client.get(url, headers: headers),
        onResponse: (response) {
          return response.body;
        });
  }

  Future<String> checkPromotionServiceRegions(
      {required String endpoint}) async {
    final url = _endpointWithApplicationCustomPath(
        'custom-api/api/scan_barcode_percentage.php?barcode=$endpoint');

    log(url.toString());

    final Map<String, String> headers = {
      'Content-Type': ContentTypes.applicationCharset
    };

    return _handleRequest(
        onRequest: () => _client.get(Uri.parse(url)),
        onResponse: (response) {
          return response.body;
        });
  }
}

extension on StockApi {
  Uri _endpointWithApplicationPath(String path) {
    print(baseUrl.toString());
    print(baseUrl.replace(path: '${baseUrl.path}$applicationPath$path'));
    return baseUrl.replace(path: '${baseUrl.path}$applicationPath$path');
  }

  Uri _endpointWithApplicationPathAndParameter(
          String path, Map<String, dynamic> param) =>
      baseUrl.replace(
          path: '${baseUrl.path}$applicationPath$path', queryParameters: param);
  Uri _endpoint(String path) => baseUrl.replace(path: '${baseUrl.path}$path');

  String _endpointWithApplicationPathString(String path) {
    String newpath = '$baseUrl$applicationPath$path';
    return newpath;
  }

  String _endpointWithApplicationCustomPath(String path) {
    String abpath = '$baseUrl$path';
    // return baseUrl.replace(path: '${baseUrl.path}$applicationPath$path');

    print("path$abpath");

    return abpath;
  }

  Future<T> _handleRequest<T>(
      {required Future<http.Response> Function() onRequest,
      required T Function(http.Response) onResponse}) async {
    if (!networkOnline) {
      throw "Oops, device is offline, please check your internet connection.";
    } else {
      try {
        final response = await onRequest().timeout(
          timeoutDuration,
          onTimeout: () => throw TimeoutException("Timeout Exception"),
        );

        if (response.statusCode == 200) {
          if ((response.contentLength ?? 0) < 1) {
            throw "respose is empty";
          }
          int timeOut = 0;
          try {
            timeOut = BaseResponse.fromJson(response.body).errorCode;
          } catch (e) {}

          if (timeOut == 1604) {
            throw "session timeout, please relogin";
          }
          return onResponse(response);
        } else {
          log("Network Response Error", time: DateTime.now());
          // throw "Network error"; //"Oops, We are having some trouble connecting";
          log(response.toString());
          return onResponse(response);
        }
      } on SocketException {
        log("Socket Exception", time: DateTime.now());
        throw "Network error"; //'We are having some trouble reaching the server';
      } on TimeoutException {
        log("Timeout Exception", time: DateTime.now());
        throw 'Its taking longer than usual, please try again';
      } on ResponseFailure catch (e) {
        log("Response Failure", time: DateTime.now());
        if (e.errorMessage == 'You are not logged in, please log back in') {
          throw e.errorMessage;
        }
        rethrow;
      } catch (e) {
        throw e.toString();
      }
    }
  }

  Future<T> _handleHTTPRequest<T>(
      {required Future<http.Response> Function() onRequest,
      required T Function(http.Response) onResponse}) async {
    if (!networkOnline) {
      throw "Oops, device is offline, please check your internet connection.";
    } else {
      try {
        final response = await onRequest().timeout(
          timeoutDuration,
          onTimeout: () => throw TimeoutException("Timeout Exception"),
        );
        if (response.statusCode == 200) {
          if ((response.contentLength ?? 0) < 1) {
            throw "respose is empty";
          }
          return onResponse(response);
        } else {
          log("Network Response Error", time: DateTime.now());
          throw "Network error"; //"Oops, We are having some trouble connecting";
        }
      } on SocketException {
        log("Socket Exception", time: DateTime.now());
        throw "Network error"; //'We are having some trouble reaching the server';
      } on TimeoutException {
        log("Timeout Exception", time: DateTime.now());
        throw 'Its taking longer than usual, please try again';
      } on ResponseFailure catch (e) {
        log("Response Failure", time: DateTime.now());
        if (e.errorMessage == 'You are not logged in, please log back in') {
          throw e.errorMessage;
        }
        rethrow;
      } catch (e) {
        throw e.toString();
      }
    }
  }
}
