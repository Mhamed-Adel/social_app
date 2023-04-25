import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/cubit/layoutcubit.dart';
import 'package:untitled/layout/cubit/layoutstates.dart';
import 'package:untitled/shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('News Feed'),
          ),
          body: ConditionalBuilder(
              condition: LayoutCubit.get(context).model != null,
              builder: (context) {
              // var model = LayoutCubit.get(context).model;
              return  Column(
                  children: [
                    if (!FirebaseAuth.instance.currentUser!.emailVerified)
                      Container(
                        height: 50,
                        color: Colors.amber,
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              const Text('Please verify your email'),
                              const Spacer(),
                              TextButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.currentUser!.sendEmailVerification().
                                    then((value) => showToast(text: 'Check your mail', 
                                    state: ToastColors.SUCCESS)).
                                    catchError((error){
                                      print(error.toString());
                                    });
                                  }, child: const Text('Send'))
                            ],
                          ),
                        ),
                      )
                  ],
                );
              },
              fallback: (BuildContext context) =>
                  const Center(child: CircularProgressIndicator()))
        );
      },
    );
  }
}
