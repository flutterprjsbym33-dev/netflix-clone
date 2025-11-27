abstract class AuthenticationMainEvent{}
class signWithEmailAndpasswordEvent extends  AuthenticationMainEvent
{
  String email;
  String password;
  String fullName;

  signWithEmailAndpasswordEvent({required this.email,required this.password,required this.fullName});
}

class SignInWithGoogleEvents extends  AuthenticationMainEvent {}
class onLogoutPressed extends AuthenticationMainEvent{}

class onLoginPressed extends AuthenticationMainEvent{
  String emaail;
  String password;
  onLoginPressed({required this.emaail,required this.password});
}