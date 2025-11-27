abstract class AuthenticationMainState{}
class AuthenticationInitialState extends AuthenticationMainState{}
class SignUpWithEmailAndPasswordLoadingState extends AuthenticationMainState{}
class SignUpWithEmailAndPasswordSuccessState extends AuthenticationMainState{}
class SignUpWithGoogleSuccessState extends AuthenticationMainState{}
class SignUpWithGoogleLoadingState extends AuthenticationMainState{}
class SignUpWithGoogleErrorState extends AuthenticationMainState{
  String errorMsg;
  SignUpWithGoogleErrorState({required this.errorMsg});

}
class SignUpWithEmailAndPasswordErrorState extends AuthenticationMainState{
  String errorMsg;
  SignUpWithEmailAndPasswordErrorState({required this.errorMsg});
}
class onLogoutPressedLoadingState extends AuthenticationMainState{}
class onLogoutPressedSuccessState extends AuthenticationMainState{}

class onLogintPressedLoadingState extends AuthenticationMainState{}
class onLogintPressedSuccessState extends AuthenticationMainState{}
