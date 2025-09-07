import 'package:flutter/material.dart';import 'package:flutter_riverpod/flutter_riverpod.dart';import '../../core/validators.dart';import '../../repositories/auth_repository.dart';
class LoginPage extends ConsumerStatefulWidget{final void Function(Locale) onLocaleChange;const LoginPage({super.key,required this.onLocaleChange});@override ConsumerState<LoginPage> createState()=>_S();}
class _S extends ConsumerState<LoginPage>{final _k=GlobalKey<FormState>();final _e=TextEditingController();final _p=TextEditingController();bool _loading=false;
 @override Widget build(BuildContext c){return Scaffold(body: Center(child: ConstrainedBox(constraints:const BoxConstraints(maxWidth:440),child: Padding(padding:const EdgeInsets.all(16),child: Column(mainAxisAlignment:MainAxisAlignment.center,children:[
  Text('MediTour',style:Theme.of(c).textTheme.headlineMedium),const SizedBox(height:16),
  DropdownButton<Locale>(value:Localizations.localeOf(c),items:const[DropdownMenuItem(value:Locale('en'),child:Text('English')),DropdownMenuItem(value:Locale('ar'),child:Text('العربية')),DropdownMenuItem(value:Locale('tr'),child:Text('Türkçe')),DropdownMenuItem(value:Locale('de'),child:Text('Deutsch'))],onChanged:(l)=>l==null?null:widget.onLocaleChange(l)),
  const SizedBox(height:12),
  Form(key:_k,child:Column(children:[
    TextFormField(controller:_e,decoration:const InputDecoration(labelText:'Email'),validator:Validators.email),
    const SizedBox(height:12),
    TextFormField(controller:_p,decoration:const InputDecoration(labelText:'Password'),obscureText:true,validator:Validators.required),
    const SizedBox(height:16),
    SizedBox(width:double.infinity,child: FilledButton(onPressed:_loading?null:() async{ if(!_k.currentState!.validate())return; setState(()=>_loading=true); try{await ref.read(authRepositoryProvider).login(_e.text.trim(),_p.text); if(!mounted)return; Navigator.of(c).pushReplacementNamed('/home');}catch(e){if(!mounted)return; ScaffoldMessenger.of(c).showSnackBar(SnackBar(content:Text('Login failed: $e')));}finally{if(mounted)setState(()=>_loading=false);} }, child:Text(_loading?'...':'Sign in'))),
    TextButton(onPressed:()=>Navigator.of(c).pushNamed('/register'),child:const Text('Create account')),
  ]))])))));}
}
