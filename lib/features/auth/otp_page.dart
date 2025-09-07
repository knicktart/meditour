import 'package:flutter/material.dart';import 'package:flutter_riverpod/flutter_riverpod.dart';import '../../repositories/auth_repository.dart';
class OtpPage extends ConsumerStatefulWidget{const OtpPage({super.key});@override ConsumerState<OtpPage> createState()=>_S();}
class _S extends ConsumerState<OtpPage>{final _otp=TextEditingController(text:'1234');bool _loading=false;
 @override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:const Text('Verify OTP')),body: Center(child: ConstrainedBox(constraints:const BoxConstraints(maxWidth:360),child: Padding(padding:const EdgeInsets.all(16),child: Column(mainAxisAlignment:MainAxisAlignment.center,children:[
  const Text('Enter 1234 for now'),const SizedBox(height:12),TextField(controller:_otp,decoration:const InputDecoration(labelText:'OTP')),const SizedBox(height:16),
  SizedBox(width:double.infinity,child: FilledButton(onPressed:_loading?null:() async{setState(()=>_loading=true);try{await ref.read(authRepositoryProvider).verifyOtp(_otp.text.trim());if(!mounted)return;Navigator.of(c).pushNamedAndRemoveUntil('/home',(r)=>false);}catch(_){if(!mounted)return;ScaffoldMessenger.of(c).showSnackBar(const SnackBar(content:Text('Invalid OTP')));}finally{if(mounted)setState(()=>_loading=false);} }, child:Text(_loading?'...':'Verify'))),
 ])))));}
}
