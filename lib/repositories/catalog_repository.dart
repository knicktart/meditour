import 'package:flutter_riverpod/flutter_riverpod.dart';import '../models/doctor.dart';import '../services/mock_api.dart';
final catalogRepositoryProvider=Provider<CatalogRepository>((_)=>CatalogRepository());
class CatalogRepository{ Future<List<Doctor>> doctors() async=> (await MockApi.doctors()).map((j)=>Doctor.fromJson(j)).toList(); }
