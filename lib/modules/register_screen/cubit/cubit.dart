import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/register_model.dart';
import 'package:untitled/modules/register_screen/cubit/states.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit () : super(RegisterInitialState());


  static RegisterCubit get(context) => BlocProvider.of(context);
  
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone
  }){
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).
    then((value){
      userCreate(email: email, uId: value.user!.uid, name: name, phone: phone);
      emit(RegisterSuccessState());
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });
  }
  
  void userCreate({
    required String email,
    required String uId,
    required String name,
    required String phone
  }){
    emit(RegisterLoadingState());
    UserCreateModel userCreate = UserCreateModel(
    email: email,
    name: name,
    phone: phone,
    uId: uId,
    isVerified: false,

    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(userCreate.toMap()).
    then((value){
      
      emit(RegisterUserCreateSuccessState());
    }).catchError((error){
      emit(RegisterUserCreateErrorState(error.toString()));
    });
    
  }
  
    IconData suffix = Icons.visibility_outlined;
    bool isPassword = true;

    void changePasswordVisibilty(){
      isPassword = !isPassword;
      suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;
      emit(PasswordVisibiltyState());

    }
    }
