import 'package:dartz/dartz.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/api/api_consumer.dart';
import 'package:happy_tech_mastering_api_with_flutter/models/profile_model.dart';
import 'package:happy_tech_mastering_api_with_flutter/models/sign_up_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../cache/cache_helper.dart';
import '../core/api/end_ponits.dart';
import '../core/error/exceptions.dart';
import '../core/functions/upload_image_to_api.dart';
import '../models/signin_model.dart';

class UserRepositries {
  final ApiConsumer api;

  UserRepositries({required this.api});

  //! Sign In Methods
  Future<Either<String, SignInModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post(EndPoint.signIn, data: {
        ApiKeys.email: email,
        ApiKeys.password: password,
      });
      final user = SignInModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(user.token);
      CacheHelper().saveData(
        key: ApiKeys.token,
        value: user.token,
      );
      CacheHelper().saveData(
        key: ApiKeys.id,
        value: decodedToken[ApiKeys.id],
      );
      return Right(user);
    } on ServerExecptions catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

//! Sign Up Methods
  Future<Either<String, SignUpModel>> signUp({
    required String email,
    required String name,
    required String phone,
    required String password,
    required String confirmPassword,
    required XFile profilePic,
  }) async {
    try {
      final response = await api.post(EndPoint.signUp, isFormData: true, data: {
        ApiKeys.name: name,
        ApiKeys.phone: phone,
        ApiKeys.email: email,
        ApiKeys.password: password,
        ApiKeys.confirmPassword: confirmPassword,
        ApiKeys.location:
            '{"name" : "methalfa" , "address" : "meet halfa" , "coordinates" : [30.1572709,31.224779]}',
        ApiKeys.profilePic: await uploadImageToApi(profilePic)
      });
      final signUpModel = SignUpModel.fromJson(response);
      return Right(signUpModel);
    } on ServerExecptions catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

//! get User Profile Data
  Future<Either<String, UserModel>> getUserModel() async {
    try {
      final response = await api.get(
        EndPoint.getUserDataEndPoint(
          CacheHelper().getData(key: ApiKeys.id),
        ),
      );
      return Right(UserModel.fromJson(response));
    } on ServerExecptions catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
