
class FetchedUserList{
  List<Fetchedusers> users;
  FetchedUserList({required this.users});
}



class Fetchedusers{
  String email;
  String fullname;
  String photoUrl;
  String id;

  Fetchedusers({required this.email,
    required this.fullname,
    required this.photoUrl,
    required this.id});

 factory Fetchedusers.fromJson(Map<String,dynamic> json)
  {
    return Fetchedusers(email: json['email'] , fullname: json['fullname'], photoUrl: json['photoUrl'], id: json['id']);

    }


}