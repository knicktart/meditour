import 'package:flutter/material.dart';import 'package:flutter_riverpod/flutter_riverpod.dart';import '../../core/validators.dart';import '../../repositories/auth_repository.dart';
class RegisterPage extends ConsumerStatefulWidget{final void Function(Locale) onLocaleChange;const RegisterPage({super.key,required this.onLocaleChange});@override ConsumerState<RegisterPage> createState()=>_S();}
class _S extends ConsumerState<RegisterPage>{final _k=GlobalKey<FormState>();final _name=TextEditingController();final _email=TextEditingController();final _mobile=TextEditingController();final _country=TextEditingController();DateTime? _dob;String _gender='Male';Locale _lang=const Locale('en');bool _loading=false;final _pwd=TextEditingController(text:'secret');
 @override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:const Text('Create account')),body: SingleChildScrollView(padding:const EdgeInsets.all(16),child: Center(child: ConstrainedBox(constraints:const BoxConstraints(maxWidth:520),child: Form(key:_k,child: Column(children:[
  TextFormField(controller:_name,decoration:const InputDecoration(labelText:'Name'),validator:Validators.required),const SizedBox(height:12),
  TextFormField(controller:_email,decoration:const InputDecoration(labelText:'Email'),validator:Validators.email),const SizedBox(height:12),
  TextFormField(controller:_mobile,decoration:const InputDecoration(labelText:'Mobile'),validator:Validators.required),const SizedBox(height:12),
  TextFormField(controller:_country,decoration:const InputDecoration(labelText:'Country'),validator:Validators.required),const SizedBox(height:12),
  Row(children:[
    Expanded(child: OutlinedButton(onPressed:() async{final d=await showDatePicker(context:c,firstDate:DateTime(1920,1,1),lastDate:DateTime.now(),initialDate:DateTime(1990,1,1)); if(d!=null)setState(()=>_dob=d);}, child:Text(_dob==null?'Pick DOB':_dob!.toIso8601String().split('T').first))),
    const SizedBox(width:8),
    Expanded(child: DropdownButtonFormField<String>(decoration:const InputDecoration(labelText:'Gender'),value:_gender,items:const[DropdownMenuItem(value:'Male',child:Text('Male')),DropdownMenuItem(value:'Female',child:Text('Female'))],onChanged:(v)=>setState(()=>_gender=v??'Male'))),
  ]),const SizedBox(height:12),
  DropdownButtonFormField<Locale>(decoration:const InputDecoration(labelText:'Language'),value:_lang,items:const[DropdownMenuItem(value:Locale('en'),child:Text('English')),DropdownMenuItem(value:Locale('ar'),child:Text('العربية')),DropdownMenuItem(value:Locale('tr'),child:Text('Türkçe')),DropdownMenuItem(value:Locale('de'),child:Text('Deutsch'))],onChanged:(l)=>setState(()=>_lang=l??const Locale('en'))),
  const SizedBox(height:16),
  SizedBox(width:double.infinity,child: FilledButton(onPressed:_loading?null:() async{
    if(_dob==null){ScaffoldMessenger.of(c).showSnackBar(const SnackBar(content:Text('Please pick your DOB')));return;}
    if(!_k.currentState!.validate())return; setState(()=>_loading=true);
    try{final p={'name':_name.text.trim(),'email':_email.text.trim(),'mobile':_mobile.text.trim(),'country':_country.text.trim(),'gender':_gender,'dob':_dob!.toIso8601String(),'language':_lang.languageCode,'password':_pwd.text};
      await ref.read(authRepositoryProvider).register(p); widget.onLocaleChange(_lang); if(!mounted)return; Navigator.of(c).pushReplacementNamed('/otp');
    }catch(e){if(!mounted)return;ScaffoldMessenger.of(c).showSnackBar(SnackBar(content:Text('Registration failed: $e')));}finally{if(mounted)setState(()=>_loading=false);} }, child:Text(_loading?'...':'Submit'))),
 ])))));}
}
