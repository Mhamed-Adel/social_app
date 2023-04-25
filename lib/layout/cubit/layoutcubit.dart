import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/cubit/layoutstates.dart';
import 'package:untitled/models/register_model.dart';
import 'package:untitled/shared/components/constants.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit():super (LayoutGetUserInitialState());
  static LayoutCubit get(context)=> BlocProvider.of(context);

  UserCreateModel? model;

  void getUserData(){
    emit(LayoutGetUserLoadingState());

    FirebaseFirestore.instance.
    collection('users').
    doc(uId).
    get().
    then((value){
      model = UserCreateModel.fromJson(value.data()!);
      emit(LayoutGetUserSuccessState());
    }).catchError((error){

      emit(LayoutGetUserErrorState(error.toString()));
    });
  }

}