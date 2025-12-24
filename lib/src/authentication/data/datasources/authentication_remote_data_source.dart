import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_tdd/core/errors/exceptions.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/typedef.dart';
import '../models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUser();
}


class AuthRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  final http.Client _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      final response = await _client.post(
        Uri.https(kBaseUrl, '/test_api/users'),
        body: jsonEncode({
          'createdAt': createdAt,
          'name': name,
          'avatar': avatar,
        }),
        headers: {
          'content-type': 'application/json'
        }
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUser() async {
    final response = await _client.get(Uri.https(kBaseUrl, '/test_api/users'));
    try {
      if (response.statusCode != 200) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      return List<DataMap>.from(
        jsonDecode(response.body) as List,
      ).map((userData) => UserModel.fromMap(userData)).toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
