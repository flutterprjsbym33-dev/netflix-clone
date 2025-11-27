import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/auth_block_screens/AuthServices.dart';

import 'AuthenticationEvents.dart';
import 'AuthenticationMainState.dart';

class AuthenticationMainBloc extends Bloc<AuthenticationMainEvent,AuthenticationMainState>
{
  AuthenticationMainBloc():super(AuthenticationInitialState()){
    on(onSignInWithEmail);
    on(signInWithGoogle);
    on(logout);
    on(login);

  }



  void onSignInWithEmail(signWithEmailAndpasswordEvent event, Emitter<AuthenticationMainState> emit)async
  {
    try{
      emit(SignUpWithEmailAndPasswordLoadingState());
      await authServices.value.signInWithEmail(event.fullName, event.email, event.password);
      emit(SignUpWithEmailAndPasswordSuccessState());



    }catch(e)
    {
      print(e.toString());
      emit(SignUpWithEmailAndPasswordErrorState(errorMsg: e.toString()));

    }

  }


  void signInWithGoogle(SignInWithGoogleEvents event, Emitter<AuthenticationMainState> emit)async
  {
    try{
      emit(SignUpWithGoogleLoadingState());
      await authServices.value.signInWithGoogle();
      emit(SignUpWithGoogleSuccessState());

    }catch(e){
      print(e.toString());
      emit(SignUpWithGoogleErrorState(errorMsg: e.toString()));
    }

  }


  void logout(onLogoutPressed event, Emitter<AuthenticationMainState> emit)async
  {
    emit(onLogoutPressedLoadingState());
    await FirebaseAuth.instance.signOut();
    emit(onLogoutPressedSuccessState());

  }


  void login(onLoginPressed event, Emitter<AuthenticationMainState> emit)async
  {
    emit(onLogintPressedLoadingState());
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: event.emaail, password: event.password);
    emit(onLogintPressedSuccessState());

  }


}