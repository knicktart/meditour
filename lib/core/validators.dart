class Validators {
  static String? required(String? v)=> (v==null||v.trim().isEmpty)?'Required':null;
  static String? email(String? v){ if(v==null||v.isEmpty)return'Required'; final ok=RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v); return ok?null:'Invalid email';}
}
