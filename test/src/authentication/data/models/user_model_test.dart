import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:practice_tdd/core/utils/typedef.dart';
import 'package:practice_tdd/src/authentication/data/models/user_model.dart';
import 'package:practice_tdd/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();

  test('should be a subclass of User entity', () {
    // Assert
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [UserModel] with the right data', () {
      // Act
      final result = UserModel.fromMap(tMap);

      // Assert
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a [UserModel] with the right data', () {
      // Act
      final result = UserModel.fromJson(tJson);

      // Assert
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a [DataMap] with the right data', () {
      // Act
      final result = tModel.toMap();

      // Assert
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [JSON] string with the right data', () {
      // Act
      final result = tModel.toJson();

      // Assert
      expect(result, equals(tJson));
    });
  });

  group('copyWith', () {
    test('should return a [UserModel] with different data', () {
      // Act
      final result = tModel.copyWith(name: 'Paul');

      // Assert
      expect(result.name, equals('Paul'));
    });
  });
}

// import 'dart:convert';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:practice_tdd/core/utils/typedef.dart';
// import 'package:practice_tdd/src/authentication/data/models/user_model.dart';
// import 'package:practice_tdd/src/authentication/domain/entities/user.dart';

// import '../../../../fixtures/fixture_reader.dart';

// void main() {
//   //  Arrange
//   const tModel = UserModel.empty();

//   test('should be a subclass of User entity', () {
//     // Assert
//     expect(tModel, isA<User>());
//   });

//   final tJson = fixture('user.json');
//   final tMap = jsonDecode(tJson) as DataMap;

//   group('fromMap', () {
//     test('should return a [usermodel] with the right data', () {});
//   });

//   group('fromJson', () {});

//   group('toMap', () {
//     test('should reeturn a map with right data', () {
//       // Assert
//       final result = tModel.toMap();

//       expect(result, equals(tMap));
//     });
//   });
//   group('toJson', () {
//     test('should reeturn a map with right data', () {
//       // Assert
//       final result = tModel.toJson();
//       final tJson = jsonEncode();

//       expect(result, equals(tJson));
//     });
//   });
// }
