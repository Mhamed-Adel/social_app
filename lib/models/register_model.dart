class UserCreateModel{
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isVerified;

  UserCreateModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.isVerified,
  });

  UserCreateModel.fromJson(Map<String,dynamic> json){
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    isVerified=json['isVerified'];
  }

  Map<String,dynamic> toMap(){
    return 
    {
    'name': name,
    'email':email,
    'phone':phone,
    'uId':uId,
    'isVerified':isVerified
    };
    

  }
}