import 'dart:convert';import 'package:flutter/services.dart' show rootBundle;import 'package:http/http.dart' as http;import '../core/config.dart';
class ChatService{
 late List<Map<String,String>> _kb; late List<String> _kw;
 Future<void> init() async{final raw=await rootBundle.loadString('assets/knowledge/turkey_medical_tourism.json');final j=jsonDecode(raw);_kb=List<Map<String,String>>.from(j['qa'].map((e)=>{'q':'${e['q']}'.toLowerCase(),'a':'${e['a']}'}));_kw=List<String>.from(j['keywords'].map((e)=>'$e'.toLowerCase()));}
 bool _inScope(String m){final s=m.toLowerCase();return _kw.any((k)=>s.contains(k));}
 Future<String> respond(String m) async{
  if(!_inScope(m)) return 'I can only help with Turkey Medical Tourism.';
  final l=m.toLowerCase(); for(final p in _kb){ if(l.contains(p['q']!)) return p['a']!; }
  if(AppConfig.groqApiKey.startsWith('<')) return 'Please provide more details. (Groq key not set)';
  final r=await http.post(Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
    headers:{'Authorization':'Bearer ${AppConfig.groqApiKey}','Content-Type':'application/json'},
    body: jsonEncode({'model':'llama-3.1-8b-instant','messages':[{'role':'system','content':'Restrict to Turkey Medical Tourism only.'},{'role':'user','content':m}], 'temperature':0.2, 'max_tokens':400}));
  if(r.statusCode!=200) return 'Service busy (${r.statusCode}).'; final j=jsonDecode(r.body); return j['choices'][0]['message']['content']??'No response.';
 }
}
