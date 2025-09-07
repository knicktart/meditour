import 'package:flutter_riverpod/flutter_riverpod.dart';import '../models/booking.dart';import '../services/mock_api.dart';
final bookingRepositoryProvider=Provider<BookingRepository>((_)=>BookingRepository());
class BookingRepository{ Future<Booking> bookConsult({required DateTime at,required double price}) async=>Booking.fromJson(await MockApi.bookConsult(at:at,price:price)); Future<List<Booking>> myBookings() async=> (await MockApi.myBookings()).map((j)=>Booking.fromJson(j)).toList(); }
