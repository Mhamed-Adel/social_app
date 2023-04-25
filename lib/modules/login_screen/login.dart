import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_layout.dart';
import 'package:untitled/modules/login_screen/cubit/cubit.dart';
import 'package:untitled/modules/login_screen/cubit/states.dart';
import 'package:untitled/modules/register_screen/register.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/network/local/shred_pref.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ( context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginSocialStates>(
        listener: (BuildContext context, state) {
          
          if( state is LoginSocialErrorState ){
            showToast(
              text: state.error, 
              state: ToastColors.FAILED);
          }
          if(state is LoginSocialSuccessState){
            CachHelper.saveData(key: 'uId', value: state.uId).then((value){
              navigateAndFinish(context, SocialLayout());
            });
          }

          
          },
        builder: (BuildContext context,  state) {  
        return  Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                      Text('LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.black)),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: 'Email',
                        prefix: Icons.email,
                        validate: (String? value){
                          if(value!.isEmpty){
                            return 'mustnot be empty';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        label: 'password',
                        prefix: Icons.lock,
                        isPassword: LoginCubit.of(context).isPassword,
                        suffix: LoginCubit.of(context).suffix,
                        suffixPress: (){
                          LoginCubit.of(context).changePasswordVisibilty();
                        },
                        validate: (String? value){
                          if(value!.isEmpty){
                            return 'mustnot be empty';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ConditionalBuilder(
                        condition:  state is! LoginSocialLoadingState,
                        builder:(context) => defaultButton(
                          onPress:(){
                          if(formKey.currentState!.validate()){
                            print('login');
                            LoginCubit.of(context).userLogin(
                              email: emailController.text, 
                              password: passwordController.text);
                          }
                        
                        },
                        text: 'login'),
                        fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account ?'),
                          TextButton(
                            onPressed: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder:(context) => RegisterScreen()));
                            }, 
                            child: const Text('REGISTER'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ); },
      ),
    );
  }
}
