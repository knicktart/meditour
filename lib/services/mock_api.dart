import 'dart:async';import 'dart:math';
class MockApi{
 static int _uid=1,_bid=1;
 static final _users=<Map<String,dynamic>>[];
 static final _bookings=<Map<String,dynamic>>[];
 static final _doctors=List.generate(8,(i)=>{'id':i+1,'name':'Dr. '+['Aylin','Kemal','Deniz','Murat','Selin','Efe','Leyla','Burak'][i],'specialty':['Dental','Hair','Cosmetic','Orthopedic'][i%4],'photo_url':null,'qualification':'MD, Board Certified','cv':'10+ years intl. experience.'});
 static Future<Map<String,dynamic>> register(Map<String,dynamic> p) async{await Future.delayed(Duration(milliseconds:250));final u={'id':_uid++,...p};_users.add(u);return {'token':'t-${u['id']}', 'user':u};}
 static Future<Map<String,dynamic>> verifyOtp(String otp) async{await Future.delayed(Duration(milliseconds:150));if(otp=='1234')return{'ok':true};throw Exception('Invalid OTP');}
 static Future<Map<String,dynamic>> login(String email,String pwd) async{await Future.delayed(Duration(milliseconds:250));final u=_users.reversed.firstWhere((x)=>x['email']==email,orElse:()=>{});if(u.isEmpty)throw Exception('User not found');return{'token':'t-${u['id']}', 'user':u};}
 static Future<List<Map<String,dynamic>>> doctors() async{await Future.delayed(Duration(milliseconds:200));return _doctors;}
 static Future<Map<String,dynamic>> bookConsult({required DateTime at,required double price}) async{await Future.delayed(Duration(milliseconds:250));final room='mt-${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(999999)}';final b={'id':_bid++,'kind':'consult','scheduled_at':at.toIso8601String(),'price':price,'currency':'USD','room':room};_bookings.add(b);return b;}
 static Future<List<Map<String,dynamic>>> myBookings() async{await Future.delayed(Duration(milliseconds:150));return List<Map<String,dynamic>>.from(_bookings);}
 static Future<Map<String,dynamic>> quotation(Map<String,dynamic> p) async{await Future.delayed(Duration(milliseconds:200));return {'ok':true,'id':DateTime.now().millisecondsSinceEpoch};}
 static Future<Map<String,dynamic>> saveCompliance(bool a,DateTime when) async{await Future.delayed(Duration(milliseconds:150));return {'ok':true,'at':when.toIso8601String()};}
 static Future<Map<String,dynamic>> cmsHome() async{await Future.delayed(Duration(milliseconds:150));return {'title':'Welcome to MediTour','body':'Trusted partner for medical travel in Turkey.'};}
}
