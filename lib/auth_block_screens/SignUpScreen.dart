import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_clone/Screeens/HomeScreen.dart';
import 'package:netflix_clone/auth_block_screens/AuthenticationMainBloc.dart';
import 'package:netflix_clone/auth_block_screens/AuthenticationMainState.dart';

import 'package:netflix_clone/auth_block_screens/SignUpButtonCubit.dart';

import '../ChatApp/ChatAppHomeScreen.dart';
import 'AuthenticationEvents.dart';

class SignUpScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignUpScreen();
  }

}


class _SignUpScreen extends State<SignUpScreen> {

  TextEditingController _fullName =TextEditingController();
  TextEditingController _email =TextEditingController();
  TextEditingController _password =TextEditingController();

  List<String> signUpLoginButtons = [
    "SignUp",
    "Login"
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
   return Scaffold(
     backgroundColor: Colors.lightBlue.shade100,
     body:SafeArea(child:Padding(padding: EdgeInsets.only(left: 8,right: 6,bottom: 10,top: 10),
     child: Center(
       child: SizedBox(
         height: height*9,
         child: Card(
           elevation: 2,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15)
           ),
           color: Colors.white,
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: IntrinsicHeight(
               child: Column(
                 children: [
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text("SignUp & Login",style: TextStyle(color: Colors.black,fontSize: 22.sp,fontWeight: FontWeight.w600),),
                       SizedBox(height: 6.h,),
                       Divider(color: Colors.black38,thickness: 1,)


                     ],
                   ),
                   SizedBox(height: 6.h,),
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: List.generate(signUpLoginButtons.length, (index){
                       return Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: GestureDetector(
                           onTap: (){
                             context.read<SignUpButtonCubit>().addIndex(index);

                           },
                           child: Container(
                             height: height*0.06,
                             width: 140.w,
                             decoration: BoxDecoration(
                               color: context.watch<SignUpButtonCubit>().state == index ? null :Colors.grey,
                                 borderRadius: BorderRadius.circular(15),
                                 gradient: context.watch<SignUpButtonCubit>().state == index ? LinearGradient(
                                     colors:  [Colors.blue.shade900,Colors.blueAccent]) : null
                             ),
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Center(child: Text(signUpLoginButtons[index],style: TextStyle(color:context.watch<SignUpButtonCubit>().state == index ?  Colors.white : Colors.black,fontSize: 22.sp,fontWeight: FontWeight.w600),)),
                             ),
                           ),

                         ),
                       );
                     }),
                   ),
                   SizedBox(height: 14.h,),
                   BlocBuilder<SignUpButtonCubit,int>(builder: (context,state){
                     if(state == 0)
                       {
                         return Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                             children: [
                               customTextField("Fullname", Icons.account_circle,_fullName),
                               SizedBox(height: 18.h,),
                               customTextField("Email", Icons.email,_email),
                               SizedBox(height: 18.h,),
                               customTextField("Password", Icons.password,_password),
                               SizedBox(height: 5.h,),
                               Align(alignment: Alignment.centerRight,
                                   child: TextButton(onPressed: (){}, child: Text("Forgot Password?",style: TextStyle(color: Colors.black),))),
                               SizedBox(height: 18.h,),
                               BlocConsumer<AuthenticationMainBloc,AuthenticationMainState>(
                                 listener: (context,state){
                                   if(state is SignUpWithEmailAndPasswordSuccessState)
                                     {
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatAppHomeScreen()));
                                     }
                                 },
                                 builder: (context,state) {
                                   if(state is AuthenticationInitialState)
                                     {
                                       return  gradientButton("SignUp", height,(){
                                         context.read<AuthenticationMainBloc>().add(signWithEmailAndpasswordEvent(email: _email.text, password: _password.text, fullName: _fullName.text));

                                       });
                                     }
                                   if(state is SignUpWithEmailAndPasswordLoadingState)
                                   {
                                     return  Center(child: CircularProgressIndicator(),);
                                   }
                                   else{
                                     return gradientButton("SignUp", height,(){
                                       context.read<AuthenticationMainBloc>().add(signWithEmailAndpasswordEvent(email: _email.text, password: _password.text, fullName: _fullName.text));

                                     });
                                   }

                                 }
                               ),
                               SizedBox(height: 10.h,),
                               Row(
                                 children: [
                                   Expanded(child: Divider(color: Colors.black38,)),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text("SignUpWith",style: TextStyle(color: Colors.black87,fontSize: 16),),
                                   ),
                                   Expanded(child: Divider(color: Colors.black38,)),
                                 ],
                               ),
                               SizedBox(height: 10.h,),
                               Row(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   socailIcon("assets/images/google.png", "Google",(){}),
                                   SizedBox(width: 15.w,),
                                   socailIcon("assets/images/facebook.png", "Facebook",(){}),
                                 ],
                               ),

                               SizedBox(height: 10.h,),
                               TextButton(onPressed: (){}, child: Text("Already Have an Account? Login",style: TextStyle(color: Colors.black,fontSize: 18),))



                             ],
                           ),
                         );
                       }
                     else{
                       return Column(
                         children: [
                           customTextField("Email", Icons.email, _email),
                           SizedBox(height: 10.h,),
                           customTextField("Password", Icons.password, _password),
                           SizedBox(height: 15.h,),
                           BlocBuilder<AuthenticationMainBloc,AuthenticationMainState>(
                             builder: (context,state) {
                               if(state is onLogintPressedLoadingState)
                                 {
                                   return gradientButton("Logging............", height, (){
                                     context.read<AuthenticationMainBloc>().add(onLoginPressed(emaail: _email.text, password: _password.text));
                                   });
                                 }
                               else{

                                   return gradientButton("Login", height, (){
                                     context.read<AuthenticationMainBloc>().add(onLoginPressed(emaail: _email.text, password: _password.text));
                                   });

                               }
                             }
                           )

                         ],
                       );
                     }
                   })
                 ],
               ),
             ),
           ),

         ),
       ),
     ),))
     );
  }

}

Widget customTextField(String hint,IconData icon,TextEditingController controller)
{
  return TextField(
    controller: controller,
    decoration: InputDecoration(
        hintText: hint,
        suffixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),

        )
    ),
  );
}

Widget gradientButton(String hint,double height,VoidCallback onTap)
{
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height*0.06,
      width: 240.w,
      decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(15),
          gradient:  LinearGradient(
              colors:  [Colors.blue.shade900,Colors.blueAccent])
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text(hint,style: TextStyle(color: Colors.white ,fontSize: 20.sp,fontWeight: FontWeight.w800),)),
      ),
    ),
  );
}

Widget socailIcon(String path,String hint,VoidCallback onTap)
{
  return GestureDetector(
    onTap: onTap,
    child: Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(path),
            SizedBox(width: 10.w,),
            Text(hint,style: TextStyle(fontSize: 16,color: Colors.black),)
    
          ],
        ),
      ),
    ),
  );
}

