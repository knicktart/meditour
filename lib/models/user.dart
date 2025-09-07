class AppUser{final int id;final String name,email,mobile,country,gender,language;final DateTime dob;
AppUser({required this.id,required this.name,required this.email,required this.mobile,required this.country,required this.gender,required this.dob,required this.language});
factory AppUser.fromJson(Map<String,dynamic> j)=>AppUser(id:j['id'],name:j['name'],email:j['email'],mobile:j['mobile'],country:j['country'],gender:j['gender'],dob:DateTime.parse(j['dob']),language:j['language']??'en');
Map<String,dynamic> toJson()=>{'id':id,'name':name,'email':email,'mobile':mobile,'country':country,'gender':gender,'dob':dob.toIso8601String(),'language':language};
}
