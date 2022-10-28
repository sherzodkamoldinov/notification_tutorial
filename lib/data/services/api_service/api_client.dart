import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notification_tutorial/data/services/api_service/custom%20exception.dart';
import 'package:notification_tutorial/utils/consts.dart';

class ApiClient {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 25000,
      receiveTimeout: 20000,
      headers: {
        "Authorization": "key=$notificationMessageKey",
        "Content-type": "application/json"
      },
    ),
  );

  ApiClient() {
    _init();
  }

  _init() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          debugPrint('ON ERRORGA KIRDI');
          switch (error.type) {
            case DioErrorType.connectTimeout: // ULANISH VAQTI TUGADI
            case DioErrorType.sendTimeout: // MA'LUMOT JO'NATISH VAQTI TUGADI
            case DioErrorType
                .receiveTimeout: // MA'LUMOT QABUL QILISH VAQTI TUGADI
              throw DeadlineExceededException(error.requestOptions);
            case DioErrorType.response:
              switch (error.response?.statusCode) {
                case 400:
                  throw BadRequestException(error.response?.data['message']);
                case 401:
                  throw UnauthorizedException(error.requestOptions);
                case 404:
                  throw NotFoundException(error.requestOptions);
                case 409:
                  throw ConflictException(error.requestOptions);
                case 500:
                  throw InternalServerErrorException(error.requestOptions);
              }
              break;
            case DioErrorType.cancel:
              break;
            case DioErrorType.other:
              throw NoInternetConnectionException(error.requestOptions);
          }
          debugPrint('Error Status Code:${error.response?.statusCode}');
          return handler.next(error);
        },
        onRequest: (requestOptions, handler) {
          debugPrint('ON REQUEST GA KIRDI');
          requestOptions.headers['Accept'] = "application/json";
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          debugPrint('ON RESPONSE GA KIRDI');
          return handler.next(response);
        },
      ),
    );
  }
}
