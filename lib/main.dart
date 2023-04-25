import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/cubit/layoutcubit.dart';
import 'package:untitled/layout/social_layout.dart';
import 'package:untitled/modules/login_screen/login.dart';
import 'package:untitled/shared/bloc_observer.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/network/local/shred_pref.dart';
import 'package:untitled/shared/styles/colors.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
Bloc.observer=MyBlocObserver();
await  CachHelper.init();

  Widget? widget;
  uId = CachHelper.getData('uId');


  if(uId != ' '){
  widget = const SocialLayout();
  }else{
  widget = LoginScreen();
  }

  runApp( SocialApp(
    startWidget:widget
  ));
}

class SocialApp extends StatelessWidget {
  final Widget startWidget;
  const SocialApp({super.key,required this.startWidget,});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    
    return BlocProvider(
      create: (BuildContext context) =>LayoutCubit()..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: defaultColor,
        ),
        home:  LoginScreen(),
      ),
    );
  }
}



