import 'package:flutter/material.dart';import 'package:flutter_riverpod/flutter_riverpod.dart';import 'package:flutter_secure_storage/flutter_secure_storage.dart';import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/config.dart';import 'features/auth/login_page.dart';import 'features/auth/register_page.dart';import 'features/auth/otp_page.dart';import 'features/home/home_page.dart';import 'features/chat/chat_page.dart';import 'features/consult/consult_page.dart';import 'features/quotation/quotation_page.dart';import 'features/doctors/doctors_page.dart';import 'features/compliance/compliance_page.dart';import 'features/bookings/my_bookings_page.dart';import 'features/profile/profile_page.dart';
final storageProvider=Provider((_)=>const FlutterSecureStorage());
class MediApp extends ConsumerStatefulWidget{const MediApp({super.key});@override ConsumerState<MediApp> createState()=>_MediAppState();}
class _MediAppState extends ConsumerState<MediApp>{Locale _l=const Locale('en');bool _boot=false;String? _t;
 Future<void> _init() async{final s=ref.read(storageProvider);_l=Locale(await s.read(key:'language')??'en');_t=await s.read(key:'token');setState(()=>_boot=true);} @override void initState(){super.initState();_init();}
 void _set(Locale l) async{final s=ref.read(storageProvider);await s.write(key:'language',value:l.languageCode);setState(()=>_l=l);}
 @override Widget build(BuildContext c){if(!_boot)return const MaterialApp(home: Scaffold(body: Center(child:CircularProgressIndicator())));
  return MaterialApp(title:AppConfig.appTitle,debugShowCheckedModeBanner:false,locale:_l,
    supportedLocales:const[Locale('en'),Locale('ar'),Locale('tr'),Locale('de')],
    localizationsDelegates:const[GlobalMaterialLocalizations.delegate,GlobalCupertinoLocalizations.delegate,GlobalWidgetsLocalizations.delegate],
    theme: ThemeData(useMaterial3:true,colorScheme:ColorScheme.fromSeed(seedColor:Colors.teal),inputDecorationTheme:const InputDecorationTheme(border:OutlineInputBorder())),
    routes:{'/':(ctx)=>_t==null?LoginPage(onLocaleChange:_set):const HomePage(),'/register':(ctx)=>RegisterPage(onLocaleChange:_set),'/otp':(ctx)=>const OtpPage(),'/home':(ctx)=>const HomePage(),'/chat':(ctx)=>const ChatPage(),'/consult':(ctx)=>const ConsultPage(),'/quotation':(ctx)=>const QuotationPage(),'/doctors':(ctx)=>const DoctorsPage(),'/compliance':(ctx)=>const CompliancePage(),'/bookings':(ctx)=>const MyBookingsPage(),'/profile':(ctx)=>const ProfilePage()});}
}
