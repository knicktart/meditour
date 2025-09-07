class Booking{final int id;final String kind;final DateTime scheduledAt;final double price;final String currency;final String? room;
Booking({required this.id,required this.kind,required this.scheduledAt,required this.price,required this.currency,this.room});
factory Booking.fromJson(Map<String,dynamic> j)=>Booking(id:j['id'],kind:j['kind'],scheduledAt:DateTime.parse(j['scheduled_at']),price:(j['price'] as num).toDouble(),currency:j['currency']??'USD',room:j['room']);
}
