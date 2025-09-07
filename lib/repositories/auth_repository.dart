import 'dart:convert';import 'package:flutter_secure_storage/flutter_secure_storage.dart';import 'package:flutter_riverpod/flutter_riverpod.dart';import '../services/mock_api.dart';
final authRepositoryProvider=Provider<AuthRepository>((_)=>AuthRepository());
class AuthRepository{
 final _s=const FlutterSecureStorage();
 Future<Map<String,dynamic>> register(Map<String,dynamic> p) async{final r=await MockApi.register(p);await _s.write(key:'token',value:r['token']);await _s.write(key:'language',value:p['language']??'en');await _s.write(key:'user',value:jsonEncode(r['user']));return r;}
 Future<void> verifyOtp(String otp) async=>MockApi.verifyOtp(otp);
 Future<Map<String,dynamic>> login(String email,String pwd) async{final r=await MockApi.login(email,pwd);await _s.write(key:'token',value:r['token']);await _s.write(key:'language',value:r['user']['language']??'en');await _s.write(key:'user',value:jsonEncode(r['user']));return r;}
 Future<void> logout() async=>_s.deleteAll(); Future<String?> getToken()=>_s.read(key:'token'); Future<String?> getLanguage()=>_s.read(key:'language');
}
