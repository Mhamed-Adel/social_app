import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_layout.dart';
import 'package:untitled/modules/register_screen/cubit/cubit.dart';
import 'package:untitled/modules/register_screen/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';

import '../../shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
    var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit,RegisterStates>(
          listener: (context, state) {
          if (state is RegisterUserCreateSuccessState){
            navigateAndFinish(context, const SocialLayout());
          }
          },
          builder:(context, state) { 
          return  Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text('REGISTER NOW',
                            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                              color: defaultColor
                            ),
                            
                            ),
                          ),
              
                          const SizedBox(height:15.0,),
                                  
                          defaultFormField(
                            controller: nameController, 
                            type: TextInputType.name, 
                            validate: (String? value){
                              if(value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            }, 
                            label: 'User Name', 
                            prefix: Icons.person),
                          const SizedBox(height: 16.0,),
              
                            defaultFormField(
                            controller: emailController, 
                            type: TextInputType.emailAddress, 
                            validate: (String? value){
                              if(value!.isEmpty) {
                                return 'Please enter your email address';
                              }
                              return null;
                            }, 
                            label: 'Email Address', 
                            prefix: Icons.email),
                          
                          const SizedBox(height: 16.0,),
                          defaultFormField(
                            controller: passwordController, 
                            type: TextInputType.visiblePassword, 
                            validate: (String? value){
                              if(value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            }, 
                            label: 'Password', 
                            prefix: Icons.lock,
                            isPassword : RegisterCubit.get(context).isPassword,
                            suffix: RegisterCubit.get(context).suffix,
                            suffixPress: (){
                            RegisterCubit.get(context).changePasswordVisibilty();
                            },
                            
                            ),
                            const SizedBox(height: 16.0,),
              
                            defaultFormField(
                            controller: phoneController, 
                            type: TextInputType.phone, 
                            validate: (String? value){
                              if(value!.isEmpty) {
                                return 'Please enter your phone';
                              }
                              return null;
                            }, 
                            label: 'phone', 
                            prefix: Icons.phone
                            ),
                            const SizedBox(height: 15.0,),
                            ConditionalBuilder(
                              condition: state is! RegisterLoadingState ,
                              builder: (BuildContext context)=>
                                defaultButton(
                                onPress: (){
                                  if(formKey.currentState!.validate()){
                                  print('registered');
                                  RegisterCubit.get(context).userRegister(
                                    email: emailController.text, 
                                    password: passwordController.text, 
                                    name: nameController.text, 
                                    phone: phoneController.text);
                                  }
                                }, 
                                text: 'REGISTER'),
                              fallback: (context) => const Center(child: CircularProgressIndicator()),
                              
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );}
  ),
  
      ),
    );
  }
}