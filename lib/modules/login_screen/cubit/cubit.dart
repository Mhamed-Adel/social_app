import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/login_screen/cubit/states.dart';
import 'package:untitled/modules/register_screen/cubit/states.dart';
import 'package:untitled/shared/network/local/shred_pref.dart';

class LoginCubit extends Cubit<LoginSocialStates>{
  LoginCubit () :super(LoginSocialInitialState());

  static LoginCubit of(context)=> BlocProvider.of(context);


void userLogin({
  required String email,
  required String password
}){
  emit(LoginSocialLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).
  then((value){
    CachHelper.saveData(key: 'uId', value: value.user!.uid);
    emit(LoginSocialSuccessState(value.user!.uid));
  }).catchError((error){
    emit(LoginSocialErrorState(error.toString()));
  });
}


  IconData suffix = Icons.visibility;
  bool isPassword = true;

  void changePasswordVisibilty(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordVisibilty());
  }
}