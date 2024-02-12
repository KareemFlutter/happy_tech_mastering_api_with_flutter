import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_state.dart';
import 'package:happy_tech_mastering_api_with_flutter/models/signin_model.dart';
import 'package:happy_tech_mastering_api_with_flutter/repositries/user_repositries.dart';
import 'package:image_picker/image_picker.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepositries) : super(UserInitial());
  final UserRepositries userRepositries;
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  //Profile Pic
  XFile? profilePic;
  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();

  //! Sign In Method
  SignInModel? user;
  signIn() async {
    emit(SignInLoadingState());
    final response = await userRepositries.signIn(
      email: signInEmail.text,
      password: signInPassword.text,
    );
    response.fold(
      (errorMessage) => emit(SignInFailureState(errorMessage: errorMessage)),
      (signInModel) => emit(SignInSuccessState()),
    );
  }

//! Image Picker Method
  uploadProfilePicture(XFile image) {
    profilePic = image;
    emit(UploadProfilePicture());
  }

//! Sign Up Method
  signUp() async {
    emit(SignInLoadingState());
    final response = await userRepositries.signUp(
        email: signUpEmail.text,
        name: signUpName.text,
        phone: signUpPhoneNumber.text,
        password: signUpPassword.text,
        confirmPassword: confirmPassword.text,
        profilePic: profilePic!);

    response.fold(
      (errorMessage) => emit(SignUpFailureState(errorMessage: errorMessage)),
      (signUpModel) => emit(SignUpSuccessState(message: signUpModel.message)),
    );
  }

  //! get User Profile
  getUserProfile() async {
    emit(GetUserDataLoadingState());
    final response = await userRepositries.getUserModel();
    response.fold(
      (errorMessage) => emit(GetUserDataFailureState(message: errorMessage)),
      (userModel) => emit(GetUserDataSuccessState(userModel: userModel)),
    );
  }
}
