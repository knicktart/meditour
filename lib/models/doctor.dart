class Doctor{final int id;final String name,specialty;final String? photoUrl,qualification,cv;
Doctor({required this.id,required this.name,required this.specialty,this.photoUrl,this.qualification,this.cv});
factory Doctor.fromJson(Map<String,dynamic> j)=>Doctor(id:j['id'],name:j['name'],specialty:j['specialty'],photoUrl:j['photo_url'],qualification:j['qualification'],cv:j['cv']);
}
